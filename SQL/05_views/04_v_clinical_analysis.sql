CREATE OR REPLACE VIEW analytics.v_clinical_analysis AS

SELECT

    d.ccsr_diagnosis_code,
    d.ccsr_diagnosis_description,

    d.apr_drg_code,
    d.apr_drg_description,

    COUNT(*) AS admissions,

    ROUND(AVG(f.length_of_stay_days),2) AS avg_los,

    ROUND(SUM(f.total_charges),2) AS total_charges,

    ROUND(SUM(f.total_costs),2) AS total_costs,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN s.apr_risk_of_mortality = 'Extreme'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS extreme_mortality_percent

FROM warehouse.fact_discharge f

JOIN warehouse.dim_diagnosis d
    ON f.diagnosis_key = d.diagnosis_key

JOIN warehouse.dim_severity s
    ON f.severity_key = s.severity_key

GROUP BY
    d.ccsr_diagnosis_code,
    d.ccsr_diagnosis_description,
    d.apr_drg_code,
    d.apr_drg_description;