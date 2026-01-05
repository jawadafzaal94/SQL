-- DISCTINCT = UNIQUE
SELECT 
	DISTINCT MAKE 
FROM OLX_CARS

-- MAKE, MODEL
SELECT 
	DISTINCT MAKE, 
	         MODEL 
FROM OLX_CARS

SELECT 
	DISTINCT MAKE, 
	         MODEL 
FROM OLX_CARS
ORDER BY MAKE, MODEL

SELECT 
	DISTINCT MODEL, 
	          MAKE
FROM OLX_CARS
ORDER BY MODEL, MAKE

SELECT * 
FROM OLX_CARS 
WHERE DESCRIPTION IS NULL

SELECT * 
FROM GlobalSharkAttack
WHERE area IS NULL

-- country, area, location

SELECT * 
FROM GlobalSharkAttack
WHERE AREA IS NULL
  AND LOCATION IS NULL
  AND COUNTRY IS NULL

-- LIKE
-- wo sarey log jo samandar me nahatey huey
-- attack ka shikar hogaye Bath
-- activity

SELECT *
FROM GlobalSharkAttack 
WHERE activity LIKE '%bath%'

-- fatal
-- LIKE fatal

SELECT * 
FROM FinalGlobalSharkAttack
WHERE Activity LIKE 'Bath%' 
AND Injury LIKE 'Fatal%'

-- show tables

SELECT * 
FROM INFORMATION_SCHEMA.TABLES

SELECT * 
FROM sys.tables

SELECT * 
FROM city

CREATE TABLE participants
(FirstName varchar(255),
LastName varchar(255))

-- participants (FirstName, LastName)

SELECT * 
FROM participants

INSERT INTO participants
VALUES
('Noor', 'Surani')


SELECT * 
FROM participants
WHERE FirstName LIKE 'A%';


SELECT * 
FROM participants  
WHERE firstname LIKE 'A%' or lastname LIKE 'A%'

SELECT * 
FROM participants
WHERE lastname LIKE 'SU%'

SELECT * 
FROM participants
WHERE FirstName LIKE 'N%' -- % wildcard

SELECT * 
FROM participants
WHERE FirstName = 'Jawad'

ALTER TABLE participants
ADD Marks int

-- Power of Now

SELECT * 
FROM participants
WHERE marks is not null
ORDER BY marks DESC

UPDATE participants
SET Marks = 75
WHERE FirstName = 'Asif'
AND LastName = 'Ansari'

ALTER TABLE participants
ADD ParticipantId INT IDENTITY(1,1);

SELECT * 
FROM participants
WHERE FirstName = 'Noor'
  AND LastName = 'Surani';

WHERE marks = 100

INSERT INTO participants
VALUES
('Noor', 'Surani', 75)

INSERT INTO participants
(FirstName, LastName, Marks)
VALUES
('Noor', 'Surani', '75')





UPDATE participants
SET Marks = 75
WHERE FirstName LIKE 'Jawad'
and
LastName LIKE 'Afzaal'


-- 1, +1


-- IDENTITY(1,1);

DELETE FROM participants
WHERE FirstName = 'Noor'
AND
LastName = 'Surani';

SELECT * 
FROM participants
WHERE FirstName LIKE 'asif'

SELECT * 
FROM supermarket_sales

SELECT 
 	SUM(QUANTITY) 
FROM supermarket_sales

	
-- COUNT
-- MAX
-- MIN

	
SELECT 
	SUM(Quantity) AS QTY_SUM
FROM SUPERMARKET_SALES

SELECT 
	SUM(quantity)
FROM supermarket_sales;

SELECT 
	COUNT(*) AS TotalSales
FROM supermarket_sales;

SELECT 
	COUNT(quantity) AS QuantityCount
FROM supermarket_sales;

SELECT 
	MIN(quantity) AS MinQuantity
FROM supermarket_sales;

SELECT 
	MAX(quantity) AS MaxQuantity
FROM supermarket_sales;

SELECT 
	AVG(quantity) AS MaxQuantity
FROM supermarket_sales;



-- AS (Alias)

SELECT * 
FROM participants

SELECT 
	FirstName AS first,
LastName as last FROM participants


SELECT firstname + ' ' + lastname as FullName
FROM participants


SELECT 
	city, count(*) as RecCount,
	sum(quantity) as SumQuantity,
	max(quantity) as MaxQuantity,
	min(quantity) as MinQuantity,
	avg(quantity) as AvgQuantity
FROM supermarket_sales
GROUP BY city

SELECT * 
FROM supermarket_sales

SELECT * 
FROM OLX_CARS

-- Make, Model count

SELECT 
	MAKE, 
	MODEL, 
	COUNT(*)
FROM OLX_CARS
GROUP BY MAKE, MODEL

SELECT 
    Make, 
    Model, 
    COUNT(*) AS TotalCars
FROM OLX_CARS
GROUP BY Make, Model
ORDER BY Make ASC, TotalCars DESC;

SELECT 
	OC.MAKE,
	OC.MODEL, 
	COUNT(*) as "Total Records"
FROM OLX_CARS OC
GROUP BY oc.MAKE, oc.MODEL
ORDER BY oc.make DESC, oc.model asc

SELECT * 
FROM GlobalSharkAttack

	
-- Country, DESC count(*)

-- GROUP BY country
-- display country, count(*) as incidentcount
-- order country, incident DESC

	
SELECT Country,
	count(*) as incident 
FROM GlobalSharkAttack
GROUP BY country 
HAVING COUNT(*) > 100
ORDER BY incident DESC

SELECT * 
FROM sys.tables
WHERE name LIKE '%pak%'

SELECT * 
FROM GlobalSharkAttack

SELECT 
	country, 
	Count(*) as incident
FROM GlobalSharkAttack
GROUP BY country
HAVING COUNT(*) > 100
ORDER BY incident DESC;

-- ye ishq nahi asaan

SELECT * 
FROM aah_pakelection

-- year wise votes, valid votes sum
-- order year

SELECT YEAR, 
	SUM(VOTES),
	FORMAT(SUM(VOTES), 'N0') AS F_VOTES
FROM AAH_PAKELECTION 
WHERE YEAR IS NOT NULL
GROUP BY YEAR
ORDER BY YEAR ASC

-- YEAR, PARTY WISE, VOTES DESC

-- FORMAT(NUMERIC FUNCTION OR VALUE, 'N0') AS NAME

SELECT 
	party, 
	year, 
	sum(votes) AS TotalVotes
FROM aah_pakelection
GROUP BY party, year
ORDER BY year, TotalVotes DESC

SELECT 
	party, 
	year ,
	\Format(Sum(Votes),'N0') As F_Votes
FROM aah_pakelection
WHERE Year Is NOT NULL
GROUP BY Year
ORDER BY year ASC


SELECT 
	party, 
	year, 
	format(sum(votes),'N0') as sumvotes
FROM aah_pakelection
WHERE year is not null
GROUP BY party, year
ORDER BY year, sumvotes DESC

SELECT * 
FROM tblEmployee
	
SELECT * 
FROM tblDesignation

SELECT e.*, d.*
FROM tblEmployee e
INNER JOIN tblDesignation d
		ON e.DesignationID=d.DesignationID

SELECT * 
FROM sys.tables

