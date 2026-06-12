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

CREATE INDEX idx_fact_hospital_diagnosis
ON warehouse.fact_discharge(hospital_key, diagnosis_key);

/* =========================
   DIMENSION BUSINESS KEY INDEXES
   ========================= */

CREATE INDEX idx_dim_hospital_facility_id
ON warehouse.dim_hospital(facility_id);

CREATE INDEX idx_dim_diagnosis_ccsr
ON warehouse.dim_diagnosis(ccsr_diagnosis_code);

CREATE INDEX idx_dim_procedure_ccsr
ON warehouse.dim_procedure(ccsr_procedure_code);