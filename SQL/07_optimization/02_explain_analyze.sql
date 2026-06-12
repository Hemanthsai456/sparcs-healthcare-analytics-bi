/* =========================
   Hospital Performance
   ========================= */

EXPLAIN ANALYZE
SELECT
    h.facility_name,
    COUNT(*) AS admissions,
    SUM(f.total_charges) AS total_charges,
    SUM(f.total_costs) AS total_costs
FROM warehouse.fact_discharge f
JOIN warehouse.dim_hospital h
    ON f.hospital_key = h.hospital_key
GROUP BY h.facility_name;

/*  Total rows: 33
    Query complete 00:00:00.696
                                 */ 


/* =========================
   Diagnosis Analytics
   ========================= */

EXPLAIN ANALYZE
SELECT
    d.ccsr_diagnosis_description,
    COUNT(*) AS admissions
FROM warehouse.fact_discharge f
JOIN warehouse.dim_diagnosis d
    ON f.diagnosis_key = d.diagnosis_key
GROUP BY d.ccsr_diagnosis_description;

/*  Total rows: 35
    Query complete 00:00:00.462
                                 */ 


/* =========================
   Payment Analytics
   ========================= */

EXPLAIN ANALYZE
SELECT
    p.payment_typology_1,
    SUM(f.total_charges)
FROM warehouse.fact_discharge f
JOIN warehouse.dim_payment p
    ON f.payment_key = p.payment_key
GROUP BY p.payment_typology_1;

/*  Total rows: 33
    Query complete 00:00:00.618
                                 */ 