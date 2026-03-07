--Find employees whose salary is greater than the average salary.--

WITH avg_salary AS (
    SELECT AVG(salary) AS avg_sal
    FROM employees
)

SELECT name, salary
FROM employees
WHERE salary > (SELECT avg_sal FROM avg_salary);

-- Explanation: 
-- CTE calculates average salary.
-- Main query compares each salary with that value.

-- Find customers whose total order value is greater than 400.

WITH customer_totals AS (
    SELECT customer_id,
           SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)

SELECT *
FROM customer_totals
WHERE total_spent > 400;

-- Output
-- customer_id	   total_spent
--    101	             500

-- Find the top salesperson in each region.

WITH ranked_sales AS (
    SELECT salesperson,
           region,
           sales,
           RANK() OVER(PARTITION BY region ORDER BY sales DESC) AS rnk
    FROM sales
)

SELECT salesperson, region, sales
FROM ranked_sales
WHERE rnk = 1;

-- Key Idea
-- CTE stores ranking first → then filter.



-- Multiple CTEs (Advanced Interview Question)

-- Customers
| id | name  |
| -- | ----- |
| 1  | Ali   |
| 2  | Sara  |
| 3  | Ahmed |

-- Orders
| order_id | customer_id | amount |
| -------- | ----------- | ------ |
| 1        | 1           | 300    |
| 2        | 1           | 200    |
| 3        | 2           | 400    |

-- Find customers who spent more than the average customer spending.

WITH customer_spending AS (
    SELECT customer_id,
           SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),

avg_spending AS (
    SELECT AVG(total_spent) AS avg_total
    FROM customer_spending
)

SELECT 
  c.name, 
  cs.total_spent
FROM customer_spending cs
JOIN customers c
  ON cs.customer_id = c.id
WHERE cs.total_spent > (SELECT avg_total FROM avg_spending);












