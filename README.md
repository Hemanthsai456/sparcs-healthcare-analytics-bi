# Healthcare Analytics & Business Intelligence System

> **A production-style Healthcare Data Warehouse and Business Intelligence platform built using PostgreSQL 18 and Power BI to transform multi-year healthcare data into actionable business insights.**

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-blue?logo=postgresql)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-Analytics-success)
![Data Warehouse](https://img.shields.io/badge/Data%20Warehouse-Star%20Schema-orange)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![LICENSE](https://img.shields.io/badge/MIT-blue)
---

# Project Statistics

| Metric | Value |
|---------|------:|
| Source Dataset | NYS SPARCS Inpatient Discharge Data |
| Dataset Years | 2011, 2012, 2014, 2018, 2021, 2023, 2024 |
| Years Integrated | **7** |
| Fact Table Records | **16,311,772** |
| Dimension Tables | **8** |
| Analytics Views | **11** |
| Materialized Views | **6** |
| SQL Analytics Modules | **8** |
| Power BI Dashboards | **8** |
| Database | PostgreSQL 18 |

---

# Project Overview

Healthcare organizations generate massive amounts of operational, financial, and clinical data every year. While this information is valuable, raw healthcare datasets are difficult to analyze directly due to their size, complexity, and transactional structure.

This project transforms **seven years of New York State SPARCS inpatient discharge data** into a production-style dimensional data warehouse using PostgreSQL 18. The platform integrates data engineering, dimensional modeling, SQL analytics, query optimization, and interactive Power BI dashboards to support healthcare decision-making.

The final solution enables historical trend analysis across **16.31 million inpatient discharge records** while providing reusable analytics through SQL and business intelligence dashboards.

---

# Business Problem

The original SPARCS datasets are designed for data distribution rather than analytical reporting.

Challenges include:

- Large yearly datasets containing millions of records.
- Complex raw data unsuitable for direct business reporting.
- Repeated business logic across analytical queries.
- Lack of centralized KPI calculations.
- Limited support for multi-year healthcare trend analysis.

This project addresses these challenges by building a centralized analytical warehouse that standardizes business logic, supports historical reporting, and enables interactive business intelligence.

---

# Project Highlights

- Integrated **7 years** of healthcare data into a single warehouse.
- Built a **Star Schema** dimensional model.
- Processed **16.31 million** inpatient discharge records.
- Designed a reusable multi-year ETL pipeline.
- Implemented **11 Analytics Views**.
- Implemented **6 Materialized Views**.
- Developed **8 Business SQL Analytics modules**.
- Built **8 interactive Power BI dashboards**.
- Optimized analytical performance using indexes and `EXPLAIN ANALYZE`.
- Produced professional technical and business documentation.

---

# Project Evolution

| Version 1 | Version 2 |
|------------|-----------|
| Single-year warehouse (2024) | Multi-year analytical warehouse |
| One dataset | Seven integrated datasets |
| Single-year reporting | Historical trend analysis |
| 7 Dashboard Pages | 8 Dashboard Pages |
| Basic warehouse | Production-style analytical platform |

---

# System Architecture

```
SPARCS CSV Files
        │
        ▼
Staging Layer
        │
        ▼
Data Quality Validation
        │
        ▼
ETL Transformation
        │
        ▼
Star Schema Data Warehouse
        │
        ▼
Analytics Views & Materialized Views
        │
        ▼
Power BI Dashboards
```

---

# Data Pipeline

```
CSV Dataset

↓

staging.sparcs_raw

↓

Data Quality Validation

↓

Dimension Loading

↓

Fact Loading

↓

Warehouse Validation

↓

Analytics Views

↓

Materialized Views

↓

Power BI
```

The ETL pipeline is designed to process one dataset year at a time, allowing new SPARCS releases to be integrated without redesigning the warehouse.

---

# Technology Stack

| Category | Technology |
|----------|------------|
| Database | PostgreSQL 18 |
| Query Language | SQL |
| Database Administration | pgAdmin 4 |
| Data Warehouse | Star Schema |
| Business Intelligence | Microsoft Power BI |
| Data Profiling | Python, Jupyter Notebook |
| Version Control | Git & GitHub |
| Documentation | Markdown |

---

# Dataset Overview

**Source:** New York State Department of Health – SPARCS (Statewide Planning and Research Cooperative System)

### Dataset Characteristics

- Publicly available de-identified inpatient discharge data.
- Seven integrated reporting years.
- One record represents one inpatient discharge.
- Standardized schema across supported years.
- More than **16.31 million** records loaded into the warehouse.

Supported years:

- 2011
- 2012
- 2014
- 2018
- 2021
- 2023
- 2024

---

# Data Warehouse

The warehouse follows a **Star Schema** optimized for analytical workloads.

### Fact Table

- **fact_discharge**

Stores one record for every inpatient discharge.

### Dimension Tables

- dim_hospital
- dim_patient
- dim_diagnosis
- dim_procedure
- dim_severity
- dim_payment
- dim_admission
- dim_date

### Design Features

- Star Schema architecture.
- Surrogate keys.
- Unknown Member strategy.
- Multi-year dimensional warehouse.
- ETL audit logging.
- Referential integrity validation.

![Star Schema](DOCS/images/star_schema.png)

---

# Analytics Layer

The analytics layer provides reusable SQL assets that simplify reporting while improving performance for analytical workloads.

### Analytics Views

The warehouse includes **11 analytics views** covering major business domains:

- Executive Summary
- Hospital Performance
- Patient Demographics
- Clinical Analysis
- Financial Summary
- Geographic Analysis
- Risk Analysis
- Operations
- Clinical Detail
- Hospital Clinical
- Financial Detail

These views encapsulate reusable business logic and simplify SQL-based reporting.

---

### Materialized Views

To improve the performance of frequently executed aggregation queries, the warehouse implements **6 materialized views**.

Materialized views store precomputed analytical results and can be refreshed after warehouse updates, reducing execution time for repeated reporting workloads.

---

### Business SQL Analytics

The project includes **8 business-oriented SQL analytics modules** covering:

- Hospital Analytics
- Patient Analytics
- Clinical Analytics
- Financial Analytics
- Operational Analytics
- Geographic Analytics
- Risk Analytics
- Trend Analytics

---

### Query Optimization

Performance improvements include:

- Foreign key indexing
- Execution plan analysis using `EXPLAIN ANALYZE`
- Materialized views
- Query optimization
- Warehouse statistics maintenance

---

# Business Intelligence Layer

Power BI connects directly to the PostgreSQL dimensional warehouse using **Import Mode**.

The reporting solution consists of **8 interactive dashboard pages** designed for executive reporting and domain-specific healthcare analysis.

### Dashboard Features

- Interactive slicers
- Dynamic KPI cards
- Cross-filtering
- Bookmark navigation
- Page navigation
- Interactive tables
- Year-based filtering
- Consistent business definitions

---

## Power BI Report

The complete Power BI report (`healthcare_analytics.pbix`) is approximately **450 MB** and is hosted externally to keep the GitHub repository lightweight.

📥 **Download Power BI Report:**  
**Google Drive:** https://drive.google.com/drive/folders/1eHpAuOLM7pzCe2eLxF6XW9RRzw-QfuuR?usp=sharing

> Dashboard screenshots are included below for quick preview.

## Dashboard Gallery

### Executive Dashboard

![Executive Dashboard](POWERBI/dashboard_images/01_Executive_Dashboard.png)

---

### Hospital Analytics

![Hospital Analytics](POWERBI/dashboard_images/02_Hospital_Analytics.png)

---

### Patient Analytics

![Patient Analytics](POWERBI/dashboard_images/03_Patient_Analytics.png)

---

### Clinical Analytics

![Clinical Analytics](POWERBI/dashboard_images/04_Clinical_Analytics.png)

---

### Financial Analytics

![Financial Analytics](POWERBI/dashboard_images/05_Financial_Analytics.png)

---

### Geographic Analytics

![Geographic Analytics](POWERBI/dashboard_images/06_Geographic_Analytics.png)

---

### Risk & Severity Analytics

![Risk & Severity Analytics](POWERBI/dashboard_images/07_Risk_Severity_Analytics.png)

---

### Healthcare Evolution & Trends

![Healthcare Evolution & Trends](POWERBI/dashboard_images/08_Healthcare_Evolution_Trends.png)

---

# Repository Structure

```text
Healthcare-Analytics-BI-System/
│
├── data/
│
├── docs/
│   ├── 01_TRD.md
│   ├── 02_BRD.md
│   ├── 03_Architecture_Implementation.md
│   ├── 04_Data_Dictionary.md
│   ├── 05_Data_Profiling_Quality.md
│   ├── 06_ETL_Star_Schema.md
│   ├── 07_KPI_Definitions.md
│   ├── 08_Query_Optimization.md
│   ├── 09_Dashboard_Documentation.md
│   └── 10_Business_Insights_Report.md
│
├── notebooks/
│
├── POWERBI/
│
├── SQL/
│   ├── Database Setup
│   ├── Staging
│   ├── Dimensions
│   ├── Fact
│   ├── Views
│   ├── Analytical Queries
│   ├── Optimization
│   └── Reporting Layer
│
└── README.md
```

---

# Documentation

Detailed documentation is available in the `/docs` directory.

| Document | Description |
|----------|-------------|
| TRD | Technical Requirements Document |
| BRD | Business Requirements Document |
| Architecture | System Architecture & Implementation |
| Data Dictionary | Warehouse Reference |
| Data Profiling | Data Quality & Profiling |
| ETL | ETL Pipeline & Star Schema |
| KPI Definitions | Business Metrics |
| Query Optimization | Performance Optimization |
| Dashboard Documentation | Power BI Guide |
| Business Insights | Analytical Findings & Recommendations |

---

# Key Features

- Multi-year ETL pipeline
- Layered warehouse architecture
- Star Schema dimensional model
- Surrogate key implementation
- Unknown Member strategy
- ETL audit logging
- Data quality validation
- Historical trend analysis
- Business SQL analytics
- Analytics views
- Materialized views
- Query optimization
- Interactive Power BI dashboards
- Professional technical documentation

---

# Results & Achievements

- Successfully integrated **7 years** of SPARCS healthcare data.
- Loaded **16,311,772** inpatient discharge records into a centralized warehouse.
- Designed a scalable Star Schema using **8 dimension tables** and **1 fact table**.
- Built a reusable ETL pipeline capable of supporting future dataset additions.
- Developed **11 analytics views** and **6 materialized views** for reporting.
- Created **8 interactive Power BI dashboards** with standardized KPIs.
- Implemented query optimization techniques using indexes and `EXPLAIN ANALYZE`.
- Produced a complete suite of technical and business documentation.

---

# Future Enhancements

Potential future improvements include:

- Automated ETL scheduling.
- Incremental warehouse refresh.
- Cloud deployment.
- Additional SPARCS dataset years.
- Advanced forecasting and machine learning models.
- Real-time reporting integration.

---

# About

This project was developed to demonstrate end-to-end capabilities in:

- Data Engineering
- Data Warehousing
- PostgreSQL
- SQL Analytics
- Query Optimization
- Business Intelligence
- Power BI
- Technical Documentation

It showcases the complete lifecycle of building a production-style healthcare analytics platform—from raw data ingestion to interactive business intelligence reporting.

---

## Connect

**GitHub:** https://github.com/HemanthSai456

**LinkedIn:** https://www.linkedin.com/in/hemanth-sai-charagundla-4a8659376/

If you found this project useful or have suggestions for improvement, feel free to connect or open an issue.