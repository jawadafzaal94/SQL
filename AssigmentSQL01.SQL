
Find the maximum overall rating in BA_AirlineReviews.

SELECT
  MAX (Overallrating) AS MAX_RATING
FROM BA_AirlineReviews


-------------------------

Select order_id as OrderID and cost_of_the_order as OrderCost from foodhub_orders.

SELECT 
  order_id AS OrderID,
  ROUND(cost_of_the_order, 2) AS OrderCost
FROM foodhub_orders

--------------------------

List all distinct aircraft from BA_AirlineReviews.

SELECT
  DISTINCT (aircraft) AS Aircrafts
FROM BA_AirlineReviews
ORDER BY Aircrafts

-------------------------

Count visits by patient_gender in hospital_er.

SELECT
   patient_gender,
   Count(patient_gender) as Visits
FROM hospital_er
GROUP BY patient_gender

---------------------------

Select reviews from BA_AirlineReviews ordered by reviewer name

SELECT *
FROM BA_AirlineReviews
ORDER BY Name

---------------------------

Select patient_age, patient_race, patient_gender from hospital_er

SELECT
  patient_age,
  patient_race,
  patient_gender
FROM hospital_er

---------------------------

Select TOP 10 rows from Pak_Elc.

SELECT TOP 10 *
FROM Pak_Elc

---------------------------

Select all rows from GlobalSharkAttack where Fatal_Y_N = 1 (need to ask)

SELECT *
FROM GlobalSharkAttack
WHERE Fatal_Y_N = 1

--------------------------------

Select rows from GlobalSharkAttack where country LIKE '%UNITED%'.

SELECT *
FROM GlobalSharkAttack
WHERE country LIKE '%UNITED%'

---------------------------------

Select reviews from BA_AirlineReviews where aircraft IS NULL (need to check)


SELECT *
FROM BA_AirlineReviews
WHERE aircraft IS NULL

-------------------------------------

Find the total number of rows in Pak_Elc.

SELECT 
  COUNT (*) AS Total
FROM Pak_Elc


--------------------------------------

Select CandidateName as Candidate and Votes as CandidateVotes from Pak_Elc

SELECT
  CandidateName AS Candidate,
  Votes AS CandidateVotes
FROM Pak_Elc

-------------------------------------

List all distinct patient_race values from hospital_er.


SELECT
  DISTINCT patient_race
FROM hospital_er

-----------------------------------

Count incidents by InjuryCategory in GlobalSharkAttack


SELECT
   InjuryCategory, 
   COUNT(*) AS incidents
FROM GlobalSharkAttack
GROUP BY InjuryCategory

------------------------------------

Select all reviews from BA_AirlineReviews ordered by review date DESC

SELECT *
FROM BA_AirlineReviews
ORDER BY datetime DESC

----------------------------------

Find the average Votes in Pak_Elc


SELECT
  AVG(Votes) AS VOTES
FROM Pak_Elc


---------------

Count incidents by country and CondenseActivity in GlobalSharkAttack.

SELECT
   country, 
   CondenseActivity,
   COUNT(*) AS incidents
FROM GlobalSharkAttack
GROUP BY country, CondenseActivity


---------------------------------

Show department_referral values from hospital_er having average patient_waittime greater than 30.

SELECT
  department_referral,
  COUNT(*) AS Number
FROM hospital_er
GROUP BY department_referral
HAVING AVG(patient_waittime) > 30


------------------------------------------

Select rows from GlobalSharkAttack ordered by age DESC. (need to check)


SELECT *
FROM GlobalSharkAttack
ORDER BY AGE DESC

-------------------------------------------

Select TOP 10 rows from Pak_Elc where Province = 'KPK' ordered by Votes DESC.

SELECT TOP 10 *
FROM Pak_Elc
WHERE Province = 'KPK'

--------------------------------------------

Select rows from GlobalSharkAttack where InjuryCategory = 'Moderate' AND Fatal_Y_N = 0. (need to check)


SELECT *
FROM GlobalSharkAttack
WHERE InjuryCategory = 'Moderate'
  AND Fatal_Y_N = 0


--------------------------------------------

Select rows from foodhub_orders where cost_of_the_order BETWEEN 10 AND 30. (need to check fine)

SELECT *
FROM foodhub_orders
WHERE cost_of_the_order BETWEEN 10 AND 30

--------------------------------------------

Select rows from hospital_er where patient_race IN ('White','African American').

SELECT *
FROM hospital_er
WHERE patient_race IN ('White','African American')


-------------------------------------------

Select rows from hospital_er where patient_race LIKE '%American%'.

SELECT *
FROM hospital_er
WHERE patient_race LIKE '%American%'

--------------------------------------------

Select rows from GlobalSharkAttack where InjuryCategory IS NULL (need to check category) 

SELECT *
FROM GlobalSharkAttack
WHERE InjuryCategory IS NULL

---------------------------------------------

Find the total number of recommended reviews in BA_AirlineReviews.


SELECT 
   COUNT(*) AS total_number
FROM BA_AirlineReviews


----------------------------------------------

Count reviews by route in BA_AirlineReviews


SELECT 
    Route, 
    COUNT(*) AS Count
FROM BA_AirlineReviews
GROUP BY Route

------------------------------------------------

Show Product_line values from supermarket_sales having more than 50 transactions.

SELECT 
    Product_line, 
    COUNT(*) AS Count
FROM supermarket_sales
GROUP BY Product_line
HAVING COUNT(*) > 50

--------------------------------------------------

Select rows from GlobalSharkAttack ordered by age DESC

SELECT *
FROM GlobalSharkAttack
ORDER BY AGE DESC

---------------------------------------------------

Select TOP 10 reviews from BA_AirlineReviews ordered by overall rating DESC.


SELECT TOP 10 *
FROM BA_AirlineReviews
ORDER BY overallrating DESC


