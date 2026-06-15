-- SUBSTRING
SELECT first_name, LEFT(first_name,4)
FROM employee_demographics
;

SELECT first_name, RIGHT(first_name,4)
FROM employee_demographics;

SELECT
    first_name,
    LEFT(first_name, 4),
    RIGHT(first_name, 4),
    SUBSTRING(first_name, 3, 2),  /* column_name, position, length */
    birth_date,
    SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics;

-- REPLACE

SELECT first_name, REPLACE(first_name, 'a' ,'z') /* char to replace and the char to replace with */
FROM employee_demographics
;

-- LOCATE

SELECT LOCATE('x' , 'Alexander');

SELECT first_name, LOCATE ('An', first_name)
FROM employee_demographics
;

-- CONCAT

SELECT first_name, last_name,
	CONCAT(first_name,'   ', last_name) AS full_name
FROM employee_demographics
;

-- CASE STATEMENTS

SELECT
first_name,
last_name,
age,
CASE
	WHEN age<=30 THEN 'YOUNG'
	WHEN age BETWEEN 31 AND 50 THEN 'OLD'
    WHEN age>= 50 THEN 'GOOD NIGHT'
END AS age_bracket
FROM employee_demographics
;

-- PAY INCR4EASE AND BONUS
-- <50000 = 5%
-- >50000= 7%
-- FINANCE= 10% BONUS


SELECT first_name, last_name, salary,
CASE
	WHEN salary<50000 THEN salary * 1.05
    WHEN salary>50000 THEN salary * 1.07

    
END as new_salary,
CASE
	WHEN dept_id=6 THEN salary * .10
END as BONUS
FROM employee_salary
;

-- SUB QUERIES
SELECT *
FROM employee_demographics
	WHERE employee_id IN (
    SELECT employee_id 
		FROM employee_salary
		WHERE dept_id= 1)
;


SELECT first_name, last_name ,salary , 
(SELECT
AVG(salary) FROM employee_salary)
FROM employee_salary;

SELECT gender, AVG(age), MAX(age),MIN(age),COUNT(age)
FROM employee_demographics
group by gender;


SELECT  AVG(avg_age), AVG(max_age), AVG(min_age)
FROM (
    SELECT gender,
           AVG(age) AS avg_age,
           MAX(age) AS max_age,
           MIN(age) AS min_age,
           COUNT(age)
    FROM employee_demographics
    GROUP BY gender
) AS agg_table;


