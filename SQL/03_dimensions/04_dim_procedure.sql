-- Create Table

CREATE TABLE warehouse.dim_procedure (
    procedure_key SERIAL PRIMARY KEY,

    ccsr_procedure_code VARCHAR(20),
    ccsr_procedure_description VARCHAR(300)
);

ALTER TABLE warehouse.dim_procedure
ADD CONSTRAINT uq_dim_procedure
UNIQUE
(
    ccsr_procedure_code,
    ccsr_procedure_description
);

-- Load Dimension

WITH cleaned AS
(
    SELECT DISTINCT
        NULLIF(TRIM(ccsr_procedure_code::TEXT), '')      AS ccsr_procedure_code,
        NULLIF(TRIM(ccsr_procedure_description), '')     AS ccsr_procedure_description
    FROM staging.sparcs_raw
)
INSERT INTO warehouse.dim_procedure
(
    ccsr_procedure_code,
    ccsr_procedure_description
)
SELECT
    c.ccsr_procedure_code,
    c.ccsr_procedure_description
FROM cleaned c
WHERE NOT EXISTS
(
    SELECT 1
    FROM warehouse.dim_procedure d
    WHERE c.ccsr_procedure_code
            IS NOT DISTINCT FROM d.ccsr_procedure_code
      AND c.ccsr_procedure_description
            IS NOT DISTINCT FROM d.ccsr_procedure_description
);

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_procedure;