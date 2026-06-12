# Star Schema Design

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

The Healthcare Analytics & Business Intelligence System uses a Star Schema dimensional model to support healthcare analytics, business intelligence reporting, SQL analytics, and Power BI dashboard development.

The Star Schema was selected because it provides:

* Simpler analytical queries
* Faster aggregations
* Better reporting performance
* Reduced query complexity
* Improved Power BI integration
* Easier business user adoption
* Scalable analytical architecture

The warehouse is designed around a central fact table containing inpatient discharge events and multiple dimension tables that provide descriptive business context.

---

# 2. Why Star Schema?

Several modeling approaches were evaluated during warehouse design.

---

## Third Normal Form (3NF)

### Advantages

* Reduced redundancy
* Strong transactional integrity
* Efficient operational processing

### Limitations

* Complex joins
* Poor analytical performance
* Difficult dashboard development
* Not optimized for business reporting

### Decision

Not selected because the project focuses on analytical reporting rather than transactional processing.

---

## Snowflake Schema

### Advantages

* Reduced redundancy
* Highly normalized structure
* Strong data consistency

### Limitations

* Additional joins
* Increased query complexity
* Reduced reporting simplicity
* Harder for business users to understand

### Decision

Not selected because reporting simplicity and Power BI integration were prioritized.

---

## Star Schema

### Advantages

* Simplified reporting
* Faster aggregations
* Reduced query complexity
* Excellent Power BI integration
* Business-friendly structure
* Easier maintenance

### Decision

Selected as the primary warehouse architecture.

---

# 3. Warehouse Structure

The dimensional warehouse consists of:

## Fact Table

```text id="cyh4rq"
warehouse.fact_discharge
```

---

## Dimension Tables

```text id="zlw4im"
warehouse.dim_hospital
warehouse.dim_patient
warehouse.dim_diagnosis
warehouse.dim_procedure
warehouse.dim_severity
warehouse.dim_payment
warehouse.dim_admission
```

---

# 4. Star Schema Diagram

```text id="e8prku"
                          dim_hospital
                                |
                                |
                                |
dim_patient ----- fact_discharge ----- dim_diagnosis
                                |
                                |
                           dim_procedure
                                |
                                |
                           dim_severity
                                |
                                |
                            dim_payment
                                |
                                |
                           dim_admission
```

---

## Visual Diagram

<img src="./images/star_schema.png" alt="Star Schema" width="500" />

The fact table serves as the central hub of the dimensional model.

All analytical reporting originates from the fact table and joins to surrounding dimensions through surrogate keys.

---

# 5. Fact Table Design

## Table

```text id="v0xwwi"
warehouse.fact_discharge
```

---

## Business Purpose

Stores measurable healthcare events related to inpatient discharge activity.

The fact table serves as the primary source for:

* KPI calculations
* Power BI dashboards
* SQL analytics
* Business reporting
* Financial analysis
* Clinical analysis

---

# 6. Fact Table Grain

## Definition

One row represents one inpatient discharge record.

---

## Why This Grain Was Selected

The SPARCS dataset is naturally recorded at the discharge-event level.

Selecting discharge-level grain provides:

* Maximum analytical flexibility
* Detailed reporting capability
* Accurate aggregations
* Consistent KPI calculations
* Reusable reporting assets

---

## Examples

| Admission           | Fact Rows |
| ------------------- | --------- |
| Patient Discharge A | 1         |
| Patient Discharge B | 1         |
| Patient Discharge C | 1         |

Each discharge generates exactly one fact record.

---

## Benefits

* Supports all reporting domains
* Enables drill-down analysis
* Preserves source-level detail
* Prevents unnecessary aggregation

---

# 7. Fact Table Size

| Metric       | Value                |
| ------------ | -------------------- |
| Rows         | 2,196,737            |
| Grain        | One discharge record |
| Fact Type    | Transaction Fact     |
| Measures     | 4                    |
| Foreign Keys | 7                    |

---

# 8. Fact Table Measures

The fact table stores quantitative metrics used for reporting.

---

## admission_count

### Description

Admission counter.

### Purpose

Supports counting admissions through aggregation.

### Example

```sql id="jlwm8y"
SUM(admission_count)
```

---

## total_charges

### Description

Total amount charged for the inpatient encounter.

### Purpose

Supports:

* Revenue analysis
* Financial reporting
* Payer analysis

---

## total_costs

### Description

Estimated hospital cost associated with the inpatient encounter.

### Purpose

Supports:

* Cost analysis
* Efficiency reporting
* Resource utilization analysis

---

## length_of_stay_days

### Description

Numeric inpatient length of stay.

### Purpose

Supports:

* Operational reporting
* Clinical analysis
* Length of stay calculations

---

# 9. Fact Table Attributes

The fact table also stores descriptive attributes.

---

## discharge_year

Used for:

* Time-based reporting
* Trend analysis
* Year-level filtering

---

## length_of_stay_raw

Stores the original SPARCS LOS values.

Examples:

```text id="4q3x38"
120+
45
12
5
```

Purpose:

* Preserve source fidelity
* Maintain auditability
* Support validation

---

# 10. Dimension Design

Dimensions provide descriptive business context for analytical reporting.

Each dimension represents a business entity that can be used for filtering, grouping, and slicing data.

---

# 11. Dimension: Hospital

## Table

```text id="5xh8zt"
warehouse.dim_hospital
```

---

## Business Purpose

Provides hospital and geographic context.

---

## Business Key

```text id="rlq2ks"
permanent_facility_id
```

---

## Key Attributes

* Facility ID
* Facility Name
* Operating Certificate Number
* Hospital County
* Health Service Area

---

## Example Analysis

