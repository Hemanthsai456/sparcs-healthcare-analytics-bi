/*
====================================================
TREND ANALYTICS
====================================================

Domain:
Multi-Year Healthcare Trend Analysis

Purpose:
Analyze long-term healthcare trends,
hospital performance, financial efficiency,
and operational changes.

Data Source:
analytics.v_yearly_summary
analytics.v_hospital_trends
analytics.v_yoy_growth

====================================================
*/


/*
====================================================
Question 1

How have inpatient admissions changed
across all available years?

Business Value:
Identifies long-term healthcare demand
and utilization trends.
====================================================
*/

SELECT
    discharge_year,
    total_admissions
FROM analytics.v_yearly_summary
ORDER BY discharge_year;


/*
====================================================
Question 2

Which years experienced the highest
Year-over-Year admission growth?

Business Value:
Highlights years with the largest
increase in inpatient demand.
====================================================
*/

SELECT
    discharge_year,
    previous_year_admissions,
    total_admissions,
    admission_growth_pct
FROM analytics.v_yoy_growth
ORDER BY admission_growth_pct DESC NULLS LAST;


/*
====================================================
Question 3

How has the Charge-to-Cost Ratio
changed over time?

Business Value:
Measures long-term financial efficiency
of the healthcare system.
====================================================
*/

SELECT
    discharge_year,
    charge_to_cost_ratio
FROM analytics.v_yearly_summary
ORDER BY discharge_year;


/*
====================================================
Question 4

Which hospitals generated the highest
total charges over time?

Business Value:
Identifies the highest revenue-generating
hospitals across multiple years.
====================================================
*/

SELECT
    facility_name,
    discharge_year,
    total_charges,
    charge_to_cost_ratio
FROM analytics.v_hospital_trends
ORDER BY
    total_charges DESC
LIMIT 10;


/*
====================================================
Question 5

Which hospitals maintained the best
financial efficiency over time?

Business Value:
Highlights hospitals consistently
operating with stronger Charge-to-Cost Ratios.
====================================================
*/

SELECT
    facility_name,
    discharge_year,
    charge_to_cost_ratio
FROM analytics.v_hospital_trends
ORDER BY
    charge_to_cost_ratio DESC,
    total_charges DESC
LIMIT 10;


/*
====================================================
Question 6

Which years experienced the greatest
increase in healthcare costs?

Business Value:
Identifies years with the largest
growth in healthcare expenditure.
====================================================
*/

SELECT
    discharge_year,
    total_costs,
    cost_growth_pct
FROM analytics.v_yoy_growth
ORDER BY cost_growth_pct DESC NULLS LAST;


/*
====================================================
Question 7

How has Average Length of Stay
changed over time?

Business Value:
Evaluates long-term operational
efficiency across the healthcare system.
====================================================
*/

SELECT
    discharge_year,
    average_length_of_stay,
    los_growth_pct
FROM analytics.v_yoy_growth
ORDER BY discharge_year;