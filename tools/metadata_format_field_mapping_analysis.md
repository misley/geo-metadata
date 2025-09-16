# Comprehensive Metadata Format Field Mapping Analysis

## Executive Summary

This analysis examines the field relationships and mapping capabilities between major geospatial metadata standards, with particular focus on NPS-specific requirements. Based on analysis of collected documentation, tools, and code repositories, we can identify cross-format compatibility and potential data loss scenarios.

## Format Coverage Analysis

### Standards Examined
1. **EML (Ecological Metadata Language)** - Used by NPS DataStore
2. **ISO 19115 family** (19115-1, 19115-2, 19115-3, 19139)
3. **FGDC CSDGM** - Federal Geographic Data Committee Content Standard
4. **STAC** - SpatioTemporal Asset Catalog
5. **mdJSON** - ADIwg intermediate format
6. **DCAT-US** - Data.gov catalog format

## NPS-Specific Field Requirements

### EML Extensions Used by NPS (from EMLeditor analysis)

#### Core NPS Fields in EML
```xml
<!-- NPS-specific elements found in EMLeditor -->
<dataset>
  <alternateIdentifier>doi: https://doi.org/10.57830/XXXXXXX</alternateIdentifier>
  <title>Data Package Title</title>
  <creator><!-- Author information --></creator>
  <metadataProvider><!-- Producing Units --></metadataProvider>
  <pubDate><!-- Publication Date --></pubDate>
  <abstract><!-- Abstract --></abstract>
  <additionalInfo><!-- Notes section for DataStore --></additionalInfo>
  <CUI><!-- Controlled Unclassified Information codes --></CUI>
  <geographicDescription>NPS Content Unit Link: PARK_CODE</geographicDescription>
  <temporalCoverage>
    <rangeOfDates>
      <beginDate>YYYY-MM-DD</beginDate>
      <endDate>YYYY-MM-DD</endDate>
    </rangeOfDates>
  </temporalCoverage>
  <usageCitation><!-- Associated DRR information --></usageCitation>
  <methods><!-- Methodology description --></methods>
  <dataTable>
    <physical>
      <distribution>
        <online>
          <url>https://irma.nps.gov/DataStore/Reference/Profile/XXXXXXX</url>
        </online>
      </distribution>
    </physical>
  </dataTable>
</dataset>

<!-- Additional metadata for CUI marking -->
<additionalMetadata>
  <metadata>
    <CUImarking>SP-NPSR|SP-HISTP|SP-ARCHR|PUBLIC</CUImarking>
  </metadata>
</additionalMetadata>
```

#### NPS CUI (Controlled Unclassified Information) System
**Dissemination Codes:**
- `FED ONLY` - Federal employees only
- `FEDCON` - Federal employees and contractors
- `DL ONLY` - Named individuals only
- `NOCON` - Government but no contractors
- `PUBVER` - Public version (CUI removed)
- `PUBFUL` - Public full (no CUI originally)
- `PUBLIC` - No CUI

**CUI Markings:**
- `SP-NPSR` - NPS Resource location information
- `SP-HISTP` - Historic property information  
- `SP-ARCHR` - Archaeological resource information
- `PUBLIC` - No CUI marking needed

### NPS DataStore API Fields (from datastore_interactions.R)

#### Required DataStore Reference Fields
```json
{
  "referenceTypeId": "dataPackage",
  "title": "[DRAFT]: {data_package_title}",
  "referenceCode": "XXXXXXX", // 7-digit reference ID
  "doi": "https://doi.org/10.57830/XXXXXXX",
  "publisher": "National Park Service",
  "location": "Fort Collins, Colorado",
  "dateOfIssue": "YYYY-MM-DD"
}
```

## Format Translation Capabilities

### mdTranslator (ADIwg) - Cross-Format Translation Engine

**Input Format:** mdJSON (native)
**Output Formats:**
1. ISO 19115-2 XML (95% coverage)
2. ISO 19115-3 XML (95% coverage) 
3. ISO 19110 XML (Feature Catalog)
4. FGDC CSDGM XML (Full coverage)
5. DCAT-US JSON (Data.gov)
6. HTML (Human readable)

