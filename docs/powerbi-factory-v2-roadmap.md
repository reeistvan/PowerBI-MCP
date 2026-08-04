# Power BI Factory V2 Roadmap

## Theme 1 - Enterprise Data Model

### 1. Star Schema Implementation
- Business Value: Enables cleaner reporting, easier filtering, and better scalability for future analytics use cases.
- Technical Complexity: High
- Priority: High

### 2. Surrogate Keys
- Business Value: Improves model stability, supports consistent dimension relationships, and simplifies future data refreshes.
- Technical Complexity: Medium
- Priority: High

### 3. DimDate
- Business Value: Enables time-based analysis such as YTD, MTD, period comparison, and trend reporting.
- Technical Complexity: Medium
- Priority: High

### 4. DimRegion
- Business Value: Supports region-based analysis and improves consistency across executive, regional, and product insights.
- Technical Complexity: Medium
- Priority: High

### 5. DimProduct
- Business Value: Enables product-level segmentation and cross-analysis with regions and claim types.
- Technical Complexity: Medium
- Priority: High

### 6. DimClaimType
- Business Value: Adds a business-relevant categorization layer for claim analysis and deeper drill-down capability.
- Technical Complexity: Medium
- Priority: Medium

## Theme 2 - Advanced Measures

### 1. YTD
- Business Value: Supports executive and monthly performance tracking with period-over-period context.
- Technical Complexity: Medium
- Priority: High

### 2. MTD
- Business Value: Helps users assess short-term claim trends and current-period performance quickly.
- Technical Complexity: Medium
- Priority: High

### 3. Previous Period
- Business Value: Improves comparability across periods and supports trend-based decision-making.
- Technical Complexity: Medium
- Priority: High

### 4. Growth %
- Business Value: Makes changes over time immediately understandable for business users.
- Technical Complexity: Medium
- Priority: High

### 5. Trend KPIs
- Business Value: Strengthens the reporting experience by providing dynamic performance indicators across time.
- Technical Complexity: Medium
- Priority: Medium

## Theme 3 - Security

### 1. RLS Design
- Business Value: Protects sensitive claim and financial information and enables role-based access control.
- Technical Complexity: High
- Priority: High

### 2. Role Design
- Business Value: Ensures the right user groups see the right data and reduces unnecessary exposure of business information.
- Technical Complexity: Medium
- Priority: High

### 3. Security Testing
- Business Value: Validates that access rules work correctly and reduces operational risk.
- Technical Complexity: Medium
- Priority: High

## Theme 4 - Governance

### 1. Ownership Matrix
- Business Value: Clarifies accountability for data quality, model changes, and report content.
- Technical Complexity: Medium
- Priority: High

### 2. Change Management
- Business Value: Reduces unintended impact from model or report changes and improves auditability.
- Technical Complexity: Medium
- Priority: High

### 3. Data Steward Process
- Business Value: Establishes a repeatable process for data quality handling, issue triage, and ownership.
- Technical Complexity: Medium
- Priority: High

### 4. Audit Trail
- Business Value: Improves traceability of model and report changes for governance and compliance needs.
- Technical Complexity: Medium
- Priority: Medium

## Theme 5 - Deployment

### 1. Git Workflow
- Business Value: Improves collaboration, version control, and change tracking across report and model work.
- Technical Complexity: Medium
- Priority: High

### 2. PBIP Branching
- Business Value: Enables safer parallel development and cleaner release management for PBIP-based work.
- Technical Complexity: Medium
- Priority: High

### 3. Release Management
- Business Value: Makes deployment predictable and reduces the risk of inconsistent report versions.
- Technical Complexity: Medium
- Priority: Medium

## Theme 6 - MCP Integration

### 1. Semantic Model Review
- Business Value: Improves model quality through structured review of structure, relationships, and consistency.
- Technical Complexity: Medium
- Priority: High

### 2. Measure Review
- Business Value: Ensures measures are correct, documented, and aligned with business definitions.
- Technical Complexity: Medium
- Priority: High

### 3. Report Review
- Business Value: Improves user experience, consistency, and business alignment across report pages.
- Technical Complexity: Medium
- Priority: High

### 4. Governance Review
- Business Value: Strengthens the reporting foundation by validating governance controls and documentation quality.
- Technical Complexity: Medium
- Priority: Medium
