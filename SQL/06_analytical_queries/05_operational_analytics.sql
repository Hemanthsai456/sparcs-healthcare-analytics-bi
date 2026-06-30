/*
====================================================
OPERATIONAL ANALYTICS
====================================================

Domain:
Hospital Operations Analysis

Purpose:
Analyze admission patterns, patient
disposition, resource utilization, and
operational efficiency.

Data Source:
analytics.v_operations
====================================================
*/


/*
====================================================
Question 1

Which admission types account for the
highest number of hospital admissions?

Business Value:
Identifies the primary sources of
hospital demand.
====================================================
*/

SELECT
    discharge_year,
    type_of_admission,
    admissions

FROM analytics.v_operations

ORDER BY admissions DESC;



/*
====================================================
Question 2

Which admission types have the longest
average length of stay?

Business Value:
Highlights admission categories requiring
extended hospital resources.
====================================================
*/

SELECT
    type_of_admission,

    ROUND(
        AVG(avg_los),
        2
    ) AS avg_length_of_stay

FROM analytics.v_operations

GROUP BY type_of_admission

ORDER BY avg_length_of_stay DESC;



/*
====================================================
Question 3

Which patient dispositions generate the
highest treatment costs?

Business Value:
Identifies discharge outcomes associated
with the greatest healthcare expenditure.
====================================================
*/

SELECT
    patient_disposition,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_operations

GROUP BY patient_disposition

ORDER BY total_costs DESC;



/*
====================================================
Question 4

Which admission types generate the
highest treatment charges?

Business Value:
Measures the financial contribution of
different admission categories.
====================================================
*/

SELECT
    type_of_admission,

    ROUND(
        SUM(total_charges),
        2
    ) AS total_charges

FROM analytics.v_operations

GROUP BY type_of_admission

ORDER BY total_charges DESC;



/*
====================================================
Question 5

Which admission types have above-average
length of stay?

Business Value:
Identifies operational areas where
patients remain hospitalized longer
than average.
====================================================
*/

SELECT
    type_of_admission,

    ROUND(
        AVG(avg_los),
        2
    ) AS avg_length_of_stay

FROM analytics.v_operations

GROUP BY type_of_admission

HAVING AVG(avg_los) >
(
    SELECT AVG(avg_los)
    FROM analytics.v_operations
)

ORDER BY avg_length_of_stay DESC;



/*
====================================================
Question 6

How do admission types rank by patient
volume each year?

Business Value:
Ranks admission categories according to
annual hospital demand.
====================================================
*/

SELECT
    discharge_year,
    type_of_admission,
    admissions,

    RANK() OVER
    (
        PARTITION BY discharge_year
        ORDER BY admissions DESC
    ) AS admission_rank

FROM analytics.v_operations

ORDER BY
    discharge_year,
    admission_rank;



/*
====================================================
Question 7

Which patient disposition groups belong
to the highest treatment cost quartile?

Business Value:
Segments discharge outcomes according
to healthcare resource consumption.
====================================================
*/

SELECT
    patient_disposition,
    total_costs,

    NTILE(4) OVER
    (
        ORDER BY total_costs DESC
    ) AS cost_quartile

FROM analytics.v_operations

ORDER BY
    cost_quartile,
    total_costs DESC;