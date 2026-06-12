-- 2. Patient Dimension Table
-- Create a dim_patient table in warehouse schema 

CREATE TABLE warehouse.dim_patient (
    patient_key SERIAL PRIMARY KEY,
    age_group VARCHAR(20),
    gender VARCHAR(10),
    race VARCHAR(50),
    ethnicity VARCHAR(50)
);

-- Insert the data
INSERT INTO warehouse.dim_patient (
    age_group,
    gender,
    race,
    ethnicity
)
SELECT DISTINCT
    age_group,
    gender,
    race,
    ethnicity
FROM staging.sparcs_raw;

-- check the data is inserted successfully
SELECT COUNT(*)
FROM warehouse.dim_patient;

-- check the data 
SELECT *
FROM warehouse.dim_patient
ORDER BY patient_key
LIMIT 10;
