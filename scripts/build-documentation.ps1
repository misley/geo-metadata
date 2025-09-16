# Builds documentation from cloned repositories
# Generates analysis summaries and tool matrices

$ErrorActionPreference = "Stop"

# Get paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$ReposDir = Join-Path $ProjectRoot "content-cache\repositories"
$DocsDir = Join-Path $ProjectRoot "content-cache\generated"

Write-Host "📚 Building documentation..." -ForegroundColor Yellow

# Create documentation directory
if (!(Test-Path $DocsDir)) {
    New-Item -ItemType Directory -Path $DocsDir -Force | Out-Null
}

# Build repository analysis
function Build-RepositoryAnalysis {
    param(
        [string]$Category,
        [string]$OutputFile
    )
    
    Write-Host "📋 Analyzing $Category repositories..." -ForegroundColor Cyan
    
    $content = @"
# $Category Repository Analysis

*Generated: $(Get-Date)*

## Repositories Analyzed

"@
    
    if (Test-Path $ReposDir) {
        $repos = Get-ChildItem $ReposDir -Directory
        
        foreach ($repo in $repos) {
            $repoName = $repo.Name
            $readmeFile = $null
            
            # Find README file
            $readmeFiles = @("README.md", "README.rst", "README.txt")
            foreach ($readme in $readmeFiles) {
                $readmePath = Join-Path $repo.FullName $readme
                if (Test-Path $readmePath) {
                    $readmeFile = $readmePath
                    break
                }
            }
            
            $content += "`n### $repoName`n`n"
            
            if ($readmeFile) {
                try {
                    $readmeContent = Get-Content $readmeFile -Head 10 | Where-Object { $_ -notmatch '^#' -and $_.Trim() -ne '' } | Select-Object -First 1
                    if ($readmeContent) {
                        $content += "**Description**: $readmeContent`n"
                    } else {
                        $content += "**Description**: Repository found but description not available`n"
                    }
                }
                catch {
                    $content += "**Description**: Error reading README`n"
                }
            } else {
                $content += "**Description**: No README found`n"
            }
            
            $content += "**Location**: ``content-cache\repositories\$repoName```n`n"
        }
    } else {
        $content += "`n*No repositories found*`n"
    }
    
    $content | Out-File -FilePath $OutputFile -Encoding UTF8
    Write-Host "✅ $Category analysis complete: $OutputFile" -ForegroundColor Green
}

# Generate repository analysis
$toolsAnalysisFile = Join-Path $DocsDir "Tools_analysis.md"
Build-RepositoryAnalysis -Category "Tools" -OutputFile $toolsAnalysisFile

# Create environment summary
$summaryFile = Join-Path $DocsDir "environment_summary.md"

$downloadsDir = Join-Path $ProjectRoot "content-cache\downloads"
$downloadsList = ""
if (Test-Path $downloadsDir) {
    $downloads = Get-ChildItem $downloadsDir -File
    if ($downloads) {
        $downloadsList = ($downloads | ForEach-Object { "  - $($_.Name)" }) -join "`n"
    } else {
        $downloadsList = "  - No downloads found"
    }
} else {
    $downloadsList = "  - Downloads directory not found"
}

$reposList = ""
if (Test-Path $ReposDir) {
    $repos = Get-ChildItem $ReposDir -Directory
    if ($repos) {
        $reposList = ($repos | ForEach-Object { "  - $($_.Name)" }) -join "`n"
    } else {
        $reposList = "  - No repositories found"
    }
} else {
    $reposList = "  - Repositories directory not found"
}

# Calculate disk usage
function Get-DirectorySize {
    param([string]$Path)
    
    if (Test-Path $Path) {
        try {
            $size = (Get-ChildItem $Path -Recurse -File | Measure-Object -Property Length -Sum).Sum
            if ($size -gt 1GB) {
                return "{0:N2} GB" -f ($size / 1GB)
            } elseif ($size -gt 1MB) {
                return "{0:N2} MB" -f ($size / 1MB)
            } else {
                return "{0:N2} KB" -f ($size / 1KB)
            }
        }
        catch {
            return "Error calculating size"
        }
    } else {
        return "Directory not found"
    }
}

$downloadsSize = Get-DirectorySize $downloadsDir
$reposSize = Get-DirectorySize $ReposDir
$generatedSize = Get-DirectorySize $DocsDir
$totalCacheSize = Get-DirectorySize (Join-Path $ProjectRoot "content-cache")

$summaryContent = @"
# Environment Summary

*Generated: $(Get-Date)*

## Content Cache Structure

``````
content-cache\
├── downloads\          # Official resources and documentation
├── repositories\       # Cloned tool repositories
└── generated\         # Generated documentation and analysis
``````

## Downloaded Resources

$downloadsList

## Cloned Repositories

$reposList

## Disk Usage

- **Downloads**: $downloadsSize
- **Repositories**: $reposSize  
- **Generated**: $generatedSize
- **Total Cache**: $totalCacheSize

"@

$summaryContent | Out-File -FilePath $summaryFile -Encoding UTF8

Write-Host "📚 Documentation build complete" -ForegroundColor Green
Write-Host "📁 Generated docs: $DocsDir" -ForegroundColor Cyan