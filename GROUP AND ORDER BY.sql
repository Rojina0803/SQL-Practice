-- group by

SELECT *
from employee_demographics;

SELECT gender
FROM employee_demographics
group by gender
;

SELECT gender, avg(age)
FROM employee_demographics
group by gender
;

SELECT gender,AVG(age), max(age), min(age),count(age)
FROM employee_demographics
group by gender
;

-- order by
SELECT *
FROM employee_demographics
order by first_name DESC;

SELECT *
FROM employee_demographics
order by gender,
age desc;

SELECT *
FROM employee_demographics
order by 5,4 asc; -- not a best practice.


