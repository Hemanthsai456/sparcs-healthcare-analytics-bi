CREATE OR REPLACE VIEW analytics.v_patient_demographics AS

SELECT

    dt.discharge_year,

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

JOIN warehouse.dim_date dt
    ON f.date_key = dt.date_key

GROUP BY
    dt.discharge_year,
    p.age_group,
    p.gender,
    p.race,
    p.ethnicity;