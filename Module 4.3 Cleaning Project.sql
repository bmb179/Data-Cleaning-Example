--Dataset location: https://archive.ics.uci.edu/ml/datasets/Automobile
--Project for Google Data Analytics Certificate, Course 4, Week 3, Hands-On Activity: Clean data using SQL
--Creating the table for import
CREATE TABLE auto_data (
    make varchar,
    fuel_type varchar,
    num_of_doors varchar,
    body_style varchar,
    drive_wheels varchar,
    engine_location varchar,
    wheel_base numeric,
    vehicle_length numeric,
    width numeric,
    height numeric,
    curb_weight numeric,
    engine_type varchar,
    num_of_cylinders varchar,
    engine_size numeric,
    fuel_system varchar,
    compression_ratio numeric,
    horsepower numeric,
    city_mpg numeric,
    highway_mpg numeric,
    price numeric);
--Normally, the NOT NULL constraint could be assigned to each column for checking for errors/omissions upon import.
--However, this was not included in the project because I already know nulls exist in this dataset.
--Many of the columns below were not included in the dataset because they would later be calculated using actuarial formulas. For these, I have annotated them as "NOT IN THE DATASET"

COPY auto_data
FROM 'C:\directory\auto_data.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM auto_data;

--1. symboling: -3, -2, -1, 0, 1, 2, 3. NOT IN THE DATASET

--2. normalized-losses: continuous from 65 to 256. NOT IN THE DATASET

--3. make: alfa-romero, audi, bmw, chevrolet, dodge, honda, isuzu, 
--jaguar, mazda, mercedes-benz, mercury, mitsubishi, nissan, peugot, 
--plymouth, porsche, renault, saab, subaru, toyota, volkswagen, volvo
SELECT DISTINCT make
FROM auto_data
ORDER BY make ASC;--all correct


--4. fuel-type: diesel, gas.
SELECT DISTINCT fuel_type
FROM auto_data;--all correct

--5. aspiration: std, turbo. NOT IN THE DATASET

--6. num-of-doors: four, two.
SELECT *
FROM auto_data
WHERE num_of_doors IS NULL; --Two nulls found to be corrected with UPDATE statements

UPDATE auto_data
SET num_of_doors = 'four'
WHERE make = 'dodge'
  AND fuel_type = 'gas'
  AND body_style = 'sedan';
  
UPDATE auto_data
SET num_of_doors = 'four'
WHERE make = 'mazda'
  AND fuel_type = 'diesel'
  AND body_style = 'sedan';

--7. body-style: hardtop, wagon, sedan, hatchback, convertible.
SELECT DISTINCT body_style
FROM auto_data;--all correct

--8. drive-wheels: 4wd, fwd, rwd.
SELECT DISTINCT drive_wheels
FROM auto_data; --2 4wd entries, one has a trailing space

SELECT DISTINCT drive_wheels, LENGTH(drive_wheels) AS string_length
FROM auto_data;

UPDATE auto_data
SET drive_wheels = TRIM(drive_wheels)
WHERE TRUE;--trimming excess spaces

--9. engine-location: front, rear.
SELECT DISTINCT engine_location
FROM auto_data;--all correct

--10. wheel-base: continuous from 86.6 120.9.
SELECT MIN(wheel_base), MAX(wheel_base)
FROM auto_data;--all correct

--11. length: continuous from 141.1 to 208.1.
SELECT MIN(vehicle_length) AS min_length, MAX(vehicle_length) AS max_length
FROM auto_data;--all correct

--12. width: continuous from 60.3 to 72.3.
SELECT MIN(width) AS min_width, MAX(width) AS max_width
FROM auto_data;--all correct

--13. height: continuous from 47.8 to 59.8.
SELECT MIN(height) AS min_height, MAX(height) AS max_height
FROM auto_data;--all correct

--14. curb-weight: continuous from 1488 to 4066.
SELECT MIN(curb_weight) AS min_curb_weight, MAX(curb_weight) AS max_curb_weight
FROM auto_data;--all correct

--15. engine-type: dohc, dohcv, l, ohc, ohcf, ohcv, rotor.
SELECT DISTINCT engine_type
FROM auto_data;--all correct

--16. num-of-cylinders: eight, five, four, six, three, twelve, two.
SELECT DISTINCT num_of_cylinders
FROM auto_data; --tow instead of two

UPDATE auto_data
SET num_of_cylinders = 'two'
WHERE num_of_cylinders = 'tow'; --updating typo

--17. engine-size: continuous from 61 to 326.
SELECT MIN(engine_size) AS min_engine_size, MAX(engine_size) AS max_engine_size
FROM auto_data;--all correct

--18. fuel-system: 1bbl, 2bbl, 4bbl, idi, mfi, mpfi, spdi, spfi.
SELECT DISTINCT fuel_system
FROM auto_data;--all correct

--19. bore: continuous from 2.54 to 3.94. NOT IN THE DATASET

--20. stroke: continuous from 2.07 to 4.17. NOT IN THE DATASET

--21. compression-ratio: continuous from 7 to 23.
SELECT MIN(compression_ratio) AS min_compression_ratio, MAX(compression_ratio) AS max_compression_ratio
FROM auto_data;--Max should be 23, not 70

SELECT MIN(compression_ratio) AS min_compression_ratio, MAX(compression_ratio) AS max_compression_ratio
FROM auto_data
WHERE compression_ratio <> 70; --70 entered by error, skips from the max of 23 to 70

SELECT COUNT(*) AS num_of_rows_to_delete
FROM auto_data
WHERE compression_ratio = 70; --Only one row, assignment prompts to delete the row with the erroneous compression ratio

DELETE FROM auto_data
WHERE compression_ratio = 70; --Erroneous row deleted, BigQuery syntax called for in the assignment is slightly different for this query

--22. horsepower: continuous from 48 to 288.
SELECT MIN(horsepower), MAX(horsepower)
FROM auto_data;--all correct

--23. peak-rpm: continuous from 4150 to 6600. NOT IN THE DATASET

--24. city-mpg: continuous from 13 to 49.
SELECT MIN(city_mpg), MAX(city_mpg)
FROM auto_data;--all correct

--25. highway-mpg: continuous from 16 to 54.
SELECT MIN(highway_mpg), MAX(highway_mpg)
FROM auto_data;--all correct

--26. price: continuous from 5118 to 45400.
SELECT MAX(price) AS max_price, MIN(price) AS min_price
FROM auto_data;
--There should not be $0 prices
SELECT *
FROM auto_data
WHERE price < 5118;
--found and deleting erroneous entries as instructed to earlier in the prompts
DELETE FROM auto_data
WHERE price < 5118;
--Google assignment prompt: What is the max price value?
--Answer: Max price is $45,400





