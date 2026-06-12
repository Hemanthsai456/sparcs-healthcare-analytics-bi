# Technical Decisions

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

This document records the major technical decisions made during the design and implementation of the Healthcare Analytics & Business Intelligence System.

The purpose of documenting these decisions is to explain the reasoning behind the architecture, dimensional model, reporting approach, optimization strategy, and Power BI implementation.

---

# 2. PostgreSQL Selected as the Database Platform

## Decision

PostgreSQL 18 was selected as the primary database platform.

---

## Reasoning

PostgreSQL provides:

* Strong SQL support
* Advanced analytical capabilities
* Materialized view support
* Query optimization tools
* Open-source accessibility
* Industry adoption

---

## Benefits

* Suitable for data warehousing
* Supports analytical workloads
* Easy integration with Power BI
* Demonstrates enterprise-grade SQL skills

---

# 3. Star Schema Selected as the Warehouse Model

## Decision

A Star Schema architecture was implemented.

---

## Reasoning

The project focuses on analytical reporting rather than transactional processing.

Star Schema provides:

* Simpler joins
* Faster aggregations
* Business-friendly reporting
* Better dashboard performance

---

## Benefits

* Reduced query complexity
* Easier Power BI integration
* Industry-standard dimensional design

---

# 4. One Discharge Record Defined as the Fact Table Grain

## Decision

The fact table grain was defined as:

```text
One row = One inpatient discharge record
```

---

## Reasoning

The SPARCS dataset records activity at the discharge level.

Using the same grain:

* Preserves source detail
* Avoids aggregation loss
* Supports flexible reporting

---

## Benefits

* Maximum analytical flexibility
* Consistent KPI calculations
* Accurate reporting

---

# 5. Permanent Facility ID Selected as Hospital Business Key

## Decision

Hospital identification is based on:

```text
permanent_facility_id
```

instead of facility name.

---

## Reasoning

Profiling revealed that several hospital names mapped to multiple facility identifiers.

Facility IDs uniquely identified hospitals.

---

## Benefits

* Reliable hospital identification
* Improved data integrity
* Prevention of duplicate business entities

---

# 6. Surrogate Keys Implemented Across All Dimensions

## Decision

All dimensions use surrogate keys.

Examples:

```text
hospital_key
patient_key
diagnosis_key
procedure_key
severity_key
payment_key
admission_key
```

---

## Reasoning

Surrogate keys isolate warehouse relationships from source system changes.

---

## Benefits

* Improved join performance
* Simplified relationships
* Better dimensional modeling practices

---

# 7. Unknown Member Strategy Implemented

## Decision

Each dimension contains an Unknown Member record.

```text
Surrogate Key = 0
```

---

## Reasoning

Missing or unmatched dimension values should not prevent fact loading.

---

## Benefits

* Preserves referential integrity
* Prevents fact row loss
* Supports robust ETL processing

---

# 8. No Data Imputation Performed

## Decision

Missing values were not artificially imputed.

---

## Reasoning

The project is a Business Intelligence solution rather than a Machine Learning project.

Artificial imputation could distort analytical reporting.

---

## Benefits

* Preserves source data integrity
* Avoids introducing assumptions
* Maintains reporting accuracy

---

# 9. Derived Metrics Not Stored in the Fact Table

## Decision

Derived metrics are calculated dynamically.

Examples:

* Average LOS
* Average Charge per Admission
* Average Cost per Admission
* Charge-to-Cost Ratio
* Emergency Admission Rate

---

## Reasoning

Derived metrics can be calculated at reporting time.

---

## Benefits

* Reduced storage redundancy
* Consistent calculations
* Greater reporting flexibility

---

# 10. Analytics Views Created for SQL Reporting

## Decision

Dedicated analytics views were created.

Examples:

```text
v_executive_summary
v_hospital_performance
v_financial_summary
v_geographic_analysis
```

---

## Reasoning

Business users often require reusable reporting datasets.

---

## Benefits

* Centralized business logic
* Consistent SQL reporting
* Simplified analytical queries

---

# 11. Materialized Views Added as a Reporting Layer

## Decision

Materialized views were implemented for selected analytical domains.

---

## Reasoning

The project demonstrates reporting optimization techniques and PostgreSQL performance features.

---

## Benefits

* Faster aggregations
* Reduced query execution times
* Demonstration of advanced SQL concepts

---

# 12. Power BI Connected Directly to the Dimensional Warehouse

## Decision

Power BI connects directly to:

```text
fact_discharge
+
dimension tables
```

---

## Not Used

```text
analytics views
materialized views
```

as primary dashboard sources.

---

## Reasoning

Direct Star Schema consumption is the preferred Power BI design approach.

---

## Benefits

* Simpler semantic model
* Better DAX flexibility
* Reduced reporting dependencies
* Industry-standard architecture

---

# 13. Limited Use of DAX Measures

## Decision

Only reusable business calculations were implemented as explicit DAX measures.

Examples:

* Charge-to-Cost Ratio
* Average Charge per Admission
* Average Cost per Admission
* Emergency Admission Rate
* Extreme Severity Rate
* Extreme Mortality Rate

---

## Reasoning

Basic aggregations can be handled directly by Power BI.

---

## Benefits

* Simpler model maintenance
* Reduced complexity
* Easier report development

---

# 14. Domain-Oriented Dashboard Design

## Decision

Reporting was organized into seven business domains.

---

## Dashboard Structure

1. Executive Dashboard
2. Hospital Analytics
3. Patient Analytics
4. Clinical Analytics
5. Financial Analytics
6. Geographic Analytics
7. Risk & Severity Analytics

---

## Reasoning

Each page focuses on a distinct business perspective.

---

## Benefits

* Reduced visual redundancy
* Improved user experience
* Better analytical storytelling

---

# 15. Business Insights Layer Included

## Decision

Business insights were documented in addition to technical deliverables.

---

## Reasoning

Business Intelligence projects should demonstrate analytical value, not only technical implementation.

---

## Benefits

* Stronger portfolio presentation
* Better business alignment
* Improved stakeholder communication

---

# 16. GitHub Portfolio Structure

## Decision

The repository was organized into:

```text
SQL
POWERBI
DOCS
Data
Business_SQL_Analytics
```

---

## Reasoning

Clear separation improves maintainability and project navigation.

---

## Benefits

* Easier review process
* Professional presentation
* Better project organization

---

# 17. Summary

The Healthcare Analytics & Business Intelligence System was designed using industry-standard data warehousing and business intelligence practices.

Technical decisions focused on maintaining data integrity, improving analytical flexibility, supporting efficient reporting, and demonstrating practical data engineering and business intelligence skills.

The resulting solution combines dimensional modeling, SQL analytics, Power BI reporting, and performance optimization into a scalable healthcare analytics platform.
