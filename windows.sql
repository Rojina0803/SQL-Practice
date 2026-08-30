-- window functions

SELECT *
FROM employee_demographics;

SELECT gender, AVG(salary) as avg_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
GROUP BY gender;
;


SELECT dem.first_name,dem.last_name, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
;


SELECT dem.first_name,dem.last_name,salary, SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
;


SELECT dem.employee_id ,dem.first_name,dem.last_name,gender,salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
;

SELECT 
    dem.employee_id,
    dem.first_name,
    dem.last_name,
    gender,
    salary,
    LAG(salary) OVER(
        PARTITION BY gender 
        ORDER BY salary DESC
    ) AS previous_salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;


SELECT 
    dem.employee_id,
    dem.first_name,
    dem.last_name,
    gender,
    salary,
    LEAD(salary) OVER(
        PARTITION BY gender 
        ORDER BY salary DESC
    ) AS next_salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;