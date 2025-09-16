# Clones external tool repositories for analysis
# Removes .git directories to prevent nested repos

param(
    [switch]$EssentialOnly
)

$ErrorActionPreference = "Stop"

# Get paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$ReposDir = Join-Path $ProjectRoot "content-cache\repositories"

# Create repositories directory
if (!(Test-Path $ReposDir)) {
    New-Item -ItemType Directory -Path $ReposDir -Force | Out-Null
}

Write-Host "📦 Cloning tool repositories..." -ForegroundColor Yellow

# Repository clone function
function Clone-Repository {
    param(
        [string]$Name,
        [string]$Url,
        [string]$Description
    )
    
    $TargetDir = Join-Path $ReposDir $Name
    
    if (Test-Path $TargetDir) {
        Write-Host "✅ $Name (cached)" -ForegroundColor Green
        return $true
    }
    
    Write-Host "📦 Cloning $Name..." -ForegroundColor Cyan
    Write-Host "   $Description" -ForegroundColor Gray
    
    try {
        # Clone with depth 1 for efficiency
        $null = & git clone --depth 1 --quiet $Url $TargetDir 2>&1
        
        # Remove .git to prevent nested repos
        $gitDir = Join-Path $TargetDir ".git"
        if (Test-Path $gitDir) {
            Remove-Item -Path $gitDir -Recurse -Force
        }
        
        Write-Host "✅ $Name cloned" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Failed to clone $Name from $Url`: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Check if git is available
try {
    $null = & git --version 2>&1
}
catch {
    Write-Host "❌ Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host "   Please install Git from https://git-scm.com/download/win" -ForegroundColor Yellow
    throw "Git is required for repository cloning"
}

# Essential repositories (always clone)
Write-Host "📦 Cloning essential tools..." -ForegroundColor Yellow

$essentialRepos = @(
    @{
        Name = "pygeometa"
        Url = "https://github.com/geopython/pygeometa"
        Description = "Python library for ISO metadata generation"
    },
    @{
        Name = "pystac"
        Url = "https://github.com/stac-utils/pystac"
        Description = "Python library for STAC"
    },
    @{
        Name = "NPSdatastore"
        Url = "https://github.com/nationalparkservice/NPSdatastore"
        Description = "NPS DataStore R package"
    },
    @{
        Name = "DPchecker"
        Url = "https://github.com/nationalparkservice/DPchecker"
        Description = "Data package validation framework"
    }
)

foreach ($repo in $essentialRepos) {
    Clone-Repository -Name $repo.Name -Url $repo.Url -Description $repo.Description
}

if (-not $EssentialOnly) {
    Write-Host "📦 Cloning extended tool ecosystem..." -ForegroundColor Yellow
    
    $extendedRepos = @(
        @{
            Name = "EMLeditor"
            Url = "https://github.com/nationalparkservice/EMLeditor"
            Description = "EML metadata editing R package"
        },
        @{
            Name = "QCkit"
            Url = "https://github.com/nationalparkservice/QCkit"
            Description = "Quality control R package"
        },
        @{
            Name = "DSbulkUploadR"
            Url = "https://github.com/nationalparkservice/DSbulkUploadR"
            Description = "Bulk upload R package"
        },
        @{
            Name = "OWSLib"
            Url = "https://github.com/geopython/OWSLib"
            Description = "Python OGC web services library"
        },
        @{
            Name = "pycsw"
            Url = "https://github.com/geopython/pycsw"
            Description = "Python CSW server implementation"
        },
        @{
            Name = "stactools"
            Url = "https://github.com/stac-utils/stactools"
            Description = "STAC command line tools"
        },
        @{
            Name = "ckan"
            Url = "https://github.com/ckan/ckan"
            Description = "Open source data portal platform"
        },
        @{
            Name = "geonetwork"
            Url = "https://github.com/geonetwork/core-geonetwork"
            Description = "Open source metadata catalog"
        },
        @{
            Name = "mdEditor"
            Url = "https://github.com/adiwg/mdEditor"
            Description = "Metadata editor web application"
        }
    )
    
    foreach ($repo in $extendedRepos) {
        Clone-Repository -Name $repo.Name -Url $repo.Url -Description $repo.Description
    }
}

$repoCount = (Get-ChildItem $ReposDir -Directory).Count
Write-Host "📦 Repository cloning complete" -ForegroundColor Green
Write-Host "📁 Repositories location: $ReposDir" -ForegroundColor Cyan
Write-Host "📊 Total repositories: $repoCount" -ForegroundColor Cyan