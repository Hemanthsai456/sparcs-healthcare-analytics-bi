CREATE OR REPLACE VIEW analytics.v_operations AS

SELECT

    dt.discharge_year,

    a.type_of_admission,

    a.patient_disposition,

    a.emergency_department_indicator,

    COUNT(*) AS admissions,

    ROUND(AVG(f.length_of_stay_days),2) AS avg_los,

    ROUND(SUM(f.total_charges),2) AS total_charges,

    ROUND(SUM(f.total_costs),2) AS total_costs

FROM warehouse.fact_discharge f

JOIN warehouse.dim_admission a
    ON f.admission_key = a.admission_key

JOIN warehouse.dim_date dt
    ON f.date_key = dt.date_key

GROUP BY
    dt.discharge_year,
    a.type_of_admission,
    a.patient_disposition,
    a.emergency_department_indicator;