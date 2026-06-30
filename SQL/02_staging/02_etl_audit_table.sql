DROP TABLE IF EXISTS staging.etl_load_history;

CREATE TABLE staging.etl_load_history(

    load_id BIGSERIAL PRIMARY KEY,

    dataset_year SMALLINT NOT NULL,

    source_file VARCHAR(255) NOT NULL,

    load_start TIMESTAMP NOT NULL,

    load_end TIMESTAMP,

    rows_loaded_to_staging INTEGER,

    rows_loaded_to_fact INTEGER,

    current_fact_table_rows BIGINT,

    load_status VARCHAR(20) NOT NULL,

    rows_rejected INTEGER,

    error_message TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

COMMENT ON TABLE staging.etl_load_history IS
'Tracks every yearly ETL execution.';