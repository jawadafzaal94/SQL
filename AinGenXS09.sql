SELECT DISTINCT MAKE
FROM OLX_CARS


-----

SELECT 
       DISTINCT MAKE, 
                MODEL 
FROM OLX_CARS
ORDER BY MAKE, MODEL


----------


SELECT *
FROM Globalsharkattack
WHERE COUNTRY IS null
   AND AREA IS null
   AND Location IS null

----------

SELECT *
FROM GlobalSharkAttack SHA
WHERE ACTIVITY like '%bath%'

------------

SELECT *
FROM GlobalSharkAttack SHA
WHERE INJURY like '%fatal%'

----------

SELECT * 
From GlobalSharkAttack 
WHERE Injury Like '%fatal%'


------

INSERT INTO participants

VALUES 

('Jawad' , 'Afzaal' )


----------

SELECT * 
From participants
WHERE FirstName = 'A%'

------

SELECT *
FROM participants
WHERE firstname LIKE 'A%'
   OR lastname LIKE 'A%'


--------

UPDATE PARTICIPANTS 
SET MARKS = 100
WHERE Firstname = 'Jawad' 
      AND lastname = 'Afzaal'


UPDATE PARTICIPANTS
SET MARKS = 75
WHERE Firstname = 'Jawad' 
  AND Lastname  = 'Afzaal'

----------------

DELETE PARTICIPANTS/////
WHERE Firstname = 'Jawad'//
  AND Lastname  = 'Afzaal'///

-------------


DELETE PARTICIPANTS
WHERE Firstname = 'Jawad'
  AND Lastname  = 'Afzaal'

-----------------



SELECT *
FROM SUPERMARKET_SALES

---------


SELECT 
  SUM(Quantity) AS Qty_SUM
FROM SUPERMARKET_SALES

----------


SELECT 
  FIRSTNAME +' '+ LASTNAME AS Fullname
FROM PARTICIPANTS
ORDER BY 1


--------
SELECT 
    Make, 
    Model, 
    COUNT(*) AS TotalCars
FROM OLX_CARS
GROUP BY Make, 
         Model
ORDER BY Make ASC, 
         TotalCars DESC


----------

SELECT
    COUNTRY,
    COUNT(*) AS TOTALNUMBERS
FROM globalsharkattack
GROUP BY COUNTRY
ORDER BY TOTALNUMBERS

--------

SELECT
  Country,
  COUNT(*) AS TotalAttacks
FROM GlobalSharkAttack
GROUP BY Country
ORDER BY TotalAttacks DESC

---------------

SELECT 
     COUNTRY, 
     COUNT(*) as Incident
From GlobalSharkAttack
GROUP BY country
HAVING count(*) > 100
ORDER BY incident DESC

--------

SELECT 
     YEAR, 
     SUM(VOTES) as VOTES,
     SUM(Validvotes) as ValidVOTES,
From ahh_pakelection
GROUP BY YEAR
ORDER BY VOTES, ValidVOTES

-------

SELECT *
FROM AAH_PAKELECTION 

------



SELECT YEAR, 
	SUM(VOTES) AS Votes,
	FORMAT(SUM(VOTES), 'N0') AS F_VOTES
FROM AAH_PAKELECTION 
GROUP BY YEAR
ORDER BY YEAR ASC

----------


SELECT 
    party, 
    year, 
    sum(votes) AS TotalVotes
FROM aah_pakelection
GROUP BY party, year
ORDER BY year, TotalVotes desc

-------------------------

WITH party_votes AS (
    SELECT 
        party,
        year,
        SUM(votes) AS totalvotes,
DENSE_RANK() OVER (
            PARTITION BY year
            ORDER BY totalvotes DESC
        ) AS party_rank
    FROM party_votes
    FROM aah_pakelection
    GROUP BY party, year
),
ranked_parties AS (
    SELECT
        party,
        year,
        totalvotes,
        DENSE_RANK() OVER (
            PARTITION BY year
            ORDER BY totalvotes DESC
        ) AS party_rank
    FROM party_votes
)
SELECT
    party,
    year,
    totalvotes,
    party_rank
FROM ranked_parties
WHERE party_rank <= 3
ORDER BY year, party_rank
