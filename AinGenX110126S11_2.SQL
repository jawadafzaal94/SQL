SELECT * 
FROM tblEmployee
INNER JOIN tblDesignation
        ON tblEmployee.DesignationID = tblDesignation.DesignationID


---------------------

SELECT 
 Ad_ID, 
 Car_name, 
 make, 
 model, 
 price,
(select avg(convert(bigint, price)) from OLX_CARS) as avg_price,
(select MAX(convert(bigint, price)) from OLX_CARS) as MAX_price
from OLX_CARS
WHERE price > (select avg(convert(bigint, price)) from OLX_CARS)


-----------

SELECT
  C.NAME AS COLUMN_NAME,
  T.NAME AS DATA_TYPE,
  C.MAX_LENGTH,
  C.IS_NULLABLE
FROM sys.columns C
JOIN sys.types T 
  ON c.user_type_id = t.user_type_id
WHERE C.object_id = OBJECT_ID('GlobalSharkAttack')
ORDER BY c.column_id

------------------------------

sys.tables Saari tables ki list

sys.columns Har table ke columns

sys.views Views ki detail

sys.indexes Index information

sys.objects Sab database objects

sys.schemas Schemas list

sys.foreign_keys Foreign keys

sys.key_constraints Primary / Unique keys

sys.procedures Stored procedures


----------------------------------------


SELECT
        COUNT(*)										AS Row_count,
        MAX(patient_waittime)							AS Max_Wait_Time,
        MIN(patient_waittime)							AS Min_Wait_Time,
        AVG(patient_waittime)							AS Avg_Wait_Time,
        STDEV(patient_waittime)							AS StdDev_Wait_Time,
        VAR(patient_waittime)							AS Var_Wait_Time,
       (MAX(patient_waittime) - MIN(patient_waittime)) AS Range_Wait_Time
FROM hospital_er

--------------------------------

SELECT 
    top 5 COUNTRY, 
    COUNT(*) AS CountryCount
FROM GlobalSharkAttack
WHERE country is not null
  AND ltrim(rtrim(country)) <> ''
GROUP BY country
ORDER BY CountryCount desc

------------------

SELECT 
     TOP 3 
     type, 
     COUNT(*) AS TypeCount
FROM GlobalSharkAttack
WHERE type IS NOT NULL AND type <> ''
GROUP BY type
ORDER BY TypeCount DESC

-----------------------

SELECT 
     TOP 3 
     YEAR, 
     COUNT(*) AS yearcount
FROM GlobalSharkAttack
WHERE type IS NOT NULL AND type <> ''
GROUP BY YEAR
ORDER BY yearcount DESC

------------------------------

SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (TRY_CONVERT(INT,age)) OVER () AS Q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY (TRY_CONVERT(INT,age)) OVER () AS Median_Q2,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (TRY_CONVERT(INT,age)) OVER () AS Q3
FROM globalsharkattack
WHERE age IS NOT NULL;

-------------------------------------


SELECT
   count(*) AS Count
FROM financial_loan_bank_ns 
WHERE loan_status = 'Charged Off'

--------------------------------------

SELECT
  SUBSTRING(email, 1, 4) as subsemail 
FROM tblEmployee

-----------------------

SELECT 
  SUBSTRING(email, 1, charindex('@',email)-1) as subsemail 
FROM tblEmployee

--------------------------

SELECT 
  SUBSTRING(description, 1, charindex(',',description)) as subsemail 
FROM OLX_CARS


-----------------------------------

Select 
CHARINDEX (',' description) 
From OLX_CARS

Select *
From GlobalSharkAttack

------------------------------------

SELECT charindex(',', description) as COmmain_DeSC 
FROM OLX_CARS
WHERE description like '%,%'

------------------

SELECT SUBSTRING(description,1,4) AS Detail
FROM OLX_CARS

------------------------

SELECT 
  emp_id, 
  emp_name,
  dept_id,
  salary,
  rank() over (order by salary desc) as salary_rank
FROM employee

----------------------------

select emp_id, 
       emp_name,
       dept_id,salary,
       dense_rank() over (partition by dept_id order by salary desc) as salary_rank
FROM employee

-------------------------

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'GlobalSharkAttack'
ORDER by table_name


-----------------------------

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'tblEmployee'
ORDER BY table_name

-----------------------------------


JOINS PRACTICE: https://pakdb-logic-engine-547526820015.us-west1.run.app/
