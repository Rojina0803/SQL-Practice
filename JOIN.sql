-- JOINS

-- INNER JOIN
 select *
 from employee_demographics;
 
 select *
 from employee_salary;
 
select *
from employee_demographics
INNER JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
;

select *
from employee_demographics as dem
INNER JOIN employee_salary as sal -- aliasing
	ON dem.employee_id = sal.employee_id
;

select  dem.employee_id,age, occupation
from employee_demographics as dem
INNER JOIN employee_salary as sal -- aliasing
	ON dem.employee_id = sal.employee_id
;


-- OUTER JOINS
select *
from employee_demographics as dem -- LEFT TABLE
LEFT OUTER JOIN employee_salary as sal -- RIGHT TABLE
	ON dem.employee_id = sal.employee_id
;

select  *
from employee_demographics as dem 
RIGHT OUTER JOIN employee_salary as sal 
	ON dem.employee_id = sal.employee_id
;

-- SELF JOINS
select  emp1.employee_id as emp_santa,
emp1.first_name AS emp_first_name_santa,
emp1.last_name AS emp_last_name_santa,

emp2.employee_id as emp_name,
emp2.first_name AS emp_first_name,
emp2.last_name AS emp_last_name
from employee_salary as emp1
join employee_salary as emp2
	on  emp1.employee_id + 1 = emp2.employee_id
;

-- Joining multiple tables together
select *
from employee_demographics as dem
INNER JOIN employee_salary as sal 
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments  pd
	ON sal.dept_id= pd.department_id
;



select *
from parks_departments
;