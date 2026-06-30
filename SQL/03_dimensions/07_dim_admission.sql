-- Create Dimension Table

CREATE TABLE warehouse.dim_admission (
    admission_key SERIAL PRIMARY KEY,

    type_of_admission VARCHAR(50),
    patient_disposition VARCHAR(500),
    emergency_department_indicator VARCHAR(10)
);

ALTER TABLE warehouse.dim_admission
ADD CONSTRAINT uq_dim_admission
UNIQUE
(
    type_of_admission,
    patient_disposition,
    emergency_department_indicator
);

-- Load Dimension Table

WITH cleaned AS
(
    SELECT DISTINCT
        NULLIF(TRIM(type_of_admission), '')
            AS type_of_admission,
        NULLIF(TRIM(patient_disposition), '')
            AS patient_disposition,
        NULLIF(TRIM(emergency_department_indicator), '')
            AS emergency_department_indicator
    FROM staging.sparcs_raw
)
INSERT INTO warehouse.dim_admission
(
    type_of_admission,
    patient_disposition,
    emergency_department_indicator
)
SELECT
    c.type_of_admission,
    c.patient_disposition,
    c.emergency_department_indicator
FROM cleaned c
WHERE NOT EXISTS
(
    SELECT 1
    FROM warehouse.dim_admission d
    WHERE c.type_of_admission
            IS NOT DISTINCT FROM d.type_of_admission
      AND c.patient_disposition
            IS NOT DISTINCT FROM d.patient_disposition
      AND c.emergency_department_indicator
            IS NOT DISTINCT FROM d.emergency_department_indicator
);

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_admission;