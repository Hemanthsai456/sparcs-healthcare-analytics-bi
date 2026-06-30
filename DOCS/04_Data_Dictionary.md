# Data Dictionary

## 1. Overview

This document defines the dimensional data model implemented within the Healthcare Analytics & Business Intelligence System.

It serves as a reference for the warehouse schema by describing each table, its purpose, key relationships, and column definitions.

The warehouse consists of:

- 8 Dimension Tables
- 1 Fact Table

All tables reside within the `warehouse` schema and follow a Star Schema design.

---

## 2. Warehouse Overview

| Table | Type | Purpose |
|---------|------|---------|
| fact_discharge | Fact | Stores one record per inpatient discharge. |
| dim_hospital | Dimension | Hospital and geographic information. |
| dim_patient | Dimension | Patient demographics. |
| dim_diagnosis | Dimension | Diagnosis classifications. |
| dim_procedure | Dimension | Procedure classifications. |
| dim_severity | Dimension | Severity and mortality information. |
| dim_payment | Dimension | Payment information. |
| dim_admission | Dimension | Admission details. |
| dim_date | Dimension | Discharge year. |

---

## 3. Fact Table

### warehouse.fact_discharge

**Purpose**

Stores one record for every inpatient discharge loaded into the warehouse.

**Grain**

One row = One inpatient discharge.

**Primary Key**

fact_key

**Foreign Keys**

- hospital_key
- patient_key
- diagnosis_key
- procedure_key
- severity_key
- payment_key
- admission_key
- date_key

### Measures

| Column | Data Type | Description |
|---------|-----------|-------------|
| admission_count | INTEGER | Admission counter. |
| total_charges | NUMERIC(14,2) | Total billed charges. |
| total_costs | NUMERIC(14,2) | Estimated treatment costs. |
| length_of_stay_days | INTEGER | Numeric length of stay. |
| length_of_stay_raw | TEXT | Original SPARCS LOS value. |
| created_at | TIMESTAMP | ETL load timestamp. |

---

## 4. Dimension Tables

### dim_hospital

**Purpose**

Stores hospital and geographic information.

**Business Key**

Permanent Facility ID

| Column | Description |
|---------|-------------|
| hospital_key | Surrogate key |
| facility_id | Permanent facility identifier |
| facility_name | Hospital name |
| operating_certificate_number | Operating certificate number |
| hospital_county | County |
| health_service_area | Health Service Area |

---

### dim_patient

**Purpose**

Stores patient demographic attributes.

**Business Key**

Age Group + Gender + Race + Ethnicity

| Column | Description |
|---------|-------------|
| patient_key | Surrogate key |
| age_group | Age category |
| gender | Gender |
| race | Race |
| ethnicity | Ethnicity |

---

### dim_diagnosis

**Purpose**

Stores diagnosis classifications.

| Column | Description |
|---------|-------------|
| diagnosis_key | Surrogate key |
| ccsr_diagnosis_code | Diagnosis code |
| ccsr_diagnosis_description | Diagnosis description |
| apr_drg_code | APR DRG code |
| apr_drg_description | APR DRG description |
| apr_mdc_code | APR MDC code |
| apr_mdc_description | APR MDC description |

---

### dim_procedure

**Purpose**

Stores procedure classifications.

| Column | Description |
|---------|-------------|
| procedure_key | Surrogate key |
| ccsr_procedure_code | Procedure code |
| ccsr_procedure_description | Procedure description |

---

### dim_severity

**Purpose**

Stores patient severity information.

| Column | Description |
|---------|-------------|
| severity_key | Surrogate key |
| apr_severity_of_illness_code | Severity code |
| apr_severity_of_illness_description | Severity description |
| apr_risk_of_mortality | Mortality risk |
| apr_medical_surgical_description | Medical/Surgical classification |

---

### dim_payment

**Purpose**

Stores payment classifications.

| Column | Description |
|---------|-------------|
| payment_key | Surrogate key |
| payment_typology_1 | Primary payer |
| payment_typology_2 | Secondary payer |
| payment_typology_3 | Tertiary payer |

---

### dim_admission

**Purpose**

Stores admission-related information.

| Column | Description |
|---------|-------------|
| admission_key | Surrogate key |
| type_of_admission | Admission type |
| patient_disposition | Patient disposition |
| emergency_department_indicator | Emergency department indicator |

---

### dim_date

**Purpose**

Supports year-based reporting.

| Column | Description |
|---------|-------------|
| date_key | Surrogate key |
| discharge_year | Dataset year |

---

## 5. Relationship Summary

The warehouse follows a one-to-many Star Schema relationship.

Each dimension table joins to the fact table using surrogate keys.

The fact table serves as the central analytical table for SQL reporting, materialized views, and Power BI.

---

## 6. Unknown Member Strategy

Every dimension contains an Unknown Member record with a surrogate key of **0**.

This strategy preserves referential integrity during ETL by ensuring unmatched or missing source values can still be loaded into the fact table without rejecting records.