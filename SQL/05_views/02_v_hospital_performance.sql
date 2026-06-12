CREATE OR REPLACE VIEW analytics.v_hospital_performance AS

SELECT

    h.facility_id,

    h.facility_name,

    h.hospital_county,

    h.health_service_area,

    COUNT(*) AS admissions,

    ROUND(SUM(f.total_charges),2) AS total_charges,

    ROUND(SUM(f.total_costs),2) AS total_costs,

    ROUND(AVG(f.length_of_stay_days),2) AS avg_los,

    ROUND(
        SUM(f.total_charges) /
        NULLIF(SUM(f.total_costs),0),
        2
    ) AS charge_cost_ratio,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN a.emergency_department_indicator = 'Y'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS emergency_rate_percent

FROM warehouse.fact_discharge f

JOIN warehouse.dim_hospital h
    ON f.hospital_key = h.hospital_key

JOIN warehouse.dim_admission a
    ON f.admission_key = a.admission_key

GROUP BY
    h.facility_id,
    h.facility_name,
    h.hospital_county,
    h.health_service_area;