INSERT INTO staging.etl_load_history
(
    dataset_year,
    source_file,
    load_start,
    load_end,
    rows_loaded_to_staging,
    rows_loaded_to_fact,
    current_fact_table_rows,
    load_status
)
VALUES
(
    2021,
    'sparcs_2021_raw.csv',

    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,

    (SELECT COUNT(*) FROM staging.sparcs_raw),

    (SELECT COUNT(*)
     FROM warehouse.fact_discharge
     WHERE date_key = 2021),

    (SELECT COUNT(*)
     FROM warehouse.fact_discharge),

    'SUCCESS'
);