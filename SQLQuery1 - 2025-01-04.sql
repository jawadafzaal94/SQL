-- DISCTINCT = UNIQUE
SELECT DISTINCT MAKE FROM OLX_CARS

-- MAKE, MODEL
SELECT DISTINCT MAKE, MODEL FROM OLX_CARS

SELECT DISTINCT MAKE, MODEL 
FROM OLX_CARS
ORDER BY MAKE, MODEL

SELECT DISTINCT MODEL, MAKE
FROM OLX_CARS
ORDER BY MODEL, MAKE

SELECT * FROM OLX_CARS WHERE DESCRIPTION IS NULL

SELECT * FROM GlobalSharkAttack
where area is null

-- country, area, location

SELECT * FROM GlobalSharkAttack
WHERE
AREA IS NULL
AND
LOCATION IS NULL
AND
COUNTRY IS NULL

-- LIKE
-- wo sarey log jo samandar me nahatey huey
-- attack ka shikar hogaye Bath
-- activity

SELECT *
FROM GlobalSharkAttack 
where activity like '%bath%'

-- fatal
-- like fatal

select * from FinalGlobalSharkAttack
where Activity like 'Bath%' and Injury like 'Fatal%'

-- show tables

select * from INFORMATION_SCHEMA.TABLES

select * from sys.tables

select * from city

CREATE TABLE participants
(FirstName varchar(255),
LastName varchar(255))

-- participants (FirstName, LastName)

select * from participants

INSERT INTO participants
VALUES
('Noor', 'Surani')


SELECT * FROM participants
WHERE FirstName LIKE 'A%';


select * from participants  
where firstname like 'A%' or lastname like 'A%'

select * from participants
where lastname like 'SU%'

select * from participants
where FirstName like 'N%' -- % wildcard

select * from participants
where FirstName = 'Jawad'

ALTER TABLE participants
ADD Marks int

-- Power of Now

select * from participants
where marks is not null
order by marks desc

UPDATE participants
SET Marks = 75
WHERE FirstName = 'Asif'
AND LastName = 'Ansari'

ALTER TABLE participants
ADD ParticipantId INT IDENTITY(1,1);

SELECT * FROM participants
WHERE FirstName = 'Noor'
AND
LastName = 'Surani';
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
WHERE FirstName like 'Jawad'
and
LastName like 'Afzaal'


-- 1, +1


-- IDENTITY(1,1);

DELETE FROM participants
WHERE FirstName = 'Noor'
AND
LastName = 'Surani';

select * From participants
where
FirstName like 'asif'

select * from supermarket_sales

SELECT SUM(QUANTITY) FROM supermarket_sales
-- COUNT
-- MAX
-- MIN
SELECT SUM(Quantity) AS QTY_SUM
FROM SUPERMARKET_SALES

SELECT SUM(quantity)
FROM supermarket_sales;

SELECT COUNT(*) AS TotalSales
FROM supermarket_sales;

SELECT COUNT(quantity) AS QuantityCount
FROM supermarket_sales;

SELECT MIN(quantity) AS MinQuantity
FROM supermarket_sales;

SELECT MAX(quantity) AS MaxQuantity
FROM supermarket_sales;

SELECT AVG(quantity) AS MaxQuantity
FROM supermarket_sales;



-- AS (Alias)

select * from participants

select FirstName AS first,
LastName as last from participants


select firstname + ' ' + lastname as FullName
from participants


select city, count(*) as RecCount,
sum(quantity) as SumQuantity,
max(quantity) as MaxQuantity,
min(quantity) as MinQuantity,
avg(quantity) as AvgQuantity
from supermarket_sales
group by city

select * from supermarket_sales

select * from OLX_CARS

-- Make, Model count

SELECT MAKE, MODEL, COUNT(*)
FROM OLX_CARS
GROUP BY MAKE, MODEL

SELECT 
    Make, 
    Model, 
    COUNT(*) AS TotalCars
FROM OLX_CARS
GROUP BY Make, Model
ORDER BY Make ASC, TotalCars DESC;

SELECT OC.MAKE, OC.MODEL, COUNT(*) as "Total Records"
FROM OLX_CARS OC
GROUP BY oc.MAKE, oc.MODEL
order by oc.make desc, oc.model asc

select * From GlobalSharkAttack
-- Country, desc count(*)

-- group by country
-- display country, count(*) as incidentcount
-- order country, incident desc
select Country,count(*) as incident from GlobalSharkAttack
Group by country 
having count(*) > 100
Order by incident desc

select * from sys.tables
where name like '%pak%'

select * from GlobalSharkAttack

Select country, Count(*) as incident
	From GlobalSharkAttack
	group by country
	having count(*) > 100
	ORDER BY incident DESC;

-- ye ishq nahi asaan

select * from aah_pakelection

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

select party, year, sum(votes) AS TotalVotes
from aah_pakelection
group by party, year
order by year, TotalVotes desc

Select party, year ,\Format(Sum(Votes),'N0') As F_Votes
From aah_pakelection
Where Year Is NOT NULL
Group by Year
Order by year ASC


SELECT party, year, format(sum(votes),'N0') as sumvotes
FROM aah_pakelection
where year is not null
group by party, year
order by year, sumvotes desc

select * from tblEmployee
select * from tblDesignation

select e.*, d.*
	from tblEmployee e
		inner join tblDesignation d
			on e.DesignationID=d.DesignationID

select * from sys.tables
