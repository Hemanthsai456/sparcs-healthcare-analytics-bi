# Data Profiling Report

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Executive Summary

Data profiling was performed on the SPARCS 2024 Hospital Inpatient Discharge dataset to understand data quality, identify business keys, assess dimensional modeling requirements, and validate the suitability of the dataset for analytical reporting.

The profiling process examined:

* Dataset structure
* Missing values
* Cardinality
* Business keys
* Data quality issues
* Fact table grain
* Dimension design requirements

The findings from this analysis directly influenced the warehouse architecture, star schema design, ETL process, and reporting strategy.

---

# 2. Dataset Overview

## Dataset

SPARCS 2024 Hospital Inpatient Discharge Data

---

## Source

New York State Department of Health

---

## Dataset Characteristics

| Attribute   | Value                          |
| ----------- | ------------------------------ |
| Format      | CSV                            |
| Rows        | 2,196,737                      |
| Columns     | 33                             |
| Granularity | One inpatient discharge record |
| Data Type   | Structured Tabular Data        |

---

## Analytical Purpose

The dataset supports:

* Healthcare utilization analysis
* Clinical analysis
* Financial reporting
* Operational reporting
* Risk assessment
* Geographic analysis
* Business intelligence dashboards

---

# 3. Profiling Objectives

The profiling phase was designed to answer the following questions:

### Data Quality

* Are there significant missing values?
* Are there invalid values?
* Are there data consistency issues?

---

### Data Modeling

* What should the fact table grain be?
* Which dimensions should be created?
* Which business keys are reliable?

---

### Reporting

* Which attributes are useful for analytics?
* Which measures can support KPI calculations?

---

### Warehouse Design

* How should the star schema be structured?
* What surrogate key strategy should be used?
* Is an Unknown Member strategy required?

---

# 4. Profiling Methodology

The profiling process consisted of multiple analytical stages.

---

## Stage 1: Dataset Structure Review

Examined:

* Column names
* Data types
* Business meanings
* Candidate dimensions
* Candidate measures

---

## Stage 2: Missing Value Analysis

Evaluated completeness of each attribute.

---

## Stage 3: Cardinality Analysis

Measured uniqueness and distinct value counts.

---

## Stage 4: Business Key Discovery

Validated uniqueness and consistency of candidate identifiers.

---

## Stage 5: Fact Grain Validation

Confirmed the most appropriate level of detail for the warehouse.

---

## Stage 6: Dimension Design Assessment

Identified business entities and reporting attributes.

---

# 5. Missing Value Analysis

## Objective

Determine completeness of critical reporting attributes.

---

## Results

| Attribute Category | Missing Percentage |
| ------------------ | ------------------ |
| Birth Weight       | 90.54%             |
| Payment Typology 3 | 89.07%             |
| Payment Typology 2 | 54.83%             |
| Procedure Fields   | 29.31%             |
| ZIP Code           | 1.91%              |
| Hospital Fields    | 0.24%              |

---

# 6. Missing Value Findings

## Birth Weight

### Missing Percentage

```text
90.54%
```

### Assessment

Extremely sparse.

Not suitable for reliable reporting.

### Decision

Retained in staging layer.

Excluded from dimensional warehouse design.

---

## Payment Typology 2

### Missing Percentage

```text
54.83%
```

### Assessment

Expected because many encounters have only a primary payer.

### Decision

Retained.

Handled through payment dimension.

---

## Payment Typology 3

### Missing Percentage

```text
89.07%
```

### Assessment

Expected because tertiary payers are uncommon.

### Decision

Retained.

Handled through payment dimension.

---

## Procedure Fields

### Missing Percentage

```text
29.31%
```

### Assessment

Significant but acceptable.

Many encounters legitimately have no procedure classification.

### Decision

Retained.

Missing values handled using Unknown Member strategy.

---

## ZIP Code

### Missing Percentage

```text
1.91%
```

### Assessment

Low impact.

### Decision

No special handling required.

---

## Hospital Attributes

### Missing Percentage

```text
0.24%
```

### Assessment

Excellent completeness.

### Decision

Suitable for dimensional modeling.

---

# 7. Cardinality Analysis

## Objective

Understand uniqueness and reporting potential of attributes.

---

## Results

| Attribute             | Distinct Values |
| --------------------- | --------------- |
| Health Service Area   | 8               |
| Hospital County       | 57              |
| Facility Name         | 203             |
| Permanent Facility ID | 205             |
| Age Group             | 5               |
| Gender                | 3               |
| Race                  | 4               |
| Ethnicity             | 4               |
| Diagnosis Categories  | 478             |
| Procedure Categories  | 320             |
| APR DRG               | 336             |
| APR MDC               | 26              |

---

# 8. Cardinality Findings

## Low Cardinality Attributes

Examples:

```text
Age Group
Gender
Race
Ethnicity
Severity Categories
```

These are ideal dimension attributes.

---

## Medium Cardinality Attributes

Examples:

```text
Hospitals
Counties
Diagnoses
Procedures
```

These support effective analytical segmentation.

