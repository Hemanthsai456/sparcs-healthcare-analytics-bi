# Data Lineage

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

This document describes the complete end-to-end data flow within the Healthcare Analytics & Business Intelligence System.

Data lineage provides visibility into:

* Data origins
* Data movement
* Data transformations
* Data destinations
* Reporting dependencies
* Business intelligence consumption

The lineage ensures transparency and traceability throughout the analytical lifecycle.

---

# 2. Purpose of Data Lineage

Data lineage helps stakeholders understand:

* Where data originates
* How data is transformed
* How analytical assets are created
* How KPIs are calculated
* How reports consume warehouse data

Benefits include:

* Improved governance
* Easier troubleshooting
* Better auditability
* Greater trust in reporting
* Simplified maintenance

---

# 3. End-to-End Data Flow

```text id="g8m7za"
SPARCS 2024 Hospital Inpatient Discharge Dataset
                        │
                        ▼
                 Source Layer
                        │
                        ▼
                staging.sparcs_raw
                        │
                        ▼
        Data Profiling & Quality Assessment
                        │
                        ▼
             Dimension Construction
                        │
                        ▼
              Warehouse Layer
        (Dimensions + Fact Table)
                        │
          ┌─────────────┴─────────────┐
          │                           │
          ▼                           ▼

      Power BI                 Analytics Layer

(Fact + Dimensions)            Analytics Views
                                   │
                                   ▼
                             Materialized Views
                                   │
                                   ▼
                          Business SQL Analysis
```

---

# 4. Source Layer

## Data Source

SPARCS 2024 Hospital Inpatient Discharge Data

Provider:

New York State Department of Health

---

## Source Characteristics

| Attribute   | Value                          |
| ----------- | ------------------------------ |
| Format      | CSV                            |
| Rows        | 2,196,737                      |
| Columns     | 33                             |
| Granularity | One inpatient discharge record |

---

## Purpose

The source layer provides the raw healthcare discharge data used throughout the warehouse and reporting environment.

---

# 5. Staging Layer

## Schema

```sql id="w15ps6"
staging
```

---

## Table

```sql id="jq70tq"
staging.sparcs_raw
```

---

## Input

```text id="8iuzpn"
SPARCS CSV Dataset
```

---

## Output

Raw healthcare records loaded into PostgreSQL.

---

## Purpose

The staging layer acts as the landing zone for source data.

Responsibilities:

* Data ingestion
* Source preservation
* Data profiling support
* Data quality assessment
* ETL processing

---

## Transformations

No major transformations occur within staging.

The goal is to preserve source fidelity.

---

# 6. Data Profiling Layer

## Input

```sql id="qvk1w0"
staging.sparcs_raw
```

---

## Activities

### Missing Value Analysis

Evaluated:

* Birth Weight
* Payment Typologies
* Procedure Fields
* Hospital Attributes

---

### Cardinality Analysis

Evaluated:

* Hospitals
* Counties
* Health Service Areas
* Diagnoses
* Procedures
* Severity Categories

---

### Business Key Discovery

Validated:

* Hospital business keys
* Dimension uniqueness
* Fact grain suitability

---

## Outputs

* Data Profiling Report
* Business Key Decisions
* Dimension Design Requirements

---

# 7. Dimension Loading Layer

Dimension tables are created from the staging layer.

---

## Source

```sql id="kpn1lz"
staging.sparcs_raw
```

---

## Target Dimensions

```text id="wqefy7"
warehouse.dim_hospital
warehouse.dim_patient
warehouse.dim_diagnosis
warehouse.dim_procedure
warehouse.dim_severity
warehouse.dim_payment
warehouse.dim_admission
```

---

## Transformation Logic

### Hospital

Source Fields:

```text id="7xkvd7"
Permanent Facility ID
Facility Name
Hospital County
Health Service Area
```

Target:

```text id="5qte1w"
dim_hospital
```

---

### Patient

Source Fields:

```text id="ezvy2e"
Age Group
Gender
Race
Ethnicity
```

Target:

```text id="5h0ot7"
dim_patient
```

---

### Diagnosis

Source Fields:

```text id="9on2z6"
CCSR Diagnosis
APR DRG
APR MDC
```

Target:

```text id="8kjvq8"
dim_diagnosis
```

---

### Procedure

Source Fields:

```text id="mg8db8"
CCSR Procedure Fields
```

Target:

```text id="ktuvzc"
dim_procedure
```

---

### Severity

Source Fields:

```text id="pqtzq8"
APR Severity
APR Mortality Risk
Medical/Surgical Indicator
```

Target:

```text id="kzvqkl"
dim_severity
```

---

### Payment

Source Fields:

```text id="utv59z"
Payment Typology Fields
```

Target:

```text id="07nhq9"
dim_payment
```

---

### Admission

Source Fields:

```text id="mrxvzw"
Admission Type
Patient Disposition
Emergency Department Indicator
```

Target:

```text id="v8s9s6"
dim_admission
```

---

## Outputs

Dimension tables with surrogate keys.

---

# 8. Fact Loading Layer

## Source

```sql id="1myl0m"
staging.sparcs_raw
```

and

```sql id="prc7wa"
warehouse dimensions
```

---

## Target

```sql id="ck1t7z"
warehouse.fact_discharge
```

