# ETL Process Documentation

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

This document describes the Extract, Transform, and Load (ETL) process implemented for the Healthcare Analytics & Business Intelligence System.

The ETL pipeline transforms raw healthcare discharge records into a dimensional data warehouse optimized for analytical reporting and business intelligence.

The process includes:

* Data extraction
* Data profiling
* Data quality assessment
* Dimension loading
* Fact loading
* Validation
* Optimization
* Analytical asset creation

The ETL workflow follows dimensional modeling best practices and supports scalable healthcare analytics.

---

# 2. ETL Architecture

```text
SPARCS Source Dataset
         │
         ▼
      Extract
         │
         ▼
 staging.sparcs_raw
         │
         ▼
 Data Profiling
         │
         ▼
 Data Quality Assessment
         │
         ▼
 Dimension Loading
         │
         ▼
 Fact Loading
         │
         ▼
 Validation
         │
         ▼
 Optimization
         │
         ▼
 Analytics Views
         │
         ▼
 Materialized Views
         │
         ▼
 SQL Analytics
```

---

# 3. Source System

## Dataset

SPARCS 2024 Hospital Inpatient Discharge Data

Provider:

New York State Department of Health

---

## Dataset Characteristics

| Attribute   | Value                          |
| ----------- | ------------------------------ |
| File Format | CSV                            |
| Rows        | 2,196,737                      |
| Columns     | 33                             |
| Granularity | One inpatient discharge record |

---

## Source Purpose

The dataset contains de-identified inpatient discharge records used for:

* Healthcare utilization analysis
* Clinical analysis
* Financial reporting
* Risk assessment
* Geographic analysis
* Business intelligence reporting

---

# 4. Extraction Phase

## Objective

Load the raw SPARCS dataset into PostgreSQL without modification.

---

## Target Table

```sql
staging.sparcs_raw
```

---

## Extraction Strategy

The extraction process preserves source fidelity.

No transformations are applied during extraction.

Benefits:

* Source integrity
* Auditability
* Repeatable processing
* Simplified troubleshooting

---

## Output

```text
2,196,737 records loaded
```

into:

```sql
staging.sparcs_raw
```

---

# 5. Data Profiling Phase

## Objective

Understand data quality, structure, and modeling requirements.

---

## Profiling Activities

### Missing Value Analysis

Evaluated:

* Birth Weight
* Payment Typologies
* Procedure Fields
* Geographic Attributes

---

### Cardinality Analysis

Evaluated:

* Hospitals
* Counties
* Diagnoses
* Procedures
* Severity Levels
* Payment Categories

---

### Business Key Analysis

Validated:

* Hospital identifiers
* Dimension uniqueness
* Candidate business keys

---

### Fact Grain Validation

Confirmed:

```text
One discharge record = One fact record
```

---

## Deliverables

* Data Profiling Report
* Business Key Decisions
* Dimension Design Requirements

---

# 6. Data Quality Assessment

## Objective

Evaluate data quality before warehouse construction.

---

## Major Findings

| Data Element       | Missing Percentage |
| ------------------ | ------------------ |
| Birth Weight       | 90.54%             |
| Payment Typology 3 | 89.07%             |
| Payment Typology 2 | 54.83%             |
| Procedure Fields   | 29.31%             |
| ZIP Code           | 1.91%              |
| Hospital Fields    | 0.24%              |

---

## Decisions

### Birth Weight

Retained in staging layer.

Not incorporated into warehouse design.

---

### Procedure Fields

Retained.

Missing values handled through Unknown Member strategy.

---

### Payment Fields

Retained.

Mapped through payment dimension.

---

### Data Imputation

No imputation performed.

Reason:

This project focuses on Business Intelligence rather than predictive modeling.

---

# 7. Business Key Identification

## Objective

Identify reliable natural keys for dimensional modeling.

---

## Hospital Investigation

### Candidate Key 1

Facility Name

Distinct Values:

```text
203
```

---

### Candidate Key 2

Permanent Facility ID

Distinct Values:

```text
205
```

---

## Validation Results

### Facility ID → Facility Name

```text
0 inconsistencies
```

---

### Facility Name → Facility ID

```text
3 inconsistencies
```

---

## Final Decision

Hospital Business Key:

```text
permanent_facility_id
```

---

# 8. Dimension Loading Phase

## Objective

Create reusable business entities for analytical reporting.

---

## Dimension Tables

```text
dim_hospital
dim_patient
dim_diagnosis
dim_procedure
dim_severity
dim_payment
dim_admission
```

---

# 9. Dimension Transformation Logic

## dim_hospital

Source Fields:

* Permanent Facility ID
* Facility Name
* Hospital County
* Health Service Area

Output:

```sql
warehouse.dim_hospital
```

---

## dim_patient

Source Fields:

* Age Group
* Gender
* Race
* Ethnicity

Output:

```sql
warehouse.dim_patient
```

---

## dim_diagnosis

Source Fields:

* CCSR Diagnosis
* APR DRG
* APR MDC

Output:

```sql
warehouse.dim_diagnosis
```

---

## dim_procedure

Source Fields:

* CCSR Procedure Code
* Procedure Description

Output:

```sql
warehouse.dim_procedure
```

---

## dim_severity

Source Fields:

* APR Severity
* APR Mortality Risk
* Medical/Surgical Indicator

Output:

```sql
warehouse.dim_severity
```

