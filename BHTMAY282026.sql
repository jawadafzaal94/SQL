-- Q1 

WITH demand_with_potential AS (
    SELECT
        city,
        date,
        hour,
        completed_orders,
        shrinkage_pct,
        EXTRACT(ISOWEEK FROM date) AS week_number,
        EXTRACT(YEAR FROM date) AS year,
        -- Core formula: upward adjustment for demand lost to shrinkage
        ROUND(completed_orders * (1 + shrinkage_pct * 0.0025), 2)  AS potential_orders
    FROM `project.dataset.demand`
    WHERE completed_orders IS NOT NULL   -- 11 NULLs present — excluded from aggregation
),

-- Roll up to year × week × city × hour level
weekly_hourly AS (
    SELECT
        city,
        year,
        week_number,
        hour,
        SUM(potential_orders) AS total_potential_orders,
        SUM(completed_orders) AS total_completed_orders,
        AVG(shrinkage_pct) AS avg_shrinkage_pct
    FROM demand_with_potential
    GROUP BY city, year, week_number, hour
),

-- Rank each hour within its city-week by potential demand
ranked AS (
    SELECT
        city,
        year,
        week_number,
        hour,
        ROUND(total_potential_orders, 1) AS total_potential_orders,
        ROUND(total_completed_orders, 0) AS total_completed_orders,
        ROUND(avg_shrinkage_pct, 2) AS avg_shrinkage_pct,
        ROW_NUMBER() OVER (
            PARTITION BY city, year, week_number
            ORDER BY total_potential_orders DESC) AS demand_rank
    FROM weekly_hourly
)

SELECT
    city,
    year,
    week_number,
    demand_rank AS peak_rank,
    hour AS peak_hour,
    total_potential_orders,
    total_completed_orders,
    avg_shrinkage_pct,
    ROUND(total_potential_orders - total_completed_orders, 1) AS recovered_orders
FROM ranked
WHERE demand_rank <= 5
ORDER BY city, year, week_number, demand_rank;

---------------------------------------------------------------------------------------------

-- SQL — Worst Week + Investment Calculation

WITH worst_weeks AS (
    -- Step 1: Compute avg shrinkage per city per week
    WITH ws AS (
        SELECT
            city,
            EXTRACT(YEAR FROM date) AS year,
            EXTRACT(ISOWEEK FROM date) AS week_number,
            AVG(shrinkage_pct) AS avg_shrinkage_pct
        FROM `project.dataset.demand`
        WHERE completed_orders IS NOT NULL
        GROUP BY city, year, week_number
    ),
    -- Step 2: Rank weeks within each city — worst first
    rk AS (
        SELECT
            city, 
            year, 
            week_number,
            ROW_NUMBER() OVER ( PARTITION BY city
                                    ORDER BY avg_shrinkage_pct DESC) AS rn
        FROM ws
    )
    
  SELECT 
    city, 
    year, 
    week_number 
  FROM rk 
  WHERE rn = 1
),
-- Step 3: Pull all shrinkage hours in those worst weeks
worst_data AS (
    SELECT
        d.city, 
        d.date, 
        d.hour,
        d.completed_orders, 
        d.shrinkage_pct,
        ROUND(d.completed_orders * d.shrinkage_pct * 0.0025, 3) AS lost_orders,
        s.deliveries_per_hour AS dph
    FROM `project.dataset.demand` d
    JOIN `project.dataset.supply` s
        ON  d.city = s.city
        AND d.date = s.date
        AND d.hour = s.hour
    JOIN worst_weeks w
        ON  d.city = w.city
        AND EXTRACT(YEAR FROM d.date) = w.year
        AND EXTRACT(ISOWEEK FROM d.date) = w.week_number
    WHERE d.shrinkage_pct > 0
      AND d.completed_orders IS NOT NULL
)
-- Step 4: Aggregate + calculate investment and revenue
SELECT
    city,
    COUNT(*) AS shrinkage_hours,
    ROUND(SUM(lost_orders), 2) AS total_lost_orders,
    ROUND(AVG(shrinkage_pct), 2) AS avg_shrinkage_pct,
    ROUND(AVG(dph), 3) AS avg_dph,
    -- Extra courier-hours = lost orders ÷ avg deliveries per hour
    ROUND(SUM(lost_orders) / AVG(dph), 1) AS extra_courier_hours,
    ROUND(SUM(lost_orders) / AVG(dph) / COUNT(*), 2) AS min_extra_couriers,
    -- Investment = courier-hours × €8/hr
    ROUND(SUM(lost_orders) / AVG(dph) * 8, 2) AS investment_eur,
    -- Revenue = lost orders × (€16 × 25% commission + €1 delivery fee)
    ROUND(SUM(lost_orders) * (16 * 0.25 + 1), 2) AS revenue_recovered_eur,
    ROUND(
        SUM(lost_orders) * (16 * 0.25 + 1) - SUM(lost_orders) / AVG(dph) * 8, 2) AS net_pnl_eur
FROM worst_data
GROUP BY city
ORDER BY city;

---------------------------------------------------------------------------------------------------















