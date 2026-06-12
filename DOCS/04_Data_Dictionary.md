# Data Dictionary

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

This document provides metadata definitions for all tables and columns used within the Healthcare Analytics & Business Intelligence System.

The Data Dictionary serves as the authoritative reference for:

* Data definitions
* Business meanings
* Data types
* Primary keys
* Foreign keys
* Business keys
* Reporting usage

The warehouse follows a dimensional Star Schema design consisting of one fact table and seven dimension tables.

---

# 2. Warehouse Schema Overview

## Schema

```sql
warehouse
```

---

## Fact Table

```text
fact_discharge
```

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

# 3. Dimension: dim_hospital

## Table Purpose

Stores hospital and geographic information used for facility-level and regional healthcare analysis.

---

## Table Statistics

| Attribute    | Value        |
| ------------ | ------------ |
| Table Name   | dim_hospital |
| Schema       | warehouse    |
| Primary Key  | hospital_key |
| Business Key | facility_id  |
| Row Count    | 206          |

---

## Column Definitions

| Column Name                  | Data Type    | Description                   |
| ---------------------------- | ------------ | ----------------------------- |
| hospital_key                 | INTEGER      | Surrogate primary key         |
| facility_id                  | INTEGER      | Permanent Facility Identifier |
| facility_name                | VARCHAR(150) | Hospital name                 |
| operating_certificate_number | VARCHAR(20)  | Operating certificate number  |
| hospital_county              | VARCHAR(50)  | County location               |
| health_service_area          | VARCHAR(50)  | Health Service Area           |

---

## Reporting Usage

Used in:

* Hospital Analytics
* Geographic Analytics
* Executive Dashboard
* Financial Analysis

---

# 4. Dimension: dim_patient

## Table Purpose

Stores patient demographic attributes used for population and utilization analysis.

---

## Table Statistics

| Attribute    | Value                                 |
| ------------ | ------------------------------------- |
| Table Name   | dim_patient                           |
| Schema       | warehouse                             |
| Primary Key  | patient_key                           |
| Business Key | age_group + gender + race + ethnicity |
| Row Count    | 205                                   |

---

## Column Definitions

| Column Name | Data Type   | Description           |
| ----------- | ----------- | --------------------- |
| patient_key | INTEGER     | Surrogate primary key |
| age_group   | VARCHAR(20) | Patient age category  |
| gender      | VARCHAR(10) | Patient gender        |
| race        | VARCHAR(50) | Patient race          |
| ethnicity   | VARCHAR(50) | Patient ethnicity     |

---

## Reporting Usage

Used in:

* Patient Analytics
* Demographic Reporting
* Risk Analysis
* Clinical Analysis

---

# 5. Dimension: dim_diagnosis

## Table Purpose

Stores diagnosis classifications and clinical groupings.

---

## Table Statistics

| Attribute   | Value         |
| ----------- | ------------- |
| Table Name  | dim_diagnosis |
| Schema      | warehouse     |
| Primary Key | diagnosis_key |
| Row Count   | 6,795         |

---

## Column Definitions

| Column Name                | Data Type    | Description                               |
| -------------------------- | ------------ | ----------------------------------------- |
| diagnosis_key              | INTEGER      | Surrogate primary key                     |
| ccsr_diagnosis_code        | VARCHAR(20)  | CCSR diagnosis code                       |
| ccsr_diagnosis_description | VARCHAR(300) | Diagnosis description                     |
| apr_drg_code               | INTEGER      | APR DRG code                              |
| apr_drg_description        | VARCHAR(500) | APR DRG description                       |
| apr_mdc_code               | INTEGER      | APR Major Diagnostic Category code        |
| apr_mdc_description        | VARCHAR(500) | APR Major Diagnostic Category description |

---

## Reporting Usage

Used in:

* Clinical Analytics
* Risk Analytics
* Cost Analysis
* Diagnosis Reporting

---

# 6. Dimension: dim_procedure

## Table Purpose

Stores procedure classifications used for healthcare service analysis.

---

## Table Statistics

| Attribute   | Value         |
| ----------- | ------------- |
| Table Name  | dim_procedure |
| Schema      | warehouse     |
| Primary Key | procedure_key |
| Row Count   | 322           |

---

## Column Definitions

| Column Name                | Data Type    | Description           |
| -------------------------- | ------------ | --------------------- |
| procedure_key              | INTEGER      | Surrogate primary key |
| ccsr_procedure_code        | VARCHAR(20)  | CCSR procedure code   |
| ccsr_procedure_description | VARCHAR(300) | Procedure description |

---

## Reporting Usage

Used in:

* Clinical Analytics
* Procedure Utilization Analysis
* Cost Analysis

---

# 7. Dimension: dim_severity

## Table Purpose

Stores patient severity and mortality classifications.

---

## Table Statistics

| Attribute   | Value        |
| ----------- | ------------ |
| Table Name  | dim_severity |
| Schema      | warehouse    |
| Primary Key | severity_key |
| Row Count   | 33           |

---

## Column Definitions

| Column Name                         | Data Type   | Description                     |
| ----------------------------------- | ----------- | ------------------------------- |
| severity_key                        | INTEGER     | Surrogate primary key           |
| apr_severity_of_illness_code        | INTEGER     | Severity classification code    |
| apr_severity_of_illness_description | VARCHAR(50) | Severity category               |
| apr_risk_of_mortality               | VARCHAR(50) | Mortality risk category         |
| apr_medical_surgical_description    | VARCHAR(50) | Medical/Surgical classification |

