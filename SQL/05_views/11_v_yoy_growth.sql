CREATE OR REPLACE VIEW analytics.v_yoy_growth AS

WITH yearly AS
(
SELECT

    dt.discharge_year,

    COUNT(*) AS total_admissions,

    SUM(f.total_charges) AS total_charges,

    SUM(f.total_costs) AS total_costs,

    ROUND(AVG(f.length_of_stay_days),2) AS average_length_of_stay

FROM warehouse.fact_discharge f

JOIN warehouse.dim_date dt
ON f.date_key = dt.date_key

GROUP BY
    dt.discharge_year
)

SELECT

    discharge_year,

    total_admissions,

    total_charges,

    total_costs,

    average_length_of_stay,

    LAG(total_admissions)
        OVER(ORDER BY discharge_year)
        AS previous_year_admissions,

    ROUND(

        (
            total_admissions
            -
            LAG(total_admissions)
            OVER(ORDER BY discharge_year)
        )

        *100.0

        /

        NULLIF
        (
            LAG(total_admissions)
            OVER(ORDER BY discharge_year),
            0
        ),

        2

    ) AS admission_growth_pct,

    ROUND(

        (
            total_charges
            -
            LAG(total_charges)
            OVER(ORDER BY discharge_year)
        )

        *100

        /

        NULLIF
        (
            LAG(total_charges)
            OVER(ORDER BY discharge_year),
            0
        ),

        2

    ) AS charge_growth_pct,

    ROUND(

        (
            total_costs
            -
            LAG(total_costs)
            OVER(ORDER BY discharge_year)
        )

        *100

        /

        NULLIF
        (
            LAG(total_costs)
            OVER(ORDER BY discharge_year),
            0
        ),

        2

    ) AS cost_growth_pct,

    ROUND(

        (
            average_length_of_stay
            -
            LAG(average_length_of_stay)
            OVER(ORDER BY discharge_year)
        )

        *100

        /

        NULLIF
        (
            LAG(average_length_of_stay)
            OVER(ORDER BY discharge_year),
            0
        ),

        2

    ) AS los_growth_pct

FROM yearly

ORDER BY
    discharge_year;