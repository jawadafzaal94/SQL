SELECT 
 E.ID,
 E.Employeename, 
 G.Gender
FROM tblEmployee E
INNER JOIN tblGender G
        ON E.GenderID=G.ID

----------------------------------


SELECT 
  F.title,
  A.first_name,
  A.last_name
FROM film F
INNER JOIN film_actor FA
        ON F.film_id = FA.film_id
INNER JOIN actor A
        ON FA.actor_id = A.actor_id

---------------------------------------

SELECT 
  F.title,
  C.name
FROM film F
INNER JOIN film_category FC
        ON F.film_id = FC.film_id
INNER JOIN category C
        ON FC.category_id = C.category_id

---------------------------

SELECT 
  F.title AS title ,
  L.Name AS Name
FROM film F
INNER JOIN Language L
        ON F.language_id = L.language_id



SELECT 
  F.title AS filmtitle,
  A.first_name,
  A.last_name,
  C.name AS categoryname,
  L.Name AS Name
FROM film F
INNER JOIN film_actor FA
        ON F.film_id = FA.film_id
INNER JOIN actor A
        ON FA.actor_id = A.actor_id
INNER JOIN Language L
        ON F.language_id = L.language_id
INNER JOIN category C
        ON F.category_id = C.category_id


SELECT 
  F.title,
  A.first_name,
  A.last_name,
  L.Name AS languageName,
  C.name AS categoryname
FROM film F
INNER JOIN film_actor FA
        ON F.film_id = FA.film_id
INNER JOIN actor A
        ON FA.actor_id = A.actor_id
INNER JOIN Language L
        ON F.language_id = L.language_id
INNER JOIN Film_category FC
        ON F.film_id = FC.film_id
INNER JOIN category C
        ON FC.category_id = C.category_id

-----------


SELECT 
 E.EmployeeName, 
 D.Departmentname
FROM tblEmployee E
LEFT JOIN tblDepartment D 
       ON E.DEPARTMENTID = D.ID

----------------------------------------

SELECT 
 E.EmployeeName,
 DE.Designation
FROM tblEmployee E
LEFT JOIN tblDesignation DE
       ON E.DEPARTMENTID = DE.DesignationID

---------------------------------------


SELECT *
FROM Globalsharkattack


----------------------------------------

SELECT GETDATE() AS DATE

--------------------------------

SELECT CONVERT(INT,GETDATE()- '1947-08-14')AS Days

-----------------------

SELECT CONVERT(DATE,'1947-08-14')AS Date

------------------

SELECT DATEADD(Month, 3, '2026-01-10')AS Date

---------------------------------------------------

SELECT TRY_CONVERT (Date, [DATE]) FROM Globalsharkattack

SELECT TRY_CONVERT(INT,GETDATE()- '1947-08-14')AS Days
