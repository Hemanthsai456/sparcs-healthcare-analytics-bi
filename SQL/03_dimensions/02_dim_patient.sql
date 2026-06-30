-- 2. Patient Dimension Table
-- Create a dim_patient table in warehouse schema 

CREATE TABLE warehouse.dim_patient (
    patient_key SERIAL PRIMARY KEY,
    age_group VARCHAR(20),
    gender VARCHAR(10),
    race VARCHAR(50),
    ethnicity VARCHAR(50)
);

ALTER TABLE warehouse.dim_patient
ADD CONSTRAINT uq_dim_patient
UNIQUE(age_group, gender, race, ethnicity);

-- Insert the data
WITH cleaned AS
(
    SELECT DISTINCT
        NULLIF(TRIM(age_group), '')     AS age_group,
        NULLIF(TRIM(gender), '')        AS gender,
        NULLIF(TRIM(race), '')          AS race,
        NULLIF(TRIM(ethnicity), '')     AS ethnicity
    FROM staging.sparcs_raw
)
INSERT INTO warehouse.dim_patient
(
    age_group,
    gender,
    race,
    ethnicity
)
SELECT
    c.age_group,
    c.gender,
    c.race,
    c.ethnicity
FROM cleaned c
WHERE NOT EXISTS
(
    SELECT 1
    FROM warehouse.dim_patient d
    WHERE c.age_group
            IS NOT DISTINCT FROM d.age_group
      AND c.gender
            IS NOT DISTINCT FROM d.gender
      AND c.race
            IS NOT DISTINCT FROM d.race
      AND c.ethnicity
            IS NOT DISTINCT FROM d.ethnicity
);

-- check the data is inserted successfully
SELECT COUNT(*)
FROM warehouse.dim_patient;

-- check the data 
SELECT *
FROM warehouse.dim_patient
ORDER BY patient_key
LIMIT 10;
