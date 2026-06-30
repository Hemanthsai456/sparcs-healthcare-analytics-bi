CREATE TABLE IF NOT EXISTS warehouse.dim_date (
    date_key SMALLINT PRIMARY KEY,
    discharge_year SMALLINT NOT NULL UNIQUE
);

INSERT INTO warehouse.dim_date (date_key, discharge_year)
SELECT DISTINCT
       discharge_year,
       discharge_year
FROM staging.sparcs_raw
WHERE discharge_year IS NOT NULL
ON CONFLICT (date_key) DO NOTHING;

COMMENT ON TABLE warehouse.dim_date IS
'Date dimension containing available SPARCS discharge years.';