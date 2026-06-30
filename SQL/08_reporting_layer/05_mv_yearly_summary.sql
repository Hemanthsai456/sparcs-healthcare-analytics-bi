DROP MATERIALIZED VIEW IF EXISTS analytics.mv_yearly_summary;

CREATE MATERIALIZED VIEW analytics.mv_yearly_summary AS

SELECT *
FROM analytics.v_yearly_summary;

CREATE INDEX idx_mv_yearly_summary_year
ON analytics.mv_yearly_summary(discharge_year);