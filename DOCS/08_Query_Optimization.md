# Query Optimization Report

## 1. Overview

The Healthcare Analytics & Business Intelligence System was designed to support analytical queries over more than **16 million inpatient discharge records**.

To improve query performance, the warehouse combines indexing, execution plan analysis, and materialized views while preserving a simple and maintainable warehouse design.

---

## 2. Optimization Strategy

The optimization process focused on:

- Frequently filtered columns.
- Dimension joins.
- Multi-year analytical reporting.
- Large aggregation queries.
- Dashboard responsiveness.

Optimization decisions were validated using PostgreSQL's `EXPLAIN ANALYZE`.

---

## 3. Indexing Strategy

Indexes were created on the foreign key columns of the fact table to improve filtering and join performance.

### Implemented Fact Table Indexes

- idx_fact_hospital
- idx_fact_patient
- idx_fact_diagnosis
- idx_fact_procedure
- idx_fact_severity
- idx_fact_payment
- idx_fact_admission
- idx_fact_date

Dimension tables rely on their primary keys and business key constraints for efficient lookups, so additional manual indexes were not required.

---

## 4. Execution Plan Analysis

Representative analytical queries were evaluated using `EXPLAIN ANALYZE` to understand PostgreSQL's execution strategy.

Examples included:

- Hospital performance reporting.
- Financial aggregation.
- Diagnosis trend analysis.
- Year-wise filtering.
- Hospital-year filtering.

Execution plans were reviewed to verify appropriate use of indexes and identify opportunities for optimization.

---

## 5. Materialized Views

Six materialized views were implemented to improve the performance of computationally expensive analytical queries.

Implemented views:

- mv_hospital_performance
- mv_financial_summary
- mv_geographic_analysis
- mv_risk_analysis
- mv_yearly_summary
- mv_hospital_trends

Materialized views store precomputed results that can be refreshed after warehouse updates, reducing query execution time for repeated reporting workloads.

---

## 6. Optimization Decisions

The following decisions guided the optimization process:

- Index frequently filtered fact table columns.
- Keep the Star Schema simple and readable.
- Use materialized views for repeated aggregations.
- Validate execution plans using `EXPLAIN ANALYZE`.
- Avoid unnecessary denormalization.
- Allow PostgreSQL's query planner to select the most efficient execution strategy.

---

## 7. Performance Summary

The optimization strategy provides:

- Faster dimension filtering.
- Improved join performance.
- Efficient year-based analysis.
- Reduced reporting latency through materialized views.
- Better scalability for multi-year analytical workloads.

Rather than optimizing every individual query, the project focuses on optimizing common reporting patterns used by SQL analytics and Power BI dashboards.

---

## 8. Conclusion

The combination of indexing, execution plan analysis, and materialized views provides a balanced optimization strategy that improves analytical performance while maintaining a clean and maintainable warehouse design.

The implemented optimizations support efficient reporting across more than **16 million inpatient discharge records** without increasing unnecessary architectural complexity.