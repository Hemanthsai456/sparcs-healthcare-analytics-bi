/*==============================================================
  FACT TABLE LOAD
==============================================================*/

/*==============================================================
  Remove Existing Fact Records
  (Current Dataset Year Only)
==============================================================*/

DELETE FROM warehouse.fact_discharge
WHERE date_key IN
(
    SELECT DISTINCT discharge_year
    FROM staging.sparcs_raw
);

/*==============================================================
  Clean & Standardize Source Data
==============================================================*/

WITH cleaned AS
(
    SELECT

    /*==========================================================
      Hospital
    ==========================================================*/

    NULLIF(BTRIM(permanent_facility_id), '')::NUMERIC::INTEGER
        AS facility_id,


    /*==========================================================
      Patient
    ==========================================================*/

    NULLIF(BTRIM(age_group),'')
        AS age_group,

    NULLIF(BTRIM(gender),'')
        AS gender,

    NULLIF(BTRIM(race),'')
        AS race,

    NULLIF(BTRIM(ethnicity),'')
        AS ethnicity,


    /*==========================================================
      Diagnosis
    ==========================================================*/

    NULLIF(BTRIM(ccsr_diagnosis_code),'')
        AS ccsr_diagnosis_code,

    NULLIF(BTRIM(ccsr_diagnosis_description),'')
        AS ccsr_diagnosis_description,

    NULLIF(BTRIM(apr_drg_code),'')::INTEGER
        AS apr_drg_code,

    NULLIF(BTRIM(apr_drg_description),'')
        AS apr_drg_description,

    NULLIF(BTRIM(apr_mdc_code),'')::INTEGER
        AS apr_mdc_code,

    NULLIF(BTRIM(apr_mdc_description),'')
        AS apr_mdc_description,


    /*==========================================================
      Procedure
    ==========================================================*/

    NULLIF(BTRIM(ccsr_procedure_code),'')
        AS ccsr_procedure_code,

    NULLIF(BTRIM(ccsr_procedure_description),'')
        AS ccsr_procedure_description,


    /*==========================================================
      Severity
    ==========================================================*/

    NULLIF(BTRIM(apr_severity_of_illness_code),'')::INTEGER
        AS apr_severity_of_illness_code,

    NULLIF(BTRIM(apr_severity_of_illness_description),'')
        AS apr_severity_of_illness_description,

    NULLIF(BTRIM(apr_risk_of_mortality),'')
        AS apr_risk_of_mortality,

    NULLIF(BTRIM(apr_medical_surgical_description),'')
        AS apr_medical_surgical_description,


    /*==========================================================
      Payment
    ==========================================================*/

    NULLIF(BTRIM(payment_typology_1),'')
        AS payment_typology_1,

    NULLIF(BTRIM(payment_typology_2),'')
        AS payment_typology_2,

    NULLIF(BTRIM(payment_typology_3),'')
        AS payment_typology_3,


    /*==========================================================
      Admission
    ==========================================================*/

    NULLIF(BTRIM(type_of_admission),'')
        AS type_of_admission,

    NULLIF(BTRIM(patient_disposition),'')
        AS patient_disposition,

    NULLIF(BTRIM(emergency_department_indicator),'')
        AS emergency_department_indicator,


    /*==========================================================
      Date
    ==========================================================*/

    discharge_year,


    /*==========================================================
      Measures
    ==========================================================*/

    length_of_stay
        AS length_of_stay_raw,

    CASE
        WHEN REPLACE(BTRIM(length_of_stay),' ','') = '120+'
            THEN 120
        ELSE
            NULLIF
            (
                REGEXP_REPLACE(length_of_stay,'[^0-9]','','g'),
                ''
            )::INTEGER
    END
        AS length_of_stay_days,

    NULLIF
    (
        REPLACE(total_charges,',',''),
        ''
    )::NUMERIC(14,2)
        AS total_charges,

    NULLIF
    (
        REPLACE(total_costs,',',''),
        ''
    )::NUMERIC(14,2)
        AS total_costs

    FROM staging.sparcs_raw
),

