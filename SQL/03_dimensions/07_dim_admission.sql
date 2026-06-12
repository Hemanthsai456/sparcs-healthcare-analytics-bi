-- Create Dimension Table

CREATE TABLE warehouse.dim_admission (
    admission_key SERIAL PRIMARY KEY,

    type_of_admission VARCHAR(50),
    patient_disposition VARCHAR(500),
    emergency_department_indicator VARCHAR(10)
);

-- Load Dimension Table

INSERT INTO warehouse.dim_admission (
    type_of_admission,
    patient_disposition,
    emergency_department_indicator
)
SELECT DISTINCT
    type_of_admission,
    patient_disposition,
    emergency_department_indicator
FROM staging.sparcs_raw;

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_admission;