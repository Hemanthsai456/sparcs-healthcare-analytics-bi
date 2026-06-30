-- In this we create Dimension tables and insert data into them 

-- 1. Hospital Dimension Table
-- Create a dim_hospital table in warehouse schema 

CREATE TABLE warehouse.dim_hospital (
    hospital_key SERIAL PRIMARY KEY,
    facility_id INTEGER,
    facility_name VARCHAR(150),
    operating_certificate_number VARCHAR(20),
    hospital_county VARCHAR(50),
    health_service_area VARCHAR(50)
);

ALTER TABLE warehouse.dim_hospital
ADD CONSTRAINT uq_dim_hospital
UNIQUE (facility_id);

-- Insert data into dim_hospital table

INSERT INTO warehouse.dim_hospital
(
    facility_id,
    facility_name,
    operating_certificate_number,
    hospital_county,
    health_service_area
)
SELECT DISTINCT
    NULLIF(TRIM(s.permanent_facility_id), '')::NUMERIC::INTEGER,

    NULLIF(TRIM(s.facility_name), ''),

    NULLIF(TRIM(s.operating_certificate_number), ''),

    NULLIF(TRIM(s.hospital_county), ''),

    NULLIF(TRIM(s.health_service_area), '')

FROM staging.sparcs_raw s

WHERE s.permanent_facility_id IS NOT NULL

ON CONFLICT (facility_id)
DO NOTHING;

-- Check data is inserted successfully 
SELECT COUNT(*) FROM warehouse.dim_hospital;

-- check the data 
SELECT *
FROM warehouse.dim_hospital
ORDER BY hospital_key
LIMIT 10;
