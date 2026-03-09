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

----------------------------------------------

-- Question 1 — Total Sales per Customer

-- Table: orders

order_id	customer_id	amount
1	             101	200
2	             101	150
3	             102	300
4	             103	100
5	             102	250

Task

Using a CTE, calculate the total amount spent by each customer and return:

customer_id

total_spent


WITH total_amount_spent AS (

SELECT 
    customer_id,
    SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
)

SELECT 
    customer_id,
    total_spent
FROM total_amount_spent

---------------------
-- Question 2 — Filter High Value Customers

-- Table: orders

order_id	customer_id	amount
1	             201	100
2	             201	200
3	             202	500
4	             203	150
5	             202	300

Task

Use a CTE to calculate total spending per customer

From that result, return customers who spent more than 400

Return:

customer_id
total_spent

WITH total_amount_spent AS (

SELECT 
    customer_id,
    SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
)

SELECT 
    customer_id,
    total_spent
FROM total_amount_spent
WHERE total_spent > 400

---------------------------------------------------------

-- Question 3 — Average Salary Comparison

-- Table: employees

id	name	salary
1	 Ali	4000
2	Sara	7000
3	Ahmed	5000
4	Zain	3000

Task

Create a CTE that calculates the average salary

Return employees whose salary is greater than the average

Return:

name
salary

WITH emp_average_salary AS (

SELECT 
    AVG(salary) AS average_salary
FROM employees
    
)

SELECT
    name,
    salary
FROM employees
WHERE salary > (SELECT 
                    average_salary
                FROM emp_average_salary)

------------------------------------------------------

    
MEDIUM
    
-- Question 1 — Top Customer by Total Spending
-- Table: orders
    
order_id	customer_id	amount
  1	             101	200
  2	             102	500
  3	             101	300
  4	             103	150
  5	             102	200
  6	             104	700
    
Task

Use a CTE to calculate total spending per customer

Return the customer who spent the most

Return:

customer_id
total_spent

WITH cus_total_spent AS (

    SELECT 
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)

SELECT 
    customer_id,
    total_spent
FROM cus_total_spent
ORDER BY total_spent DESC 
LIMIT 1 

--------------

WITH cus_total_spent AS (

    SELECT 
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),

rank_customers AS (
    SELECT 
        *, 
        RANK () OVER ( ORDER BY total_spent DESC ) AS rnk
    FROM cus_total_spent
    
)

SELECT 
    customer_id,
    total_spent
FROM rank_customers
WHERE rnk = 1 

------------------------   

-- Question 2 — Highest Paid Employee in Each Department

Table: employees
id	name	department	salary
1	Ali	       Sales	4000
2	Sara	   Sales	6000
3	Ahmed	    Tech	7000
4	Zain	    Tech	6500
5	Noor	      HR	5000

Task
Use a CTE with a window function
Find the highest paid employee in each department

Return:
name
department
salary

(Hint: RANK() or ROW_NUMBER())

WITH highest_paid AS (
    SELECT name,
           department,
           salary,
           RANK () OVER ( PARTITION BY department ORDER BY salary DESC ) AS rnk
FROM employees
)

SELECT 
    name,
    department,
    salary
FROM highest_paid
WHERE rnk = 1

------------------------------------------------

-- Question 3 — Customers Who Spent Above Average
Table: orders
order_id	customer_id	amount
1	             201	100
2	             201	300
3	             202	500
4	             203	200
5	             202	100
Task

Create a CTE to calculate total spending per customer
Create another CTE to calculate the average of those totals

Return customers whose spending is above the average

Return:
customer_id
total_spent


WITH total_spending_customer AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id

),

average_total_spent AS (
    SELECT 
        AVG(total_spent) AS average_spent
    FROM total_spending_customer
)

SELECT 
    customer_id,
    total_spent
FROM total_spending_customer
WHERE total_spent > ( SELECT 
                        average_spent
                      FROM average_total_spent
                      )