### Field Mapping Matrix

| **Concept** | **EML** | **ISO 19115-3** | **FGDC CSDGM** | **mdJSON** | **STAC** | **Notes** |
|-------------|---------|------------------|-----------------|------------|----------|-----------|
| **Title** | `title` | `gmd:title` | `idinfo/citation/citeinfo/title` | `title` | `title` | ✅ Universal |
| **Abstract** | `abstract` | `gmd:abstract` | `idinfo/descript/abstract` | `abstract` | `description` | ✅ Universal |
| **Keywords** | `keywordSet` | `gmd:descriptiveKeywords` | `idinfo/keywords` | `keyword` | N/A | ✅ Compatible |
| **Temporal Coverage** | `temporalCoverage` | `gmd:extent/gmd:EX_Extent/gmd:temporalElement` | `idinfo/timeperd` | `extent/temporalExtent` | `datetime` | ✅ Compatible |
| **Spatial Coverage** | `geographicCoverage` | `gmd:extent/gmd:EX_Extent/gmd:geographicElement` | `idinfo/spdom` | `extent/geographicExtent` | `bbox` | ✅ Compatible |
| **Creator/Author** | `creator` | `gmd:pointOfContact` | `idinfo/citation/citeinfo/origin` | `contact` | N/A | ✅ Compatible |
| **Publisher** | `publisher` | `gmd:distributor` | `idinfo/citation/citeinfo/pubinfo` | `contact` | N/A | ✅ Compatible |
| **DOI/Identifier** | `alternateIdentifier` | `gmd:identifier` | `idinfo/citation/citeinfo/onlink` | `identifier` | `id` | ✅ Compatible |
| **Data URL** | `physical/distribution/online/url` | `gmd:transferOptions` | `distinfo/stdorder/digform/digtopt/onlinopt/computer/networka/networkr` | `distributor/transferOption` | `assets` | ✅ Compatible |
| **Methods** | `methods` | `gmd:lineage` | `dataqual/lineage` | `lineage` | N/A | ✅ Compatible |
| **Data Quality** | Limited | `gmd:dataQualityInfo` | `dataqual` | `dataQuality` | N/A | ⚠️ EML Limited |
| **Maintenance** | Limited | `gmd:maintenanceInformation` | `metainfo/metd` | `maintInfo` | N/A | ⚠️ EML Limited |
| **Usage Constraints** | `intellectualRights` | `gmd:resourceConstraints` | `idinfo/useconst` | `constraint` | `license` | ✅ Compatible |
| **CUI Information** | `<CUI>` + `<CUImarking>` | No standard field | No standard field | Custom extension | N/A | ❌ **NPS-Specific** |
| **Park Unit Codes** | `geographicDescription` | No standard field | Custom in `place` | Custom extension | N/A | ❌ **NPS-Specific** |
| **DRR Association** | `usageCitation` | `gmd:aggregationInfo` | No standard field | `associatedResource` | N/A | ⚠️ Limited support |
| **File Descriptions** | `dataTable/entityDescription` | `gmd:distributionInfo` | `distinfo/stdorder/digform/digtinfo` | `distributor` | `assets` | ✅ Compatible |

**Legend:**
- ✅ **Universal** - Direct mapping available
- ✅ **Compatible** - Mapping with minor transformation  
- ⚠️ **Limited** - Partial support or workarounds needed
- ❌ **NPS-Specific** - No equivalent in other standards

## Critical Mapping Challenges

### 1. **NPS CUI (Controlled Unclassified Information)**

**Challenge:** CUI codes and markings are NPS/federal-specific with no equivalent in ISO or FGDC standards.

**Current Approach:**
```xml
<!-- EML Implementation -->
<additionalInfo>
  Contains CUI. Only federal employees should have access.
</additionalInfo>
<additionalMetadata>
  <metadata>
    <CUImarking>SP-NPSR</CUImarking>
  </metadata>
</additionalMetadata>
```

