CREATE OR REPLACE VIEW analytics.v_risk_analysis AS

SELECT

    dt.discharge_year,

    s.apr_severity_of_illness_description,

    s.apr_risk_of_mortality,

    COUNT(*) AS admissions,

    ROUND(AVG(f.length_of_stay_days),2) AS avg_los,

    ROUND(SUM(f.total_charges),2) AS total_charges,

    ROUND(SUM(f.total_costs),2) AS total_costs

FROM warehouse.fact_discharge f

JOIN warehouse.dim_severity s
    ON f.severity_key = s.severity_key

JOIN warehouse.dim_date dt
    ON f.date_key = dt.date_key

GROUP BY
    dt.discharge_year,
    s.apr_severity_of_illness_description,
    s.apr_risk_of_mortality;