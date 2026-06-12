-- Create Table

CREATE TABLE warehouse.dim_diagnosis (
    diagnosis_key SERIAL PRIMARY KEY,

    ccsr_diagnosis_code VARCHAR(20),
    ccsr_diagnosis_description VARCHAR(300),

    apr_drg_code INTEGER,
    apr_drg_description VARCHAR(500),

    apr_mdc_code INTEGER,
    apr_mdc_description VARCHAR(500)
);

-- Load Dimension

INSERT INTO warehouse.dim_diagnosis (
    ccsr_diagnosis_code,
    ccsr_diagnosis_description,
    apr_drg_code,
    apr_drg_description,
    apr_mdc_code,
    apr_mdc_description
)
SELECT DISTINCT
    ccsr_diagnosis_code,
    ccsr_diagnosis_description,
    apr_drg_code,
    apr_drg_description,
    apr_mdc_code,
    apr_mdc_description
FROM staging.sparcs_raw;

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_diagnosis;

-- check the data 
SELECT *
FROM warehouse.dim_diagnosis
ORDER BY diagnosis_key
LIMIT 10;