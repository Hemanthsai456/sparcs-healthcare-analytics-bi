DROP MATERIALIZED VIEW IF EXISTS analytics.mv_geographic_analysis;

CREATE MATERIALIZED VIEW analytics.mv_geographic_analysis AS

SELECT *
FROM analytics.v_geographic_analysis;

SELECT COUNT(*)
FROM analytics.v_geographic_analysis;

SELECT COUNT(*)
FROM analytics.mv_geographic_analysis;

CREATE INDEX idx_mv_geographic_hsa
ON analytics.mv_geographic_analysis(health_service_area);

