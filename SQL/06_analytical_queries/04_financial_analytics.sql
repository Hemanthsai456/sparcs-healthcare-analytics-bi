/*
====================================================
FINANCIAL ANALYTICS
====================================================

Domain:
Healthcare Financial Performance Analysis

Purpose:
Analyze payer mix, revenue, costs,
financial efficiency, and resource
utilization.

Data Source:
analytics.v_financial_summary
====================================================
*/


/*
====================================================
Question 1

Which payer categories generate the
highest total revenue?

Business Value:
Identifies the primary sources of
healthcare revenue.
====================================================
*/

SELECT
    discharge_year,
    payment_typology_1,

    ROUND(
        SUM(total_charges),
        2
    ) AS total_revenue

FROM analytics.v_financial_summary

GROUP BY
    discharge_year,
    payment_typology_1

ORDER BY total_revenue DESC;



/*
====================================================
Question 2

Which payer categories incur the
highest healthcare costs?

Business Value:
Identifies payer groups consuming
the greatest healthcare resources.
====================================================
*/

SELECT
    discharge_year,
    payment_typology_1,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_financial_summary

GROUP BY
    discharge_year,
    payment_typology_1

ORDER BY total_costs DESC;



/*
====================================================
Question 3

Which payer categories achieve the
highest financial efficiency?

Business Value:
Measures revenue generated for every
dollar spent on patient care.
====================================================
*/

SELECT
    discharge_year,
    payment_typology_1,

    ROUND(
        SUM(total_charges) /
        NULLIF(SUM(total_costs),0),
        2
    ) AS charge_cost_ratio

FROM analytics.v_financial_summary

GROUP BY
    discharge_year,
    payment_typology_1

ORDER BY charge_cost_ratio DESC;



/*
====================================================
Question 4

Which payer categories generate the
largest financial surplus?

Business Value:
Measures the financial contribution
of each payer category.
====================================================
*/

SELECT
    discharge_year,
    payment_typology_1,

    ROUND(
        SUM(total_charges) -
        SUM(total_costs),
        2
    ) AS financial_surplus

FROM analytics.v_financial_summary

GROUP BY
    discharge_year,
    payment_typology_1

ORDER BY financial_surplus DESC;



/*
====================================================
Question 5

Which payer categories have above-average
treatment costs?

Business Value:
Identifies payer groups whose costs
exceed the overall average.
====================================================
*/

SELECT
    payment_typology_1,

    ROUND(
        AVG(total_costs),
        2
    ) AS avg_cost

FROM analytics.v_financial_summary

GROUP BY payment_typology_1

HAVING
    AVG(total_costs) >
    (
        SELECT AVG(total_costs)
        FROM analytics.v_financial_summary
    )

ORDER BY avg_cost DESC;



/*
====================================================
Question 6

How do payer categories rank by
financial surplus each year?

Business Value:
Ranks payer categories according to
their annual financial contribution.
====================================================
*/

WITH payer_summary AS
(
    SELECT
        discharge_year,
        payment_typology_1,

        SUM(total_charges) -
        SUM(total_costs) AS financial_surplus

    FROM analytics.v_financial_summary

    GROUP BY
        discharge_year,
        payment_typology_1
)

SELECT
    discharge_year,
    payment_typology_1,

    ROUND(financial_surplus,2) AS financial_surplus,

    RANK() OVER
    (
        PARTITION BY discharge_year
        ORDER BY financial_surplus DESC
    ) AS surplus_rank

FROM payer_summary

ORDER BY
    discharge_year,
    surplus_rank;



/*
====================================================
Question 7

How have total charges changed over
time for each payer category?

Business Value:
Measures year-over-year revenue
growth across payer categories.
====================================================
*/

WITH yearly_revenue AS
(
    SELECT
        discharge_year,
        payment_typology_1,

        SUM(total_charges) AS total_revenue

    FROM analytics.v_financial_summary

    GROUP BY
        discharge_year,
        payment_typology_1
)

SELECT
    discharge_year,
    payment_typology_1,

    ROUND(total_revenue,2) AS total_revenue,

    ROUND(
        total_revenue -
        LAG(total_revenue) OVER
        (
            PARTITION BY payment_typology_1
            ORDER BY discharge_year
        ),
        2
    ) AS revenue_growth

FROM yearly_revenue

ORDER BY
    payment_typology_1,
    discharge_year;