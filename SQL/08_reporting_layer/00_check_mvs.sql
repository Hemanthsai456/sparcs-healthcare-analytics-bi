SELECT schemaname,
       matviewname
FROM pg_matviews
WHERE schemaname = 'analytics';

