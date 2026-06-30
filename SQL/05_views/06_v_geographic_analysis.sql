CREATE OR REPLACE VIEW analytics.v_geographic_analysis AS

SELECT

    dt.discharge_year,

    h.health_service_area,

    h.hospital_county,

    COUNT(*) AS admissions,

    ROUND(SUM(f.total_charges),2) AS total_charges,

    ROUND(SUM(f.total_costs),2) AS total_costs,

    ROUND(AVG(f.length_of_stay_days),2) AS avg_los

FROM warehouse.fact_discharge f

JOIN warehouse.dim_hospital h
    ON f.hospital_key = h.hospital_key

JOIN warehouse.dim_date dt 
    ON f.date_key = dt.date_key

GROUP BY
    dt.discharge_year,
    h.health_service_area,
    h.hospital_county;