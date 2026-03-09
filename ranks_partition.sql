-- Problem: Top 3 Customers per Region by Revenue

Table: orders
  
order_id	customer_id	region	amount
   1        	101    	North	   200
   2	        102	    North	   500
   3	        101	    North	   300
   4	        103	    South	   400
   5	        104	    South	   600
   6	        103	    South	   200
   7	        105	    North	   700

  Task
Use a CTE to calculate total revenue per customer per region
Use a window function to rank customers within each region

Return the top 3 customers per region by revenue
  
Return:
region
customer_id
total_revenue
rank

Hint:
PARTITION BY region

WITH total_revenue_customer_region AS (
    SELECT 
      customer_id,
      region,
      SUM(amount) AS total_revenue
  FROM orders
  GROUP BY customer_id, region
), 

rank_customer AS (
    SELECT 
      customer_id,
      region,
      total_revenue,
      RANK() OVER (PARTITION BY region ORDER BY total_revenue DESC) AS rnk
FROM total_revenue_customer_region  
)

SELECT
  region,
  customer_id,
  total_revenue,
  rnk
FROM rank_customer
WHERE rnk <= 3

-----------------------------------------

-- 2️⃣ User Retention / Cohort Query
Problem: Calculate Day-7 Retention
Table: user_activity
user_id	   activity_date
   1	      2024-01-01
   1	      2024-01-08
   2	      2024-01-01
   2	      2024-01-02
   3	      2024-01-01
   3	      2024-01-08

  Definition
Day-7 retention = (Users who returned exactly 7 days after first activity ÷ Total users who signed up that day)

Task
Create a CTE to get each user’s first activity date

Join it with the activity table
Count users who returned 7 days later

Return:
signup_date
total_users
returned_day7_users
retention_rate

Hint:
DATEDIFF(activity_date, first_date)
(or equivalent depending on SQL dialect)

-----------

  
WITH first_activity AS (
    SELECT 
        user_id,
        MIN(activity_date) AS signup_date
    FROM user_activity
    GROUP BY user_id
),

day7_return AS (
    SELECT 
        f.user_id,
        f.signup_date
    FROM first_activity f
    JOIN user_activity a
      ON f.user_id = a.user_id
     AND a.activity_date = DATE_ADD(f.signup_date, INTERVAL 7 DAY)
)

SELECT 
    signup_date,
    COUNT(DISTINCT f.user_id) AS total_users,
    COUNT(DISTINCT d.user_id) AS returned_day7_users,
    COUNT(DISTINCT d.user_id) * 1.0 / COUNT(DISTINCT f.user_id) AS retention_rate
FROM first_activity f
LEFT JOIN day7_return d
    ON f.user_id = d.user_id
GROUP BY signup_date

-----------------------

3️⃣ Event Funnel Analysis
Problem: Purchase Funnel
  
Table: events
  
user_id	  event_name	  event_time
   1	    view_product	  10:00
   1	    add_to_cart    	10:05
   1	      purchase	    10:10
   2	    view_product	  11:00
   2	     add_to_cart	  11:03
   3	    view_product	  12:00

  Funnel Steps
1️⃣ view_product
2️⃣ add_to_cart
3️⃣ purchase

Task

Calculate the number of users who reached each stage:

Return:

stage	users
viewed_product	?
added_to_cart	?
purchased	?

Constraint:

Users must follow the correct order of events.

Hint:

Use CTEs for each funnel stage.

---------------------------------------------------------

WITH viewed AS (
    SELECT 
      DISTINCT user_id
      FROM events
    WHERE event_name = 'view_product'
),

added_cart AS (
    SELECT 
      DISTINCT e.user_id
    FROM events e
    JOIN viewed v
      ON e.user_id = v.user_id
    WHERE e.event_name = 'add_to_cart'
),

purchased AS (
    SELECT 
      DISTINCT e.user_id
    FROM events e
    JOIN added_cart a
      ON e.user_id = a.user_id
    WHERE e.event_name = 'purchase'
)

SELECT 
  'viewed_product' AS stage,
  COUNT(*) AS users
FROM viewed

UNION ALL

SELECT 
  'added_to_cart',
  COUNT(*)
FROM added_cart

UNION ALL

SELECT 
  'purchased',
  COUNT(*)
FROM purchased;




















