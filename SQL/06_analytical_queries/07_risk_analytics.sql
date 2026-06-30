/*
====================================================
RISK ANALYTICS
====================================================

Domain:
Clinical Risk Analysis

Purpose:
Analyze severity of illness, mortality
risk, healthcare utilization, and
financial impact across patient risk groups.

Data Source:
analytics.v_risk_analysis
====================================================
*/


/*
====================================================
Question 1

Which severity levels account for the
highest number of hospital admissions?

Business Value:
Identifies patient groups requiring the
greatest volume of hospital care.
====================================================
*/

SELECT
    discharge_year,
    apr_severity_of_illness_description,
    admissions

FROM analytics.v_risk_analysis

ORDER BY admissions DESC;



/*
====================================================
Question 2

Which mortality risk categories generate
the highest treatment charges?

Business Value:
Evaluates the financial impact of
different mortality risk groups.
====================================================
*/

SELECT
    discharge_year,
    apr_risk_of_mortality,
    total_charges

FROM analytics.v_risk_analysis

ORDER BY total_charges DESC;



/*
====================================================
Question 3

Which severity levels incur the
highest treatment costs?

Business Value:
Identifies patient groups consuming
the greatest healthcare resources.
====================================================
*/

SELECT
    discharge_year,
    apr_severity_of_illness_description,
    total_costs

FROM analytics.v_risk_analysis

ORDER BY total_costs DESC;



/*
====================================================
Question 4

Which mortality risk categories have
the longest average length of stay?

Business Value:
Measures hospital resource utilization
across mortality risk groups.
====================================================
*/

SELECT
    apr_risk_of_mortality,

    ROUND(
        AVG(avg_los),
        2
    ) AS avg_length_of_stay

FROM analytics.v_risk_analysis

GROUP BY apr_risk_of_mortality

ORDER BY avg_length_of_stay DESC;



/*
====================================================
Question 5

Which severity levels have an
above-average length of stay?

Business Value:
Identifies high-risk patient groups
requiring longer hospitalization than
the overall average.
====================================================
*/

SELECT
    apr_severity_of_illness_description,

    ROUND(
        AVG(avg_los),
        2
    ) AS avg_length_of_stay

FROM analytics.v_risk_analysis

GROUP BY apr_severity_of_illness_description

HAVING
    AVG(avg_los) >
(
    SELECT AVG(avg_los)
    FROM analytics.v_risk_analysis
)

ORDER BY avg_length_of_stay DESC;



/*
====================================================
Question 6

How do severity levels rank by
hospital admissions each year?

Business Value:
Ranks patient severity groups according
to annual healthcare demand.
====================================================
*/

SELECT
    discharge_year,
    apr_severity_of_illness_description,
    admissions,

    RANK() OVER
    (
        PARTITION BY discharge_year
        ORDER BY admissions DESC
    ) AS admission_rank

FROM analytics.v_risk_analysis

ORDER BY
    discharge_year,
    admission_rank;



/*
====================================================
Question 7

How are mortality risk categories
segmented based on treatment costs?

Business Value:
Groups mortality risk categories into
cost tiers for financial planning and
resource allocation.
====================================================
*/

SELECT
    apr_risk_of_mortality,
    total_costs,

    NTILE(4) OVER
    (
        ORDER BY total_costs DESC
    ) AS cost_quartile

FROM analytics.v_risk_analysis

ORDER BY
    cost_quartile,
    total_costs DESC;