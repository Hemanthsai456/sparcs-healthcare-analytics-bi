# Data Model Decisions

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

This document explains the major architectural, modeling, ETL, reporting, and business intelligence decisions made during the design and implementation of the Healthcare Analytics & Business Intelligence System.

Each decision was evaluated based on:

* Business requirements
* Data characteristics
* Reporting needs
* Query performance
* Scalability
* Maintainability
* Business intelligence compatibility

The objective was to build a business-oriented analytical platform rather than a transactional database.

---

# 2. Why PostgreSQL?

## Decision

Use PostgreSQL 18 as the primary analytical database platform.

---

## Alternatives Considered

* MySQL
* SQL Server
* Oracle Database
* SQLite

---

## Reasons

### Open Source

No licensing costs.

---

### Enterprise Features

Supports:

* Schemas
* Views
* Materialized Views
* Indexing
* Query Optimization
* Analytical Workloads

---

### Strong Analytics Ecosystem

Integrates easily with:

* Power BI
* Tableau
* Python
* ETL Tools

---

### Large Dataset Support

The project contains:

```text id="nsn4i0"
2,196,737 records
```

PostgreSQL can comfortably handle datasets significantly larger than this.

---

## Final Decision

```text id="sxv1j0"
PostgreSQL 18
```

selected as the analytical database platform.

---

# 3. Why Build a Data Warehouse?

## Decision

Create a dimensional data warehouse instead of performing analysis directly on raw source data.

---

## Problems with Raw Data Analysis

Raw datasets often contain:

* Repeated values
* Complex structures
* Inconsistent reporting logic
* Performance limitations
* Difficult query development

---

## Benefits of a Warehouse

* Centralized reporting
* Consistent KPIs
* Better performance
* Reusable business entities
* Simplified dashboard development

---

## Final Decision

Implement a dedicated analytical warehouse.

---

# 4. Why Use a Star Schema?

## Decision

Implement a Star Schema design.

---

## Alternatives Considered

### Third Normal Form (3NF)

Advantages:

* Reduced redundancy
* Strong transactional integrity

Disadvantages:

* Complex joins
* Difficult reporting
* Poor BI usability

---

### Snowflake Schema

Advantages:

* Highly normalized
* Reduced duplication

Disadvantages:

* Additional joins
* Increased complexity
* Reduced reporting performance

---

## Benefits of Star Schema

### Simpler Queries

Fewer joins required.

---

### Faster Aggregations

Optimized for analytical workloads.

---

### Better Power BI Integration

Star schemas are the recommended modeling approach for Power BI.

---

### Business-Friendly Design

Easier for analysts and stakeholders to understand.

---

## Final Decision

```text id="2j5z0k"
Star Schema
```

selected as the warehouse architecture.

---

# 5. Why Create One Central Fact Table?

## Decision

Create a single transaction fact table.

---

## Fact Table

```sql id="3rk7bg"
warehouse.fact_discharge
```

---

## Grain

One row represents one inpatient discharge record.

---

## Benefits

* Maximum reporting flexibility
* Detailed analysis
* Consistent KPI calculations
* Supports all business domains

---

## Final Decision

Single transaction fact table implemented.

---

# 6. Why Use Permanent Facility ID?

## Investigation

Two hospital identifiers were available.

---

### Candidate 1

Facility Name

Distinct Values:

```text id="l4p7o6"
203
```

---

### Candidate 2

Permanent Facility ID

Distinct Values:

```text id="gczs7q"
205
```

---

## Findings

### Facility ID → Facility Name

Result:

```text id="65v2yx"
0 inconsistencies
```

---

### Facility Name → Facility ID

Result:

```text id="pc1l6m"
3 inconsistencies
```

---

## Risk

Facility Name could not uniquely identify hospitals.

---

## Final Decision

```text id="uvfww2"
permanent_facility_id
```

selected as the Hospital Dimension business key.

---

# 7. Why Use Surrogate Keys?

## Decision

Implement surrogate keys across all dimensions.

---

## Examples

```text id="uknhvx"
hospital_key
patient_key
diagnosis_key
procedure_key
severity_key
payment_key
admission_key
```

---

## Benefits

### Faster Joins

Integer joins outperform text-based joins.

---

### Stable Relationships

Independent of source-system changes.

---

### Simplified Fact Loading

Fact tables store compact integer references.

---

### Better Warehouse Design

Supports future scalability.

---

## Final Decision

Surrogate keys implemented for all dimensions.

---

# 8. Why Use an Unknown Member Strategy?

## Decision

Create an Unknown Member record in every dimension.

---

## Implementation

```text id="vt0o6h"
Surrogate Key = 0
```

---

## Purpose

Handle:

* Missing values
* Invalid values
* Unmatched records

---

## Benefits

### Preserve Referential Integrity

Every fact row maintains valid dimension references.

---

### Prevent Fact Row Loss

Records are not discarded during ETL.

---

### Improve Data Quality Visibility

Unknown records remain measurable and auditable.

---

## Final Decision

Unknown Member strategy implemented across all dimensions.

---

# 9. Why Store Length of Stay Twice?

## Decision

Store both raw and numeric LOS values.

