DROP MATERIALIZED VIEW IF EXISTS analytics.mv_hospital_trends;

CREATE MATERIALIZED VIEW analytics.mv_hospital_trends AS

SELECT *
FROM analytics.v_hospital_trends;

CREATE INDEX idx_mv_hospital_trends
ON analytics.mv_hospital_trends
(
    discharge_year,
    facility_name
);