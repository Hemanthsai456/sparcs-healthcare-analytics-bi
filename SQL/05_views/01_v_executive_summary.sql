CREATE OR REPLACE VIEW analytics.v_executive_summary AS

SELECT

    COUNT(*) AS total_admissions,

    ROUND(SUM(total_charges),2) AS total_charges,

    ROUND(SUM(total_costs),2) AS total_costs,

    ROUND(AVG(total_charges),2) AS average_charge,

    ROUND(AVG(total_costs),2) AS average_cost,

    ROUND(AVG(length_of_stay_days),2) AS average_los,

    ROUND(
        SUM(total_charges) /
        NULLIF(SUM(total_costs),0),
        2
    ) AS charge_cost_ratio,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN a.emergency_department_indicator = 'Y'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS emergency_rate_percent,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN s.apr_severity_of_illness_description = 'Extreme'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS extreme_severity_percent,

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

JOIN warehouse.dim_severity s
    ON f.severity_key = s.severity_key

JOIN warehouse.dim_admission a
    ON f.admission_key = a.admission_key;