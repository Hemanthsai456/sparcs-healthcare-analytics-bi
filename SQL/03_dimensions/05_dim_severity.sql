-- Create Table

CREATE TABLE warehouse.dim_severity (
    severity_key SERIAL PRIMARY KEY,

    apr_severity_of_illness_code INTEGER,
    apr_severity_of_illness_description VARCHAR(50),

    apr_risk_of_mortality VARCHAR(50),

    apr_medical_surgical_description VARCHAR(50)
);

ALTER TABLE warehouse.dim_severity
ADD CONSTRAINT uq_dim_severity
UNIQUE
(
    apr_severity_of_illness_code,
    apr_severity_of_illness_description,
    apr_risk_of_mortality,
    apr_medical_surgical_description
);

-- Load Dimension

WITH cleaned AS
(
    SELECT DISTINCT
        NULLIF(TRIM(apr_severity_of_illness_code), '')::INTEGER
            AS apr_severity_of_illness_code,
        NULLIF(TRIM(apr_severity_of_illness_description), '')
            AS apr_severity_of_illness_description,
        NULLIF(TRIM(apr_risk_of_mortality), '')
            AS apr_risk_of_mortality,
        NULLIF(TRIM(apr_medical_surgical_description), '')
            AS apr_medical_surgical_description
    FROM staging.sparcs_raw
)
INSERT INTO warehouse.dim_severity
(
    apr_severity_of_illness_code,
    apr_severity_of_illness_description,
    apr_risk_of_mortality,
    apr_medical_surgical_description
)
SELECT
    c.apr_severity_of_illness_code,
    c.apr_severity_of_illness_description,
    c.apr_risk_of_mortality,
    c.apr_medical_surgical_description
FROM cleaned c
WHERE NOT EXISTS
(
    SELECT 1
    FROM warehouse.dim_severity d
    WHERE c.apr_severity_of_illness_code
            IS NOT DISTINCT FROM d.apr_severity_of_illness_code
      AND c.apr_severity_of_illness_description
            IS NOT DISTINCT FROM d.apr_severity_of_illness_description
      AND c.apr_risk_of_mortality
            IS NOT DISTINCT FROM d.apr_risk_of_mortality
      AND c.apr_medical_surgical_description
            IS NOT DISTINCT FROM d.apr_medical_surgical_description
);

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_severity;