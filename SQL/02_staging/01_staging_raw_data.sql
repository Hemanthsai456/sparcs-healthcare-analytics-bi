DROP TABLE IF EXISTS staging.sparcs_raw;

CREATE TABLE staging.sparcs_raw (
    health_service_area TEXT,
    hospital_county TEXT,
    operating_certificate_number TEXT,
    permanent_facility_id TEXT,
    facility_name TEXT,
    age_group TEXT,
    zip_code TEXT,
    gender TEXT,
    race TEXT,
    ethnicity TEXT,
    length_of_stay TEXT,
    type_of_admission TEXT,
    patient_disposition TEXT,
    discharge_year INTEGER,
    ccsr_diagnosis_code TEXT,
    ccsr_diagnosis_description TEXT,
    ccsr_procedure_code TEXT,
    ccsr_procedure_description TEXT,
    apr_drg_code TEXT,
    apr_drg_description TEXT,
    apr_mdc_code TEXT,
    apr_mdc_description TEXT,
    apr_severity_of_illness_code TEXT,
    apr_severity_of_illness_description TEXT,
    apr_risk_of_mortality TEXT,
    apr_medical_surgical_description TEXT,
    payment_typology_1 TEXT,
    payment_typology_2 TEXT,
    payment_typology_3 TEXT,
    birth_weight TEXT,
    emergency_department_indicator TEXT,
    total_charges TEXT,
    total_costs TEXT
);


COMMENT ON TABLE staging.sparcs_raw IS
'Temporary landing table for raw SPARCS datasets. One dataset is loaded, processed into the warehouse, validated, and then truncated before loading the next dataset.';