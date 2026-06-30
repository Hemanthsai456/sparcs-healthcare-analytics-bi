-- Validations 

-- Number of rows
SELECT COUNT(*)
FROM staging.sparcs_raw;

--  NULL Values in facility_name
SELECT COUNT(*)
FROM staging.sparcs_raw
WHERE facility_name IS NULL;

-- NULL Values in total_charges
SELECT COUNT(*)
FROM staging.sparcs_raw
WHERE total_charges IS NULL;

-- NULL Values in total_costs
SELECT COUNT(*)
FROM staging.sparcs_raw
WHERE total_costs IS NULL;

-- Count distinct facility_name
SELECT
    COUNT(DISTINCT facility_name)
FROM staging.sparcs_raw;

