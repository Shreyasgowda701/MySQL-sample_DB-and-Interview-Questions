-- Active: 1721841987536@@127.0.0.1@3306@employees

-- Question 1
SELECT * from employees;

-- Question 2
SELECT first_name, Last_name from employees;


-- Question 3
SELECT emp_no, first_name , Last_name, hire_date from employees
where hire_date >= '2000-01-01';

-- Question 4
SELECT COUNT(dept_no) as total_departments from departments;

-- Question 5
SELECT DISTINCT(title) from titles;

-- Question 6
SELECT emp_no, first_name, last_name FROM employees
WHERE first_name = 'Georgy';

-- Question 7
SELECT emp_no, salary from salaries
WHERE salary > 60000;

-- Question 8
SELECT birth_date, gender from employees;

-- Question 9
SELECT dept_name from departments
ORDER BY dept_name asc;

-- Question 10
SELECT min(hire_date) earliest_hire_date from employees;

-- Question 11
SELECT last_name, hire_date from employees;

-- Question 12
SELECT dept_no, dept_name from departments;

-- Question 13
SELECT first_name, last_name, birth_date from employees
WHERE birth_date BETWEEN '1960-01-01' and '1969-12-31';

-- Question 14
SELECT COUNT(*) from employees;

-- Question 15
SELECT first_name, Last_name from employees
WHERE last_name = 'Erde';

-- Question 16
SELECT emp_no, title from titles;

-- Question 17
SELECT emp_no,first_name, last_name FROM employees
WHERE hire_date = '2000-01-01';

-- Question 18
SELECT DISTINCT(gender) from employees;

-- Question 19
SELECT MAX(salary) from salaries;

-- Question 20
SELECT COUNT(*) as total_employees_hired_before_1990 from employees
WHERE hire_date < '1990-01-01';