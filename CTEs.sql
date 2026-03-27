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
           RANK () OVER ( PARTITION BY department 
                              ORDER BY salary DESC ) AS rnk
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

----------------------------------------------

-- 1️⃣ Second Highest Salary per Department

Table: employees
id	name	department	salary
1	Ali	    Sales	    4000
2	Sara	Sales	    6000
3	Ahmed	Sales	    5000
4	Zain	Tech	    7000
5	Noor	Tech	    6500

Task
Return the second highest salary in each department.

Return:
department
name
salary

-----------------------------------------------

WITH salaries AS (

    SELECT 
        department,
        name,
        salary,
        DENSE_RANK() OVER (PARTITION BY department 
                               ORDER BY salary DESC) AS rnk
    FROM employees

)

 SELECT 
        department,
        name,
        salary
FROM salaries
WHERE rnk = 2

--------------------------------------------------

2️⃣ Running Total of Daily Sales

Table: sales
order_id	order_date	amount
  1	         2024-01-01	 200
  2	         2024-01-01	 100
  3	         2024-01-02	 300
  4	         2024-01-03	 150
  5	         2024-01-03	 200
Task
First calculate total sales per day
Then compute a running cumulative total

Return:
| order_date | daily_sales | running_total |

Hint:
SUM(daily_sales) OVER (ORDER BY order_date)

---------------

WITH total_sales_day AS (

        SELECT 
            order_date,
            SUM(amount) AS daily_sales
        FROM sales
        GROUP BY order_date
)

SELECT 
    order_date,
    daily_sales,
    SUM(daily_sales) OVER (ORDER BY order_date) AS running_total
FROM total_sales_day


----------------------------------------

(Q3)

Table: orders

order_id	customer_id	order_date
  1	             101	2024-01-01
  2	             101	2024-01-02
  3	             102	2024-01-01
  4	             102	2024-01-04
  5	             103	2024-01-03
  6	             103	2024-01-04

Task
Find customers who placed orders on consecutive days.

Return:
customer_id

Hint:
LAG(order_date)


-------------------

WITH ordered_dates AS (

    SELECT 
        customer_id,
        order_date,
        LAG(order_date) OVER (
                        PARTITION BY customer_id 
                            ORDER BY order_date
                                ) AS prev_order_date
    FROM orders

)

SELECT DISTINCT customer_id
FROM ordered_dates
WHERE DATEDIFF(order_date, prev_order_date) = 1;

---------------------------------------------

1️⃣ First Purchase Conversion
    
Table: events
user_id	 event_name 	event_time
1	      signup	       Jan 1
1	   view_product  	   Jan 2
1	    purchase	       Jan 5
2	      signup	       Jan 1
2	    view_product	    Jan 3

    
Task
Find percentage of users who made a purchase after signup.

Return:
total_users
purchasers
conversion_rate

    ---------------------------------------------------------

WITH signup_users AS (
    SELECT 
        DISTINCT user_id
    FROM events
    WHERE event_name = 'signup'
),

purchase_users AS (
    SELECT 
        DISTINCT user_id
    FROM events
    WHERE event_name = 'purchase'
)

SELECT 
    COUNT(DISTINCT s.user_id) AS total_users,
    COUNT(DISTINCT p.user_id) AS purchasers,
    COUNT(DISTINCT p.user_id) * 100.0 / COUNT(DISTINCT s.user_id) AS conversion_rate
FROM signup_users s
LEFT JOIN purchase_users p
       ON s.user_id = p.user_id;

-------------------------------------------------------------------------------
    
2️⃣ Most Active Day per User
Table: user_activity
user_id	activity_date
1	Jan 1
1	Jan 1
1	Jan 2
2	Jan 3
2	Jan 3
    
Task
Find the day each user was most active.

Return:

user_id
activity_date
activity_count

--------------------------------------------------------------------------------
    
3️⃣ Top 2 Products per Category
Table: sales
product_id	category	revenue
1	A	100
2	A	200
3	A	150
4	B	300
5	B	250
    
Task
Find top 2 products by revenue per category.


    
    -----------------------------------------------------------------------
🚀 Set 2 — Medium+ (Real BI Thinking)
4️⃣ Daily Active Users (DAU)
Table: logins
user_id	login_date
1	Jan 1
1	Jan 1
2	Jan 1
2	Jan 2

Task
Calculate DAU per day.


    
-------------------------------------------------------------------------------------
5️⃣ Users with Increasing Activity
Table: orders
user_id	order_date	amount
1	Jan 1	100
1	Jan 2	200
1	Jan 3	300
2	Jan 1	100
2	Jan 2	50
    
Task
Find users whose order amount strictly increases day by day.
(Hint: LAG())



 ---------------------------------------------------------------------------------------------   
6️⃣ Average Time Between Orders
Table: orders
user_id	order_time
1	Jan 1 10:00
1	Jan 1 12:00
1	Jan 2 10:00
    
Task
Calculate average time between orders per user.






---------------------------------------------------------------------------------------------
🧠 Set 3 — Hard (Interview Level)
7️⃣ Retention Cohort (Week 1 Retention)
Table: logins
user_id	login_date
1	Jan 1
1	Jan 8
2	Jan 1
2	Jan 2
    
Task
Calculate Week-1 retention per signup date.





---------------------------------------------------------------------------------------------
8️⃣ Sessionization (Very Important)
Table: events
user_id	event_time
1	10:00
1	10:05
1	11:00
    
Task
Create sessions where:
new session if gap > 30 minutes

Return:
user_id
session_id




---------------------------------------------------------------------------------------------
    
9️⃣ Funnel Drop-Off Rate
Table: events
user_id	step
1	signup
1	login
1	purchase
2	signup
2	login
Task

Calculate:

users at each step
drop-off % between steps













