# Validates geo-metadata environment setup
# Checks for required tools and content availability

$ErrorActionPreference = "Stop"

# Get paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$CacheDir = Join-Path $ProjectRoot "content-cache"

Write-Host "🔍 Validating geo-metadata environment..." -ForegroundColor Yellow

# Track validation results
$ValidationErrors = 0

# Validation function
function Test-ValidationItem {
    param(
        [string]$Item,
        [scriptblock]$Condition
    )
    
    try {
        if (& $Condition) {
            Write-Host "✅ $Item" -ForegroundColor Green
        } else {
            Write-Host "❌ $Item" -ForegroundColor Red
            $script:ValidationErrors++
        }
    }
    catch {
        Write-Host "❌ $Item (Error: $($_.Exception.Message))" -ForegroundColor Red
        $script:ValidationErrors++
    }
}

# Check core directory structure
Write-Host "📁 Checking directory structure..." -ForegroundColor Cyan

Test-ValidationItem "Project root exists" { Test-Path $ProjectRoot }
Test-ValidationItem "Documentation directory" { Test-Path (Join-Path $ProjectRoot "docs") }
Test-ValidationItem "Scripts directory" { Test-Path (Join-Path $ProjectRoot "scripts") }
Test-ValidationItem "Content cache directory" { Test-Path $CacheDir }

# Check core research files
Write-Host "📚 Checking research content..." -ForegroundColor Cyan

Test-ValidationItem "Main README" { Test-Path (Join-Path $ProjectRoot "README.md") }
Test-ValidationItem "Research summary" { Test-Path (Join-Path $ProjectRoot "comprehensive_metadata_research_summary.md") }
Test-ValidationItem "Citations" { Test-Path (Join-Path $ProjectRoot "citations.md") }
Test-ValidationItem "Standards documentation" { Test-Path (Join-Path $ProjectRoot "docs\standards") }
Test-ValidationItem "Implementation summaries" { Test-Path (Join-Path $ProjectRoot "docs\summaries") }

# Check scripts exist
Write-Host "🔧 Checking scripts..." -ForegroundColor Cyan

$scripts = @("setup-environment.ps1", "download-resources.ps1", "clone-repositories.ps1", "build-documentation.ps1")
foreach ($script in $scripts) {
    $scriptPath = Join-Path $ProjectRoot "scripts\$script"
    Test-ValidationItem "Script $script exists" { Test-Path $scriptPath }
}

# Check content cache (if exists)
if (Test-Path $CacheDir) {
    Write-Host "📦 Checking content cache..." -ForegroundColor Cyan
    
    Test-ValidationItem "Downloads directory" { Test-Path (Join-Path $CacheDir "downloads") }
    Test-ValidationItem "Repositories directory" { Test-Path (Join-Path $CacheDir "repositories") }
    Test-ValidationItem "Generated docs directory" { Test-Path (Join-Path $CacheDir "generated") }
    
    # Count content
    $downloadsDir = Join-Path $CacheDir "downloads"
    $reposDir = Join-Path $CacheDir "repositories"
    
    $downloadCount = 0
    $repoCount = 0
    
    if (Test-Path $downloadsDir) {
        $downloadCount = (Get-ChildItem $downloadsDir -File).Count
    }
    
    if (Test-Path $reposDir) {
        $repoCount = (Get-ChildItem $reposDir -Directory).Count
    }
    
    Write-Host "📊 Content summary:" -ForegroundColor Cyan
    Write-Host "   Downloads: $downloadCount files" -ForegroundColor Gray
    Write-Host "   Repositories: $repoCount directories" -ForegroundColor Gray
    
    # Calculate total size
    try {
        $cacheSize = (Get-ChildItem $CacheDir -Recurse -File | Measure-Object -Property Length -Sum).Sum
        $cacheSizeMB = [math]::Round($cacheSize / 1MB, 2)
        Write-Host "   Total size: $cacheSizeMB MB" -ForegroundColor Gray
    }
    catch {
        Write-Host "   Total size: Unable to calculate" -ForegroundColor Gray
    }
}

# Check required tools
Write-Host "🛠️  Checking system tools..." -ForegroundColor Cyan

Test-ValidationItem "PowerShell available" { $PSVersionTable.PSVersion -ge [Version]"5.0" }
Test-ValidationItem "Git available" { 
    try { 
        $null = & git --version 2>&1
        $true 
    } catch { 
        $false 
    } 
}
Test-ValidationItem ".NET WebClient available" { 
    try { 
        [System.Net.WebClient] | Out-Null
        $true 
    } catch { 
        $false 
    } 
}

# Final validation summary
Write-Host ""
Write-Host "🎯 Validation Summary" -ForegroundColor White
Write-Host "====================" -ForegroundColor White

if ($ValidationErrors -eq 0) {
    Write-Host "✅ All validations passed!" -ForegroundColor Green
    Write-Host "🚀 Environment is ready for use" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ $ValidationErrors validation errors found" -ForegroundColor Red
    Write-Host "🔧 Please address the issues above" -ForegroundColor Yellow
    exit 1
}