---

## Raw Value

```sql id="8jvcfq"
length_of_stay_raw
```

Example:

```text id="hb9ec6"
120+
```

---

## Numeric Value

```sql id="kqzj8m"
length_of_stay_days
```

Example:

```text id="s0uqeh"
120
```

---

## Benefits

### Preserve Source Fidelity

Original source values remain available.

---

### Enable Calculations

Supports:

* Average LOS
* LOS distributions
* Operational analysis

---

## Final Decision

Dual-storage strategy implemented.

---

# 10. Why Not Store Derived Metrics?

## Decision

Do not physically store calculated KPIs.

---

## Examples

```text id="fb6lqz"
Average LOS
Average Cost Per Admission
Average Charge Per Admission
Charge-to-Cost Ratio
Emergency Admission Rate
```

---

## Risks of Physical Storage

* Redundancy
* Inconsistency
* Maintenance complexity

---

## Better Approach

Calculate metrics dynamically.

---

## Calculation Locations

* SQL Queries
* Analytics Views
* Materialized Views
* Power BI Measures

---

## Final Decision

Derived metrics are not stored in warehouse tables.

---

# 11. Why Create an Analytics Layer?

## Decision

Introduce a dedicated analytics schema.

---

## Schema

```sql id="t2l2ta"
analytics
```

---

## Purpose

Separate business logic from warehouse storage.

---

## Benefits

### Reusable Business Logic

Calculations defined once.

---

### Consistent Reporting

All analytical outputs use identical logic.

---

### Simplified SQL Analytics

Reduces repetitive query development.

---

## Key Assets

```text id="e5hq64"
v_executive_summary
v_hospital_performance
v_patient_demographics
v_clinical_analysis
v_financial_summary
v_geographic_analysis
v_risk_analysis
v_operations
```

---

## Final Decision

Analytics layer implemented.

---

# 12. Why Create Materialized Views?

## Decision

Create materialized views for optimization demonstrations and reporting acceleration.

---

## Problem

Large aggregations can require repeated computation.

---

## Solution

Precompute commonly used analytical summaries.

---

## Materialized Views

```text id="jlwmhf"
mv_hospital_performance
mv_financial_summary
mv_geographic_analysis
mv_risk_analysis
```

---

## Benefits

### Faster Query Performance

Precomputed aggregations reduce workload.

---

### PostgreSQL Feature Demonstration

Showcases advanced database capabilities.

---

### Optimization Benchmarking

Supports EXPLAIN ANALYZE comparisons.

---

## Important Note

Materialized views are **not** the primary Power BI data source.

They are used for:

* SQL analytics
* Performance demonstrations
* Reporting acceleration

---

## Final Decision

Materialized views implemented as optimization assets.

---

# 13. Why Connect Power BI Directly to Fact and Dimension Tables?

## Decision

Power BI consumes the dimensional warehouse directly.

---

## Data Sources

```text id="u2w0t6"
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

## Alternative Considered

Using analytics views and materialized views as primary Power BI sources.

---

## Reasons for Rejection

* Reduced analytical flexibility
* Limited drill-down capability
* More difficult dimensional analysis
* Less control over DAX calculations

---

## Benefits of Direct Star Schema Consumption

### Industry Standard Design

Matches common Power BI best practices.

---

### Better Analytical Flexibility

Supports custom slicing and filtering.

---

### Simplified Semantic Model

Fact table surrounded by dimensions.

---

### Improved Dashboard Scalability

New measures can be added without redesigning database views.

---

## Final Decision

Power BI consumes fact and dimension tables directly.

---

# 14. Why Use Import Mode?

## Decision

Use Power BI Import Mode.

---

## Benefits

* Faster report performance
* Better user experience
* Reduced query latency
* Simplified deployment

---

## Final Decision

Import Mode selected for dashboard development.

---

# 15. Why Organize Analytics by Business Domain?

## Decision

Separate analytical assets into business-focused domains.

---

## Domains

* Executive
* Hospital
* Patient
* Clinical
* Financial
* Geographic
* Operational
* Risk

---

## Benefits

* Easier navigation
* Better stakeholder alignment
* Simpler reporting design
* Improved maintainability

---

## Final Decision

Domain-driven analytics architecture implemented.

---

# 16. Why Separate SQL Analytics from Power BI?

## Decision

Maintain distinct analytical pathways.

---

## SQL Analytics Purpose

* Business investigations
* Ad-hoc reporting
* Query optimization
* Business findings generation

---

## Power BI Purpose

* Interactive dashboards
* KPI monitoring
* Executive reporting
* Self-service analytics

---

## Benefits

* Cleaner architecture
* Better maintainability
* Clear stakeholder usage

---

## Final Decision

SQL analytics and BI reporting remain separate but complementary.

---

# 17. Summary

The Healthcare Analytics & Business Intelligence System incorporates a series of architectural and modeling decisions designed to maximize analytical flexibility, reporting performance, scalability, and business usability.

The final solution combines dimensional modeling, PostgreSQL optimization techniques, SQL analytics, and Power BI reporting while maintaining clear separation between warehouse storage, analytical processing, optimization assets, and business intelligence consumption.
