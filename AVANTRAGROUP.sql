Question 1 — Basic SQL Aggregation

You have this table:

orders
order_id	customer_id	amount
   1	        101     	50
   2	        102	      100
   3	        101     	70
   4	        103	      30
   5	        102	      120

Write a SQL query to return:

customer_id
total_amount_spent


SELECT 
  customer_id,
  SUM(amount) AS total_amount_spent
FROM orders
GROUP BY customer_id
ORDER BY total_amount_spent DESC

------------------------------

Question 2 — Filtering + Aggregation

Using the same orders table:

Write a SQL query to return:

customer_id
total_amount_spent

But only include customers whose total spending is greater than 100.

Sort results by total_amount_spent descending.


SELECT 
  customer_id,
  SUM(amount) AS total_amount_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY total_amount_spent DESC

-----------------------------------

Question 3 — JOIN (Very Important)

You have two tables:

customers
customer_id	customer_name
    101     	Ali
    102	     Sara
    103	     Ahmed

  orders
order_id	customer_id	amount
   1	       101	      50
   2	       102	      100
   3	       101	      70
   4	       103	      30
   5	       102	      120
  
Task:

Return:

customer_name
total_amount_spent

Sort by total_amount_spent descending.

SELECT 
  customer_name, 
  SUM(amount) AS total_amount_spent
FROM customers c
JOIN orders o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_amount_spent DESC

----------------------------------------

Question 4 — LEFT JOIN + NULL Handling
Task:

Return:

customer_name
total_amount_spent
Requirements:
Include ALL customers (even those with no orders)
If no orders → show 0
Sort by total_amount_spent DESC



SELECT 
  c.customer_name, 
  COALESCE(SUM(o.amount), 0) AS total_amount_spent
FROM customers c
LEFT JOIN orders o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_amount_spent DESC


---------------

Question 5 — COUNT + DISTINCT

Using the orders table:

Task:

Return:

total_orders
total_unique_customers


SELECT 
  COUNT(*) AS total_orders,
  COUNT(DISTINCT customer_id) AS total_unique_customers
FROM orders;

-----------------------------------------

Question 6 — Top N (Classic)

Using orders table:

Task:

Return:

customer_id
total_amount_spent

👉 Only show top 2 customers by total spending


SELECT 
   customer_id,
   SUM(amount) AS total_amount_spent
FROM orders
GROUP BY customer_id
ORDER by SUM(amount) DESC
LIMIT 2

--------------------------

Question 7 — Second Highest (Classic Interview Favorite)

Using orders table:

Task:

Find the second highest total spending customer

👉 Return:

customer_id
total_amount_spent


WITH customer_total AS (
  SELECT 
    customer_id,
    SUM(amount) AS total_amount_spent
  FROM orders 
  GROUP BY customer_id
),

ranks AS (
  SELECT 
    *,
    RANK() OVER (ORDER BY total_amount_spent DESC) AS rnk
  FROM customer_total
)

SELECT
  customer_id,
  total_amount_spent
FROM ranks
WHERE rnk = 2;

------------------

Question 8 — Daily Active Users (DAU)
Table: logins
Task:

Return:

date
number of unique users per day


SELECT
    DATE(login_time) AS date,
    COUNT(DISTINCT user_id) AS daily_active_users
FROM logins
GROUP BY DATE(login_time)
ORDER BY date;








