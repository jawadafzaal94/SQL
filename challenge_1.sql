-- Ch 1 
-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates

SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT LIKE 'A%' 
  AND CITY NOT LIKE 'E%' 
  AND CITY NOT LIKE 'I%' 
  AND CITY NOT LIKE 'O%' 
  AND CITY NOT LIKE 'U%'
  AND CITY NOT LIKE '%a'
  AND CITY NOT LIKE '%e'
  AND CITY NOT LIKE '%i'
  AND CITY NOT LIKE '%o'
  AND CITY NOT LIKE '%u'



-- SELECT DISTINCT CITY
-- FROM STATION
-- WHERE CITY REGEXP '^[^aeiouAEIOU].*[^aeiouAEIOU]$'

 -- Ch 2 
  
  
  -- Min & Max Value 

(
    SELECT 
        MAX(population) AS max_population
    FROM country
)
UNION ALL
(
    SELECT 
        MIN(population) AS min_population
    FROM country
)