* Hospital performance
* Geographic analysis
* Regional utilization
* Facility benchmarking

---

# 12. Dimension: Patient

## Table

```text id="0i3d0v"
warehouse.dim_patient
```

---

## Business Purpose

Provides patient demographic information.

---

## Business Key

```text id="svvd2i"
(age_group, gender, race, ethnicity)
```

---

## Key Attributes

* Age Group
* Gender
* Race
* Ethnicity

---

## Example Analysis

* Demographic trends
* Population analysis
* Utilization by age group
* Risk analysis by population segment

---

# 13. Dimension: Diagnosis

## Table

```text id="6h2vwc"
warehouse.dim_diagnosis
```

---

## Business Purpose

Provides diagnosis classification information.

---

## Key Attributes

* CCSR Diagnosis Code
* CCSR Diagnosis Description
* APR DRG
* APR MDC

---

## Example Analysis

* Diagnosis frequency
* Clinical utilization
* Disease burden analysis
* Cost by diagnosis

---

# 14. Dimension: Procedure

## Table

```text id="t8pj89"
warehouse.dim_procedure
```

---

## Business Purpose

Provides procedure classification information.

---

## Key Attributes

* CCSR Procedure Code
* Procedure Description

---

## Example Analysis

* Procedure utilization
* Service line analysis
* Procedure cost analysis

---

# 15. Dimension: Severity

## Table

```text id="9g3qiw"
warehouse.dim_severity
```

---

## Business Purpose

Provides severity and mortality classifications.

---

## Key Attributes

* Severity Level
* Mortality Risk
* Medical/Surgical Indicator

---

## Example Analysis

* Severity distribution
* Mortality risk assessment
* Clinical complexity analysis

---

# 16. Dimension: Payment

## Table

```text id="u5n0r8"
warehouse.dim_payment
```

---

## Business Purpose

Provides payer information.

---

## Key Attributes

* Primary Payer
* Secondary Payer
* Tertiary Payer

---

## Example Analysis

* Payer mix
* Revenue analysis
* Financial performance

---

# 17. Dimension: Admission

## Table

```text id="9w5j3h"
warehouse.dim_admission
```

---

## Business Purpose

Provides admission and discharge context.

---

## Key Attributes

* Admission Type
* Patient Disposition
* Emergency Department Indicator

---

## Example Analysis

* Admission trends
* Emergency utilization
* Patient flow analysis
* Discharge outcomes

---

# 18. Relationship Design

All dimensions connect directly to the fact table.

---

## Relationship Pattern

```text id="yyv93f"
Dimension (1)
      │
      │
      ▼
Fact (Many)
```

---

## Cardinality

| Dimension | Relationship |
| --------- | ------------ |
| Hospital  | 1:M          |
| Patient   | 1:M          |
| Diagnosis | 1:M          |
| Procedure | 1:M          |
| Severity  | 1:M          |
| Payment   | 1:M          |
| Admission | 1:M          |

---

## Join Structure

```sql id="0ah2s3"
fact_discharge.hospital_key
→ dim_hospital.hospital_key

fact_discharge.patient_key
→ dim_patient.patient_key

fact_discharge.diagnosis_key
→ dim_diagnosis.diagnosis_key

fact_discharge.procedure_key
→ dim_procedure.procedure_key

fact_discharge.severity_key
→ dim_severity.severity_key

fact_discharge.payment_key
→ dim_payment.payment_key

fact_discharge.admission_key
→ dim_admission.admission_key
```

---

# 19. Surrogate Key Strategy

All dimensions use surrogate keys.

Examples:

```text id="a1kz42"
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

### Improved Performance

Integer joins outperform business-key joins.

### Stability

Warehouse relationships remain independent of source changes.

### Simplicity

Provides a consistent dimensional design.

### Scalability

Supports future warehouse expansion.

---

# 20. Unknown Member Strategy

Each dimension contains an Unknown Member record.

Implementation:

```text id="ngc6o2"
Surrogate Key = 0
```

---

## Purpose

* Prevent fact row loss
* Preserve referential integrity
* Handle missing dimension values
* Handle unmatched records

---

## Example

```text id="9p1p1x"
hospital_key = 0
facility_name = 'Unknown'
```

---

## Benefits

* Successful ETL execution
* Consistent reporting
* Better data quality handling

---

# 21. Design Decisions

## Hospital Business Key

Selected:

```text id="kfs93g"
permanent_facility_id
```

Reason:

Facility Name was not uniquely associated with hospitals.

---

## Derived Metrics

Not stored physically in the fact table.

Examples:

* Average LOS
* Average Cost Per Admission
* Average Charge Per Admission
* Charge-to-Cost Ratio
* Emergency Admission Rate

These metrics are calculated dynamically through SQL and Power BI measures.

---

## Direct Power BI Consumption

Power BI connects directly to:

```text id="l4s9rl"
warehouse.fact_discharge

warehouse.dim_hospital
warehouse.dim_patient
warehouse.dim_diagnosis
warehouse.dim_procedure
warehouse.dim_severity
warehouse.dim_payment
warehouse.dim_admission
```

This allows Power BI to leverage the full dimensional model and maintain analytical flexibility.

---

# 22. Benefits of the Final Design

The implemented Star Schema provides:

* Simplified reporting
* Faster aggregations
* Better Power BI performance
* Reduced query complexity
* Business-friendly structure
* Scalable architecture
* Reusable analytical assets

---

# 23. Summary

The Healthcare Analytics & Business Intelligence System uses a dimensional Star Schema centered around a discharge-level transaction fact table and seven supporting dimensions.

The design supports healthcare analytics across executive, financial, clinical, operational, geographic, demographic, and risk domains while providing excellent compatibility with Power BI and maintaining strong analytical performance.
