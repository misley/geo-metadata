# Setup Instructions for Windows

## Quick Setup

1. **Clone repository**:
   ```powershell
   git clone https://github.com/misley/geo-metadata.git
   cd geo-metadata
   ```

2. **Run setup**:
   ```powershell
   .\scripts\setup-environment.ps1 -SetupType full
   ```

3. **Validate environment**:
   ```powershell
   .\scripts\validate-setup.ps1
   ```

## Setup Options

### Full Setup (~1.7GB)
Downloads all resources + clones all tool repositories + builds documentation
```powershell
.\scripts\setup-environment.ps1 -SetupType full
```

### Minimal Setup (~200MB)  
Core resources + essential repositories only
```powershell
.\scripts\setup-environment.ps1 -SetupType minimal
```

### Research Only (~244KB)
No external downloads - research documents only
```powershell
.\scripts\setup-environment.ps1 -SetupType research-only
```

## Prerequisites

- **Windows 10+** with PowerShell 5.0+
- **Git for Windows**: https://git-scm.com/download/win
- **Internet connection** for downloads

## Troubleshooting

### PowerShell Execution Policy
If scripts won't run:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Git Not Found
Install Git for Windows and restart PowerShell

### Download Failures
Check internet connection and try again - scripts resume interrupted downloads

## What Gets Downloaded

### Official Resources
- NPS Metadata Working Group Report
- NPS Metadata Templates  
- Federal Standards Documentation

### Tool Repositories
- Python: pygeometa, pystac, OWSLib, pycsw
- R/NPS: DPchecker, EMLeditor, QCkit, NPSdatastore
- Platforms: CKAN, GeoNetwork, mdEditor

## Repository Structure After Setup

```
geo-metadata/
├── docs/                    # Research content (always available)
├── scripts/                # PowerShell setup scripts
├── content-cache/          # External content (built by scripts)
│   ├── downloads/         # Official documents and resources  
│   ├── repositories/      # Cloned tool repositories
│   └── generated/         # Generated analysis and documentation
├── README.md              # Main project overview
└── setup.log             # Setup execution log
```