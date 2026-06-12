/*
====================================================
GEOGRAPHIC ANALYTICS
====================================================

Domain:
Regional Healthcare Analysis

Purpose:
Analyze admissions,
charges,
costs,
LOS,
severity,
and mortality across regions.

Data Source:
analytics.v_geographic_analysis
analytics.v_hospital_clinical

====================================================
*/


/*
====================================================
Question 1

Which Health Service Areas have the highest
number of admissions?

Business Value:
Identifies regions with the highest demand
for healthcare services.
====================================================
*/

SELECT
    health_service_area,
    SUM(admissions) AS admissions
FROM analytics.v_geographic_analysis
GROUP BY health_service_area
ORDER BY admissions DESC;



/*
====================================================
Question 2

Which Health Service Areas generate the
highest total charges?

Business Value:
Identifies regions driving healthcare revenue.
====================================================
*/

SELECT
    health_service_area,
    SUM(total_charges) AS total_charges
FROM analytics.v_geographic_analysis
GROUP BY health_service_area
ORDER BY total_charges DESC;



/*
====================================================
Question 3

Which Health Service Areas generate the
highest total costs?

Business Value:
Identifies regions consuming the most
healthcare resources.
====================================================
*/

SELECT
    health_service_area,
    SUM(total_costs) AS total_costs
FROM analytics.v_geographic_analysis
GROUP BY health_service_area
ORDER BY total_costs DESC;



/*
====================================================
Question 4

Which Health Service Areas have the longest
average length of stay?

Business Value:
Highlights regions with more complex
or resource-intensive patient care.
====================================================
*/

SELECT
    health_service_area,
    ROUND(AVG(avg_los),2) AS avg_los
FROM analytics.v_geographic_analysis
GROUP BY health_service_area
ORDER BY avg_los DESC;



/*
====================================================
Question 5

Which counties have the highest number
of admissions?

Business Value:
Provides a detailed geographic view of
patient demand.
====================================================
*/

SELECT
    hospital_county,
    SUM(admissions) AS admissions
FROM analytics.v_geographic_analysis
GROUP BY hospital_county
ORDER BY admissions DESC
LIMIT 10;



/*
====================================================
Question 6

Which counties generate the highest
    total charges?

    Business Value:
    Identifies counties driving healthcare revenue.
    ====================================================
    */

    SELECT
        hospital_county,
        SUM(total_charges) AS total_charges
    FROM analytics.v_geographic_analysis
    GROUP BY hospital_county
    ORDER BY total_charges DESC
    LIMIT 10;



    /*
    ====================================================
    Question 7

    Which counties generate the highest
    total costs?

    Business Value:
    Identifies counties consuming the most
    healthcare resources.
    ====================================================
    */

    SELECT
        hospital_county,
        SUM(total_costs) AS total_costs
    FROM analytics.v_geographic_analysis
    GROUP BY hospital_county
    ORDER BY total_costs DESC
    LIMIT 10;

/*
====================================================
Question 8

Which counties have the highest average
cost per admission?

Business Value:
Identifies counties with the most
resource-intensive patient care.
====================================================
*/

SELECT
    hospital_county,

    ROUND(
        SUM(total_costs) /
        NULLIF(SUM(admissions),0),
        2
    ) AS avg_cost_per_admission

FROM analytics.v_geographic_analysis

GROUP BY hospital_county

ORDER BY avg_cost_per_admission DESC
LIMIT 10;

/*
====================================================
Question 9

Which counties have the highest average
charge per admission?

Business Value:
Identifies counties generating the highest
revenue per patient admission.
====================================================
*/

SELECT
    hospital_county,

    ROUND(
        SUM(total_charges) /
        NULLIF(SUM(admissions),0),
        2
    ) AS avg_charges_per_admission

FROM analytics.v_geographic_analysis

GROUP BY hospital_county

ORDER BY avg_charges_per_admission DESC
LIMIT 10;

/*
====================================================
Question 10

Which counties have the longest average
length of stay?

Business Value:
Highlights counties with potentially
more complex patient populations.
====================================================
*/

SELECT
    hospital_county,
    ROUND(AVG(avg_los),2) AS avg_los
FROM analytics.v_geographic_analysis
GROUP BY hospital_county
ORDER BY avg_los DESC
LIMIT 10;



/*
====================================================
Question 11

Which Health Service Areas have the highest
percentage of extreme severity cases?

Business Value:
Identifies regions managing the most
clinically complex patients.
====================================================
*/

SELECT
    health_service_area,

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

GROUP BY health_service_area

ORDER BY extreme_severity_percent DESC;



/*
====================================================
Question 12

Which Health Service Areas have the highest
percentage of extreme mortality-risk cases?

Business Value:
Identifies regions treating the most
critical patient populations.
====================================================
*/

SELECT
    health_service_area,

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

GROUP BY health_service_area

ORDER BY extreme_mortality_percent DESC;