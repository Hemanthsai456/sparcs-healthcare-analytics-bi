/* ==========================================================
   TABLE STATISTICS
   ========================================================== */

SELECT
    schemaname,
    relname AS table_name,
    n_live_tup AS estimated_rows,
    pg_size_pretty(pg_total_relation_size(relid)) AS total_size,
    pg_size_pretty(pg_relation_size(relid)) AS table_size,
    pg_size_pretty(
        pg_total_relation_size(relid)
        - pg_relation_size(relid)
    ) AS indexes_size
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;