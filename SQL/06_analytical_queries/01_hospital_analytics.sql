/*
====================================================
HOSPITAL ANALYTICS
====================================================

Domain:
Hospital Performance Analysis

Purpose:
Analyze hospital admissions, costs, charges,
efficiency, severity, and mortality trends.

Data Source:
analytics.v_hospital_performance
analytics.v_hospital_clinical

====================================================
*/


/*
====================================================
Question 1

Which hospitals handle the highest number of admissions?

Business Value:
Identifies the busiest hospitals and helps evaluate
capacity utilization.
====================================================
*/

SELECT
    facility_name,
    admissions
FROM analytics.v_hospital_performance
ORDER BY admissions DESC
LIMIT 10;



/*
====================================================
Question 2

Which hospitals generate the highest total charges?

Business Value:
Identifies hospitals producing the largest revenue.
====================================================
*/

SELECT
    facility_name,
    total_charges
FROM analytics.v_hospital_performance
ORDER BY total_charges DESC
LIMIT 10;



/*
====================================================
Question 3

Which hospitals generate the highest total costs?

Business Value:
Highlights hospitals consuming the largest resources.
====================================================
*/

SELECT
    facility_name,
    total_costs
FROM analytics.v_hospital_performance
ORDER BY total_costs DESC
LIMIT 10;



/*
====================================================
Question 4

Which hospitals have the highest emergency admission rates?

Business Value:
Measures dependence on emergency services.
====================================================
*/

SELECT
    facility_name,
    emergency_rate_percent
FROM analytics.v_hospital_performance
ORDER BY emergency_rate_percent DESC
LIMIT 10;



/*
====================================================
Question 5

Which hospitals have the longest average length of stay?

Business Value:
Helps identify potential operational inefficiencies
or highly complex patient populations.
====================================================
*/

SELECT
    facility_name,
    avg_los
FROM analytics.v_hospital_performance
ORDER BY avg_los DESC
LIMIT 10;



/*
====================================================
Question 6

Which hospitals have the highest charge-to-cost ratio?

Business Value:
Measures financial efficiency and profitability.
====================================================
*/

SELECT
    facility_name,
    charge_cost_ratio
FROM analytics.v_hospital_performance
ORDER BY charge_cost_ratio DESC
LIMIT 10;



/*
====================================================
Question 7

Which hospitals treat the highest percentage
of extreme severity cases?

Business Value:
Identifies hospitals managing highly complex patients.
====================================================
*/

SELECT
    facility_name,

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

FROM analytics.v_hospital_clinical

GROUP BY facility_name

ORDER BY extreme_severity_percent DESC
LIMIT 10;



/*
====================================================
Question 8

Which hospitals treat the highest percentage
of extreme mortality-risk cases?

Business Value:
Identifies hospitals handling the most critical cases.
====================================================
*/

SELECT
    facility_name,

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

FROM analytics.v_hospital_clinical

GROUP BY facility_name

ORDER BY extreme_mortality_percent DESC
LIMIT 10;



/*
====================================================
Question 9

Which hospitals have the highest average charge
per admission?

Business Value:
Measures revenue intensity per patient.
====================================================
*/

SELECT
    facility_name,

    ROUND(
        total_charges / admissions,
        2
    ) AS avg_charge_per_admission

FROM analytics.v_hospital_performance

ORDER BY avg_charge_per_admission DESC
LIMIT 10;



/*
====================================================
Question 10

Which hospitals have the highest average cost
per admission?

Business Value:
Measures resource utilization intensity.
====================================================
*/

SELECT
    facility_name,

    ROUND(
        total_costs / admissions,
        2
    ) AS avg_cost_per_admission

FROM analytics.v_hospital_performance

ORDER BY avg_cost_per_admission DESC
LIMIT 10;