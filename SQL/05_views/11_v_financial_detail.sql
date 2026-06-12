CREATE OR REPLACE VIEW analytics.v_financial_detail AS

SELECT

    pay.payment_typology_1,
    pay.payment_typology_2,
    pay.payment_typology_3,

    p.age_group,

    h.health_service_area,

    f.total_charges,
    f.total_costs,

    f.length_of_stay_days

FROM warehouse.fact_discharge f

JOIN warehouse.dim_payment pay
    ON f.payment_key = pay.payment_key

JOIN warehouse.dim_patient p
    ON f.patient_key = p.patient_key

JOIN warehouse.dim_hospital h
    ON f.hospital_key = h.hospital_key;