---

## Grain

One row per inpatient discharge record.

---

## Transformation Logic

### Surrogate Key Resolution

Business keys are matched against dimensions.

Dimension surrogate keys are assigned to fact rows.

---

### Unknown Member Handling

When no match exists:

```text id="59a0rb"
Surrogate Key = 0
```

is assigned.

---

### Measure Population

Measures loaded:

* admission_count
* total_charges
* total_costs
* length_of_stay_days

---

## Output

```sql id="6q5z8v"
warehouse.fact_discharge
```

containing:

```text id="jgtjlwm"
2,196,737 rows
```

---

# 9. Warehouse Layer

## Purpose

Acts as the central analytical repository.

---

## Tables

### Fact

```text id="b4p7ol"
fact_discharge
```

---

### Dimensions

```text id="u0q9i6"
dim_hospital
dim_patient
dim_diagnosis
dim_procedure
dim_severity
dim_payment
dim_admission
```

---

## Output

Provides the primary source for:

* Power BI
* SQL Analytics
* KPI Calculations
* Business Reporting

---

# 10. Analytics Layer

## Schema

```sql id="1z6w9z"
analytics
```

---

## Purpose

Provide reusable analytical datasets and business calculations.

---

## Input

```sql id="w2yccr"
warehouse.fact_discharge
warehouse.dim_*
```

---

## Analytics Views

### Executive

```text id="07f4ow"
v_executive_summary
```

---

### Hospital

```text id="w1v9r1"
v_hospital_performance
```

---

### Patient

```text id="gxj9v4"
v_patient_demographics
```

---

### Clinical

```text id="p6y4s8"
v_clinical_analysis
v_clinical_detail
v_hospital_clinical
```

---

### Financial

```text id="vbkfrh"
v_financial_summary
v_financial_detail
```

---

### Geographic

```text id="m3x0x6"
v_geographic_analysis
```

---

### Operational

```text id="bcp79o"
v_operations
```

---

### Risk

```text id="7gwb6h"
v_risk_analysis
```

---

## Output

Business-ready analytical datasets.

---

# 11. Materialized View Layer

## Purpose

Demonstrate advanced PostgreSQL optimization and reporting acceleration techniques.

---

## Input

Analytics Views

---

## Materialized Views

```text id="fjlwmz"
mv_hospital_performance
mv_financial_summary
mv_geographic_analysis
mv_risk_analysis
```

---

## Purpose

* Query benchmarking
* Performance optimization
* Reporting acceleration
* PostgreSQL feature demonstration

---

## Output

Pre-aggregated reporting datasets.

---

# 12. Business SQL Analytics Layer

## Input

* Warehouse tables
* Analytics views
* Materialized views

---

## Analytical Domains

* Hospital Analytics
* Patient Analytics
* Clinical Analytics
* Financial Analytics
* Operational Analytics
* Geographic Analytics
* Risk Analytics

---

## Purpose

Generate:

* Business findings
* Trend analysis
* KPI reporting
* Strategic insights

---

## Output

Business insight documentation and analytical reports.

---

# 13. Power BI Consumption Layer

## Purpose

Provide interactive business intelligence dashboards.

---

## Data Sources

Power BI connects directly to the dimensional warehouse.

---

### Fact Table

```sql id="ljw0tm"
warehouse.fact_discharge
```

---

### Dimensions

```sql id="8itd7m"
warehouse.dim_hospital
warehouse.dim_patient
warehouse.dim_diagnosis
warehouse.dim_procedure
warehouse.dim_severity
warehouse.dim_payment
warehouse.dim_admission
```

---

## Not Used Directly

Power BI does not directly consume:

```text id="b5e1ae"
analytics views
materialized views
```

These assets support SQL analytics and optimization workflows.

---

## Output

Interactive dashboards for:

* Executive Analytics
* Hospital Analytics
* Patient Analytics
* Clinical Analytics
* Financial Analytics
* Geographic Analytics
* Risk & Severity Analytics

---

# 14. KPI Lineage

Example KPI:

### Total Admissions

Source:

```text id="qgexqm"
SPARCS Dataset
```

↓

```text id="a6uwtb"
staging.sparcs_raw
```

↓

```text id="xf9r3o"
warehouse.fact_discharge.admission_count
```

↓

```text id="ms1qgc"
SUM(admission_count)
```

↓

```text id="m5m7z4"
Power BI KPI Card
```

---

Example KPI:

### Average Length of Stay

Source:

```text id="7r8zvr"
length_of_stay_days
```

↓

```text id="4jy5dz"
AVG(length_of_stay_days)
```

↓

```text id="ysp0j5"
Dashboard Visualization
```

---

# 15. Data Governance Considerations

The lineage supports:

* Traceability
* Transparency
* Validation
* Auditability
* Reporting consistency

All reported metrics can be traced back to source-level discharge records.

---

# 16. Summary

The Healthcare Analytics & Business Intelligence System implements a fully traceable data lineage from raw SPARCS discharge records through staging, dimensional modeling, fact loading, analytical processing, SQL reporting, and Power BI visualization.

The architecture maintains clear separation between warehouse storage, analytical processing, optimization assets, and business intelligence consumption while ensuring consistency, transparency, and scalability across the reporting environment.
