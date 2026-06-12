CREATE OR REPLACE VIEW analytics.v_financial_summary AS

SELECT

    p.payment_typology_1,

    COUNT(*) AS admissions,

    ROUND(SUM(f.total_charges),2) AS total_charges,

    ROUND(SUM(f.total_costs),2) AS total_costs,

    ROUND(AVG(f.total_charges),2) AS avg_charge,

    ROUND(AVG(f.total_costs),2) AS avg_cost,

    ROUND(
        SUM(f.total_charges) /
        NULLIF(SUM(f.total_costs),0),
        2
    ) AS charge_cost_ratio

FROM warehouse.fact_discharge f

JOIN warehouse.dim_payment p
    ON f.payment_key = p.payment_key

GROUP BY
    p.payment_typology_1;