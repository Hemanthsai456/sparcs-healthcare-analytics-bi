-- Create Table

CREATE TABLE warehouse.dim_procedure (
    procedure_key SERIAL PRIMARY KEY,

    ccsr_procedure_code VARCHAR(20),
    ccsr_procedure_description VARCHAR(300)
);

-- Load Dimension

INSERT INTO warehouse.dim_procedure (
    ccsr_procedure_code,
    ccsr_procedure_description
)
SELECT DISTINCT
    ccsr_procedure_code,
    ccsr_procedure_description
FROM staging.sparcs_raw;

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_procedure;