/* ==========================================================
   DATABASE OVERVIEW
   ========================================================== */

SELECT
    current_database() AS database_name,
    current_user AS connected_user,
    current_schema() AS current_schema,
    version() AS postgresql_version,
    now() AS current_timestamp,
    pg_size_pretty(pg_database_size(current_database())) AS database_size;