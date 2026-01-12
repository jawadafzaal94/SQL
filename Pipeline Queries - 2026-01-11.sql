select * into olx_cars_pipeline
	from OLX_CARS

--drop car_profile
--from olx_cars

alter table olx_cars_pipeline drop column car_profile

select * from olx_cars_pipeline where description is null

delete from olx_cars_pipeline where description is null

alter table olx_cars_pipeline
add seller_city varchar(255)

update olx_cars_pipeline
set seller_city = substring(seller_location, charindex(',',seller_location)+1, 100)

SELECT *FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTSWHERE TABLE_NAME = 'olx_cars'order by table_name
