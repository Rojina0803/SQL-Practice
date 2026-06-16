-- WINDOW FUNCTIONS

SELECT gender, avg(salary)
FROM employee_demographics dem
	JOIN employee_salary sal
		ON dem.employee_id= sal.employee_id
	GROUP BY gender
;

SELECT
dem.first_name,
dem.last_name,
avg(salary)
	OVER(PARTITION BY gender)
FROM employee_demographics dem
	JOIN employee_salary sal
		ON dem.employee_id= sal.employee_id
	
;

SELECT
dem.first_name,
dem.last_name, salary,
SUM(salary)
	OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_total
FROM employee_demographics dem
	JOIN employee_salary sal
		ON dem.employee_id= sal.employee_id
	
;

-- ROW NUMBER

SELECT
dem.employee_id,
dem.first_name,
dem.last_name, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC)AS row_num,
RANK() OVER (PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER (PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
	JOIN employee_salary sal
		ON dem.employee_id= sal.employee_id
	
;

-- CTES
WITH CTE_Example AS(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id= sal.employee_id
GROUP BY gender
		)
SELECT AVG(avg_sal)
FROM CTE_Example
        
;

-- Using subquery instead of CTE
SELECT AVG(avg_sal)
from(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id= sal.employee_id
GROUP BY gender
		) example_subq;
        

-- creating multiple CTES

WITH CTE_Example AS (
    SELECT
        employee_id,
        gender,
        birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS (
    SELECT
        employee_id
    FROM employee_salary
    WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
    ON CTE_Example.employee_id = CTE_Example2.employee_id
;

-- TEMPORARY TABLES : ONLY VISIBLE TO THE SESSION THEY ARE CREATED IN..


-- (METHOD-1)
CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favourite_movie varchar(100)

);


SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES('RIRI','DIAZ','LA LA LAND');

SELECT *
FROM temp_table;

        
-- (METHOD-2)

SELECT *
FROM employee_salary;

CREATE TEMPORARY TABLE  salary_over_50k
SELECT *
FROM employee_salary
WHERE salary>= 50000;

SELECT *
FROM salary_over_50k;



-- STORED PROCEDURES
SELECT *
FROM employee_salary
	WHERE salary>= 50000
;

CREATE PROCEDURE  large_salaries1()
SELECT *
FROM employee_salary
	WHERE salary>= 50000
;

CALL large_salaries();

DELIMITER $$
CREATE PROCEDURE  large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
		WHERE salary>= 50000;
	SELECT *
	FROM employee_salary
		WHERE salary>= 10000;
END $$

DELIMITER ;

CALL large_salaries3();



DELIMITER $$
CREATE PROCEDURE  large_salary(p_employee_id INT)
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = p_employee_id
        ;
END $$

DELIMITER ;

CALL large_salary(1);

-- TRIGGERS AND EVENTS
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;


DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
		INSERT INTO employee_demographics(employee_id,first_name,last_name)
        VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

DELIMITER ;

INSERT INTO employee_salary (employee_id,first_name,last_name,occupation,salary,dept_id)
VALUES (14,'Jean-Raphino','Saperstine','Entertainment 720 CEO',1000000,NULL);

SET SQL_SAFE_UPDATES = 0;

DELETE FROM employee_salary
WHERE employee_id = 14;

DELETE FROM employee_demographics
WHERE employee_id = 14;

SET SQL_SAFE_UPDATES = 1;
-- i made a mistake lol



SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics;

-- EVENTS (SCHEDULED AUTOMATOR)

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT retirement_plan
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age>= 60;

END $$
DELIMITER ;

SELECT *
FROM employee_demographics;

-- SHOW VARIABLES LIKE '%event%' (if it didnt work)






