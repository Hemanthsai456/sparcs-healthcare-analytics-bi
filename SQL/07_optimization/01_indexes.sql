/* =========================
   FACT TABLE INDEXES
   ========================= */

CREATE INDEX idx_fact_hospital
ON warehouse.fact_discharge(hospital_key);

CREATE INDEX idx_fact_patient
ON warehouse.fact_discharge(patient_key);

CREATE INDEX idx_fact_diagnosis
ON warehouse.fact_discharge(diagnosis_key);

CREATE INDEX idx_fact_procedure
ON warehouse.fact_discharge(procedure_key);

CREATE INDEX idx_fact_severity
ON warehouse.fact_discharge(severity_key);

CREATE INDEX idx_fact_payment
ON warehouse.fact_discharge(payment_key);

CREATE INDEX idx_fact_admission
ON warehouse.fact_discharge(admission_key);

CREATE INDEX idx_fact_date
ON warehouse.fact_discharge(date_key);

/* =========================
   DIMENSION BUSINESS KEY INDEXES
   ========================= */

-- ALL DIMENSION TABLES HAVE BUSINESS KEYS THAT ARE USED TO JOIN TO THE FACT TABLE. SO SEPARATE EXPLICIT INDEXING IS NOT REQUIRED.