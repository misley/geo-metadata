# Main environment setup orchestrator for geo-metadata
# Usage: .\scripts\setup-environment.ps1 [-SetupType full|minimal|research-only]

param(
    [ValidateSet("full", "minimal", "research-only")]
    [string]$SetupType = "full"
)

$ErrorActionPreference = "Stop"

# Get script and project paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$CacheDir = Join-Path $ProjectRoot "content-cache"

# Setup logging
$LogFile = Join-Path $ProjectRoot "setup.log"
Start-Transcript -Path $LogFile -Append

Write-Host "🚀 Setting up geo-metadata environment: $SetupType" -ForegroundColor Green
Write-Host "📅 Started: $(Get-Date)" -ForegroundColor Cyan
Write-Host "📁 Project root: $ProjectRoot" -ForegroundColor Cyan

# Create cache structure
$CacheDirs = @("downloads", "repositories", "generated")
foreach ($dir in $CacheDirs) {
    $dirPath = Join-Path $CacheDir $dir
    if (!(Test-Path $dirPath)) {
        New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
    }
}

# Execute setup phases
try {
    switch ($SetupType) {
        "full" {
            Write-Host "📦 Full setup: downloads + repositories + documentation" -ForegroundColor Yellow
            & "$ScriptDir\download-resources.ps1"
            & "$ScriptDir\clone-repositories.ps1"
            & "$ScriptDir\build-documentation.ps1"
        }
        "minimal" {
            Write-Host "📦 Minimal setup: core resources only" -ForegroundColor Yellow
            & "$ScriptDir\download-resources.ps1" -CoreOnly
            & "$ScriptDir\clone-repositories.ps1" -EssentialOnly
        }
        "research-only" {
            Write-Host "📦 Research setup: no external dependencies" -ForegroundColor Yellow
            Write-Host "✅ Research files available in docs/" -ForegroundColor Green
        }
    }
    
    # Validate setup
    Write-Host "🔍 Validating environment..." -ForegroundColor Yellow
    & "$ScriptDir\validate-setup.ps1"
    
    Write-Host "✅ Setup complete: $(Get-Date)" -ForegroundColor Green
    
    # Calculate cache size
    if (Test-Path $CacheDir) {
        $cacheSize = (Get-ChildItem $CacheDir -Recurse | Measure-Object -Property Length -Sum).Sum
        $cacheSizeMB = [math]::Round($cacheSize / 1MB, 2)
        Write-Host "📊 Cache size: $cacheSizeMB MB" -ForegroundColor Cyan
    }
    
    Write-Host "📋 Setup log: $LogFile" -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Setup failed: $($_.Exception.Message)" -ForegroundColor Red
    throw
}
finally {
    Stop-Transcript
}