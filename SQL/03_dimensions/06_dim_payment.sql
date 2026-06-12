-- Create Table

CREATE TABLE warehouse.dim_payment (
    payment_key SERIAL PRIMARY KEY,

    payment_typology_1 VARCHAR(50),
    payment_typology_2 VARCHAR(50),
    payment_typology_3 VARCHAR(50)
);

-- Load Dimension

INSERT INTO warehouse.dim_payment (
    payment_typology_1,
    payment_typology_2,
    payment_typology_3
)
SELECT DISTINCT
    payment_typology_1,
    payment_typology_2,
    payment_typology_3
FROM staging.sparcs_raw;

-- Validation

SELECT COUNT(*)
FROM warehouse.dim_payment;