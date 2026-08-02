/* ==========================================================
   ANALYTICS VIEWS
   ========================================================== */

SELECT
    table_schema,
    table_name
FROM information_schema.views
ORDER BY table_schema,
         table_name;

/* ==========================================================
   MATERALIZED VIEWS
   ========================================================== */


SELECT
    schemaname,
    matviewname
FROM pg_matviews;