**Mapping Options:**
- **ISO 19115-3:** Could use `gmd:resourceConstraints/gmd:MD_SecurityConstraints`
- **FGDC CSDGM:** Could use `idinfo/secinfo` or `idinfo/accconst`
- **STAC:** Could use custom extension or `license` field

**Recommendation:** Create standardized extension for federal CUI requirements

### 2. **NPS Park Unit Connections**

**Challenge:** Park unit codes (e.g., "YELL", "GRCA") are NPS-specific organizational identifiers.

**Current Approach:**
```xml
<geographicDescription>NPS Content Unit Link: YELL, GRCA</geographicDescription>
```

**Mapping Options:**
- **ISO 19115-3:** Could use `gmd:extent/gmd:EX_Extent/gmd:description`
- **FGDC CSDGM:** Could use `idinfo/spdom/descgeog` or custom `place/placekey`
- **STAC:** Could use custom extension

### 3. **DataStore Reference Integration**

**Challenge:** NPS DataStore-specific DOI pattern and reference structure.

**Current Pattern:**
```
DOI: https://doi.org/10.57830/XXXXXXX
DataStore URL: https://irma.nps.gov/DataStore/Reference/Profile/XXXXXXX
```

**Integration Points:**
- DOI maps universally to identifier fields
- DataStore URL maps to distribution/access fields  
- 7-digit reference code used for API integration

### 4. **Data Release Report (DRR) Linkage**

**Challenge:** NPS-specific publication workflow linking data packages to formal reports.

**Current Approach:**
```xml
<usageCitation>
  <title>Associated Data Release Report Title</title>
  <alternateIdentifier>doi: https://doi.org/10.xxxx/report_doi</alternateIdentifier>
</usageCitation>
```

**Mapping Options:**
- **ISO 19115-3:** `gmd:aggregationInfo/gmd:MD_AggregateInformation`
- **FGDC CSDGM:** No direct equivalent, could use `idinfo/citation/citeinfo`

## Data Preservation Strategies

### 1. **Lossless Round-Trip Conversion**

**Requirements for maintaining NPS-specific fields:**

#### Strategy A: Extended mdJSON (Recommended)
```json
{
  "metadata": {
    "metadataInfo": {...},
    "resourceInfo": {...},
    "npsExtension": {
      "cuiDissemination": "FEDCON",
      "cuiMarking": "SP-NPSR", 
      "parkUnits": ["YELL", "GRCA"],
      "datastoreReference": "1234567",
      "associatedDRR": {
        "title": "Report Title",
        "doi": "10.xxxx/report_doi"
      }
    }
  }
}
```

#### Strategy B: EML as Master Format
- Maintain EML as authoritative source
- Generate ISO/FGDC for compliance/interoperability
- Accept some field loss in derived formats
- Document mapping limitations

### 2. **Field Preservation Matrix**

| **NPS Field** | **Preservation Method** | **Alternative Standards** |
|---------------|-------------------------|---------------------------|
| CUI Codes | Custom extension in all formats | Security constraints mapping |
| Park Units | Geographic description field | Place keywords |
| DataStore DOI | Standard identifier field | Direct mapping |
| DRR Linkage | Associated resource field | Citation relationships |
| Producer Units | Contact/organization field | Direct mapping |
| File Descriptions | Distribution information | Direct mapping |

### 3. **Validation Requirements**

**Pre-Conversion Validation:**
```r
# Example validation from EMLeditor
validate_nps_metadata <- function(eml_object) {
  issues <- list()
  
  # Check for required NPS fields
  if(is.null(get_doi(eml_object))) {
    issues <- append(issues, "Missing DataStore DOI")
  }
  
  if(is.null(get_content_units(eml_object))) {
    issues <- append(issues, "Missing NPS Park Unit connections")
  }
  
  if(is.null(get_cui_code(eml_object))) {
    issues <- append(issues, "Missing CUI designation")
  }
  
  return(issues)
}
```

## Implementation Recommendations

### 1. **Immediate Actions**

