# R Metadata Tools and Libraries

## EML Package - Ecological Metadata Language

### Overview
**EML** is the premier R package for working with Ecological Metadata Language, providing comprehensive metadata capabilities for ecological and environmental sciences.

**Key Features:**
- Complete EML 2.2.0 specification support
- S3 list-based object system (simplified from previous S4 implementation)
- JSON-LD representation via emld package
- XML validation and serialization
- Rich metadata structures for ecological data

### Core Metadata Elements
- **Dataset Information**: Title, creators, contacts, publishers
- **Coverage Metadata**: Temporal, spatial, and taxonomic coverage
- **Attribute Metadata**: Detailed field descriptions and constraints
- **Methods**: Detailed methodology documentation from Word/Markdown
- **Physical Metadata**: File format specifications
- **Keywords and Vocabularies**: Controlled vocabulary support

### Installation and Basic Usage
```r
# Install from CRAN
install.packages("EML")
library(EML)

# Create minimal EML document
me <- list(individualName = list(givenName = "Jane", surName = "Doe"))
my_eml <- list(dataset = list(
  title = "Sample Dataset",
  creator = me,
  contact = me
))

# Write and validate
write_eml(my_eml, "metadata.xml")
eml_validate("metadata.xml")
```

### Advanced Features
- **Constructor methods**: `eml$creator()`, `eml$dataset()` etc. for tab completion
- **Import capabilities**: Read from Word documents and Markdown files
- **Complex structures**: Nested lists for detailed metadata
- **Version control**: Support for EML 2.1.1 and 2.2.0 versions

### Integration Opportunities
- **Spatial data**: Combine with sf/sp for geospatial metadata
- **Data workflows**: Integrate with R data processing pipelines
- **Publishing**: Connect to data repositories (DataONE, KNB)

## dataone Package - DataONE Repository Interface

### Overview
**dataone** provides R interface to the DataONE network of data repositories, enabling metadata and data management across federated repositories.

**Key Features:**
- DataONE API 2.0 implementation
- Search and discovery across member nodes
- Metadata and data upload/download
- Authentication system integration
- Package-based data collections

### Repository Network
- **KNB** - Knowledge Network for Biocomplexity
- **Arctic Data Center** - NSF Arctic research data
- **Dryad** - General research data repository
- **LTER** - Long Term Ecological Research sites

### Core Functionality
```r
library(dataone)

# Connect to production environment
cn <- CNode("PROD")
mn <- getMNode(cn, "urn:node:KNB")

# Search for datasets
mySearchTerms <- list(
  q="abstract:salmon+AND+keywords:spawn",
  fl="id,title,dateUploaded,abstract,size"
)
result <- query(mn, solrQuery=mySearchTerms, as="data.frame")

# Download metadata and data
metadata <- rawToChar(getObject(mn, result[1,'id']))
```

### Upload Capabilities
- **Authentication**: X.509 certificate-based authentication
- **Data objects**: Support for various file formats
- **Metadata**: EML and other metadata standards
- **Data packages**: Collections of related data and metadata

## Core R Spatial Packages with Metadata Support

### sf Package - Simple Features for R

**Metadata Capabilities:**
- **Built-in attributes**: Coordinate reference systems, geometry types
- **Data frame integration**: Metadata stored as data frame attributes
- **GDAL integration**: Access to format-specific metadata
- **Projection metadata**: Comprehensive CRS information

**Metadata Access:**
```r
library(sf)
# Read spatial data with metadata
data <- st_read("dataset.gpkg")

# Access CRS metadata
st_crs(data)
# Access attribute metadata
attributes(data)
```

### raster Package (Legacy - now superseded by terra)

**Metadata Support:**
- **Raster attributes**: Resolution, extent, CRS information
- **Band metadata**: Multi-band raster information
- **History tracking**: Processing step documentation
- **Format-specific**: NetCDF, HDF metadata preservation

## R Metadata Development Opportunities

### 1. ISO Standards Integration
**Potential Projects:**
- **iso19115** package: Create R package for ISO 19115-3:2023 support
- **EML-ISO bridge**: Convert between EML and ISO 19115 standards
- **sf metadata enhancement**: Add ISO metadata support to spatial objects

### 2. Metadata Validation Tools
**Development Areas:**
- **Schema validation**: R functions for ISO 19115-3 XSD validation
- **Completeness checking**: Assess metadata completeness against standards
- **Quality assessment**: Metadata quality scoring and reporting

### 3. Workflow Integration
**Integration Points:**
- **R Markdown**: Embed metadata generation in reproducible documents
- **Drake/targets**: Integrate metadata into data processing pipelines
- **Shiny applications**: Interactive metadata creation interfaces

### 4. Repository Connections
**Extension Opportunities:**
- **CSW clients**: R interface to Catalog Service for the Web
- **pycsw integration**: R interface to pycsw catalog servers
- **QGIS bridge**: Connect R metadata to QGIS Processing framework

## Comparison with Other Tools

### Strengths of R Approach
- **Statistical integration**: Metadata tied to analytical workflows
- **Reproducible research**: Metadata generation as part of literate programming
- **Rich ecosystem**: Leverage existing spatial and data science packages
- **Community support**: rOpenSci and other R communities

### Limitations
- **Standards support**: Limited ISO 19115-3:2023 native support
- **Geospatial focus**: EML more ecological than general geospatial
- **XML complexity**: Complex XML structures challenging in R

### Recommended R Workflow
1. **Data processing**: Use sf, terra for spatial data handling
2. **Metadata creation**: Use EML for rich metadata documentation
3. **Validation**: Develop custom validation functions
4. **Publishing**: Use dataone for repository publishing
5. **Discovery**: Use OWSLib-style tools for catalog search

*Last updated: September 8, 2025*
