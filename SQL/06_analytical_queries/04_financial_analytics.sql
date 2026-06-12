/*
====================================================
FINANCIAL ANALYTICS
====================================================

Domain:
Healthcare Financial Performance Analysis

Purpose:
Analyze payer mix, charges, costs,
resource utilization, and financial efficiency.

Data Source:
analytics.v_financial_summary
analytics.v_financial_detail

====================================================
*/


/*
====================================================
Question 1

Which payer categories generate the highest
total charges?

Business Value:
Identifies the largest revenue-generating
payer categories.
====================================================
*/

SELECT
    payment_typology_1,
    total_charges
FROM analytics.v_financial_summary
ORDER BY total_charges DESC;



/*
====================================================
Question 2

Which payer categories generate the highest
total costs?

Business Value:
Identifies payer categories consuming
the most healthcare resources.
====================================================
*/

SELECT
    payment_typology_1,
    total_costs
FROM analytics.v_financial_summary
ORDER BY total_costs DESC;



/*
====================================================
Question 3

Which payer categories have the highest
average charge per admission?

Business Value:
Measures financial intensity of patients
covered by each payer category.
====================================================
*/

SELECT
    payment_typology_1,
    avg_charge
FROM analytics.v_financial_summary
ORDER BY avg_charge DESC;



/*
====================================================
Question 4

Which payer categories have the highest
average cost per admission?

Business Value:
Identifies payer categories associated
with expensive patient care.
====================================================
*/

SELECT
    payment_typology_1,
    avg_cost
FROM analytics.v_financial_summary
ORDER BY avg_cost DESC;



/*
====================================================
Question 5

Which payer categories have the highest
charge-to-cost ratio?

Business Value:
Measures financial efficiency across
payer categories.
====================================================
*/

SELECT
    payment_typology_1,
    charge_cost_ratio
FROM analytics.v_financial_summary
ORDER BY charge_cost_ratio DESC;



/*
====================================================
Question 6

Which payer categories generate the highest total profit proxy
(Charges - Costs)?

Business Value:
Identifies payer categories associated with the largest financial surplus.
====================================================
*/

SELECT
    payment_typology_1,

    ROUND(
        SUM(total_charges) - SUM(total_costs),
        2
    ) AS financial_surplus

FROM analytics.v_financial_detail

GROUP BY payment_typology_1

ORDER BY financial_surplus DESC;



/*
====================================================
Question 7

Which payer categories have the longest
average length of stay?

Business Value:
Identifies payer categories associated
with prolonged patient care.
====================================================
*/

SELECT
    payment_typology_1,

    ROUND(
        AVG(length_of_stay_days),
        2
    ) AS avg_los

FROM analytics.v_financial_detail

GROUP BY payment_typology_1

ORDER BY avg_los DESC;



/*
====================================================
Question 8

Which age groups generate the highest
Medicare costs?

Business Value:
Evaluates cost burden of Medicare
across patient age groups.
====================================================
*/

SELECT
    age_group,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_financial_detail

WHERE payment_typology_1 = 'Medicare'

GROUP BY age_group

ORDER BY total_costs DESC;



/*
====================================================
Question 9

Which regions generate the highest
Medicaid costs?

Business Value:
Identifies geographic concentration
of Medicaid spending.
====================================================
*/

SELECT
    health_service_area,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_financial_detail

WHERE payment_typology_1 = 'Medicaid'

GROUP BY health_service_area

ORDER BY total_costs DESC;



/*
====================================================
Question 10

Which payer categories have the highest
average cost per admission?

Business Value:
Measures resource utilization intensity
across payer categories.
====================================================
*/

SELECT
    payment_typology_1,

    ROUND(
        SUM(total_costs) /
        NULLIF(COUNT(*),0),
        2
    ) AS avg_cost_per_admission

FROM analytics.v_financial_detail

GROUP BY payment_typology_1

ORDER BY avg_cost_per_admission DESC;