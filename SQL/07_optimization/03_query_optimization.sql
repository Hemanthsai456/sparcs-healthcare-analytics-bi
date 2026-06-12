/* ======================================
QUERY 1
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
Sequential Scan -> Index Scan
*/


/* ======================================
QUERY 2
Diagnosis Lookup
====================================== */

EXPLAIN ANALYZE
SELECT *
FROM warehouse.fact_discharge
WHERE diagnosis_key = 100;

/*
Optimization Applied:
idx_fact_diagnosis

Expected Improvement:
Faster filtering on diagnosis dimension
*/


/* ======================================
QUERY 3
Admission Analysis
====================================== */

EXPLAIN ANALYZE
SELECT
    admission_key,
    COUNT(*)
FROM warehouse.fact_discharge
GROUP BY admission_key;

/*
Optimization Observation:
PostgreSQL may still choose
Parallel Seq Scan + Hash Aggregate.

Reason:
Large percentage of rows are read.
Index is not always beneficial.
*/