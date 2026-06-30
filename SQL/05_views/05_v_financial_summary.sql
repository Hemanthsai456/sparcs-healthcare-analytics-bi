CREATE OR REPLACE VIEW analytics.v_financial_summary AS

SELECT

    dt.discharge_year,

    pay.payment_typology_1,
    pay.payment_typology_2,
    pay.payment_typology_3,

    h.health_service_area,

    COUNT(*) AS total_admissions,

    SUM(f.total_charges) AS total_charges,

    SUM(f.total_costs) AS total_costs,

    ROUND(AVG(f.total_charges),2) AS avg_charge,

    ROUND(AVG(f.total_costs),2) AS avg_cost,

    ROUND(AVG(f.length_of_stay_days),2) AS avg_length_of_stay,

    ROUND(
        SUM(f.total_charges) /
        NULLIF(SUM(f.total_costs),0),
        2
    ) AS charge_cost_ratio

FROM warehouse.fact_discharge f

JOIN warehouse.dim_date dt
    ON f.date_key = dt.date_key

JOIN warehouse.dim_payment pay
    ON f.payment_key = pay.payment_key

JOIN warehouse.dim_hospital h
    ON f.hospital_key = h.hospital_key

GROUP BY

    dt.discharge_year,

    pay.payment_typology_1,
    pay.payment_typology_2,
    pay.payment_typology_3,

    h.health_service_area;