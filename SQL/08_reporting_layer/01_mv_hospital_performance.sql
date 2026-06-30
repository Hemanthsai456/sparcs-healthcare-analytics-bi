DROP MATERIALIZED VIEW IF EXISTS analytics.mv_hospital_performance;

CREATE MATERIALIZED VIEW analytics.mv_hospital_performance AS

SELECT *
FROM analytics.v_hospital_performance;

-- Create Index
CREATE INDEX idx_mv_hospital_performance_facility_id
ON analytics.mv_hospital_performance(facility_id);
