/* ======================================
QUERY 1
Year-wise Fact Lookup
====================================== */

EXPLAIN ANALYZE
SELECT *
FROM warehouse.fact_discharge
WHERE date_key = 2024;

/*
Optimization Applied:
idx_fact_date

Expected Improvement:
Sequential Scan -> Index Scan

Reason:
Frequently used filter for
multi-year analysis.
*/


/* ======================================
QUERY 2
Hospital Lookup
====================================== */

EXPLAIN ANALYZE
SELECT *
FROM warehouse.fact_discharge
WHERE hospital_key = 50;

/*
Optimization Applied:
idx_fact_hospital

Expected Improvement:
Sequential Scan -> Bitmap Index Scan on idx_fact_hospital

Reason:
Improves hospital-level
filtering and reporting.
*/


/* ======================================
QUERY 3
Hospital-Year Analysis
====================================== */

EXPLAIN ANALYZE
SELECT
    COUNT(*) AS total_admissions
FROM warehouse.fact_discharge
WHERE hospital_key = 50
AND date_key = 2024;

/*
Optimization Applied:
idx_fact_hospital
idx_fact_date

Expected Improvement:
Bitmap Index Scan on idx_fact_hospital and idx_fact_date
on planner statistics.

Reason:
Common filtering pattern
used in multi-year dashboards.
*/


/* ======================================
QUERY 4
Yearly Aggregation
====================================== */

EXPLAIN ANALYZE
SELECT
    date_key,
    COUNT(*) AS total_admissions
FROM warehouse.fact_discharge
GROUP BY date_key;

/*
Optimization Observation:
PostgreSQL choose
Parallel Index Only Scan using idx_fact_date on fact_discharge

Reason:
Large percentage of rows
are scanned.

Indexes are generally not
beneficial for full-table
aggregations.
*/