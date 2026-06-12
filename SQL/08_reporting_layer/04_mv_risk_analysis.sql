DROP MATERIALIZED VIEW IF EXISTS analytics.mv_risk_analysis;

CREATE MATERIALIZED VIEW analytics.mv_risk_analysis AS

SELECT *
FROM analytics.v_risk_analysis;

SELECT COUNT(*)
FROM analytics.v_risk_analysis;

SELECT COUNT(*)
FROM analytics.mv_risk_analysis;

CREATE INDEX idx_mv_risk_analysis_severity
ON analytics.mv_risk_analysis(apr_severity_of_illness_description);

