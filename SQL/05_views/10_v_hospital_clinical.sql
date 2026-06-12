CREATE OR REPLACE VIEW analytics.v_hospital_clinical AS

SELECT

    h.facility_name,
    h.hospital_county,
    h.health_service_area,

    d.ccsr_diagnosis_code,
    d.ccsr_diagnosis_description,

    s.apr_severity_of_illness_description,
    s.apr_risk_of_mortality,

    f.length_of_stay_days,
    f.total_charges,
    f.total_costs

FROM warehouse.fact_discharge f

JOIN warehouse.dim_hospital h
    ON f.hospital_key = h.hospital_key

JOIN warehouse.dim_diagnosis d
    ON f.diagnosis_key = d.diagnosis_key

JOIN warehouse.dim_severity s
    ON f.severity_key = s.severity_key;