/*
====================================================
CLINICAL ANALYTICS
====================================================

Domain:
Clinical Performance Analysis

Purpose:
Analyze diagnosis volume, severity,
mortality, LOS, costs, and charges.

Data Source:
analytics.v_clinical_analysis
analytics.v_clinical_detail

====================================================
*/


/*
====================================================
Question 1

What are the most common diagnoses?

Business Value:
Identifies the largest drivers of hospital volume.
====================================================
*/

SELECT
    ccsr_diagnosis_description,
    SUM(admissions) AS admissions
FROM analytics.v_clinical_analysis
GROUP BY ccsr_diagnosis_description
ORDER BY admissions DESC
LIMIT 10;



/*
====================================================
Question 2

Which diagnoses generate the highest total charges?

Business Value:
Identifies diagnoses driving healthcare spending.
====================================================
*/

SELECT
    ccsr_diagnosis_description,
    SUM(total_charges) AS total_charges
FROM analytics.v_clinical_analysis
GROUP BY ccsr_diagnosis_description
ORDER BY total_charges DESC
LIMIT 10;



/*
====================================================
Question 3

Which diagnoses generate the highest total costs?

Business Value:
Identifies the most resource-intensive conditions.
====================================================
*/

SELECT
    ccsr_diagnosis_description,
    SUM(total_costs) AS total_costs
FROM analytics.v_clinical_analysis
GROUP BY ccsr_diagnosis_description
ORDER BY total_costs DESC
LIMIT 10;



/*
====================================================
Question 4

Which diagnoses have the longest average
length of stay?

Business Value:
Highlights conditions requiring prolonged care.
====================================================
*/

SELECT
    ccsr_diagnosis_description,
    ROUND(AVG(avg_los),2) AS avg_los
FROM analytics.v_clinical_analysis
GROUP BY ccsr_diagnosis_description
ORDER BY avg_los DESC
LIMIT 10;



/*
====================================================
Question 5

Which diagnoses have the highest percentage
of extreme mortality cases?

Business Value:
Identifies the most life-threatening conditions.
====================================================
*/

SELECT
    ccsr_diagnosis_description,

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

GROUP BY ccsr_diagnosis_description

ORDER BY extreme_mortality_percent DESC
LIMIT 10;



/*
====================================================
Question 6

Which diagnoses have the highest percentage
of extreme severity cases?

Business Value:
Identifies clinically complex conditions.
====================================================
*/

SELECT
    ccsr_diagnosis_description,

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

GROUP BY ccsr_diagnosis_description

ORDER BY extreme_severity_percent DESC
LIMIT 10;



/*
====================================================
Question 7

What are the most common diagnoses
among elderly patients?

Business Value:
Helps understand disease burden
in older populations.
====================================================
*/

SELECT
    ccsr_diagnosis_description,
    COUNT(*) AS admissions

FROM analytics.v_clinical_detail

WHERE age_group = '70 or Older'

GROUP BY ccsr_diagnosis_description

ORDER BY admissions DESC
LIMIT 10;



/*
====================================================
Question 8

What are the most common diagnoses
among pediatric patients?

Business Value:
Supports child healthcare planning.
====================================================
*/

SELECT
    ccsr_diagnosis_description,
    COUNT(*) AS admissions

FROM analytics.v_clinical_detail

WHERE age_group = '0 to 17'

GROUP BY ccsr_diagnosis_description

ORDER BY admissions DESC
LIMIT 10;



/*
====================================================
Question 9

Which diagnoses have the highest
average charge per admission?

Business Value:
Measures financial intensity per case.
====================================================
*/

SELECT
    ccsr_diagnosis_description,

    ROUND(
        SUM(total_charges) /
        NULLIF(SUM(admissions),0),
        2
    ) AS avg_charge_per_admission

FROM analytics.v_clinical_analysis

GROUP BY ccsr_diagnosis_description

ORDER BY avg_charge_per_admission DESC
LIMIT 10;



/*
====================================================
Question 10

Which diagnoses have the highest
average cost per admission?

Business Value:
Measures resource utilization per case.
====================================================
*/

SELECT
    ccsr_diagnosis_description,

    ROUND(
        SUM(total_costs) /
        NULLIF(SUM(admissions),0),
        2
    ) AS avg_cost_per_admission

FROM analytics.v_clinical_analysis

GROUP BY ccsr_diagnosis_description

ORDER BY avg_cost_per_admission DESC
LIMIT 10;