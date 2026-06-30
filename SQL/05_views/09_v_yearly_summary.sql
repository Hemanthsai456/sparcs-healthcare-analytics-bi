CREATE OR REPLACE VIEW analytics.v_yearly_summary AS

SELECT

    dt.discharge_year,

    COUNT(*) AS total_admissions,

    SUM(f.total_charges) AS total_charges,

    SUM(f.total_costs) AS total_costs,

    ROUND(AVG(f.total_charges),2) AS average_charge,

    ROUND(AVG(f.total_costs),2) AS average_cost,

    ROUND(AVG(f.length_of_stay_days),2) AS average_length_of_stay,

    ROUND(
        SUM(f.total_charges) /
        NULLIF(SUM(f.total_costs),0),
        2
    ) AS charge_to_cost_ratio

FROM warehouse.fact_discharge f

JOIN warehouse.dim_date dt
ON f.date_key = dt.date_key

GROUP BY
    dt.discharge_year

ORDER BY
    dt.discharge_year;