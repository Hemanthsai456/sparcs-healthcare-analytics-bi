/*
====================================================
CLINICAL ANALYTICS
====================================================

Domain:
Clinical Performance Analysis

Purpose:
Analyze diagnoses, severity of illness,
mortality risk, resource utilization,
and clinical performance.

Data Source:
analytics.v_clinical_analysis
====================================================
*/


/*
====================================================
Question 1

Which diagnosis groups account for the
highest number of hospital admissions?

Business Value:
Identifies the most frequently treated
clinical conditions.
====================================================
*/

SELECT
    discharge_year,
    apr_drg_description,
    admissions

FROM analytics.v_clinical_analysis

ORDER BY
    admissions DESC,
    apr_drg_description;



/*
====================================================
Question 2

Which diagnosis groups generate the
highest treatment costs?

Business Value:
Identifies diagnoses that consume the
largest share of healthcare resources.
====================================================
*/

SELECT
    discharge_year,
    apr_drg_description,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_clinical_analysis

GROUP BY
    discharge_year,
    apr_drg_description

ORDER BY total_costs DESC;



/*
====================================================
Question 3

Which severity levels have the longest
average length of stay?

Business Value:
Evaluates the relationship between
clinical severity and hospital utilization.
====================================================
*/

SELECT
    apr_severity_of_illness_description,

    ROUND(
        AVG(avg_los),
        2
    ) AS avg_length_of_stay

FROM analytics.v_clinical_analysis

GROUP BY
    apr_severity_of_illness_description

ORDER BY avg_length_of_stay DESC;



/*
====================================================
Question 4

Which mortality risk categories incur
the highest healthcare costs?

Business Value:
Measures the financial impact of
different mortality risk levels.
====================================================
*/

SELECT
    apr_risk_of_mortality,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_clinical_analysis

GROUP BY
    apr_risk_of_mortality

ORDER BY total_costs DESC;



/*
====================================================
Question 5

Which diagnosis groups have above-average
charge-to-cost efficiency?

Business Value:
Identifies clinical services generating
higher financial returns than average.
====================================================
*/

SELECT
    apr_drg_description,

    ROUND(
        SUM(total_charges) /
        NULLIF(SUM(total_costs),0),
        2
    ) AS charge_cost_ratio

FROM analytics.v_clinical_analysis

GROUP BY
    apr_drg_description

HAVING
    SUM(total_charges) /
    NULLIF(SUM(total_costs),0)
    >
    (
        SELECT
            SUM(total_charges) /
            NULLIF(SUM(total_costs),0)
        FROM analytics.v_clinical_analysis
    )

ORDER BY charge_cost_ratio DESC;



/*
====================================================
Question 6

How do diagnosis groups rank by total
hospital admissions each year?

Business Value:
Ranks diagnoses according to annual
patient demand.
====================================================
*/

SELECT
    discharge_year,
    apr_drg_description,
    admissions,

    RANK() OVER
    (
        PARTITION BY discharge_year
        ORDER BY admissions DESC
    ) AS admission_rank

FROM analytics.v_clinical_analysis

ORDER BY
    discharge_year,
    admission_rank;



/*
====================================================
Question 7

Which diagnosis groups belong to the
highest treatment cost quartile?

Business Value:
Segments diagnoses according to
resource consumption for benchmarking
and financial planning.
====================================================
*/

SELECT
    discharge_year,
    apr_drg_description,

    ROUND(total_costs,2) AS total_costs,

    NTILE(4) OVER
    (
        PARTITION BY discharge_year
        ORDER BY total_costs DESC
    ) AS cost_quartile

FROM analytics.v_clinical_analysis

ORDER BY
    discharge_year,
    cost_quartile,
    total_costs DESC;