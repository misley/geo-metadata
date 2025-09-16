# ISO 19115 Standards Overview

## Current Standards Hierarchy (2025)

### ISO 19115-3:2023 - XML Schema Implementation (CURRENT)
- **Status**: Published August 2023
- **Type**: International Standard
- **Purpose**: XML implementation of ISO 19115-1 and ISO 19115-2
- **Key Features**:
  - XML schema for validating metadata instance documents
  - Schematron rules for validation constraints
  - Direct generation from conceptual UML models
  - Replaces ISO/TS 19115-3:2016 (withdrawn)

### ISO 19115-1:2014 - Fundamentals
- **Status**: Published April 2014, under revision
- **Type**: International Standard to be revised (Stage 90.92)
- **Purpose**: Core metadata schema for geographic information and services
- **Amendments**:
  - Amendment 1:2018
  - Amendment 2:2020
- **Will be replaced by**: ISO/AWI 19115-1 (under development)

### ISO 19115-2 - Extensions for Imagery and Gridded Data
- **Purpose**: Extends ISO 19115-1 for satellite imagery and gridded data
- **Integration**: Implemented through ISO 19115-3:2023

## Key Findings

1. **Most Current Standard**: ISO 19115-3:2023 is the current XML implementation standard
2. **Foundation**: Built on ISO 19115-1:2014 (with amendments) and ISO 19115-2
3. **XML Focus**: Direct XML schema generation from UML models
4. **Validation**: Includes both XML Schema and Schematron validation rules

## Standard Applications
- Cataloguing of all types of geographic resources
- Geographic services and datasets description
- Dataset series and individual feature description
- Data discovery, fitness for use, access, and transfer

## Related Standards
- ISO/TS 19139 (predecessor XML implementation)
- ISO 19118 (UML to XML transformation rules)
- ISO/IEC 19757-3 (Schematron validation)

## Next Steps for Research
1. Identify tools supporting ISO 19115-3:2023
2. Assess backward compatibility with ISO 19115-1:2014
3. Research CSDGM relationship and mapping
4. Tool analysis for QGIS, R, and Python

*Last updated: September 8, 2025*
