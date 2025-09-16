# QGIS Metadata Tools and Support

## Built-in QGIS Metadata Support

### QgsLayerMetadata Class
QGIS has comprehensive built-in metadata support through the `QgsLayerMetadata` class:

**Key Features:**
- Structured metadata store for map layers
- Dublin Core metadata specification compatibility  
- Designed for future ISO specification compatibility
- Internal QGIS format with common metadata structure
- XML-based storage and management

**Core Metadata Elements:**
- Identifier, title, abstract
- Keywords and categories  
- Contact information
- Licensing and rights
- Spatial and temporal extents
- Coordinate reference systems
- Constraints and fees
- Character encoding

**Methods and Functionality:**
- `readFromLayer()` - Read metadata from layer custom properties
- `saveToLayer()` - Save metadata to layer custom properties
- `readMetadataXml()` - Load from XML DOM elements
- `writeMetadataXml()` - Export to XML DOM elements
- `contains()` - Search metadata content
- `matches()` - Regular expression matching

### Limitations and Considerations
- **Compatibility Note**: "QGIS internal schema does not represent a superset of all existing metadata schemas and accordingly conversion from specific metadata formats to QgsLayerMetadata may result in a loss of information"
- **Current Status**: Designed for Dublin Core, with ISO compatibility planned for future releases
- **Validation**: Supports QgsLayerMetadataValidator and QgsNativeMetadataValidator

## Metadata Schema Location
- Schema definition: `resources/qgis-resource-metadata.xsd` in QGIS source code
- XML implementation follows Dublin Core specifications

## Integration Points
- Layer Properties Dialog
- Browser Panel metadata display
- Custom Properties storage system
- Processing framework integration potential

## Development Opportunities
1. **ISO 19115-3:2023 Plugin**: Create a plugin to bridge QGIS native metadata to ISO 19115-3
2. **Metadata Export Tools**: Develop tools to export QGIS metadata to standard XML formats
3. **Catalog Integration**: Connect to CSW catalogs for metadata publishing
4. **Validation Enhancement**: Add ISO 19115 validation rules

## Next Research Steps
1. Search for existing QGIS metadata plugins
2. Investigate QGIS Processing framework tools for metadata
3. Research third-party QGIS plugins for ISO compliance
4. Document development pathways for ISO 19115-3 support

*Last updated: September 8, 2025*
