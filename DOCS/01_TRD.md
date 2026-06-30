# Technical Requirements Document (TRD)

## 1. Purpose

This document defines the technical requirements, architecture objectives, and implementation guidelines for the Healthcare Analytics & Business Intelligence System.

The project transforms New York State SPARCS inpatient discharge data into a scalable dimensional data warehouse capable of supporting healthcare analytics, SQL reporting, and interactive business intelligence dashboards.

This document serves as a technical reference for the system implementation, covering the technologies, functional capabilities, data warehouse design, ETL process, reporting requirements, and key technical decisions that guided the development of Version 2.

---

## 2. Project Overview

The Healthcare Analytics & Business Intelligence System is an end-to-end data engineering and business intelligence solution built using PostgreSQL and Power BI.

The system consolidates seven years of New York State SPARCS inpatient discharge data (2011, 2012, 2014, 2018, 2021, 2023, and 2024) into a dimensional data warehouse designed for analytical reporting rather than transactional processing.

Raw healthcare data is extracted into a staging layer, transformed through an ETL pipeline, organized into a Star Schema, and exposed through SQL analytics, materialized views, and Power BI dashboards.

The implementation emphasizes scalability, maintainability, and reusable business logic while preserving the integrity of the source data.

---

## 3. Technical Objectives

The project was designed to achieve the following technical objectives:

- Build a scalable dimensional data warehouse using PostgreSQL 18.
- Process and integrate multi-year healthcare datasets through a reusable ETL pipeline.
- Preserve raw source data within a dedicated staging layer.
- Implement a Star Schema using surrogate keys and conformed dimensions.
- Maintain referential integrity through an Unknown Member strategy.
- Provide reusable SQL analytics through views and materialized views.
- Support interactive business intelligence reporting using Power BI.
- Optimize analytical workloads using indexing and query optimization techniques.
- Produce a maintainable and well-documented analytics platform suitable for portfolio and interview demonstration.

---

## 4. Project Scope

### In Scope

- Integration of seven years of New York State SPARCS inpatient discharge datasets.
- Multi-year ETL pipeline using PostgreSQL.
- Star Schema dimensional data warehouse.
- Data quality validation and profiling.
- SQL analytical reporting.
- Analytics views and materialized views.
- Query optimization and indexing.
- Interactive Power BI dashboards.
- Professional technical documentation.

### Out of Scope

- Real-time data ingestion.
- Transactional (OLTP) processing.
- Machine learning or predictive analytics.
- Patient-level identification or personally identifiable information.
- Healthcare claim processing or billing systems.
- Automated ETL scheduling and orchestration.

---

## 5. Technology Stack

| Category | Technology |
|----------|------------|
| Programming Language | SQL |
| Database | PostgreSQL 18 |
| Database Administration | pgAdmin 4 |
| ETL | PostgreSQL SQL Scripts |
| Data Warehouse Model | Star Schema |
| Business Intelligence | Microsoft Power BI |
| Data Analysis | Jupyter Notebook, Python (Data Profiling) |
| Version Control | Git & GitHub |
| Documentation | Markdown |

---

## 6. System Requirements

### Data Requirements

- Seven SPARCS inpatient discharge datasets.
- Standardized CSV format.
- Consistent source schema across supported years.
- Approximately 16.3 million inpatient discharge records.

### Database Requirements

- PostgreSQL 18
- Three logical schemas:
  - staging
  - warehouse
  - analytics

### Warehouse Requirements

The warehouse shall contain:

- 1 Fact Table
- 8 Dimension Tables
- 11 Analytics Views
- 6 Materialized Views

### Reporting Requirements

The reporting layer shall provide:

- Executive reporting
- Hospital analytics
- Patient analytics
- Clinical analytics
- Financial analytics
- Geographic analytics
- Risk & Severity analytics
- Multi-year trend analytics

---

## 7. Functional Requirements

### Data Ingestion

- Import raw CSV datasets into the staging layer.
- Support loading multiple dataset years independently.
- Preserve source data before transformation.

### Data Transformation

- Standardize data formats.
- Handle missing values consistently.
- Generate surrogate keys.
- Maintain Unknown Member records.
- Validate data before warehouse loading.

### Data Warehouse

- Populate dimension tables.
- Populate fact table.
- Maintain referential integrity.
- Support historical multi-year analysis.

### Analytics Layer

- Provide reusable analytical views.
- Generate optimized materialized views.
- Support business-focused SQL reporting.

### Dashboard Layer

- Connect Power BI directly to the dimensional warehouse.
- Provide interactive filtering.
- Support cross-page navigation.
- Present standardized KPIs across all dashboards.

---

## 8. Non-Functional Requirements

### Performance

- Support analytical queries over 16M+ records.
- Optimize frequently executed queries.
- Minimize dashboard refresh time.

### Scalability

- Allow additional SPARCS dataset years to be integrated with minimal ETL changes.
- Support warehouse growth without architectural redesign.

### Maintainability

- Modular SQL scripts.
- Layered architecture.
- Reusable ETL process.
- Centralized business logic.

### Reliability

- ETL validation checks.
- Audit logging.
- Unknown Member strategy.
- Referential integrity enforcement.

### Usability

- Consistent dashboard layout.
- Business-friendly KPIs.
- Simple navigation.
- Domain-specific analytical pages.

---

## 9. Data Warehouse Requirements

The warehouse follows a dimensional modeling approach using a Star Schema.

### Warehouse Components

- Staging Layer
- Dimension Layer
- Fact Layer
- Analytics Layer
- Reporting Layer

### Core Tables

Fact Table

- fact_discharge

Dimension Tables

- dim_hospital
- dim_patient
- dim_diagnosis
- dim_procedure
- dim_severity
- dim_payment
- dim_admission
- dim_date

The fact table stores one record per inpatient discharge and references each dimension through surrogate keys.

---

## 10. ETL Requirements

The ETL pipeline shall:

- Load one dataset year at a time.
- Preserve raw source data in the staging layer.
- Validate source data before loading.
- Insert only new dimension members.
- Maintain Unknown Member records.
- Load the fact table after all dimensions are refreshed.
- Record execution details in the ETL audit table.

---

## 11. Business Intelligence Requirements

The reporting solution shall provide:

- 8 Power BI dashboard pages.
- Standardized KPI calculations.
- Interactive filtering.
- Drill-down analysis through dimension attributes.
- Year-over-year trend reporting.
- Consistent analytical results between SQL and Power BI.

---

## 12. Performance Requirements

The system shall:

- Utilize indexes for frequently queried columns.
- Use materialized views for expensive aggregations.
- Maintain optimized execution plans.
- Support efficient reporting over approximately 16.3 million fact records.

---

## 13. Security Assumptions

- The project uses publicly available de-identified healthcare data.
- No personally identifiable information (PII) is stored.
- Database access is assumed to be controlled through PostgreSQL user permissions.
- The project is intended for analytical and educational purposes.

---

## 14. Design Principles

- Preserve source data fidelity within the staging layer.
- Separate staging, warehouse, and analytics responsibilities.
- Use surrogate keys to maintain stable relationships.
- Centralize business logic within the warehouse.
- Keep the warehouse extensible for future dataset years.
- Build reporting directly on the dimensional model.
- Optimize analytical performance without sacrificing maintainability.

---

## 15. Project Limitations

- Historical data is limited to the publicly available SPARCS dataset years.
- The warehouse is batch-loaded and does not support real-time ingestion.
- Trend analysis is limited to available years rather than continuous annual history.
- Dashboard insights depend on the completeness and quality of the published SPARCS datasets.
- Machine learning and predictive analytics are outside the scope of this project.