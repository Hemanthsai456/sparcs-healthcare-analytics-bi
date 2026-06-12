/*
====================================================
RISK ANALYTICS
====================================================

Domain:
Severity & Mortality Risk Analysis

Purpose:
Analyze severity levels,
mortality risk,
resource utilization,
and patient complexity.

Data Source:
analytics.v_risk_analysis

====================================================
*/


/*
====================================================
Question 1

What is the distribution of severity categories?

Business Value:
Provides an overview of patient complexity
across all admissions.
====================================================
*/

SELECT
    apr_severity_of_illness_description,
    SUM(admissions) AS admissions
FROM analytics.v_risk_analysis
GROUP BY apr_severity_of_illness_description
ORDER BY admissions DESC;



/*
====================================================
Question 2

What is the distribution of mortality-risk categories?

Business Value:
Provides an overview of mortality risk
across all admissions.
====================================================
*/

SELECT
    apr_risk_of_mortality,
    SUM(admissions) AS admissions
FROM analytics.v_risk_analysis
GROUP BY apr_risk_of_mortality
ORDER BY admissions DESC;


/*
====================================================
Question 3

Which severity categories generate the
highest total costs?

Business Value:
Identifies which patient complexity levels
consume the most healthcare resources.
====================================================
*/

SELECT
    apr_severity_of_illness_description,
    SUM(total_costs) AS total_costs
FROM analytics.v_risk_analysis
GROUP BY apr_severity_of_illness_description
ORDER BY total_costs DESC;



/*
====================================================
Question 4

Which severity categories generate the
highest total charges?

Business Value:
Measures revenue contribution by severity level.
====================================================
*/

SELECT
    apr_severity_of_illness_description,
    SUM(total_charges) AS total_charges
FROM analytics.v_risk_analysis
GROUP BY apr_severity_of_illness_description
ORDER BY total_charges DESC;



/*
====================================================
Question 5

Which severity categories have the
longest average length of stay?

Business Value:
Identifies severity levels associated with
extended hospitalization.
====================================================
*/

SELECT
    apr_severity_of_illness_description,
    ROUND(AVG(avg_los),2) AS avg_los
FROM analytics.v_risk_analysis
GROUP BY apr_severity_of_illness_description
ORDER BY avg_los DESC;



/*
====================================================
Question 6

Which mortality-risk categories generate
the highest total costs?

Business Value:
Measures resource utilization by mortality risk.
====================================================
*/

SELECT
    apr_risk_of_mortality,
    SUM(total_costs) AS total_costs
FROM analytics.v_risk_analysis
GROUP BY apr_risk_of_mortality
ORDER BY total_costs DESC;



/*
====================================================
Question 7

Which mortality-risk categories generate
the highest total charges?

Business Value:
Measures revenue contribution by mortality risk.
====================================================
*/

SELECT
    apr_risk_of_mortality,
    SUM(total_charges) AS total_charges
FROM analytics.v_risk_analysis
GROUP BY apr_risk_of_mortality
ORDER BY total_charges DESC;



/*
====================================================
Question 8

Which mortality-risk categories have the
longest average length of stay?

Business Value:
Identifies mortality-risk groups associated
with prolonged hospitalization.
====================================================
*/

SELECT
    apr_risk_of_mortality,
    ROUND(AVG(avg_los),2) AS avg_los
FROM analytics.v_risk_analysis
GROUP BY apr_risk_of_mortality
ORDER BY avg_los DESC;



/*
====================================================
Question 9

What percentage of admissions are classified
as Extreme Severity?

Business Value:
Measures prevalence of highly complex cases.
====================================================
*/

SELECT
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN apr_severity_of_illness_description = 'Extreme'
                THEN admissions
                ELSE 0
            END
        )
        /
        SUM(admissions),
        2
    ) AS extreme_severity_percent
FROM analytics.v_risk_analysis;



/*
====================================================
Question 10

What percentage of admissions are classified
as Extreme Mortality Risk?

Business Value:
Measures prevalence of critically high-risk patients.
====================================================
*/

SELECT
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN apr_risk_of_mortality = 'Extreme'
                THEN admissions
                ELSE 0
            END
        )
        /
        SUM(admissions),
        2
    ) AS extreme_mortality_percent
FROM analytics.v_risk_analysis;