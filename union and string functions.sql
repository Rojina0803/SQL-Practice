-- UNIONS
SELECT first_name, last_name
from employee_demographics
UNION 
SELECT  first_name, last_name
from employee_salary
;

SELECT first_name, last_name
from employee_demographics
UNION distinct
SELECT  first_name, last_name
from employee_salary
;

SELECT first_name, last_name
from employee_demographics
UNION ALL 
SELECT  first_name, last_name
from employee_salary
;

SElECT first_name, last_name, 'Old Man' AS Label
from employee_demographics
where age> 40 AND gender ='Male'
UNION
SElECT first_name, last_name, 'Old lady' AS Label
from employee_demographics
where age> 40 AND gender ='Female'

UNION
SElECT first_name, last_name, 'HIGHLY PAID EMPLOYEE' AS Label
from employee_salary
WHERE salary> 70000
ORDER BY first_name, last_name
;

-- STRING FUNCTIONS
SELECT length('skyfall')
;

SELECT first_name,length(first_name)
FROM employee_demographics
ORDER BY 2
;

SELECT UPPER ('sky');
SELECT UPPER ('SKYFALL');

SELECT first_name,UPPER(first_name) -- LOWER CAN BE USED AS WELL
FROM employee_demographics
;

SELECT  TRIM('       SKY       ');
-- SELECT  ('       SKY       ');

SELECT  LTRIM('       SKY       ');
SELECT  RTRIM('       SKY       ');

SELECT first_name, LEFT(first_name,4)
FROM employee_demographics
;

SELECT first_name, RIGHT(first_name,4)
FROM employee_demographics;

