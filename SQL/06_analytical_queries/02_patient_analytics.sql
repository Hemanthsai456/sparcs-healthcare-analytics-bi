/*
====================================================
PATIENT ANALYTICS
====================================================

Domain:
Patient Demographics Analysis

Purpose:
Analyze patient demographics, healthcare
utilization, costs, and resource
consumption across different patient groups.

Data Source:
analytics.v_patient_demographics
====================================================
*/


/*
====================================================
Question 1

Which age groups account for the highest
number of hospital admissions?

Business Value:
Identifies patient age groups driving
healthcare demand.
====================================================
*/

SELECT
    discharge_year,
    age_group,
    admissions

FROM analytics.v_patient_demographics

ORDER BY
    admissions DESC,
    age_group;



/*
====================================================
Question 2

Which gender incurs the highest
healthcare costs?

Business Value:
Evaluates healthcare spending patterns
across genders.
====================================================
*/

SELECT
    discharge_year,
    gender,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_patient_demographics

GROUP BY
    discharge_year,
    gender

ORDER BY total_costs DESC;



/*
====================================================
Question 3

Which racial groups generate the highest
hospital charges?

Business Value:
Identifies differences in healthcare
resource utilization across racial groups.
====================================================
*/

SELECT
    discharge_year,
    race,

    ROUND(
        SUM(total_charges),
        2
    ) AS total_charges

FROM analytics.v_patient_demographics

GROUP BY
    discharge_year,
    race

ORDER BY total_charges DESC;



/*
====================================================
Question 4

Which ethnic groups have the longest
average length of stay?

Business Value:
Highlights differences in hospital
utilization across ethnic groups.
====================================================
*/

SELECT
    ethnicity,

    ROUND(
        AVG(avg_los),
        2
    ) AS avg_length_of_stay

FROM analytics.v_patient_demographics

GROUP BY ethnicity

ORDER BY avg_length_of_stay DESC;



/*
====================================================
Question 5

Which age groups have above-average
hospital costs?

Business Value:
Identifies patient populations with
higher-than-average treatment costs.
====================================================
*/

SELECT
    discharge_year,
    age_group,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_patient_demographics

GROUP BY
    discharge_year,
    age_group

HAVING
    SUM(total_costs) >
    (
        SELECT AVG(total_costs)
        FROM analytics.v_patient_demographics
    )

ORDER BY total_costs DESC;



/*
====================================================
Question 6

How do age groups rank by hospital
admissions each year?

Business Value:
Ranks patient demographics by annual
hospital utilization.
====================================================
*/

SELECT
    discharge_year,
    age_group,
    admissions,

    RANK() OVER
    (
        PARTITION BY discharge_year
        ORDER BY admissions DESC
    ) AS admission_rank

FROM analytics.v_patient_demographics

ORDER BY
    discharge_year,
    admission_rank;



/*
====================================================
Question 7

Which demographic groups belong to the
highest healthcare cost quartile?

Business Value:
Segments patient groups according to
overall healthcare spending.
====================================================
*/

SELECT
    discharge_year,
    age_group,
    gender,

    ROUND(total_costs,2) AS total_costs,

    NTILE(4) OVER
    (
        PARTITION BY discharge_year
        ORDER BY total_costs DESC
    ) AS cost_quartile

FROM analytics.v_patient_demographics

ORDER BY
    discharge_year,
    cost_quartile,
    total_costs DESC;