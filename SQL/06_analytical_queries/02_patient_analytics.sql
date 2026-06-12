/*
====================================================
PATIENT ANALYTICS
====================================================

Domain:
Patient Demographics Analysis

Purpose:
Analyze admissions, costs, charges,
LOS, and demographic trends.

Data Source:
analytics.v_patient_demographics
analytics.v_clinical_detail

====================================================
*/


/*
====================================================
Question 1

Which age groups account for the highest number
of admissions?

Business Value:
Identifies the primary patient populations served.
====================================================
*/

SELECT
    age_group,
    SUM(admissions) AS admissions
FROM analytics.v_patient_demographics
GROUP BY age_group
ORDER BY admissions DESC;



/*
====================================================
Question 2

How are admissions distributed across gender?

Business Value:
Helps understand gender-based utilization patterns.
====================================================
*/

SELECT
    gender,
    SUM(admissions) AS admissions
FROM analytics.v_patient_demographics
GROUP BY gender
ORDER BY admissions DESC;



/*
====================================================
Question 3

How are admissions distributed across race groups?

Business Value:
Supports population health analysis.
====================================================
*/

SELECT
    race,
    SUM(admissions) AS admissions
FROM analytics.v_patient_demographics
GROUP BY race
ORDER BY admissions DESC;



/*
====================================================
Question 4

How are admissions distributed across ethnicities?

Business Value:
Provides insight into patient demographics.
====================================================
*/

SELECT
    ethnicity,
    SUM(admissions) AS admissions
FROM analytics.v_patient_demographics
GROUP BY ethnicity
ORDER BY admissions DESC;



/*
====================================================
Question 5

Which age groups generate the highest total charges?

Business Value:
Identifies the most revenue-generating patient groups.
====================================================
*/

SELECT
    age_group,
    SUM(total_charges) AS total_charges
FROM analytics.v_patient_demographics
GROUP BY age_group
ORDER BY total_charges DESC;



/*
====================================================
Question 6

Which age groups generate the highest total costs?

Business Value:
Identifies the most resource-intensive groups.
====================================================
*/

SELECT
    age_group,
    SUM(total_costs) AS total_costs
FROM analytics.v_patient_demographics
GROUP BY age_group
ORDER BY total_costs DESC;



/*
====================================================
Question 7

Which age groups have the longest average
length of stay?

Business Value:
Helps identify populations requiring
extended care.
====================================================
*/

SELECT
    age_group,
    AVG(avg_los) AS avg_los
FROM analytics.v_patient_demographics
GROUP BY age_group
ORDER BY avg_los DESC;



/*
====================================================
Question 8

Which demographic combinations generate
the highest costs?

Business Value:
Identifies high-cost patient segments.
====================================================
*/

SELECT
    age_group,
    gender,
    race,
    ethnicity,
    total_costs
FROM analytics.v_patient_demographics
ORDER BY total_costs DESC
LIMIT 10;



/*
====================================================
Question 9

Which age groups experience the highest
percentage of extreme mortality risk?

Business Value:
Identifies vulnerable patient populations.
====================================================
*/

SELECT
    age_group,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN apr_risk_of_mortality = 'Extreme'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS extreme_mortality_percent

FROM analytics.v_clinical_detail

GROUP BY age_group

ORDER BY extreme_mortality_percent DESC;



/*
====================================================
Question 10

Which age groups experience the highest
percentage of extreme severity cases?

Business Value:
Identifies clinically complex populations.
====================================================
*/

SELECT
    age_group,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN apr_severity_of_illness_description = 'Extreme'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS extreme_severity_percent

FROM analytics.v_clinical_detail

GROUP BY age_group

ORDER BY extreme_severity_percent DESC;