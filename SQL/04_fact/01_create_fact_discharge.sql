CREATE TABLE warehouse.fact_discharge
(
    discharge_key BIGSERIAL PRIMARY KEY,

    hospital_key INTEGER NOT NULL,
    patient_key INTEGER NOT NULL,
    diagnosis_key INTEGER NOT NULL,
    procedure_key INTEGER NOT NULL,
    severity_key INTEGER NOT NULL,
    payment_key INTEGER NOT NULL,
    admission_key INTEGER NOT NULL,

    discharge_year SMALLINT NOT NULL,

    length_of_stay_raw VARCHAR(5),

    length_of_stay_days INTEGER NOT NULL,

    total_charges NUMERIC(14,2) NOT NULL,

    total_costs NUMERIC(14,2) NOT NULL,

    admission_count SMALLINT NOT NULL DEFAULT 1,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_fact_hospital
        FOREIGN KEY (hospital_key)
        REFERENCES warehouse.dim_hospital(hospital_key),

    CONSTRAINT fk_fact_patient
        FOREIGN KEY (patient_key)
        REFERENCES warehouse.dim_patient(patient_key),

    CONSTRAINT fk_fact_diagnosis
        FOREIGN KEY (diagnosis_key)
        REFERENCES warehouse.dim_diagnosis(diagnosis_key),

    CONSTRAINT fk_fact_procedure
        FOREIGN KEY (procedure_key)
        REFERENCES warehouse.dim_procedure(procedure_key),

    CONSTRAINT fk_fact_severity
        FOREIGN KEY (severity_key)
        REFERENCES warehouse.dim_severity(severity_key),

    CONSTRAINT fk_fact_payment
        FOREIGN KEY (payment_key)
        REFERENCES warehouse.dim_payment(payment_key),

    CONSTRAINT fk_fact_admission
        FOREIGN KEY (admission_key)
        REFERENCES warehouse.dim_admission(admission_key),

    CONSTRAINT chk_los_non_negative
        CHECK (length_of_stay_days >= 0),

    CONSTRAINT chk_admission_count
        CHECK (admission_count = 1)
);