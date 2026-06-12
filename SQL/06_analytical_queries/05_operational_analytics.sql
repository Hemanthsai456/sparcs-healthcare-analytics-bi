/*
====================================================
OPERATIONAL ANALYTICS
====================================================

Domain:
Hospital Operations Analysis

Purpose:
Analyze admission patterns,
patient flow,
LOS,
emergency utilization,
and discharge outcomes.

Data Source:
analytics.v_operations

====================================================
*/


/*
====================================================
Question 1

What is the distribution of admission types?

Business Value:
Shows how hospitals receive patients
(Emergency, Elective, Urgent, etc.).
====================================================
*/

SELECT
    type_of_admission,
    SUM(admissions) AS admissions
FROM analytics.v_operations
GROUP BY type_of_admission
ORDER BY admissions DESC;



/*
====================================================
Question 2

What is the Emergency vs Non-Emergency
admission distribution?

Business Value:
Measures dependency on emergency services.
====================================================
*/

SELECT
    emergency_department_indicator,
    SUM(admissions) AS admissions
FROM analytics.v_operations
GROUP BY emergency_department_indicator
ORDER BY admissions DESC;



/*
====================================================
Question 3

Which admission types have the longest
average length of stay?

Business Value:
Identifies admission categories requiring
extended hospital resources.
====================================================
*/

SELECT
    type_of_admission,
    ROUND(AVG(avg_los),2) AS avg_los
FROM analytics.v_operations
GROUP BY type_of_admission
ORDER BY avg_los DESC;



/*
====================================================
Question 4

Which admission types generate the highest
total charges?

Business Value:
Identifies operational areas driving revenue.
====================================================
*/

SELECT
    type_of_admission,
    SUM(total_charges) AS total_charges
FROM analytics.v_operations
GROUP BY type_of_admission
ORDER BY total_charges DESC;



/*
====================================================
Question 5

Which admission types generate the highest
total costs?

Business Value:
Identifies operational areas consuming
the most resources.
====================================================
*/

SELECT
    type_of_admission,
    SUM(total_costs) AS total_costs
FROM analytics.v_operations
GROUP BY type_of_admission
ORDER BY total_costs DESC;



/*
====================================================
Question 6

What are the most common discharge dispositions?

Business Value:
Helps understand patient outcomes and
post-discharge care patterns.
====================================================
*/

SELECT
    patient_disposition,
    SUM(admissions) AS admissions
FROM analytics.v_operations
GROUP BY patient_disposition
ORDER BY admissions DESC
LIMIT 10;



/*
====================================================
Question 7

Which discharge dispositions have the
longest average LOS?

Business Value:
Identifies patient outcomes associated
with prolonged hospital stays.
====================================================
*/

SELECT
    patient_disposition,
    ROUND(AVG(avg_los),2) AS avg_los
FROM analytics.v_operations
GROUP BY patient_disposition
ORDER BY avg_los DESC
LIMIT 10;



/*
====================================================
Question 8

What percentage of admissions result in
each discharge disposition?

Business Value:
Provides insight into patient outcomes and
post-discharge care requirements.
====================================================
*/

SELECT
    patient_disposition,

    ROUND(
        100.0 * SUM(admissions) /
        SUM(SUM(admissions)) OVER (),
        2
    ) AS disposition_percentage

FROM analytics.v_operations

GROUP BY patient_disposition

ORDER BY disposition_percentage DESC;



/*
====================================================
Question 9

Which admission types have the highest
average charge per admission?

Business Value:
Measures revenue intensity by admission type.
====================================================
*/

SELECT
    type_of_admission,

    ROUND(
        SUM(total_charges) /
        NULLIF(SUM(admissions),0),
        2
    ) AS avg_charge_per_admission

FROM analytics.v_operations

GROUP BY type_of_admission

ORDER BY avg_charge_per_admission DESC;



/*
====================================================
Question 10

Which admission types have the highest
average cost per admission?

Business Value:
Measures resource utilization intensity
by admission type.
====================================================
*/

SELECT
    type_of_admission,

    ROUND(
        SUM(total_costs) /
        NULLIF(SUM(admissions),0),
        2
    ) AS avg_cost_per_admission

FROM analytics.v_operations

GROUP BY type_of_admission

ORDER BY avg_cost_per_admission DESC;