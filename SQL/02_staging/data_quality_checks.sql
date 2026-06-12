-- 1. HOSPITAL NULL ANALYSIS


SELECT COUNT(*) AS missing_facility_name
FROM staging.sparcs_raw
WHERE facility_name IS NULL;

SELECT COUNT(*) AS missing_facility_id
FROM staging.sparcs_raw
WHERE permanent_facility_id IS NULL;


-- 2. PROCEDURE NULL ANALYSIS


SELECT COUNT(*) AS missing_procedure_code
FROM staging.sparcs_raw
WHERE ccsr_procedure_code IS NULL;

SELECT COUNT(*) AS missing_procedure_description
FROM staging.sparcs_raw
WHERE ccsr_procedure_description IS NULL;


-- 3. PAYMENT NULL ANALYSIS


SELECT COUNT(*) AS missing_payment_typology_1
FROM staging.sparcs_raw
WHERE payment_typology_1 IS NULL;

SELECT COUNT(*) AS missing_payment_typology_2
FROM staging.sparcs_raw
WHERE payment_typology_2 IS NULL;

SELECT COUNT(*) AS missing_payment_typology_3
FROM staging.sparcs_raw
WHERE payment_typology_3 IS NULL;


-- 4. BIRTH WEIGHT NULL ANALYSIS


SELECT COUNT(*) AS missing_birth_weight
FROM staging.sparcs_raw
WHERE birth_weight IS NULL;


-- 5. DUPLICATE RECORD CHECK


SELECT COUNT(*) AS total_rows
FROM staging.sparcs_raw;

SELECT COUNT(*) AS distinct_rows
FROM (
SELECT DISTINCT *
FROM staging.sparcs_raw
) d;


-- 6. LENGTH OF STAY INVESTIGATION


SELECT DISTINCT length_of_stay
FROM staging.sparcs_raw
ORDER BY length_of_stay;


-- 7. HOSPITAL BUSINESS KEY VALIDATION


SELECT
permanent_facility_id,
COUNT(DISTINCT facility_name) AS name_count
FROM staging.sparcs_raw
GROUP BY permanent_facility_id
HAVING COUNT(DISTINCT facility_name) > 1;

SELECT
facility_name,
COUNT(DISTINCT permanent_facility_id) AS id_count
FROM staging.sparcs_raw
GROUP BY facility_name
HAVING COUNT(DISTINCT permanent_facility_id) > 1;


-- 8. NEGATIVE FINANCIAL VALUES


SELECT COUNT(*) AS negative_charges
FROM staging.sparcs_raw
WHERE total_charges < 0;

SELECT COUNT(*) AS negative_costs
FROM staging.sparcs_raw
WHERE total_costs < 0;


-- 9. COST GREATER THAN CHARGES


SELECT COUNT(*) AS cost_exceeds_charge
FROM staging.sparcs_raw
WHERE total_costs > total_charges;


-- 10. FINANCIAL OUTLIERS


SELECT *
FROM staging.sparcs_raw
ORDER BY total_charges DESC
LIMIT 10;

SELECT *
FROM staging.sparcs_raw
ORDER BY total_costs DESC
LIMIT 10;


-- 11. CRITICAL FIELD NULL CHECKS


SELECT COUNT(*)
FROM staging.sparcs_raw
WHERE total_charges IS NULL;

SELECT COUNT(*)
FROM staging.sparcs_raw
WHERE total_costs IS NULL;

SELECT COUNT(*)
FROM staging.sparcs_raw
WHERE discharge_year IS NULL;


-- 12. DIMENSION CARDINALITY CHECKS


SELECT COUNT(DISTINCT facility_name)
FROM staging.sparcs_raw;

SELECT COUNT(DISTINCT permanent_facility_id)
FROM staging.sparcs_raw;

SELECT COUNT(DISTINCT ccsr_diagnosis_code)
FROM staging.sparcs_raw;

SELECT COUNT(DISTINCT ccsr_procedure_code)
FROM staging.sparcs_raw;

SELECT COUNT(DISTINCT payment_typology_1)
FROM staging.sparcs_raw;
