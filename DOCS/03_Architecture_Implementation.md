# System Architecture & Implementation

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

## 1. Overview

The Healthcare Analytics & Business Intelligence System follows a layered data warehouse architecture designed to transform raw healthcare discharge records into business-ready analytical assets.

Rather than querying raw source files directly, the system separates data ingestion, transformation, storage, reporting, and visualization into independent layers. This approach improves maintainability, scalability, and reporting consistency while allowing the warehouse to grow as additional dataset years become available.

The final implementation integrates seven years of New York State SPARCS inpatient discharge data into a centralized analytical warehouse containing more than 16 million discharge records.

---

## 2. System Architecture

```


                  SPARCS CSV Datasets
        (2011 • 2012 • 2014 • 2018 • 2021 • 2023 • 2024)
                              │
                              ▼
                     Staging Layer
                   staging.sparcs_raw
                              │
                              ▼
          Data Profiling & Quality Validation
                              │
                              ▼
                  ETL Transformation Layer
                              │
             ┌────────────────┴────────────────┐
             ▼                                 ▼
      Dimension Tables                 Date Dimension
             │                                 │
             └──────────────┬──────────────────┘
                            ▼
                     fact_discharge
                            │
           ┌────────────────┼────────────────┐
           ▼                ▼                ▼
     Analytics Views   Materialized Views   SQL Analytics
                            │
                            ▼
                     Power BI Dashboards
```

---

## 3. Architecture Layers

### Source Layer

The source layer consists of publicly available de-identified SPARCS inpatient discharge datasets published by the New York State Department of Health.

Characteristics:

- CSV format
- Seven independent yearly datasets
- One record per inpatient discharge
- Consistent schema across supported years

The source files are never modified directly and serve as the authoritative source for the warehouse.

---

### Staging Layer

Schema:

```sql
staging
```

Table:

```text
sparcs_raw
```

Purpose:

- Raw data ingestion
- Temporary landing zone
- Source preservation
- Data quality validation
- ETL input

The staging layer intentionally stores data with minimal transformation. Data cleansing and standardization occur during the transformation process rather than during ingestion.

---

### Warehouse Layer

Schema:

```sql
warehouse
```

The warehouse implements a dimensional Star Schema optimized for analytical workloads.

Components:

- 8 Dimension Tables
- 1 Fact Table

The warehouse serves as the single source of truth for all analytical reporting.

---

### Analytics Layer

Schema:

```sql
analytics
```

This layer contains reusable reporting assets including:

- Analytics Views
- Materialized Views
- Business SQL queries

These assets simplify reporting while demonstrating advanced PostgreSQL analytical capabilities.

---

### Business Intelligence Layer

Power BI connects directly to the dimensional warehouse using Import Mode.

The reporting model consumes the fact table and dimension tables directly rather than relying on analytics views or materialized views, allowing greater flexibility in report development and KPI calculations.

---

## 4. Data Flow

The end-to-end processing workflow follows a repeatable ETL pipeline for each dataset year.

1. Load a yearly SPARCS dataset into the staging layer.
2. Perform data profiling and quality validation.
3. Refresh dimension tables by inserting only new business entities.
4. Populate the fact table using surrogate key lookups.
5. Validate warehouse integrity.
6. Refresh analytical assets.
7. Publish data to Power BI.

This process is repeated independently for each supported dataset year, allowing the warehouse to be extended without redesigning the underlying architecture.

---

## 5. Warehouse Design

The warehouse follows a Star Schema centered around a single transaction fact table.

### Fact Table

```text
fact_discharge
```

Grain:

> One row represents one inpatient discharge record.

Measures:

- Admission Count
- Total Charges
- Total Costs
- Length of Stay (Days)

---

### Dimension Tables

- dim_hospital
- dim_patient
- dim_diagnosis
- dim_procedure
- dim_severity
- dim_payment
- dim_admission
- dim_date

Each dimension represents a reusable business entity used for filtering, grouping, and aggregation.

Surrogate keys are used throughout the warehouse to maintain stable relationships and improve join performance.

---

## 6. ETL Workflow

The ETL pipeline was designed to support repeatable multi-year loading while preserving source data integrity.

Workflow:

Source Dataset

↓

Load into Staging

↓

Data Quality Validation

↓

Dimension Refresh

↓

Fact Table Load

↓

Warehouse Validation

↓

Analytics Layer Refresh

↓

Power BI Refresh

The ETL process also records execution metadata within an audit table, including dataset year, source file, rows loaded, execution timestamps, and load status.

---

## 7. Design Decisions

Several architectural decisions influenced the final implementation.

### Layered Architecture

Separating staging, warehouse, analytics, and reporting simplifies maintenance and isolates responsibilities.

### Star Schema

A dimensional model was selected to optimize analytical queries and simplify Power BI integration.

### Surrogate Keys

Warehouse-managed surrogate keys provide stable relationships independent of source system changes.

### Unknown Member Strategy

Every dimension contains an Unknown Member record (Key = 0), ensuring that missing or unmatched dimension values do not prevent fact loading.

### Multi-Year ETL

Rather than creating separate warehouses for each dataset, all supported years are integrated into a single warehouse, enabling historical trend analysis while reusing the existing architecture.

### Direct Power BI Integration

Power BI connects directly to the dimensional warehouse instead of analytics views, following a common enterprise BI modeling approach.

---

## 8. Final System Statistics

| Component | Count |
|------------|------:|
| Source Datasets | 7 |
| Years Integrated | 2011–2024* |
| Fact Table Rows | 16,311,772 |
| Dimension Tables | 8 |
| Analytics Views | 11 |
| Materialized Views | 6 |
| Analytical SQL Query Files | 8 |
| Dashboard Pages | 8 |

*Only publicly available SPARCS dataset years are included.

---

## 9. Architecture Summary

The final architecture provides a scalable analytical platform capable of processing multi-year healthcare data through a reusable ETL pipeline and presenting consistent business insights through SQL analytics and Power BI dashboards.

The layered design, dimensional warehouse, reusable reporting assets, and centralized business logic allow the system to be extended with future SPARCS releases while minimizing architectural changes.