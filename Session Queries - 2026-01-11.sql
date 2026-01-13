select * from tblEmployee
-- select * from tblDepartment
select * from tblDesignation


select * from tblEmployee
	inner join tblDesignation
	on tblEmployee.DesignationID=tblDesignation.DesignationID

select * from tblEmployee
	full join tblDesignation
	on tblEmployee.DesignationID=tblDesignation.DesignationID



SELECT * FROM employees3

SELECT * FROM EMPLOYEES1
UNION 
SELECT * FROM Employees2

SELECT * FROM Employees1
SELECT * FROM Employees2

SELECT * FROM EMPLOYEES1
UNION ALL
SELECT * FROM Employees2
UNION ALL
SELECT *, NULL FROM employees3

insert into employees1
values
(11, 'جتاب', 'John', 'Some', null, N'جتاب')

alter table employees1 add arabicname nvarchar(255)


select * from OLX_CARS

SELECT Ad_ID, Car_name, make, model, price,
		(select avg(convert(bigint, price)) from OLX_CARS) as avg_price
	from OLX_CARS
--	MAX, MIN

SELECT Ad_ID, Car_name, make, model, price
	FROM OLX_CARS
	WHERE PRICE > -- (AVERAGE PRICE)

SELECT AD_ID, CAR_NAME, MAKE, MODEL, PRICE,	   (select avg(convert(bigint, price)) from OLX_CARS) as avg_price,	   (select MAX(convert(bigint, price)) from OLX_CARS) as MAX_price,	   (select MIN(convert(bigint, price)) from OLX_CARS) as MIN_priceFROM OLX_CARSWHERE PRICE > (select avg(convert(bigint, price)) from OLX_CARS)

-- Descriptive Statistics
-- Table Profile

-- COUNT
SELECT COUNT(*) AS Row_Count FROM GlobalSharkAttack

-- Column List and Data Types
SELECT
	C.NAME AS COLUMN_NAME,
	T.NAME AS DATA_TYPE,
	C.MAX_LENGTH,
	C.IS_NULLABLE
FROM sys.columns C
JOIN sys.types T ON c.user_type_id=t.user_type_id
WHERE C.object_id = OBJECT_ID('employees1')
ORDER BY c.column_id

select * from sys.columns
select * from sys.types
select * From sys.indexes
select * from sys.procedures

select * from GlobalSharkAttack

SELECT COUNT(*) FROM GLOBALSHARKATTACK
	WHERE AREA IS NULL

select * from hospital_er

select
	COUNT(*)										AS Row_count,
	MAX(patient_waittime)							AS Max_Wait_Time,
	MIN(patient_waittime)							AS Min_Wait_Time,
	AVG(patient_waittime)							AS Avg_Wait_Time,
	STDEV(patient_waittime)							AS StdDev_Wait_Time,
	VAR(patient_waittime)							AS Var_Wait_Time,
	(MAX(patient_waittime) - MIN(patient_waittime)) AS Range_Wait_Time
from hospital_er

-- MEAN, MEDIAN, MODE
-- MEAN   = AVERAGE
-- MEDIAN = MID VALUE YA DARMIAN VALUE

select * from GlobalSharkAttack

SELECT top 5 COUNTRY, COUNT(*) AS CountryCount
	from GlobalSharkAttack
	where country is not null
	and ltrim(rtrim(country)) <> ''
	group by country
	order by CountryCount desc

-- TOP 3 TYPES
-- TOP 3 YEARS

-- LTRIM=LEFT TRIM SPACE GAYAB KARO, RTRIM = RIGHT SE SPACE GAYAB KARO

-- case when
-- use-case
-- over sold


SELECT TOP 3     year,     COUNT(*) AS YearCountFROM GlobalSharkAttackWHERE year IS NOT NULL AND year > 0GROUP BY yearORDER BY YearCount DESCSELECT TOP 3     type,     COUNT(*) AS TypeCountFROM GlobalSharkAttackWHERE type IS NOT NULL AND type <> ''GROUP BY typeORDER BY TypeCount DESCselect TOP 3 year,	SUM( CASE WHEN type='Unprovoked' THEN 1 ELSE 0 END) AS UnProvokedCount,	SUM( CASE WHEN type='Provoked' THEN 1 ELSE 0 END) AS ProvokedCount,	COUNT(*) AS YearCount	FROM GlobalSharkAttackGROUP BY yearorder by YearCount DESC	SELECT	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY age) OVER() AS Q1,		PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age) OVER() AS Median,AS q1,	SELECT DISTINCT    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY TRY_CONVERT(INT, Age)) OVER () AS Q1_Age,    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TRY_CONVERT(INT, Age)) OVER () AS Median_Age,    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY TRY_CONVERT(INT, Age)) OVER () AS Q3_AgeFROM GlobalSharkAttackWHERE Age IS NOT NULL;-- BEGIN TRANS, COMMIT, ROLLBACKselect * from GlobalSharkAttack_NSselect count(*) from GlobalSharkAttack_NS-- 6451 total recordsselect * from financial_loan_bankSELECT *	INTO financial_loan_bank_ns	FROM financial_loan_bankselect * from financial_loan_bank_nsselect distinct loan_status from financial_loan_bank_nsselect count(*) from financial_loan_bank_ns where loan_status='Charged Off'-- 5333begin trandelete from financial_loan_bank_ns	where loan_status='Charged Off'rollback-- commitselect * from sys.columns c where c.name like '%IsDe%'		select * from sys.tables t where t.object_id = '274100017'	select * from supermarket_salesselect * from tblEmployeeselect concat(Division, ' ', Address) as fulladdress from tblEmployeeselect upper(division) from tblEmployee-- lowerselect charindex('@',email) from tblEmployeeselect SUBSTRING(email, 1, charindex('@',email)) as subsemail from tblEmployeeselect * from OLX_CARS-- description ,select charindex(',',description),	SUBSTRING(Description,1,charindex(',',description))	from OLX_CARS	where description like '%,%'	--substring(kahan se lana hai, start kahan se karna hai, kitne characters?)select * from select * from employeeselect emp_id, emp_name, 	dept_id, salary, rank() over (order by salary desc) as salary_rank	from employeeselect emp_id, emp_name, 	dept_id, salary, dense_rank() over (order by salary desc) as salary_rank	from employeeselect emp_id, emp_name, 	dept_id, salary, dense_rank() over (partition by dept_id order by salary desc) as salary_rank	from employee