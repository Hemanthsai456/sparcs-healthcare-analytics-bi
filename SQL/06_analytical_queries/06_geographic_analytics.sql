/*
====================================================
GEOGRAPHIC ANALYTICS
====================================================

Domain:
Healthcare Geographic Analysis

Purpose:
Analyze regional healthcare demand,
financial performance, and resource
utilization across Health Service Areas
and Hospital Counties.

Data Source:
analytics.v_geographic_analysis
====================================================
*/


/*
====================================================
Question 1

Which Health Service Areas record the
highest number of hospital admissions?

Business Value:
Identifies regions with the highest
healthcare demand.
====================================================
*/

SELECT
    discharge_year,
    health_service_area,
    admissions

FROM analytics.v_geographic_analysis

ORDER BY admissions DESC;



/*
====================================================
Question 2

Which hospital counties generate the
highest treatment charges?

Business Value:
Highlights counties contributing the
largest share of hospital revenue.
====================================================
*/

SELECT
    hospital_county,

    ROUND(
        SUM(total_charges),
        2
    ) AS total_charges

FROM analytics.v_geographic_analysis

GROUP BY hospital_county

ORDER BY total_charges DESC;



/*
====================================================
Question 3

Which Health Service Areas incur the
highest treatment costs?

Business Value:
Identifies regions consuming the
greatest healthcare resources.
====================================================
*/

SELECT
    health_service_area,

    ROUND(
        SUM(total_costs),
        2
    ) AS total_costs

FROM analytics.v_geographic_analysis

GROUP BY health_service_area

ORDER BY total_costs DESC;



/*
====================================================
Question 4

Which hospital counties have the
longest average length of stay?

Business Value:
Highlights counties requiring greater
hospital resource utilization.
====================================================
*/

SELECT
    hospital_county,

    ROUND(
        AVG(avg_los),
        2
    ) AS avg_length_of_stay

FROM analytics.v_geographic_analysis

GROUP BY hospital_county

ORDER BY avg_length_of_stay DESC;



/*
====================================================
Question 5

Which Health Service Areas have
above-average patient admissions?

Business Value:
Identifies regions with healthcare
demand exceeding the statewide average.
====================================================
*/

SELECT
    health_service_area,

    SUM(admissions) AS admissions

FROM analytics.v_geographic_analysis

GROUP BY health_service_area

HAVING
    SUM(admissions) >
(
    SELECT
        AVG(admissions)
    FROM analytics.v_geographic_analysis
)

ORDER BY admissions DESC;



/*
====================================================
Question 6

How do Health Service Areas rank by
patient admissions each year?

Business Value:
Ranks regional healthcare demand to
support planning and resource allocation.
====================================================
*/

SELECT
    discharge_year,
    health_service_area,
    admissions,

    RANK() OVER
    (
        PARTITION BY discharge_year
        ORDER BY admissions DESC
    ) AS admission_rank

FROM analytics.v_geographic_analysis

ORDER BY
    discharge_year,
    admission_rank;



/*
====================================================
Question 7

How are hospital counties segmented
based on total treatment costs?

Business Value:
Groups counties into spending tiers
for regional benchmarking.
====================================================
*/

SELECT
    hospital_county,
    total_costs,

    NTILE(4) OVER
    (
        ORDER BY total_costs DESC
    ) AS cost_quartile

FROM analytics.v_geographic_analysis

ORDER BY
    cost_quartile,
    total_costs DESC;