---

## dim_payment

Source Fields:

* Payment Typology 1
* Payment Typology 2
* Payment Typology 3

Output:

```sql
warehouse.dim_payment
```

---

## dim_admission

Source Fields:

* Admission Type
* Patient Disposition
* Emergency Department Indicator

Output:

```sql
warehouse.dim_admission
```

---

# 10. Surrogate Key Generation

## Objective

Create warehouse-managed identifiers.

---

## Implementation

Each dimension receives:

```text
Surrogate Key
```

Examples:

```text
hospital_key
patient_key
diagnosis_key
procedure_key
severity_key
payment_key
admission_key
```

---

## Benefits

* Faster joins
* Stable relationships
* Improved warehouse performance
* Simplified fact loading

---

# 11. Unknown Member Strategy

## Objective

Handle unmatched or missing dimension values.

---

## Implementation

Each dimension contains:

```text
Surrogate Key = 0
```

---

## Purpose

* Preserve referential integrity
* Prevent fact row loss
* Support data quality analysis

---

## Example

```text
hospital_key = 0
facility_name = 'Unknown'
```

---

# 12. Fact Loading Phase

## Objective

Populate the central transaction fact table.

---

## Target Table

```sql
warehouse.fact_discharge
```

---

## Grain

One row per inpatient discharge record.

---

## Source

```sql
staging.sparcs_raw
```

and

```sql
warehouse.dim_*
```

---

## Loading Steps

### Step 1

Resolve dimension business keys.

---

### Step 2

Assign surrogate keys.

---

### Step 3

Apply Unknown Member handling when necessary.

---

### Step 4

Load measures.

---

### Step 5

Insert fact records.

---

# 13. Measures Loaded

The following measures are stored in the fact table.

---

## admission_count

Purpose:

Admission volume analysis.

---

## total_charges

Purpose:

Financial reporting.

---

## total_costs

Purpose:

Cost analysis.

---

## length_of_stay_days

Purpose:

Operational and clinical reporting.

---

# 14. Fact Load Results

| Metric            | Value     |
| ----------------- | --------- |
| Expected Rows     | 2,196,737 |
| Actual Rows       | 2,196,737 |
| Validation Result | PASS      |

---

# 15. Validation Phase

## Objective

Ensure warehouse integrity and completeness.

---

## Validation Checks

### Row Count Reconciliation

Compare source and fact table counts.

---

### Foreign Key Validation

Ensure valid dimension references.

---

### Unknown Key Analysis

Verify unmatched record handling.

---

### Fact Consistency Checks

Validate warehouse completeness.

---

## Results

| Validation            | Result |
| --------------------- | ------ |
| Row Count Validation  | PASS   |
| Fact Completeness     | PASS   |
| Dimension Mapping     | PASS   |
| Referential Integrity | PASS   |

---

# 16. Optimization Phase

## Objective

Improve analytical query performance.

---

## Implemented Optimizations

### Fact Indexes

```text
hospital_key
patient_key
diagnosis_key
procedure_key
severity_key
payment_key
admission_key
```

---

### Composite Indexes

```text
(hospital_key, total_charges)

(hospital_key, total_costs)
```

---

### Dimension Business Key Indexes

```text
facility_id

ccsr_diagnosis_code

ccsr_procedure_code
```

---

## Performance Activities

* Query benchmarking
* EXPLAIN ANALYZE testing
* Index validation
* Optimization tuning

---

# 17. Analytics Layer Creation

## Objective

Create reusable analytical assets.

---

## Analytics Views

```text
v_executive_summary
v_hospital_performance
v_patient_demographics
v_clinical_analysis
v_financial_summary
v_geographic_analysis
v_risk_analysis
v_operations
v_clinical_detail
v_hospital_clinical
v_financial_detail
```

---

## Purpose

* SQL analytics
* KPI calculations
* Business reporting
* Ad-hoc analysis

---

# 18. Materialized Views

## Objective

Demonstrate PostgreSQL optimization techniques.

---

## Materialized Views

```text
mv_hospital_performance
mv_financial_summary
mv_geographic_analysis
mv_risk_analysis
```

---

## Purpose

* Reporting acceleration
* Query optimization
* Performance benchmarking
* PostgreSQL feature demonstration

---

# 19. Power BI Integration

## Data Source Strategy

Power BI consumes the dimensional warehouse directly.

---

### Fact Table

```sql
warehouse.fact_discharge
```

---

### Dimensions

```sql
warehouse.dim_hospital
warehouse.dim_patient
warehouse.dim_diagnosis
warehouse.dim_procedure
warehouse.dim_severity
warehouse.dim_payment
warehouse.dim_admission
```

---

## Benefits

* Direct Star Schema modeling
* Flexible DAX calculations
* Better analytical flexibility
* Simplified semantic model

---

# 20. ETL Success Metrics

The ETL process successfully achieved:

* Complete source ingestion
* Successful dimensional modeling
* Successful fact loading
* Referential integrity preservation
* KPI-ready data structures
* Business-ready analytical assets
* Power BI integration readiness

---

# 21. Summary

The ETL process transforms over 2.1 million inpatient discharge records into a scalable dimensional healthcare data warehouse.

The pipeline incorporates data profiling, business key discovery, dimensional modeling, surrogate key management, validation, optimization, and analytical asset creation while preserving data quality and supporting enterprise-style business intelligence reporting.
