DROP MATERIALIZED VIEW IF EXISTS analytics.mv_financial_summary;

CREATE MATERIALIZED VIEW analytics.mv_financial_summary AS

SELECT *
FROM analytics.v_financial_summary;

SELECT COUNT(*)
FROM analytics.v_financial_summary;

SELECT COUNT(*)
FROM analytics.mv_financial_summary;

-- Create Index
CREATE INDEX idx_mv_financial_summary_payer
ON analytics.mv_financial_summary(payment_typology_1);
