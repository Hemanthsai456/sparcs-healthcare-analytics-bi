# Business SQL Analytics Guide

## Healthcare Analytics & Business Intelligence System

### Using New York SPARCS Hospital Inpatient Discharge Data

---

# 1. Overview

This document explains the purpose of the SQL-based analytical reporting layer implemented within the Healthcare Analytics & Business Intelligence System.

While Power BI provides interactive dashboards and visual reporting, SQL analytics provide deeper investigation capabilities, reusable reporting assets, performance optimization demonstrations, and business insight generation.

The Business SQL Analytics layer serves as a bridge between the dimensional warehouse and business decision-making.

---

# 2. Purpose of the Business SQL Analytics Layer

The Business SQL Analytics layer was created to:

* Answer business-focused analytical questions
* Demonstrate advanced SQL skills
* Generate business insights directly from the warehouse
* Create reusable reporting datasets
* Showcase PostgreSQL analytical capabilities
* Demonstrate query optimization techniques
* Support business intelligence workflows

---

# 3. Reporting Architecture

The SQL reporting architecture operates independently from the Power BI reporting layer.

```text
SPARCS Dataset
      │
      ▼
staging.sparcs_raw
      │
      ▼
Dimensional Warehouse
      │
      ▼
warehouse.fact_discharge
      │
      ▼
Analytics Views
      │
      ▼
Materialized Views
      │
      ▼
Business SQL Analytics
      │
      ▼
Business Insights
```

---

# 4. Relationship with Power BI

A common misconception is that Power BI consumes the analytics views or materialized views.

This project intentionally does not use that approach.

---

## Power BI Data Sources

Power BI connects directly to:

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

---

## Not Used by Power BI

```text
analytics views

materialized views
```

---

## Why?

Direct Star Schema consumption provides:

* Better flexibility
* Simpler semantic modeling
* Easier DAX development
* Industry-standard Power BI architecture
* Reduced dependency on pre-aggregated reporting assets

---

# 5. Analytics Views

Analytics views provide reusable reporting datasets built on top of the dimensional warehouse.

---

## Purpose

Analytics views centralize business logic and simplify reporting queries.

Benefits:

* Reusable calculations
* Consistent KPI definitions
* Simplified reporting
* Easier analytical development

---

## Implemented Views

### Executive Analytics

```sql
v_executive_summary
```

---

### Hospital Analytics

```sql
v_hospital_performance
```

---

### Patient Analytics

```sql
v_patient_demographics
```

---

### Clinical Analytics

```sql
v_clinical_analysis
v_clinical_detail
v_hospital_clinical
```

---

### Financial Analytics

```sql
v_financial_summary
v_financial_detail
```

---

### Geographic Analytics

```sql
v_geographic_analysis
```

---

### Operational Analytics

```sql
v_operations
```

---

### Risk Analytics

```sql
v_risk_analysis
```

---

# 6. Materialized Views

Materialized views were implemented to demonstrate advanced PostgreSQL reporting optimization techniques.

---

## Purpose

Materialized views store pre-computed results to reduce query execution time.

Benefits:

* Faster aggregations
* Reduced execution time
* Reporting acceleration
* Performance optimization

---

## Implemented Materialized Views

```sql
mv_hospital_performance
mv_financial_summary
mv_geographic_analysis
mv_risk_analysis
```

---

## Refresh Strategy

Materialized views can be refreshed whenever underlying warehouse data changes.

Example:

```sql
REFRESH MATERIALIZED VIEW mv_hospital_performance;
```

---

# 7. Business Analytical Query Domains

Domain-specific SQL queries were developed to answer key business questions.

---

## Hospital Analytics

File:

```text
01_hospital_analytics.sql
```

Example Questions:

* Which hospitals generate the highest admission volume?
* Which hospitals have the longest average stays?
* Which hospitals demonstrate the highest financial efficiency?

---

## Patient Analytics

File:

```text
02_patient_analytics.sql
```

Example Questions:

* Which age groups generate the most admissions?
* How do healthcare costs vary across demographics?
* How does length of stay vary by patient population?

---

## Clinical Analytics

File:

```text
03_clinical_analytics.sql
```

Example Questions:

* Which diagnoses drive healthcare utilization?
* Which procedures are most common?
* Which diagnoses generate the highest costs?

---

## Financial Analytics

File:

```text
04_financial_analytics.sql
```

Example Questions:

* Which payer categories dominate admissions?
* Which payers generate the highest charges?
* How does financial efficiency vary by payer?

---

## Operational Analytics

File:

```text
05_operational_analytics.sql
```

Example Questions:

* What proportion of admissions originate from emergency departments?
* How does length of stay vary across operational categories?

---

## Geographic Analytics

File:

```text
06_geographic_analytics.sql
```

Example Questions:

* Which regions generate the highest demand?
* Which counties have the highest admission volume?
* How do regional costs differ?

---

## Risk Analytics

File:

```text
07_risk_analytics.sql
```

Example Questions:

* How does severity impact costs?
* How does mortality risk affect resource utilization?
* Which patient groups consume the most healthcare resources?

---

# 8. Business Insight Generation Process

The project follows a structured insight-generation workflow.

```text
Warehouse Data
      │
      ▼
Analytics Views
      │
      ▼
SQL Analysis
      │
      ▼
Business Findings
      │
      ▼
Business Insights
```

This process transforms raw healthcare records into actionable business understanding.

---

# 9. Key Business Insight Areas

Analysis performed within this layer contributed to insights across:

* Hospital Performance
* Patient Demographics
* Clinical Utilization
* Financial Performance
* Geographic Demand
* Healthcare Risk
* Resource Consumption

Detailed findings are documented in:

```text
DOCS/12_Business_Insights_Summary.md
```

---

# 10. Skills Demonstrated

The Business SQL Analytics layer demonstrates practical skills in:

### SQL Development

* Complex Queries
* Aggregations
* Window Functions
* Reporting Queries

### PostgreSQL

* Views
* Materialized Views
* Query Optimization
* Performance Analysis

### Business Intelligence

* KPI Development
* Business Reporting
* Insight Generation

### Data Analytics

* Healthcare Analytics
* Financial Analytics
* Operational Analytics
* Risk Analytics

---

# 11. Summary

The Business SQL Analytics layer extends the dimensional warehouse beyond data storage and dashboard reporting.

Through analytics views, materialized views, and domain-specific analytical queries, the project demonstrates how raw healthcare data can be transformed into actionable business intelligence and decision-support insights.

Together with the Power BI dashboards, this layer completes the end-to-end analytics workflow and showcases practical SQL, PostgreSQL, business intelligence, and data analytics skills.
