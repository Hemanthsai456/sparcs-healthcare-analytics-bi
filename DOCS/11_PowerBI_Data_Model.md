# Power BI Data Model

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

This document describes the Power BI semantic model used to support interactive reporting and business intelligence dashboards.

Power BI connects directly to the dimensional warehouse implemented in PostgreSQL using a Star Schema architecture.

The model is designed to provide:

* Fast analytical reporting
* Consistent KPI calculations
* Simplified dashboard development
* Efficient filtering and aggregation
* Scalable business intelligence workflows

The Power BI model serves as the foundation for all dashboard pages within the Healthcare Analytics & Business Intelligence System.

---

# 2. Data Model Architecture

The Power BI model follows a Star Schema design.

A central fact table stores measurable healthcare events while dimension tables provide descriptive business attributes.

## Model Structure

```text
                    dim_hospital
                          |
                          |
dim_patient ---- fact_discharge ---- dim_diagnosis
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

The fact table acts as the central hub and connects to all dimensions through surrogate keys.

---

# 3. Data Sources

Power BI imports data directly from the PostgreSQL dimensional warehouse.

## Fact Table

```text
warehouse.fact_discharge
```

---

## Dimension Tables

```text
warehouse.dim_hospital
warehouse.dim_patient
warehouse.dim_diagnosis
warehouse.dim_procedure
warehouse.dim_severity
warehouse.dim_payment
warehouse.dim_admission
```

---

# 4. Fact Table

## Table

```text
warehouse.fact_discharge
```

---

## Purpose

Stores measurable healthcare events used throughout the reporting environment.

---

## Grain

One row represents one inpatient discharge record.

---

## Row Count

```text
2,196,737
```

---

## Measures Stored

* admission_count
* total_charges
* total_costs
* length_of_stay_days

---

## Descriptive Attributes

* discharge_year
* length_of_stay_raw

---

## Foreign Keys

* hospital_key
* patient_key
* diagnosis_key
* procedure_key
* severity_key
* payment_key
* admission_key

---

# 5. Dimension Tables

Dimension tables provide business context for analytical reporting.

---

## dim_hospital

Purpose:

Stores hospital and geographic attributes.

Key Attributes:

* Facility Name
* Facility ID
* Hospital County
* Health Service Area

Used For:

* Hospital Analytics
* Geographic Analytics

---

## dim_patient

Purpose:

Stores patient demographic information.

Key Attributes:

* Age Group
* Gender
* Race
* Ethnicity

Used For:

* Patient Analytics

---

## dim_diagnosis

Purpose:

Stores diagnosis classifications.

Key Attributes:

* Diagnosis Code
* Diagnosis Description
* APR DRG
* APR MDC

Used For:

* Clinical Analytics

---

## dim_procedure

Purpose:

Stores procedure classifications.

Key Attributes:

* Procedure Code
* Procedure Description

Used For:

* Clinical Analytics

---

## dim_severity

Purpose:

Stores severity and mortality classifications.

Key Attributes:

* Severity Category
* Mortality Risk
* Medical/Surgical Indicator

Used For:

* Risk & Severity Analytics

---

## dim_payment

Purpose:

Stores payer information.

Key Attributes:

* Primary Payer
* Secondary Payer
* Tertiary Payer

Used For:

* Financial Analytics

---

## dim_admission

Purpose:

Stores admission and discharge information.

Key Attributes:

* Admission Type
* Patient Disposition
* Emergency Department Indicator

Used For:

* Executive Analytics
* Operational Analysis

---

# 6. Relationships

The Power BI model uses one-to-many relationships between dimensions and the fact table.

| Dimension Table | Fact Table     | Relationship |
| --------------- | -------------- | ------------ |
| dim_hospital    | fact_discharge | 1 : *        |
| dim_patient     | fact_discharge | 1 : *        |
| dim_diagnosis   | fact_discharge | 1 : *        |
| dim_procedure   | fact_discharge | 1 : *        |
| dim_severity    | fact_discharge | 1 : *        |
| dim_payment     | fact_discharge | 1 : *        |
| dim_admission   | fact_discharge | 1 : *        |

---

# 7. Filter Direction

All relationships use:

```text
Single Direction Filtering
```

Filter flow occurs from:

```text
Dimension Tables
        ↓
Fact Table
```

---

## Benefits

* Improved query performance
* Reduced model complexity
* Predictable filter behavior
* Elimination of ambiguity
* Simplified dashboard development

---

# 8. DAX Measures

The model uses a small set of reusable DAX measures for KPI calculations.

---

## Average Charge per Admission

Purpose:

Calculate average charges generated per admission.

---

## Average Cost per Admission

Purpose:

Calculate average costs incurred per admission.

---

## Charge-to-Cost Ratio

Purpose:

Measure financial efficiency.

---

## Emergency Admission Rate

Purpose:

Measure reliance on emergency department admissions.

---

## Extreme Severity Rate

Purpose:

Measure prevalence of highly severe patient cases.

---

## Extreme Mortality Rate

Purpose:

Measure prevalence of high-risk patient populations.

---

# 9. Dashboard Integration

The Power BI semantic model supports all dashboard pages.

---

## Executive Dashboard

Focus:

Overall healthcare performance.

---

## Hospital Analytics

Focus:

Hospital utilization and efficiency.

---

## Patient Analytics

Focus:

Demographic analysis.

---

## Clinical Analytics

Focus:

Diagnosis and procedure analysis.

---

## Financial Analytics

Focus:

Payer performance and financial efficiency.

---

## Geographic Analytics

Focus:

Regional healthcare utilization.

---

## Risk & Severity Analytics

Focus:

Clinical complexity and mortality risk.

---

# 10. Direct Star Schema Consumption

Power BI connects directly to the dimensional warehouse.

Data sources include:

```text
fact_discharge
+
dimension tables
```

Power BI does not consume:

```text
analytics views
```

or

```text
materialized views
```

directly.

---

## Benefits

* Simplified semantic model
* Better reporting flexibility
* Easier DAX development
* Industry-standard BI architecture
* Reduced dependency on pre-aggregated reporting assets

---

# 11. Performance Considerations

The Power BI model benefits from:

* Star Schema architecture
* Surrogate key relationships
* Fact table indexing
* Dimension table indexing
* Single-direction filtering
* Reusable DAX measures

These design decisions improve report responsiveness and analytical performance.

---

# 12. Summary

The Power BI semantic model provides a scalable and efficient analytical foundation for healthcare reporting.

By consuming the dimensional warehouse directly through a Star Schema design, the model enables consistent KPI calculations, flexible business analysis, and interactive dashboard reporting across hospital, patient, clinical, financial, geographic, and risk domains.

The model aligns with industry-standard business intelligence practices and serves as the reporting layer for the Healthcare Analytics & Business Intelligence System.
