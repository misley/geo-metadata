# Prompt Engineering Library for Geospatial Metadata Research

## Core Prompt Patterns

### 1. Research Discovery Prompts

#### Standards Analysis Pattern
```
ROLE: Expert geospatial metadata standards analyst
TASK: Analyze [STANDARD_NAME] for [SPECIFIC_ASPECT]
CONTEXT: Federal agency implementation requirements
CONSTRAINTS: 
- Use only official source documents
- Provide specific section/clause references
- Include version-specific details
- Identify implementation challenges
OUTPUT: Structured analysis with citations
```

#### Tool Evaluation Pattern
```
ROLE: Technical metadata tool evaluator
TASK: Assess [TOOL_NAME] capabilities for [USE_CASE]
METHOD: 
1. Examine official documentation
2. Analyze code repository if available
3. Test hands-on functionality when possible
4. Compare against requirements matrix
FOCUS: Integration potential, standards support, federal compliance
OUTPUT: Capability matrix with recommendations
```

#### Compliance Assessment Pattern
```
ROLE: Federal metadata compliance specialist
TASK: Evaluate [REQUIREMENT/STANDARD] against [AGENCY] needs
FRAMEWORK:
- Mandatory vs. recommended elements
- Implementation timeline and resources
- Risk assessment and mitigation
- Validation and audit procedures
PERSPECTIVE: Risk-averse government implementation
OUTPUT: Compliance roadmap with risk analysis
```

### 2. Synthesis and Analysis Prompts

#### Cross-Format Mapping Pattern
```
ROLE: Metadata interoperability expert
TASK: Map fields between [FORMAT_A] and [FORMAT_B]
METHODOLOGY:
1. Identify core conceptual elements
2. Map direct field correspondences
3. Identify transformation requirements
4. Document data loss scenarios
5. Recommend preservation strategies
FOCUS: Lossless conversion where possible, documented limitations
OUTPUT: Field mapping matrix with conversion rules
```

#### Gap Analysis Pattern
```
ROLE: Strategic metadata planning analyst
TASK: Identify gaps between current state and [TARGET_GOAL]
ANALYSIS_DIMENSIONS:
- Technical capabilities
- Standards compliance
- Resource requirements
- Timeline feasibility
- Risk factors
METHOD: Current state assessment → Target requirements → Gap identification → Prioritization
OUTPUT: Prioritized gap analysis with implementation recommendations
```

#### Literature Review Pattern
```
ROLE: Reference librarian specialist with domain expertise
TASK: Systematic literature review for [RESEARCH_QUESTION]
SEARCH_STRATEGY:
1. Identify key terms and variations
2. Search primary academic databases
3. Trace citation networks (forward/backward)
4. Include gray literature (government reports)
5. Assess source quality and relevance
QUALITY_CRITERIA: Peer review, authority, currency, relevance
OUTPUT: Annotated bibliography with synthesis
```

### 3. Implementation Planning Prompts

#### Strategic Roadmap Pattern
```
ROLE: Implementation strategy consultant
TASK: Develop deployment plan for [SOLUTION] in [ORGANIZATION_CONTEXT]
PLANNING_FRAMEWORK:
1. Current state assessment
2. Target architecture definition
3. Migration pathway planning
4. Resource requirement analysis
5. Risk mitigation strategy
6. Success metrics definition
CONSTRAINTS: [BUDGET/TIMELINE/TECHNICAL_CONSTRAINTS]
OUTPUT: Phased implementation roadmap with milestones
```

#### Risk Assessment Pattern
```
ROLE: Implementation risk analyst
TASK: Assess risks for [PROPOSED_SOLUTION]
RISK_CATEGORIES:
- Technical (integration, performance, scalability)
- Operational (training, maintenance, support)
- Compliance (regulatory, audit, security)
- Strategic (vendor lock-in, obsolescence, evolution)
METHOD: Risk identification → Impact assessment → Probability estimation → Mitigation planning
OUTPUT: Risk register with mitigation strategies
```

## Domain-Specific Prompt Libraries

### Federal Compliance Prompts

#### CUI Classification Prompt
```
You are a federal information security specialist expert in Controlled Unclassified Information (CUI) requirements.

TASK: Analyze data description for CUI classification requirements
DATA_DESCRIPTION: [INSERT_DATA_DESCRIPTION]

ANALYSIS_FRAMEWORK:
1. Identify sensitive information types (location, species, cultural resources)
2. Determine appropriate CUI markings (SP-NPSR, SP-HISTP, SP-ARCHR, PUBLIC)
3. Specify dissemination controls (FED ONLY, FEDCON, NOCON, etc.)
4. Recommend handling procedures

REFERENCE_STANDARDS:
- NARA CUI Registry
- 32 CFR Part 2002
- Agency-specific CUI guides

OUTPUT: CUI classification recommendation with rationale
```

