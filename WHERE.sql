-- WHERE CLAUSE


SELECT *
from employee_salary
where first_name= 'Leslie'
;

SELECT *
from employee_salary
where salary> 50000
;

SELECT *
from employee_salary
where salary>=50000
;

SELECT *
from employee_salary
where salary<=50000
;

SELECT *
from employee_demographics
where gender= 'Female'
;

SELECT *
from employee_demographics
where birth_date > '1985-01-01' -- Year/Month/Date
;

-- AND OR NOT LOGICAL OPERATORS
SELECT *
from employee_demographics
where birth_date > '1985-01-01' 
and gender='Male'
;
SELECT *
from employee_demographics
where birth_date > '1985-01-01' 
OR  NOT gender='Male'
;

SELECT *
from employee_demographics
where first_name= 'Leslie' and age='44'
;

SELECT *
from employee_demographics
where (first_name= 'Leslie' and age='44') OR age>55
;

-- LIKE STATEMENT
-- % and _
SELECT *
from employee_demographics
where first_name LIKE 'Jer%'
;

SELECT *
from employee_demographics
where first_name LIKE '%er%'
;

SELECT *
from employee_demographics
where first_name LIKE 'a%'
;

SELECT *
from employee_demographics
where first_name LIKE 'a___%'
;

SELECT *
from employee_demographics
where birth_date LIKE '1989%'
;