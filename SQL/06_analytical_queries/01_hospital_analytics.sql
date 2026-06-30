/*
====================================================
HOSPITAL ANALYTICS
====================================================

Domain:
Hospital Performance Analysis

Purpose:
Evaluate hospital performance, financial
efficiency, patient volume, emergency care,
and operational effectiveness.

Data Source:
analytics.v_hospital_performance
====================================================
*/


/*
====================================================
Question 1

Which hospitals handle the highest
patient volume?

Business Value:
Identifies the busiest hospitals for
capacity planning and resource allocation.
====================================================
*/

SELECT
    discharge_year,
    facility_name,
    health_service_area,
    admissions

FROM analytics.v_hospital_performance

ORDER BY
    admissions DESC,
    facility_name;



/*
====================================================
Question 2

Which hospitals generate the highest
total charges?

Business Value:
Identifies hospitals contributing the
largest share of healthcare revenue.
====================================================
*/

SELECT
    discharge_year,
    facility_name,
    total_charges

FROM analytics.v_hospital_performance

ORDER BY total_charges DESC;



/*
====================================================
Question 3

Which hospitals have the highest
financial efficiency?

Business Value:
Measures how effectively hospitals
convert costs into charges.
====================================================
*/

SELECT
    discharge_year,
    facility_name,
    charge_cost_ratio

FROM analytics.v_hospital_performance

ORDER BY charge_cost_ratio DESC;



/*
====================================================
Question 4

Which hospitals have above-average
length of stay?

Business Value:
Highlights hospitals where patients stay
longer than the statewide average,
indicating potential operational issues
or greater case complexity.
====================================================
*/

SELECT
    discharge_year,
    facility_name,
    avg_los

FROM analytics.v_hospital_performance

WHERE avg_los >
(
    SELECT AVG(avg_los)
    FROM analytics.v_hospital_performance
)

ORDER BY avg_los DESC;



/*
====================================================
Question 5

Which hospitals have the highest
emergency admission rate?

Business Value:
Identifies hospitals with the greatest
emergency care burden.
====================================================
*/

SELECT
    discharge_year,
    facility_name,
    emergency_rate_percent

FROM analytics.v_hospital_performance

ORDER BY emergency_rate_percent DESC;



/*
====================================================
Question 6

How do hospitals rank by patient
admissions within each year?

Business Value:
Ranks hospitals by annual patient volume
to identify market leaders.
====================================================
*/

SELECT
    discharge_year,
    facility_name,
    admissions,

    RANK() OVER
    (
        PARTITION BY discharge_year
        ORDER BY admissions DESC
    ) AS admission_rank

FROM analytics.v_hospital_performance

ORDER BY
    discharge_year,
    admission_rank;



/*
====================================================
Question 7

Which hospitals belong to the highest
financial performance quartile based on
total charges?

Business Value:
Segments hospitals into performance
groups for benchmarking.
====================================================
*/

SELECT
    discharge_year,
    facility_name,
    total_charges,

    NTILE(4) OVER
    (
        PARTITION BY discharge_year
        ORDER BY total_charges DESC
    ) AS revenue_quartile

FROM analytics.v_hospital_performance

ORDER BY
    discharge_year,
    revenue_quartile,
    total_charges DESC;