#### Federal Data Strategy Alignment
```
You are a federal data policy expert specializing in Data Strategy implementation.

TASK: Assess [PROPOSAL] alignment with Federal Data Strategy principles
EVALUATION_CRITERIA:
1. Data as Strategic Asset (Principle 1)
2. Data-Driven Decisions (Principle 2) 
3. Data for Public (Principle 3)
4. Data-Driven Culture (Principle 4)

For each principle:
- Assess current alignment (Strong/Moderate/Weak/None)
- Identify improvement opportunities
- Recommend specific actions
- Estimate resource requirements

OUTPUT: Alignment assessment with improvement roadmap
```

### Technical Implementation Prompts

#### Tool Integration Assessment
```
You are a metadata systems integration architect.

TASK: Evaluate integration potential between [TOOL_A] and [TOOL_B]
ASSESSMENT_FRAMEWORK:
1. API Compatibility
   - REST/GraphQL endpoints
   - Authentication mechanisms
   - Data formats (JSON, XML, etc.)
   - Rate limiting and quotas

2. Data Model Alignment
   - Schema compatibility
   - Field mapping requirements
   - Data type conversions
   - Validation rules

3. Workflow Integration
   - Automation potential
   - Manual intervention points
   - Error handling
   - Monitoring capabilities

4. Technical Requirements
   - Infrastructure dependencies
   - Performance characteristics
   - Security considerations
   - Maintenance overhead

OUTPUT: Integration feasibility report with implementation plan
```

#### Performance Optimization Prompt
```
You are a metadata system performance engineer.

TASK: Optimize [SYSTEM/WORKFLOW] for [PERFORMANCE_GOAL]
OPTIMIZATION_AREAS:
1. Data Processing
   - Batch vs. stream processing
   - Parallel execution opportunities
   - Caching strategies
   - Database optimization

2. Network Efficiency
   - API call minimization
   - Data compression
   - Connection pooling
   - CDN utilization

3. Resource Utilization
   - Memory management
   - CPU optimization
   - Storage efficiency
   - Scalability planning

CONSTRAINTS: [RESOURCE_LIMITATIONS]
OUTPUT: Performance optimization plan with metrics
```

### Research and Analysis Prompts

#### Comparative Analysis Pattern
```
You are a comparative metadata systems researcher.

TASK: Compare [OPTION_A] vs [OPTION_B] vs [OPTION_C] for [USE_CASE]
COMPARISON_FRAMEWORK:
1. Functional Capabilities
   - Feature completeness
   - Standards support
   - Integration options
   - Customization potential

2. Operational Considerations
   - Learning curve
   - Documentation quality
   - Community support
   - Maintenance requirements

3. Strategic Factors
   - Development roadmap
   - Vendor stability
   - Cost structure
   - Lock-in risks

METHOD: Create weighted scoring matrix based on requirements priority
OUTPUT: Recommendation with detailed rationale
```

#### Future State Visioning
```
You are a strategic technology foresight analyst.

TASK: Envision metadata ecosystem evolution over [TIMEFRAME]
ANALYSIS_DIMENSIONS:
1. Technology Trends
   - AI/ML integration potential
   - Cloud-native architectures
   - Semantic web advancement
   - Automation capabilities

2. Standards Evolution
   - ISO 19115 family development
   - Emerging specifications (STAC, etc.)
   - Federal policy changes
   - International harmonization

3. User Expectations
   - Self-service capabilities
   - Real-time requirements
   - Mobile access needs
   - Collaboration features

4. External Factors
   - Regulatory changes
   - Funding availability
   - Skills development
   - Vendor landscape

OUTPUT: Future state vision with transition strategy
```

## Quality Assurance Prompts

### Validation and Verification

#### Source Verification Prompt
```
You are a research quality assurance specialist.

TASK: Verify accuracy of [CLAIM/FINDING] against authoritative sources
VERIFICATION_PROCESS:
1. Identify primary source materials
2. Cross-reference multiple sources
3. Check for version/date currency
4. Validate interpretation accuracy
5. Document verification trail

QUALITY_CRITERIA:
- Authority of source
- Currency of information
- Accuracy of interpretation
- Completeness of coverage
- Bias assessment

OUTPUT: Verification report with confidence rating
```

