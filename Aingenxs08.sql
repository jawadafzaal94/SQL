SELECT * 
FROM OLX_CARS

-- * - All columns

SELECT Car_name, Make 
FROM OLX_CARS

SELECT TOP 10 * 
FROM OLX_CARS

-- Make = Suzuki
SELECT * 
FROM OLX_CARS
	WHERE Make='Suzuki'

	Select * 
From OLX_CARS 
WHERE KM_s_driven<30000

-- AND
-- SUZUKI < 30000

SELECT *
FROM OLX_CARS�
WHERE MAKE = 'Suzuki'
     AND KM_s_driveN < 30000

select * from OLX_CARS 
WHERE (Make = 'suzuki' 
	AND KM_s_driven < 30000 and Registration_city = 'punjab') or (Make = 'toyota' and KM_s_driven < 30000 and Registration_city = 'sindh')


SELECT * 
FROM OLX_CARS AS OC
WHERE (OC.Make = 'Kia' OR OC.Make = 'Suzuki')




SELECT TOP 10 * FROM
	OLX_CARS
	WHERE MAKE = 'SUZUKI'
		 OR MAKE = 'KIA'
		 OR MAKE = 'TOYOTA'


SELECT TOP 10 * 
FROM OLX_CARS
WHERE MAKE NOT IN ('SUZUKI','KIA','TOYOTA');

--	2015, 2016, 2020 using in

SELECT  * 
FROM OLX_CARS 
WHERE YEAR NOT IN ('2015', '2016', '2020')

SELECT TOP 10 * FROM
	OLX_CARS
	ORDER BY PRICE --DESC

	-- Ascending
	-- Descending

select * from
	OLX_CARS
	ORDER BY Registration_city, Price

	select * from 
		OLX_CARS 
		WHERE Year in (2015 , 2016, 2020) 
    ORDER BY year desc

	select * from 
		OLX_CARS 
		WHERE Year in (2011, 2012, 2013, 2014, 2015 , 2016, 2020)

  
SELECT * 
FROM OLX_CARS
	WHERE YEAR BETWEEN 2011 
  AND 2020
  
SELECT*
FROM OLX_CARS AS OC
WHERE OC.Car_NAME LIKE  '%GOOD CONDITION%'

-- CAR_NAME GOOD CONDITION

-- ANYGRAVITY - GOOGLE
-- CURSOR - CURSOR
