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

ALTER TABLE warehouse.dim_diagnosis
ADD CONSTRAINT uq_dim_diagnosis
UNIQUE
(
    ccsr_diagnosis_code,
    ccsr_diagnosis_description,
    apr_drg_code,
    apr_drg_description,
    apr_mdc_code,
    apr_mdc_description
);

-- Load Dimension

WITH cleaned AS
(
    SELECT DISTINCT
        NULLIF(TRIM(ccsr_diagnosis_code), '')              AS ccsr_diagnosis_code,
        NULLIF(TRIM(ccsr_diagnosis_description), '')       AS ccsr_diagnosis_description,

        NULLIF(TRIM(apr_drg_code), '')::INTEGER            AS apr_drg_code,
        NULLIF(TRIM(apr_drg_description), '')              AS apr_drg_description,

        NULLIF(TRIM(apr_mdc_code), '')::INTEGER            AS apr_mdc_code,
        NULLIF(TRIM(apr_mdc_description), '')              AS apr_mdc_description

    FROM staging.sparcs_raw
)
INSERT INTO warehouse.dim_diagnosis
(
    ccsr_diagnosis_code,
    ccsr_diagnosis_description,
    apr_drg_code,
    apr_drg_description,
    apr_mdc_code,
    apr_mdc_description
)
SELECT
    c.ccsr_diagnosis_code,
    c.ccsr_diagnosis_description,
    c.apr_drg_code,
    c.apr_drg_description,
    c.apr_mdc_code,
    c.apr_mdc_description
FROM cleaned c
WHERE NOT EXISTS
(
    SELECT 1
    FROM warehouse.dim_diagnosis d
    WHERE c.ccsr_diagnosis_code = d.ccsr_diagnosis_code
      AND c.ccsr_diagnosis_description = d.ccsr_diagnosis_description
      AND c.apr_drg_code = d.apr_drg_code
      AND c.apr_drg_description = d.apr_drg_description
      AND c.apr_mdc_code = d.apr_mdc_code
      AND c.apr_mdc_description = d.apr_mdc_description
);

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_diagnosis;

-- check the data 
SELECT *
FROM warehouse.dim_diagnosis
ORDER BY diagnosis_key
LIMIT 10;