---

## High Cardinality Concerns

No attributes exhibited problematic cardinality levels for warehouse design.

---

# 9. Business Key Investigation

## Objective

Identify reliable natural keys for dimensional modeling.

---

# 10. Hospital Key Analysis

Two potential identifiers existed:

---

## Candidate Key 1

Facility Name

Distinct Values:

```text
203
```

---

## Candidate Key 2

Permanent Facility ID

Distinct Values:

```text
205
```

---

# 11. Validation Test 1

## Question

Can a Permanent Facility ID map to multiple hospital names?

---

## Result

```text
0 rows returned
```

---

## Conclusion

Permanent Facility IDs uniquely identify hospitals.

---

# 12. Validation Test 2

## Question

Can a Facility Name map to multiple Permanent Facility IDs?

---

## Result

```text
3 hospitals identified
```

Affected Hospitals:

* BRONXCARE HOSPITAL CENTER
* THE UNIVERSITY OF VERMONT HEALTH NETWORK - ALICE HYDE MEDICAL CENTER
* WYOMING COUNTY COMMUNITY HOSPITAL

---

## Conclusion

Facility Name is not a reliable business key.

---

# 13. Final Hospital Business Key

Selected Key:

```text
permanent_facility_id
```

Reason:

* Unique
* Stable
* Consistent
* Suitable for dimensional modeling

---

# 14. Fact Grain Analysis

## Objective

Determine the most appropriate level of detail for the fact table.

---

## Source Observation

Each source row represents one inpatient discharge event.

---

## Candidate Grains Considered

### Hospital-Level Grain

Rejected.

Would remove detailed analytical flexibility.

---

### Regional Grain

Rejected.

Would eliminate patient-level reporting capabilities.

---

### Discharge-Level Grain

Accepted.

---

# 15. Final Fact Grain

```text
One fact row = One inpatient discharge record
```

---

## Benefits

* Maximum analytical flexibility
* Detailed reporting
* Accurate aggregations
* Consistent KPI calculations

---

# 16. Dimension Design Findings

The profiling process identified seven major business entities.

---

## Hospital

Business Key:

```text
permanent_facility_id
```

---

## Patient

Business Key:

```text
(age_group,
gender,
race,
ethnicity)
```

---

## Diagnosis

Business Key:

```text
Diagnosis Classification Fields
```

---

## Procedure

Business Key:

```text
Procedure Classification Fields
```

---

## Severity

Business Key:

```text
Severity Classification Fields
```

---

## Payment

Business Key:

```text
Payment Typology Fields
```

---

## Admission

Business Key:

```text
Admission and Disposition Fields
```

---

# 17. Unknown Member Requirement

Profiling revealed the need for a standardized strategy to handle:

* Missing values
* Invalid values
* Unmatched dimension records

---

## Decision

Each dimension includes:

```text
Surrogate Key = 0
```

---

## Benefits

* Prevent fact row loss
* Preserve referential integrity
* Simplify ETL processing

---

# 18. Fact Table Validation

## Target Table

```sql
warehouse.fact_discharge
```

---

## Validation Results

| Metric            | Value     |
| ----------------- | --------- |
| Expected Rows     | 2,196,737 |
| Actual Rows       | 2,196,737 |
| Validation Status | PASS      |

---

# 19. Unknown Key Analysis

| Dimension | Unknown Records |
| --------- | --------------- |
| Hospital  | 5,295           |
| Patient   | 0               |
| Diagnosis | 0               |
| Procedure | 0               |
| Severity  | 0               |
| Payment   | 0               |
| Admission | 0               |

---

## Assessment

Unknown member usage is minimal and well controlled.

No significant data quality concerns were identified.

---

# 20. Profiling Impact on Warehouse Design

The profiling phase directly influenced:

### Star Schema Design

* Fact grain selection
* Dimension creation
* Relationship design

---

### ETL Design

* Surrogate key strategy
* Unknown member implementation
* Validation procedures

---

### Reporting Design

* KPI development
* Dashboard structure
* Analytical domains

---

# 21. Major Business Findings

The profiling process revealed several important business insights.

---

## Healthcare Utilization

Emergency admissions represent a substantial portion of inpatient activity.

---

## Payer Mix

Medicare appears to be a dominant payer category.

---

## Geographic Concentration

New York City contributes a significant share of healthcare activity.

---

## Clinical Complexity

Cardiovascular-related diagnoses represent a major utilization segment.

---

## Cost Drivers

Long-stay patients contribute disproportionately to healthcare costs.

---

## Data Quality

Overall dataset quality is strong and supports enterprise-style analytical reporting.

---

# 22. Summary

The SPARCS 2024 dataset demonstrates strong analytical value and high overall data quality.

Data profiling successfully identified business keys, validated dimensional modeling decisions, confirmed the fact table grain, and established the foundation for the Healthcare Analytics & Business Intelligence System.

The profiling results directly informed the warehouse architecture, ETL design, reporting strategy, and Power BI dashboard development while ensuring analytical consistency and data integrity throughout the project lifecycle.