/*==============================================================
  Single Load Timestamp
==============================================================*/

load_time AS
(
    SELECT CURRENT_TIMESTAMP AS ts
)

/*==============================================================
  Insert Fact Records
==============================================================*/

INSERT INTO warehouse.fact_discharge
(
    hospital_key,
    patient_key,
    diagnosis_key,
    procedure_key,
    severity_key,
    payment_key,
    admission_key,

    date_key,

    length_of_stay_raw,
    length_of_stay_days,

    total_charges,
    total_costs,

    admission_count,
    created_at
)

SELECT

    COALESCE(h.hospital_key,0)      AS hospital_key,
    COALESCE(p.patient_key,0)       AS patient_key,
    COALESCE(d.diagnosis_key,0)     AS diagnosis_key,
    COALESCE(pr.procedure_key,0)    AS procedure_key,
    COALESCE(sev.severity_key,0)    AS severity_key,
    COALESCE(pay.payment_key,0)     AS payment_key,
    COALESCE(adm.admission_key,0)   AS admission_key,

    COALESCE(dt.date_key,0)         AS date_key,

    c.length_of_stay_raw,
    c.length_of_stay_days,

    c.total_charges,
    c.total_costs,

    1 AS admission_count,

    lt.ts

FROM cleaned c
CROSS JOIN load_time lt


/*==============================================================
  Hospital
==============================================================*/

LEFT JOIN warehouse.dim_hospital h
ON c.facility_id = h.facility_id


/*==============================================================
  Patient
==============================================================*/

LEFT JOIN warehouse.dim_patient p
ON c.age_group = p.age_group
AND c.gender = p.gender
AND c.race = p.race
AND c.ethnicity = p.ethnicity


/*==============================================================
  Diagnosis
==============================================================*/

LEFT JOIN warehouse.dim_diagnosis d
ON c.ccsr_diagnosis_code = d.ccsr_diagnosis_code
AND c.ccsr_diagnosis_description = d.ccsr_diagnosis_description
AND c.apr_drg_code = d.apr_drg_code
AND c.apr_drg_description = d.apr_drg_description
AND c.apr_mdc_code = d.apr_mdc_code
AND c.apr_mdc_description = d.apr_mdc_description


/*==============================================================
  Procedure
==============================================================*/

LEFT JOIN warehouse.dim_procedure pr
ON c.ccsr_procedure_code = pr.ccsr_procedure_code
AND c.ccsr_procedure_description = pr.ccsr_procedure_description

/*==============================================================
  Severity
==============================================================*/

LEFT JOIN warehouse.dim_severity sev
ON c.apr_severity_of_illness_code = sev.apr_severity_of_illness_code
AND c.apr_severity_of_illness_description = sev.apr_severity_of_illness_description
AND c.apr_risk_of_mortality = sev.apr_risk_of_mortality
AND c.apr_medical_surgical_description = sev.apr_medical_surgical_description


/*==============================================================
  Payment
==============================================================*/

LEFT JOIN warehouse.dim_payment pay
ON c.payment_typology_1 = pay.payment_typology_1
AND c.payment_typology_2 = pay.payment_typology_2
AND c.payment_typology_3 = pay.payment_typology_3


/*==============================================================
  Admission
==============================================================*/

LEFT JOIN warehouse.dim_admission adm
ON c.type_of_admission = adm.type_of_admission
AND c.patient_disposition = adm.patient_disposition
AND c.emergency_department_indicator = adm.emergency_department_indicator


/*==============================================================
  Date
==============================================================*/

LEFT JOIN warehouse.dim_date dt
ON c.discharge_year = dt.discharge_year;


/*==============================================================
  Refresh Planner Statistics
==============================================================*/

ANALYZE warehouse.fact_discharge;