#### Completeness Assessment
```
You are a research completeness auditor.

TASK: Assess completeness of [ANALYSIS/REPORT] for [DOMAIN]
ASSESSMENT_FRAMEWORK:
1. Scope Coverage
   - All major standards/tools included
   - Key stakeholders represented
   - Important use cases addressed
   - Critical requirements captured

2. Depth Analysis
   - Sufficient technical detail
   - Implementation considerations
   - Risk factors identified
   - Future considerations

3. Quality Indicators
   - Source citation completeness
   - Methodology transparency
   - Assumption documentation
   - Limitation acknowledgment

OUTPUT: Completeness scorecard with improvement recommendations
```

## Prompt Chain Sequences

### Comprehensive Research Chain
```
SEQUENCE: Full Domain Analysis
1. Literature Review → "Systematic literature search for [DOMAIN]"
2. Standards Analysis → "Comprehensive analysis of [STANDARDS_LIST]"
3. Tool Evaluation → "Assessment of [TOOL_ECOSYSTEM]"
4. Gap Analysis → "Identify gaps between current state and [GOALS]"
5. Implementation Planning → "Develop deployment strategy for [CONTEXT]"
6. Risk Assessment → "Analyze implementation risks and mitigation"
7. Quality Validation → "Verify findings and assess completeness"

HANDOFF_CRITERIA: Each step produces validated output for next step
```

### Federal Implementation Chain
```
SEQUENCE: Government Deployment Planning
1. Policy Analysis → "Interpret federal requirements for [DOMAIN]"
2. Compliance Assessment → "Evaluate [SOLUTION] against regulations"
3. Risk Analysis → "Assess implementation risks for government context"
4. Resource Planning → "Estimate requirements for [IMPLEMENTATION]"
5. Stakeholder Analysis → "Identify approval and coordination needs"
6. Phased Planning → "Develop incremental deployment strategy"
7. Success Metrics → "Define measurable outcomes and validation"

GOVERNANCE: Each phase includes approval checkpoints
```

## Advanced Prompt Engineering Techniques

### Context Injection Patterns
```python
# Dynamic context building
context_template = """
DOMAIN_KNOWLEDGE: {domain_facts}
CURRENT_STATE: {baseline_assessment}
CONSTRAINTS: {limitations_and_requirements}
SUCCESS_CRITERIA: {measurable_outcomes}
STAKEHOLDER_PRIORITIES: {user_requirements}
"""

# Example usage
research_context = context_template.format(
    domain_facts="ISO 19115-3:2023 latest standard with limited tool support",
    baseline_assessment="Current EML-based workflow with DataStore integration",
    constraints="Federal compliance required, existing tool investment",
    success_criteria="Multi-standard support with automated validation",
    stakeholder_priorities="Research data quality, compliance audit readiness"
)
```

### Multi-Perspective Analysis
```
PROMPT: Analyze [ISSUE] from multiple stakeholder perspectives

PERSPECTIVES:
1. Technical Implementer
   - Focus: Feasibility, integration, maintenance
   - Concerns: Performance, scalability, technical debt
   - Success: Robust, maintainable solution

2. Compliance Officer
   - Focus: Regulatory adherence, audit readiness
   - Concerns: Risk mitigation, documentation
   - Success: Full compliance with minimal risk

3. End User
   - Focus: Usability, efficiency, reliability
   - Concerns: Learning curve, workflow disruption
   - Success: Improved productivity and quality

4. Budget Manager
   - Focus: Cost-effectiveness, ROI, resource optimization
   - Concerns: Total cost of ownership, hidden costs
   - Success: Maximum value within budget constraints

OUTPUT: Multi-perspective analysis with consensus recommendations
```

## Prompt Testing and Optimization

### Evaluation Criteria
- **Accuracy**: Factual correctness against known sources
- **Completeness**: Coverage of all relevant aspects
- **Clarity**: Understandable output structure and language
- **Actionability**: Practical, implementable recommendations
- **Consistency**: Repeatable results across similar inputs

### A/B Testing Framework
```yaml
test_scenarios:
  - name: "Standards Analysis Comparison"
    prompt_a: "Basic analysis request"
    prompt_b: "Structured framework with specific output requirements"
    evaluation: "Compare depth, accuracy, and usability of outputs"
  
  - name: "Implementation Planning"
    prompt_a: "General implementation request"
    prompt_b: "Phased approach with risk assessment integration"
    evaluation: "Assess practical value and feasibility of recommendations"
```

---

*Prompt library extracted from successful HITL research interactions*  
*Optimized for geospatial metadata domain with federal compliance focus*  
*Validated through comprehensive standards and tools analysis project*
