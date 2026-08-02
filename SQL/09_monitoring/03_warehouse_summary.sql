/* ==========================================================
   WAREHOUSE SUMMARY
   ========================================================== */

WITH schema_summary AS (
    SELECT
        table_schema,
        COUNT(*) FILTER (WHERE table_type = 'BASE TABLE') AS tables,
        COUNT(*) FILTER (WHERE table_type = 'VIEW') AS views
    FROM information_schema.tables
    WHERE table_schema IN ('staging', 'warehouse', 'analytics')
    GROUP BY table_schema
),

index_summary AS (
    SELECT COUNT(*) AS total_indexes
    FROM pg_indexes
    WHERE schemaname IN ('staging', 'warehouse', 'analytics')
),

matview_summary AS (
    SELECT COUNT(*) AS materialized_views
    FROM pg_matviews
    WHERE schemaname IN ('staging', 'warehouse', 'analytics')
)

SELECT
    (SELECT tables FROM schema_summary WHERE table_schema = 'staging')   AS staging_tables,
    (SELECT tables FROM schema_summary WHERE table_schema = 'warehouse') AS warehouse_tables,
    (SELECT tables FROM schema_summary WHERE table_schema = 'analytics') AS analytics_tables,

    (SELECT views FROM schema_summary WHERE table_schema = 'analytics')  AS analytics_views,

    (SELECT total_indexes FROM index_summary) AS total_indexes,

    (SELECT materialized_views FROM matview_summary) AS materialized_views;