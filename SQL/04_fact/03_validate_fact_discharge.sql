-- Checking number of rows

SELECT COUNT(*)
FROM warehouse.fact_discharge;

-- Validations

SELECT
    SUM(CASE WHEN hospital_key = 0 THEN 1 ELSE 0 END) AS unknown_hospital,
    SUM(CASE WHEN patient_key = 0 THEN 1 ELSE 0 END) AS unknown_patient,
    SUM(CASE WHEN diagnosis_key = 0 THEN 1 ELSE 0 END) AS unknown_diagnosis,
    SUM(CASE WHEN procedure_key = 0 THEN 1 ELSE 0 END) AS unknown_procedure,
    SUM(CASE WHEN severity_key = 0 THEN 1 ELSE 0 END) AS unknown_severity,
    SUM(CASE WHEN payment_key = 0 THEN 1 ELSE 0 END) AS unknown_payment,
    SUM(CASE WHEN admission_key = 0 THEN 1 ELSE 0 END) AS unknown_admission
FROM warehouse.fact_discharge;

SELECT COUNT(*) AS unknown_hospital
FROM warehouse.fact_discharge
WHERE hospital_key = 0;

SELECT COUNT(*) AS unknown_patient
FROM warehouse.fact_discharge
WHERE patient_key = 0;

SELECT COUNT(*) AS unknown_diagnosis
FROM warehouse.fact_discharge
WHERE diagnosis_key = 0;

SELECT COUNT(*) AS unknown_procedure
FROM warehouse.fact_discharge
WHERE procedure_key = 0;

SELECT COUNT(*) AS unknown_severity
FROM warehouse.fact_discharge
WHERE severity_key = 0;

SELECT COUNT(*) AS unknown_payment
FROM warehouse.fact_discharge
WHERE payment_key = 0;

SELECT COUNT(*) AS unknown_admission
FROM warehouse.fact_discharge
WHERE admission_key = 0;