#### Create NPS Metadata Profile
- Document all NPS-specific field requirements
- Define mappings for each target standard
- Establish validation rules for completeness

#### Extend mdTranslator
```ruby
# Add NPS extension to mdTranslator
module ADIWG::Mdtranslator::Writers::Iso19115_3
  class NpsExtension
    def write_cui_constraints(hContact, hResponseObj)
      # Map CUI codes to ISO security constraints
    end
    
    def write_park_units(hExtent, hResponseObj) 
      # Map park units to geographic descriptions
    end
  end
end
```

#### Update pygeometa
```python
# Add NPS template to pygeometa
nps_mcf_template = {
    'metadata': {
        'identifier': '10.57830/XXXXXXX',
        'title': 'Data Package Title',
        'nps_extension': {
            'cui_dissemination': 'FEDCON',
            'cui_marking': 'SP-NPSR',
            'park_units': ['YELL', 'GRCA'],
            'datastore_reference': '1234567'
        }
    }
}
```

### 2. **Long-term Strategy**

#### Federal Metadata Extension Standard
- Collaborate with other federal agencies  
- Propose CUI handling for ISO 19115-4
- Develop federal agency identifier schemes
- Create government data linkage standards

#### Cross-Format Synchronization
- Implement bidirectional conversion tools
- Establish authoritative format designation
- Create automated validation pipelines
- Develop change tracking systems

### 3. **Risk Mitigation**

#### Data Loss Prevention
1. **Always maintain original EML** as authoritative source
2. **Document conversion limitations** for each format
3. **Implement validation checks** post-conversion
4. **Use version control** for metadata changes
5. **Test round-trip conversions** regularly

#### Compliance Assurance
1. **Federal records requirements** - maintain complete metadata
2. **FOIA obligations** - ensure access metadata preserved
3. **Scientific reproducibility** - maintain methodological details
4. **Legal constraints** - preserve CUI and usage restrictions

## Quality Assurance Framework

### Pre-Conversion Checklist
- [ ] All required NPS fields populated
- [ ] CUI classification reviewed and validated
- [ ] Park unit codes verified against official list
- [ ] DataStore DOI confirmed and active
- [ ] Associated DRR linkage validated
- [ ] Contact information complete and current

### Post-Conversion Validation
- [ ] Critical fields preserved in target format
- [ ] No data truncation in text fields
- [ ] Temporal/spatial extents accurately transferred
- [ ] Contact roles properly mapped
- [ ] Distribution information maintained
- [ ] Usage constraints properly expressed

### Format-Specific Considerations

#### EML → ISO 19115-3
- **Strengths:** Comprehensive scientific metadata support
- **Limitations:** Limited CUI field mapping, different contact model
- **Validation:** Check extent coordinate systems, verify contact role mappings

#### EML → FGDC CSDGM  
- **Strengths:** Federal government focus, good geographic support
- **Limitations:** Older standard, limited modern web concepts
- **Validation:** Verify place keywords, check distribution format fields

#### EML → STAC
- **Strengths:** Cloud-native, modern API design
- **Limitations:** Asset-focused, limited traditional metadata concepts
- **Validation:** Ensure temporal coverage, verify asset descriptions

## Conclusion

The NPS metadata ecosystem presents unique challenges for cross-format compatibility due to federal-specific requirements like CUI handling and organizational identifiers. While core scientific and geographic metadata maps well between standards, preserving NPS-specific governance and provenance information requires:

1. **Custom extension strategies** for specialized fields
2. **EML as authoritative format** to prevent data loss
3. **Validation frameworks** to ensure completeness
4. **Documentation of limitations** for derived formats

Success requires balancing federal compliance needs with broader interoperability goals, implementing robust validation, and maintaining clear documentation of format-specific capabilities and limitations.

---

*Analysis based on: EMLeditor R package, mdTranslator Ruby gem, pygeometa Python library, NPS DataStore API documentation, and collected metadata standards documentation.*

*Key Finding: NPS-specific fields (CUI, park units, DataStore integration) require custom extension approaches but core scientific metadata achieves good cross-format compatibility.*
