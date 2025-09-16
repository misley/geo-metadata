# Geospatial Metadata Standards Summary

## Current Metadata Standards Landscape (2025)

### Primary International Standards

#### ISO 19115-3:2023 - XML Schema Implementation (RECOMMENDED)
- **Status**: Current international standard for geospatial metadata
- **Purpose**: XML implementation of ISO 19115-1 and ISO 19115-2
- **Key Features**:
  - Direct XML schema generation from UML models
  - Comprehensive validation (XML Schema + Schematron)
  - Replaces deprecated ISO/TS 19115-3:2016
- **Documentation**: [ISO 19115 Standards Overview](../standards/ISO_19115_standards_overview.md)

#### ISO 19115-1:2014 - Fundamentals
- **Status**: Core metadata standard, under revision
- **Purpose**: Fundamental metadata schema for geographic information
- **Key Features**:
  - Mandatory and conditional metadata elements
  - Extensible framework for specialized domains
  - Multiple amendments (2018, 2020)
- **Future**: Being replaced by ISO/AWI 19115-1 (under development)

#### CSDGM - Content Standard for Digital Geospatial Metadata
- **Status**: Legacy US federal standard, still in use
- **Purpose**: US federal agency metadata documentation
- **Key Features**:
  - Comprehensive US federal compliance framework
  - Detailed guidance and tooling support
  - Multiple domain-specific profiles
- **Documentation**: [CSDGM Overview](../standards/CSDGM_overview.md)

### Standards Relationship and Migration Path

```
Legacy Standards          Current Standards         Future Standards
    ↓                         ↓                         ↓
CSDGM (1998)      →     ISO 19115-1:2014     →    ISO/AWI 19115-1
ISO 19115:2003    →     ISO 19115-2         →    (under development)
ISO/TS 19115-3:2016 →  ISO 19115-3:2023    →    (stable)
```

**Recommended Migration Strategy:**
1. New projects: Start with ISO 19115-3:2023
2. Legacy data: Maintain reading capabilities for CSDGM and older ISO versions
3. Tool selection: Choose software supporting multiple standards
4. Training: Focus on ISO 19115-3:2023 while maintaining legacy knowledge

## Tool Ecosystem Analysis

### Python Tools (STRONGEST ECOSYSTEM)

#### pygeometa - Metadata Management Platform
- **Maturity**: Mature, actively maintained
- **Standards Support**: 
  - ✅ ISO 19139 (comprehensive)
  - ✅ Multiple profiles and extensions
  - ✅ STAC, DCAT, OGC API Records
  - ❌ ISO 19115-3:2023 (development needed)
- **Strengths**: CLI and API, transformation capabilities, validation
- **Integration**: Can be integrated with QGIS and R workflows
- **Documentation**: [Python Metadata Tools](../tools/python/python_metadata_tools.md)

#### OWSLib + pycsw - Catalog Integration
- **Purpose**: OGC web services and catalog management
- **Standards Support**: CSW, OGC API Records, multiple metadata formats
- **Strengths**: Production-ready catalog systems, harvesting capabilities
- **Use Cases**: Institutional metadata catalogs, data discovery portals

### QGIS Ecosystem (GOOD FOUNDATION)

#### Built-in Metadata Support
- **Current State**: Dublin Core compatible, XML-based storage
- **Strengths**: Integrated with layer properties, custom properties system
- **Limitations**: No native ISO 19115-3:2023 support
- **Development Opportunity**: Create ISO 19115-3 bridge plugin
- **Documentation**: [QGIS Metadata Support](../tools/qgis/qgis_metadata_support.md)

#### Plugin Development Opportunities
1. **ISO 19115-3 Plugin**: Bridge QGIS metadata to ISO 19115-3:2023
2. **pygeometa Integration**: QGIS Processing algorithms using pygeometa
3. **Catalog Publishing**: Connect to pycsw for metadata publishing

### R Ecosystem (SPECIALIZED STRENGTHS)

