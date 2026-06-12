# Project Architecture

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Architecture Overview

The Healthcare Analytics & Business Intelligence System follows a layered data warehouse architecture designed to transform raw healthcare discharge data into business-ready analytical assets.

The architecture separates data ingestion, storage, transformation, analytics, reporting, and visualization into dedicated layers to ensure maintainability, scalability, and reporting consistency.

The solution uses PostgreSQL 18 as the analytical database platform and Power BI as the business intelligence and visualization layer.

---

# 2. Architecture Objectives

The architecture was designed to achieve the following objectives:

* Centralize healthcare discharge data
* Support multidimensional analytical reporting
* Improve reporting consistency
* Enable business intelligence reporting
* Separate raw data from analytical assets
* Support reusable reporting datasets
* Demonstrate dimensional modeling best practices
* Enable efficient Power BI integration

---

# 3. Architecture Principles

## Layered Architecture

Each layer performs a dedicated responsibility and provides standardized outputs to downstream layers.

Benefits:

* Improved maintainability
* Easier troubleshooting
* Better scalability
* Clear separation of responsibilities

---

## Dimensional Modeling

The warehouse follows a Star Schema design.

Benefits:

* Faster aggregations
* Simplified reporting
* Reduced query complexity
* Better Power BI integration

---

## Separation of Concerns

| Layer     | Responsibility                 |
| --------- | ------------------------------ |
| Source    | Raw healthcare dataset         |
| Staging   | Data ingestion and validation  |
| Warehouse | Dimensional data storage       |
| Analytics | Business reporting assets      |
| Reporting | SQL reporting and optimization |
| BI        | Dashboard visualization        |

---

# 4. High-Level Architecture

```text
SPARCS 2024 Hospital Inpatient Discharge Dataset
                    │
                    ▼
            PostgreSQL Database
                    │
                    ▼
           staging.sparcs_raw
                    │
                    ▼
     Data Profiling & Quality Checks
                    │
                    ▼
            Warehouse Layer
                    │
                    ▼
         Dimension Tables
                    │
                    ▼
          fact_discharge
                    │
      ┌─────────────┼─────────────┐
      │             │             │
      ▼             ▼             ▼

 Power BI     Analytics Views   SQL Analytics
      │             │
      │             ▼
      │      Materialized Views
      │
      ▼

Interactive Dashboards
```

---

# 5. Architecture Diagram

See:

<img src="./images/architecture.png" alt="Star Schema" width="500" />


The architecture diagram visually represents the complete end-to-end flow of data from source ingestion to business intelligence reporting.

---

# 6. Source Layer

## Dataset

SPARCS 2024 Hospital Inpatient Discharge Data

Provider:

New York State Department of Health

### Dataset Characteristics

| Attribute   | Value                          |
| ----------- | ------------------------------ |
| Format      | CSV                            |
| Rows        | 2,196,737                      |
| Columns     | 33                             |
| Granularity | One inpatient discharge record |

Purpose:

* Source data acquisition
* Raw healthcare record storage
* Input for warehouse development

---

# 7. Staging Layer

## Schema

```sql
staging
```

## Table

```sql
staging.sparcs_raw
```

Purpose:

* Raw data ingestion
* Source preservation
* Data profiling support
* Data quality validation
* ETL processing

---

# 8. Warehouse Layer

## Schema

```sql
warehouse
```

The warehouse stores the dimensional model used for analytical reporting.

### Dimension Tables

```text
dim_hospital
dim_patient
dim_diagnosis
dim_procedure
dim_severity
dim_payment
dim_admission
```

### Fact Table

```text
fact_discharge
```

Fact Grain:

```text
One row = One inpatient discharge record
```

Purpose:

* Central analytical repository
* Dimensional reporting
* KPI calculation support
* Power BI integration

---

# 9. Analytics Layer

## Schema

```sql
analytics
```

The analytics layer contains reusable business reporting assets.

### Analytics Views

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

Purpose:

* Reusable business logic
* SQL-based reporting
* Consistent analytical calculations
* Business insight generation

---

# 10. Reporting Layer

The reporting layer contains materialized views used for SQL reporting optimization and performance demonstrations.

### Materialized Views

```text
mv_hospital_performance
mv_financial_summary
mv_geographic_analysis
mv_risk_analysis
```

Purpose:

* Reporting acceleration
* Query optimization demonstrations
* Performance benchmarking

Note:

Power BI does not consume materialized views directly.

---

# 11. Business Intelligence Layer

## Platform

Power BI

Power BI connects directly to the dimensional warehouse.

### Data Sources

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

### Dashboard Pages

1. Executive Dashboard

2. Hospital Analytics

3. Patient Analytics

4. Clinical Analytics

5. Financial Analytics

6. Geographic Analytics

7. Risk & Severity Analytics

Purpose:

* Interactive reporting
* KPI monitoring
* Business intelligence visualization
* Executive decision support

---

# 12. Technology Stack

| Component             | Technology                    |
| --------------------- | ----------------------------- |
| Database              | PostgreSQL 18                 |
| Query Language        | SQL                           |
| Data Warehouse Model  | Star Schema                   |
| Analytics Layer       | PostgreSQL Views              |
| Reporting Layer       | PostgreSQL Materialized Views |
| Business Intelligence | Power BI                      |
| Documentation         | Markdown                      |
| Version Control       | Git & GitHub                  |

---

# 13. Summary

The Healthcare Analytics & Business Intelligence System uses a layered architecture that transforms more than 2.1 million healthcare discharge records into business-ready analytical assets.

The solution combines data warehousing, dimensional modeling, SQL analytics, reporting optimization, and Power BI dashboards while maintaining clear separation between storage, analytics, reporting, and visualization layers.

Power BI consumes the dimensional warehouse directly through a star schema model, while analytics views and materialized views support SQL reporting, optimization, and business insight generation.
