/* =========================
   Hospital Performance
   ========================= */

EXPLAIN ANALYZE
SELECT
    h.facility_name,
    dt.discharge_year,
    COUNT(*) AS admissions
FROM warehouse.fact_discharge f
JOIN warehouse.dim_hospital h
ON f.hospital_key=h.hospital_key
JOIN warehouse.dim_date dt
ON f.date_key=dt.date_key
GROUP BY
h.facility_name,
dt.discharge_year;

/*  Total rows: 41
    Query complete 5320.563 ms
                              */ 


/* =========================
   Financial Summary
   ========================= */

EXPLAIN ANALYZE
SELECT
    dt.discharge_year,
    SUM(total_charges),
    SUM(total_costs)
FROM warehouse.fact_discharge f
JOIN warehouse.dim_date dt
ON f.date_key=dt.date_key
GROUP BY dt.discharge_year;

/*  Total rows: 33
    Query complete 3402.550 ms
                               */ 


/* =========================
   Diagnosis Trend
   ========================= */

EXPLAIN ANALYZE
SELECT
    dt.discharge_year,
    d.ccsr_diagnosis_description,
    COUNT(*)
FROM warehouse.fact_discharge f
JOIN warehouse.dim_diagnosis d
ON f.diagnosis_key=d.diagnosis_key
JOIN warehouse.dim_date dt
ON f.date_key=dt.date_key
GROUP BY
dt.discharge_year,
d.ccsr_diagnosis_description;

/*  Total rows: 41
    Query complete 6213.559 ms
                               */ 