-- Create Table

CREATE TABLE warehouse.dim_severity (
    severity_key SERIAL PRIMARY KEY,

    apr_severity_of_illness_code INTEGER,
    apr_severity_of_illness_description VARCHAR(50),

    apr_risk_of_mortality VARCHAR(50),

    apr_medical_surgical_description VARCHAR(50)
);

-- Load Dimension

INSERT INTO warehouse.dim_severity (
    apr_severity_of_illness_code,
    apr_severity_of_illness_description,
    apr_risk_of_mortality,
    apr_medical_surgical_description
)
SELECT DISTINCT
    apr_severity_of_illness_code,
    apr_severity_of_illness_description,
    apr_risk_of_mortality,
    apr_medical_surgical_description
FROM staging.sparcs_raw;

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_severity;