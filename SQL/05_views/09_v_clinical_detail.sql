CREATE OR REPLACE VIEW analytics.v_clinical_detail AS

SELECT

    d.ccsr_diagnosis_code,
    d.ccsr_diagnosis_description,

    d.apr_drg_code,
    d.apr_drg_description,

    p.age_group,
    p.gender,
    p.race,
    p.ethnicity,

    s.apr_severity_of_illness_description,
    s.apr_risk_of_mortality,

    f.length_of_stay_days,
    f.total_charges,
    f.total_costs,
    f.admission_count

FROM warehouse.fact_discharge f

JOIN warehouse.dim_diagnosis d
    ON f.diagnosis_key = d.diagnosis_key

JOIN warehouse.dim_patient p
    ON f.patient_key = p.patient_key

JOIN warehouse.dim_severity s
    ON f.severity_key = s.severity_key;