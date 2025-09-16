# Python Metadata Tools and Libraries

## pygeometa - Primary Python Metadata Management Tool

### Overview
**pygeometa** is the leading Python package for generating metadata for geospatial datasets, developed by the geopython community.

**Key Features:**
- Generate metadata from YAML configuration files (Metadata Control Files - MCF)
- Support for multiple output schemas including ISO 19139
- Command-line and Python API interfaces
- Import/export capabilities between formats
- Schema validation and transformation tools

### Supported Standards
- **iso19139** - ISO 19115:2003 XML implementation
- **iso19139-2** - ISO 19115-2 for imagery and gridded data  
- **iso19139-hnap** - Harmonized North American Profile
- **dcat** - W3C Data Catalog Vocabulary
- **OGC API - Records** - Part 1: Core record model
- **STAC** - SpatioTemporal Asset Catalog
- **wmo-cmp, wmo-wcmp2, wmo-wigos** - World Meteorological Organization profiles
- **Local schemas** - Custom schema support

### Installation
```bash
python3 -m venv pygeometa-env
cd pygeometa-env
. bin/activate
pip install pygeometa
```

### Command Line Usage
```bash
# Generate ISO 19139 metadata
pygeometa metadata generate file.yml --schema=iso19139 --output=metadata.xml

# Import existing metadata to MCF
pygeometa metadata import metadata.xml --schema=iso19139

# Transform between schemas
pygeometa metadata transform input.xml --input-schema=iso19139 --output-schema=oarec-record

# Validate MCF files
pygeometa metadata validate file.yml
```

### Python API
```python
from pygeometa.core import read_mcf
from pygeometa.schemas.iso19139 import ISO19139OutputSchema

# Read metadata configuration
mcf_dict = read_mcf('/path/to/file.yml')

# Generate ISO 19139
iso_os = ISO19139OutputSchema()
xml_string = iso_os.write(mcf_dict)
```

### Development and Extension
- Jinja2 template-based schema system
- Plugin architecture for custom schemas
- Extensible base classes for new output formats

### Repository and Documentation
- **GitHub**: https://github.com/geopython/pygeometa
- **Latest Release**: v0.17.0 (July 2024)
- **License**: Open source (permissive license)

## OWSLib - OGC Web Services Client

### Overview
**OWSLib** provides Python client programming interfaces for OGC web services, including metadata-related services.

**Key Features:**
- CSW (Catalog Service for the Web) client support
- WMS, WFS, WCS client capabilities
- Metadata parsing and handling
- OGC API support

### Metadata Capabilities
- CSW catalog discovery and harvesting
- Metadata record parsing (ISO 19139, Dublin Core)
- Service metadata extraction
- Integration with catalog systems

### Installation
```bash
pip3 install OWSLib
```

### Basic Usage
```python
from owslib.csw import CatalogueServiceWeb
from owslib.wms import WebMapService

# Connect to CSW catalog
csw = CatalogueServiceWeb('http://catalog.example.com/csw')
csw.getrecords()

# Extract metadata from WMS
wms = WebMapService('http://wms.example.com/wms')
print(wms.identification.title)
```

## pycsw - OGC CSW Server Implementation

### Overview
**pycsw** is a complete OGC CSW server implementation that can publish and discover geospatial metadata.

**Key Features:**
- OGC CSW 2.0.2 and 3.0.0 compliant
- OGC API - Records support
- Multiple metadata schema support (ISO 19139, Dublin Core, FGDC)
- Backend support for various databases
- Metadata harvesting capabilities

### Standards Support
- ISO 19115/19119/19139
- Dublin Core
- FGDC CSDGM
- DIF (Directory Interchange Format)

### Integration Opportunities
- Can be integrated with QGIS workflows
- Supports batch metadata publishing
- REST API for metadata management

## Development Opportunities for ISO 19115-3:2023

### 1. pygeometa Extensions
- **Add ISO 19115-3:2023 schema**: Create new Jinja2 templates for the 2023 standard
- **XML Schema validation**: Integrate ISO 19115-3:2023 XSD validation
- **Schematron rules**: Implement validation constraints

### 2. QGIS Integration
- **pygeometa QGIS Plugin**: Bridge QGIS metadata to pygeometa MCF format
- **Processing algorithms**: Create QGIS Processing tools using pygeometa
- **Catalog publishing**: Connect QGIS to pycsw for metadata publishing

### 3. Workflow Integration
- **Batch processing**: Automate metadata generation for multiple datasets
- **CI/CD integration**: Include metadata validation in deployment pipelines
- **Data pipeline integration**: Generate metadata as part of data processing workflows

*Last updated: September 8, 2025*
