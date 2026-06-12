-- Add Unknown rows to All dimensions before Fact table

INSERT INTO warehouse.dim_hospital (
    hospital_key,
    facility_id,
    facility_name,
    operating_certificate_number,
    hospital_county,
    health_service_area
)
VALUES (
    0,
    NULL,
    'Unknown',
    'Unknown',
    'Unknown',
    'Unknown'
);

INSERT INTO warehouse.dim_patient (
    patient_key,
    age_group,
    gender,
    race,
    ethnicity
)
VALUES (
    0,
    'Unknown',
    'Unknown',
    'Unknown',
    'Unknown'
);

INSERT INTO warehouse.dim_diagnosis (
    diagnosis_key,
    ccsr_diagnosis_code,
    ccsr_diagnosis_description,
    apr_drg_code,
    apr_drg_description,
    apr_mdc_code,
    apr_mdc_description
)
VALUES (
    0,
    'UNKNOWN',
    'Unknown',
    NULL,
    'Unknown',
    NULL,
    'Unknown'
);

INSERT INTO warehouse.dim_procedure (
    procedure_key,
    ccsr_procedure_code,
    ccsr_procedure_description
)
VALUES (
    0,
    'UNKNOWN',
    'Unknown'
);

INSERT INTO warehouse.dim_severity (
    severity_key,
    apr_severity_of_illness_code,
    apr_severity_of_illness_description,
    apr_risk_of_mortality,
    apr_medical_surgical_description
)
VALUES (
    0,
    NULL,
    'Unknown',
    'Unknown',
    'Unknown'
);

INSERT INTO warehouse.dim_payment (
    payment_key,
    payment_typology_1,
    payment_typology_2,
    payment_typology_3
)
VALUES (
    0,
    'Unknown',
    'Unknown',
    'Unknown'
);

INSERT INTO warehouse.dim_admission (
    admission_key,
    type_of_admission,
    patient_disposition,
    emergency_department_indicator
)
VALUES (
    0,
    'Unknown',
    'Unknown',
    'Unknown'
);