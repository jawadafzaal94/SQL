SELECT 
    NAME, 
    POPULATION
FROM CITY
WHERE POPULATION = (SELECT MAX(POPULATION) FROM CITY)
   OR POPULATION = (SELECT MIN(POPULATION) FROM CITY)

--------------------------------------

// Query the difference between the maximum and minimum populations in CITY.

SELECT 
MAX(POPULATION) - MIN(POPULATION)
FROM CITY

--------------------------------------------

// Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

// Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

SELECT 
    CEIL(AVG(Salary) - AVG(REPLACE(Salary, '0', '')))
FROM EMPLOYEES

------------------------------------------

// We define an employee's total earnings to be their monthly salary x monthly worked, 
// and the maximum total earnings to be the maximum total earnings for any employee in 
// the Employee table. Write a query to find the maximum total earnings for all employees 
// as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.


SELECT 
    Max(salary * months),
    COUNT(*)
FROM Employee
WHERE (salary * months) = (SELECT Max(salary * months) FROM Employee)




  