---

## Reporting Usage

Used in:

* Risk Analytics
* Severity Reporting
* Clinical Analysis
* Executive Dashboard

---

# 8. Dimension: dim_payment

## Table Purpose

Stores healthcare payer information.

---

## Table Statistics

| Attribute   | Value       |
| ----------- | ----------- |
| Table Name  | dim_payment |
| Schema      | warehouse   |
| Primary Key | payment_key |
| Row Count   | 433         |

---

## Column Definitions

| Column Name        | Data Type   | Description           |
| ------------------ | ----------- | --------------------- |
| payment_key        | INTEGER     | Surrogate primary key |
| payment_typology_1 | VARCHAR(50) | Primary payer         |
| payment_typology_2 | VARCHAR(50) | Secondary payer       |
| payment_typology_3 | VARCHAR(50) | Tertiary payer        |

---

## Reporting Usage

Used in:

* Financial Analytics
* Payer Analysis
* Executive Dashboard

---

# 9. Dimension: dim_admission

## Table Purpose

Stores admission and discharge characteristics.

---

## Table Statistics

| Attribute   | Value         |
| ----------- | ------------- |
| Table Name  | dim_admission |
| Schema      | warehouse     |
| Primary Key | admission_key |
| Row Count   | 202           |

---

## Column Definitions

| Column Name                    | Data Type    | Description                    |
| ------------------------------ | ------------ | ------------------------------ |
| admission_key                  | INTEGER      | Surrogate primary key          |
| type_of_admission              | VARCHAR(50)  | Admission category             |
| patient_disposition            | VARCHAR(500) | Patient discharge outcome      |
| emergency_department_indicator | VARCHAR(10)  | Emergency Department indicator |

---

## Reporting Usage

Used in:

* Operational Analytics
* Length of Stay Analysis
* Emergency Utilization Analysis

---

# 10. Fact Table: fact_discharge

## Table Purpose

Stores measurable inpatient discharge events and serves as the central table within the dimensional model.

---

## Table Statistics

| Attribute   | Value                          |
| ----------- | ------------------------------ |
| Table Name  | fact_discharge                 |
| Schema      | warehouse                      |
| Primary Key | discharge_key                  |
| Grain       | One inpatient discharge record |
| Row Count   | 2,196,737                      |

---

# 11. Fact Table Foreign Keys

| Foreign Key   | References    |
| ------------- | ------------- |
| hospital_key  | dim_hospital  |
| patient_key   | dim_patient   |
| diagnosis_key | dim_diagnosis |
| procedure_key | dim_procedure |
| severity_key  | dim_severity  |
| payment_key   | dim_payment   |
| admission_key | dim_admission |

---

# 12. Fact Table Column Definitions

| Column Name         | Data Type     | Description              |
| ------------------- | ------------- | ------------------------ |
| discharge_key       | BIGSERIAL     | Fact table primary key   |
| hospital_key        | INTEGER       | Hospital foreign key     |
| patient_key         | INTEGER       | Patient foreign key      |
| diagnosis_key       | INTEGER       | Diagnosis foreign key    |
| procedure_key       | INTEGER       | Procedure foreign key    |
| severity_key        | INTEGER       | Severity foreign key     |
| payment_key         | INTEGER       | Payment foreign key      |
| admission_key       | INTEGER       | Admission foreign key    |
| discharge_year      | SMALLINT      | Discharge year           |
| length_of_stay_raw  | VARCHAR(5)    | Original LOS value       |
| length_of_stay_days | INTEGER       | Numeric LOS value        |
| total_charges       | NUMERIC(14,2) | Total charges            |
| total_costs         | NUMERIC(14,2) | Total costs              |
| admission_count     | SMALLINT      | Admission counter        |
| created_at          | TIMESTAMP     | Warehouse load timestamp |

---

# 13. Fact Table Measures

The following columns are considered measures:

| Measure             | Description        |
| ------------------- | ------------------ |
| admission_count     | Admission volume   |
| total_charges       | Healthcare charges |
| total_costs         | Healthcare costs   |
| length_of_stay_days | Length of stay     |

---

# 14. Derived Metrics

Derived metrics are intentionally not stored within the fact table.

Examples include:

* Average Length of Stay
* Average Charge Per Admission
* Average Cost Per Admission
* Charge-to-Cost Ratio
* Emergency Admission Rate
* Severity Rate
* Mortality Risk Rate

These metrics are calculated dynamically through:

* SQL Analytics
* Analytics Views
* Power BI Measures

---

# 15. Power BI Data Model Usage

Power BI consumes the dimensional warehouse directly.

Tables imported into Power BI:

```text
warehouse.fact_discharge

warehouse.dim_hospital
warehouse.dim_patient
warehouse.dim_diagnosis
warehouse.dim_procedure
warehouse.dim_severity
warehouse.dim_payment
warehouse.dim_admission
```

This design preserves analytical flexibility while maintaining a clean Star Schema structure.

---

# 16. Unknown Member Strategy

Each dimension contains an Unknown Member record.

Implementation:

```text
Surrogate Key = 0
```

Purpose:

* Preserve referential integrity
* Prevent fact row loss
* Handle missing dimension values

---

# 17. Summary

The Healthcare Analytics & Business Intelligence System Data Dictionary provides a centralized reference for all warehouse objects, ensuring consistent understanding of business definitions, table structures, relationships, and reporting assets across the entire analytical platform.
