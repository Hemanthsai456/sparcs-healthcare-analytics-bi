INSERT INTO warehouse.fact_discharge
(
    hospital_key,
    patient_key,
    diagnosis_key,
    procedure_key,
    severity_key,
    payment_key,
    admission_key,

    discharge_year,

    length_of_stay_raw,
    length_of_stay_days,

    total_charges,
    total_costs,

    admission_count
)

SELECT

    COALESCE(h.hospital_key, 0),

    COALESCE(p.patient_key, 0),

    COALESCE(d.diagnosis_key, 0),

    COALESCE(pr.procedure_key, 0),

    COALESCE(sev.severity_key, 0),

    COALESCE(pay.payment_key, 0),

    COALESCE(adm.admission_key, 0),

    s.discharge_year::SMALLINT,

    s.length_of_stay,

    CASE
        WHEN s.length_of_stay = '120+' THEN 120
        ELSE s.length_of_stay::INTEGER
    END,

    s.total_charges::NUMERIC(14,2),

    s.total_costs::NUMERIC(14,2),

    1

FROM staging.sparcs_raw s

/* =========================
   Hospital Dimension
   ========================= */

LEFT JOIN warehouse.dim_hospital h
    ON s.permanent_facility_id::INTEGER = h.facility_id

/* =========================
   Patient Dimension
   ========================= */

LEFT JOIN warehouse.dim_patient p
    ON s.age_group = p.age_group
   AND s.gender = p.gender
   AND s.race = p.race
   AND s.ethnicity = p.ethnicity

/* =========================
   Diagnosis Dimension
   ========================= */

LEFT JOIN warehouse.dim_diagnosis d
    ON s.ccsr_diagnosis_code = d.ccsr_diagnosis_code
   AND s.ccsr_diagnosis_description = d.ccsr_diagnosis_description
   AND s.apr_drg_code = d.apr_drg_code
   AND s.apr_drg_description = d.apr_drg_description
   AND s.apr_mdc_code = d.apr_mdc_code
   AND s.apr_mdc_description = d.apr_mdc_description

/* =========================
   Procedure Dimension
   ========================= */

LEFT JOIN warehouse.dim_procedure pr
    ON s.ccsr_procedure_code
       IS NOT DISTINCT FROM pr.ccsr_procedure_code

   AND s.ccsr_procedure_description
       IS NOT DISTINCT FROM pr.ccsr_procedure_description

/* =========================
   Severity Dimension
   ========================= */

LEFT JOIN warehouse.dim_severity sev
    ON s.apr_severity_of_illness_code = sev.apr_severity_of_illness_code
   AND s.apr_severity_of_illness_description = sev.apr_severity_of_illness_description
   AND s.apr_risk_of_mortality = sev.apr_risk_of_mortality
   AND s.apr_medical_surgical_description = sev.apr_medical_surgical_description

/* =========================
   Payment Dimension
   ========================= */

LEFT JOIN warehouse.dim_payment pay
    ON s.payment_typology_1
       IS NOT DISTINCT FROM pay.payment_typology_1

   AND s.payment_typology_2
       IS NOT DISTINCT FROM pay.payment_typology_2

   AND s.payment_typology_3
       IS NOT DISTINCT FROM pay.payment_typology_3

/* =========================
   Admission Dimension
   ========================= */

LEFT JOIN warehouse.dim_admission adm
    ON s.type_of_admission = adm.type_of_admission
   AND s.patient_disposition = adm.patient_disposition
   AND s.emergency_department_indicator = adm.emergency_department_indicator;