#### EML Package - Ecological Metadata
- **Maturity**: Mature, well-established in ecological research
- **Standards Support**: EML 2.2.0, JSON-LD representation
- **Strengths**: Rich ecological metadata, reproducible research integration
- **Limitations**: Ecological focus, limited general geospatial support
- **Documentation**: [R Metadata Tools](../tools/r/r_metadata_tools.md)

#### Spatial Packages Integration
- **sf Package**: Basic metadata through attributes and CRS information
- **dataone Package**: Repository integration for data publishing
- **Development Needs**: ISO 19115 support, enhanced spatial metadata

## Standards Compliance Assessment

### Tool Coverage Matrix

| Tool/Standard | ISO 19115-3:2023 | ISO 19115-1:2014 | CSDGM | EML | Other |
|---------------|-------------------|-------------------|-------|-----|-------|
| pygeometa     | ❌ (Dev needed)   | ✅ (ISO 19139)    | ✅    | ❌  | ✅ STAC, DCAT |
| QGIS Built-in | ❌               | ❌                | Partial | ❌ | ✅ Dublin Core |
| EML (R)       | ❌               | ❌                | ❌    | ✅  | ❌ |
| OWSLib        | ❌               | ✅ (Parsing)      | ✅    | ❌  | ✅ CSW, OGC |

### Priority Development Areas

#### High Priority (Immediate Need)
1. **ISO 19115-3:2023 Support in pygeometa**
   - Add Jinja2 templates for 2023 standard
   - Implement XML Schema validation
   - Add Schematron rule validation

2. **QGIS ISO 19115-3 Plugin**
   - Bridge QGIS metadata to ISO format
   - Provide user-friendly editing interface
   - Enable export to standard XML

#### Medium Priority (Strategic Value)
3. **R ISO 19115 Package**
   - Create dedicated R package for ISO standards
   - Bridge EML to ISO conversion
   - Integrate with sf/terra spatial objects

4. **Cross-Platform Validation Tools**
   - Unified validation across Python, R, QGIS
   - Standard-agnostic validation framework
   - Quality assessment and reporting

## Implementation Recommendations

### For Organizations Starting New Projects

**Recommended Technology Stack:**
1. **Primary**: Python + pygeometa for metadata creation and management
2. **Spatial Processing**: QGIS or Python/R for spatial data processing
3. **Catalog**: pycsw for institutional catalog services
4. **Standards**: ISO 19115-3:2023 as primary standard
5. **Backup**: Maintain CSDGM reading for legacy data

### For Organizations with Legacy Systems

**Migration Strategy:**
1. **Assessment**: Audit existing metadata standards and tools
2. **Conversion**: Use pygeometa for CSDGM to ISO transformation
3. **Parallel Systems**: Run ISO and legacy systems during transition
4. **Training**: Staff development on ISO standards
5. **Tool Upgrades**: Gradual tool modernization

### For Software Developers

**Development Priorities:**
1. **ISO 19115-3:2023 Implementation**: Add support in existing tools
2. **Validation Libraries**: Cross-language validation components
3. **User Interfaces**: Simplified metadata creation interfaces
4. **Integration Tools**: Bridge existing workflows to standards compliance

## Future Outlook

### Standards Evolution
- **ISO 19115-3:2023**: Will remain stable and current
- **CSDGM**: Continued legacy support, gradual phase-out
- **Emerging Standards**: STAC, OGC API Records gaining adoption

### Technology Trends
- **Cloud Integration**: Metadata services in cloud platforms
- **AI/ML Enhancement**: Automated metadata generation and enhancement
- **Linked Data**: JSON-LD and RDF representations
- **Real-time Metadata**: Dynamic metadata for streaming data

### Strategic Recommendations
1. **Adopt ISO 19115-3:2023** as primary standard for new projects
2. **Invest in Python/pygeometa** for metadata management infrastructure
3. **Develop QGIS plugins** for desktop GIS integration
4. **Maintain legacy support** for CSDGM and older ISO versions
5. **Plan for interoperability** with emerging cloud and API standards

*Last updated: September 8, 2025*
