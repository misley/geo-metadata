# Downloads official resources using resource specifications
# Supports partial downloads and resumption

param(
    [switch]$CoreOnly
)

$ErrorActionPreference = "Stop"

# Get paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$DownloadsDir = Join-Path $ProjectRoot "content-cache\downloads"

# Create downloads directory
if (!(Test-Path $DownloadsDir)) {
    New-Item -ItemType Directory -Path $DownloadsDir -Force | Out-Null
}

Write-Host "📥 Downloading official resources..." -ForegroundColor Yellow

# Download function
function Download-File {
    param(
        [string]$Url,
        [string]$FileName,
        [string]$Description = ""
    )
    
    $FilePath = Join-Path $DownloadsDir $FileName
    
    if (Test-Path $FilePath) {
        Write-Host "✅ $FileName (cached)" -ForegroundColor Green
        return $true
    }
    
    Write-Host "⬇️  Downloading $FileName..." -ForegroundColor Cyan
    if ($Description) {
        Write-Host "   $Description" -ForegroundColor Gray
    }
    
    try {
        # Use .NET WebClient for compatibility
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add("User-Agent", "geo-metadata-setup/1.0")
        $webClient.DownloadFile($Url, $FilePath)
        $webClient.Dispose()
        
        Write-Host "✅ $FileName downloaded" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Failed to download $FileName`: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Core NPS resources (always download)
Write-Host "📥 Downloading NPS core resources..." -ForegroundColor Yellow

$coreDownloads = @(
    @{
        Url = "https://www.nps.gov/im/datamgmt/upload/Metadata-Working-Group-Report_508.pdf"
        FileName = "Metadata_Working_Group_Report_508.pdf"
        Description = "NPS Metadata Working Group comprehensive report"
    }
)

foreach ($download in $coreDownloads) {
    Download-File -Url $download.Url -FileName $download.FileName -Description $download.Description
}

# Additional resources for full setup
if (-not $CoreOnly) {
    Write-Host "📥 Downloading extended resources..." -ForegroundColor Yellow
    
    $extendedDownloads = @(
        @{
            Url = "https://www.nps.gov/im/datamgmt/upload/NPS-metadata-template.pdf"
            FileName = "NPS_metadata_template.pdf"
            Description = "Official NPS metadata template documentation"
        },
        @{
            Url = "https://www.nps.gov/im/gis/upload/NPS-Core-Spatial-Data-Standard.zip"
            FileName = "NPS_CoreSpatialDataStandard.zip"
            Description = "NPS Core Spatial Data Standard specification"
        }
    )
    
    foreach ($download in $extendedDownloads) {
        Download-File -Url $download.Url -FileName $download.FileName -Description $download.Description
    }
}

Write-Host "📦 Resource downloads complete" -ForegroundColor Green
Write-Host "📁 Downloads location: $DownloadsDir" -ForegroundColor Cyan