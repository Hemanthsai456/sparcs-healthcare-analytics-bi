-- Create Table

CREATE TABLE warehouse.dim_payment (
    payment_key SERIAL PRIMARY KEY,

    payment_typology_1 VARCHAR(50),
    payment_typology_2 VARCHAR(50),
    payment_typology_3 VARCHAR(50)
);

ALTER TABLE warehouse.dim_payment
ADD CONSTRAINT uq_dim_payment
UNIQUE
(
    payment_typology_1,
    payment_typology_2,
    payment_typology_3
);

-- Load Dimension

WITH cleaned AS
(
    SELECT DISTINCT
        NULLIF(TRIM(payment_typology_1), '')
            AS payment_typology_1,
        NULLIF(TRIM(payment_typology_2), '')
            AS payment_typology_2,
        NULLIF(TRIM(payment_typology_3), '')
            AS payment_typology_3
    FROM staging.sparcs_raw
)
INSERT INTO warehouse.dim_payment
(
    payment_typology_1,
    payment_typology_2,
    payment_typology_3
)
SELECT
    c.payment_typology_1,
    c.payment_typology_2,
    c.payment_typology_3
FROM cleaned c
WHERE NOT EXISTS
(
    SELECT 1
    FROM warehouse.dim_payment d
    WHERE c.payment_typology_1
            IS NOT DISTINCT FROM d.payment_typology_1
      AND c.payment_typology_2
            IS NOT DISTINCT FROM d.payment_typology_2
      AND c.payment_typology_3
            IS NOT DISTINCT FROM d.payment_typology_3
);

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_payment;