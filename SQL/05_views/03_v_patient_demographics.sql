CREATE OR REPLACE VIEW analytics.v_patient_demographics AS

SELECT

    p.age_group,

    p.gender,

    p.race,

    p.ethnicity,

    COUNT(*) AS admissions,

    ROUND(AVG(f.length_of_stay_days),2) AS avg_los,

    ROUND(SUM(f.total_charges),2) AS total_charges,

    ROUND(SUM(f.total_costs),2) AS total_costs

FROM warehouse.fact_discharge f

JOIN warehouse.dim_patient p
    ON f.patient_key = p.patient_key

GROUP BY
    p.age_group,
    p.gender,
    p.race,
    p.ethnicity;