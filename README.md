# SQL Queries for Employee Database

This repository contains 30 unique SQL queries designed to interact with an employee database schema. These queries cover various operations, including retrieving employee details, department information, salary data, and job titles. Each query is crafted to provide meaningful insights into the database.

## Sample Database

The queries in this repository are designed to work with the sample employee database provided by [DataCharmer](https://github.com/datacharmer/test_db). You can find the database schema and data here:

[Employee Sample Database - GitHub](https://github.com/datacharmer/test_db/tree/master)

## SQL Questions and Queries

### 1. List all employees' full names and their current department names.
```sql
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01';






```
1. List all employees' full names and their current department names.
```sql

SELECT e.first_name, e.Last_name, CONCAT(e.first_name, " ", e.last_name) as Full_name ,de.to_date, d.dept_name
FROM employees  e
JOIN dept_emp de on e.emp_no = de.emp_no
JOIN departments d on de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
-- if to_date year is 9999 then they are still active in that dept
ORDER BY to_date asc;


```
2. Find the titles of employees currently working in the 'Sales' department.
```sql
SELECT t.title, CONCAT(e.first_name, e.Last_name) as full_name, d.dept_name
FROM employees e
JOIN dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
JOIN titles t on e.emp_no = t.emp_no
WHERE d.dept_name = 'Sales'
and de.to_date = '9999-01-01' and t.to_date = '9999-01-01';
```
3. Retrieve the employee number and salary of the highest-paid employee.
```sql
SELECT s.emp_no, s.salary FROM salaries as s WHERE salary = (SELECT MAX(salary) from salaries)


   --easy method
SELECT s.emp_no, s.salary from salaries s ORDER BY salary desc LIMIT 1;





```
4. List the departments with more than 30000 employees.
```sql
SELECT d.dept_name, COUNT(de.emp_no) as total_emp from dept_emp as de
JOIN departments as d ON de.dept_no = d.dept_no
GROUP BY de.dept_no
HAVING total_emp > 30000;
--method 2
SELECT d.dept_name, COUNT(de.emp_no) AS emp_count
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
GROUP BY d.dept_name
HAVING COUNT(de.emp_no) > 30000;

```
5. Find the average salary for each department.
```sql
SELECT d.dept_name,ROUND(AVG(s.salary)) as Avg_salary from departments as d
JOIN dept_emp as de ON d.dept_no = de.dept_no
JOIN salaries as s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name;

```
6. List the employees who have held more than one title.
```
SELECT e.emp_no, CONCAT(e.first_name,' ',e.Last_name) as Full_name, COUNT(t.title) as no_of_title from employees e
JOIN titles t on e.emp_no = t.emp_no
GROUP BY e.emp_no, Full_name
HAVING no_of_title > 1
ORDER BY COUNT(t.title) desc

```
7. Find the employee(s) who have been with the company the longest.
```
SELECT * from employees
ORDER BY hire_date asc
LIMIT 1;

```
8. Retrieve the full names of employees managed by a specific manager (e.g., emp_no = 10002).
```
SELECT e.emp_no, CONCAT(e.first_name,' ',e.last_name) as full_name, de.dept_no from employees e
join dept_emp de on e.emp_no = de.emp_no
JOIN dept_manager dm ON de.dept_no=dm.dept_no
WHERE dm.emp_no = '111035'
ORDER BY e.emp_no AND de.to_date = '9999-01-01';


-- CTE method to add manager name
WITH aa as(
SELECT e.emp_no, CONCAT(e.first_name,' ',e.last_name) as full_name, de.dept_no, dm.emp_no as manager_emp_no from employees e
join dept_emp de on e.emp_no = de.emp_no
JOIN dept_manager dm ON de.dept_no=dm.dept_no
WHERE dm.emp_no = '111035'
ORDER BY e.emp_no AND de.to_date = '9999-01-01'
)
SELECT aa.emp_no, aa.full_name, aa.dept_no, e.first_name as manager_name from aa
JOIN employees e ON aa.manager_emp_no=e.emp_no

```
9. List all the employees who were hired in 1995.
```

SELECT * from employees
WHERE YEAR(hire_date) = '1995';

```
10. Find the department(s) with the lowest average salary.
```

SELECT d.dept_no, d.dept_name, ROUND(AVG(s.salary)) as Avg_salary from departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN salaries s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_no, d.dept_name
ORDER BY Avg_salary asc
limit 1;

```
11. Retrieve the number of employees in each department who hold the title 'Engineer'.
```

SELECT d.dept_name, COUNT(t.title) as Total_Engineer from departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN titles t ON de.emp_no = t.emp_no
WHERE t.title = 'Engineer' AND de.to_date = '9999-01-01'
GROUP BY d.dept_name;

```
12. List all employees who have never been managers.
```
SELECT e.emp_no,e.first_name,dm.emp_no from employees e
LEFT JOIN dept_manager dm on e.emp_no = dm.emp_no
WHERE dm.emp_no is NULL;

```
13. Find the average salary of employees with the title 'Senior Engineer'.
```
SELECT t.title, AVG(s.salary) from employees e
JOIN titles t on e.emp_no = t.emp_no
JOIN salaries s on e.emp_no = s.emp_no
WHERE t.title = 'Senior Engineer' AND s.to_date = '9999-01-01'
GROUP BY title;

```
14. List employees who have worked in more than one department.
```
SELECT e.emp_no, e.first_name, COUNT(de.dept_no) as no_of_dept from employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
GROUP BY e.emp_no, e.first_name
HAVING no_of_dept > 1;
-- Simple one
SELECT de.emp_no, COUNT(de.emp_no) from dept_emp de
GROUP BY de.emp_no HAVING COUNT(de.emp_no) > 1;

```
15. Find the most common title in the company.
```
SELECT t.title, COUNT(emp_no) as total_emp from titles t
GROUP BY t.title
ORDER BY total_emp DESC
LIMIT 1;
```

16. Retrieve the total number of employees who have left the company (i.e., have an end date in salaries or dept_emp).
```
SELECT COUNT(DISTINCT emp_no) AS employees_left from dept_emp
WHERE to_date <> '9999-01-01';

```
17. List the departments and their corresponding managers' full names.
```
SELECT d.dept_name, dm.emp_no, e.first_name from departments d
JOIN dept_manager dm on d.dept_no = dm.dept_no
JOIN employees e on dm.emp_no = e.emp_no
---- add this is you want current managers
WHERE dm.to_date = '9999-01-01';



```

18. Find all female employees who have been with the company for over 10 years.
```
SELECT e.emp_no, e.first_name as total_days from employees e
WHERE e.gender = 'F' and DATEDIFF(CURRENT_DATE, e.hire_date) > 3650;

```
19. Retrieve the highest salary for each department.
```
SELECT d.dept_name, MAX(s.salary) as Max_salary from departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no=s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name;

```
20. List the employees who have changed their title more than twice.
```
SELECT e.emp_no, e.first_name, e.last_name, COUNT(t.title) as total_title from employees e
JOIN titles t on e.emp_no = t.emp_no
GROUP by e.emp_no, e.first_name, e.last_name
HAVING total_title > 2;

```
21. Find the department with the highest employee retention rate.
```
SELECT d.dept_name, COUNT(de.emp_no) as retention_count FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY retention_count DESC
LIMIT 1;

```
22. Retrieve all employees who earn more than the average salary in their department.
```
with avg as (
SELECT d.dept_no, d.dept_name, AVG(s.salary)as avg_dept_sal from departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN salaries s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_no,dept_name
),
emp as (
SELECT e.emp_no, e.last_name, s.salary, de.dept_no from employees e
JOIN salaries s on e.emp_no = s.emp_no
JOIN dept_emp de on e.emp_no = de.emp_no
WHERE s.to_date = '9999-01-01'
)
SELECT emp.emp_no, emp.last_name,emp.salary, emp.dept_no, avg.avg_dept_sal from emp
JOIN avg on emp.dept_no = avg.dept_no
WHERE emp.salary > avg.avg_dept_sal;

Method 2 

----- Methos 2
WITH AvgSalaryPerDept AS (
   SELECT d.dept_no, AVG(s.salary) AS avg_salary
   FROM departments d
   JOIN dept_emp de ON d.dept_no = de.dept_no
   JOIN salaries s ON de.emp_no = s.emp_no
   WHERE s.to_date = '9999-01-01'
   GROUP BY d.dept_no
)
SELECT e.emp_no, e.first_name, e.last_name, s.salary, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN AvgSalaryPerDept a ON de.dept_no = a.dept_no
WHERE s.salary > a.avg_salary AND s.to_date = '9999-01-01';


Method 3 

----- Methos 3
SELECT e.emp_no, e.first_name, e.last_name, s.salary, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN (
   SELECT d.dept_no, AVG(s.salary) AS avg_salary
   FROM departments d
   JOIN dept_emp de ON d.dept_no = de.dept_no
   JOIN salaries s ON de.emp_no = s.emp_no
   WHERE s.to_date = '9999-01-01'
   GROUP BY d.dept_no) as a ON de.dept_no = a.dept_no
WHERE s.salary > a.avg_salary AND s.to_date = '9999-01-01';

```

23. List the total salary expenditure per department.
```
SELECT d.dept_name, SUM(s.salary) as total_salary from departments d
JOIN dept_emp de ON d.dept_no=de.dept_no
JOIN salaries s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name;

```
24. Retrieve the gender distribution across all departments.
```
SELECT d.dept_name,e.gender,  COUNT(e.emp_no) as gender from departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e on de.emp_no = e.emp_no
GROUP BY d.dept_name, e.gender;

```

25. Find the difference between the highest and lowest salary in the company.
```
SELECT (max(s.salary) - min(s.salary)) as salary_difference from salaries s



```
26. List the employees with the most recent hire date.
```
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date from employees e
ORDER BY e.hire_date DESC
limit 1;

```
27. Find employees who have held a managerial position in more than one department.
```
SELECT emp_no, COUNT(dept_no) manager_count from dept_manager
GROUP BY emp_no
HAVING manager_count > 1;


-- Using employee Table
SELECT e.emp_no, e.first_name, e.last_name, COUNT(dm.dept_no) AS manager_count
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name
HAVING COUNT(dm.dept_no) > 1;



```
28. Retrieve the full name and salary of employees who earn more than their manager.
```
SELECT e.emp_no, CONCAT(e.first_name,' ', e.last_name)as full_name, s.salary from employees e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN dept_manager dm on de.dept_no = dm.dept_no
JOIN salaries ms on dm.emp_no = ms.emp_no and ms.to_date = '9999-01-01'
WHERE s.salary > ms.salary and s.to_date = '9999-01-01';

```
29. List the names of departments with no employees currently assigned.
```
SELECT d.dept_name from departments d
LEFT JOIN dept_emp de on d.dept_no = de.dept_no and de.to_date = '9999-01-01'
WHERE de.emp_no is not NULL;
```

30. Find the titles and the number of employees holding each title in the 'Research' department.
```
SELECT t.title, COUNT(t.emp_no) as total_emp , de.dept_no, d.dept_name from titles t
JOIN dept_emp de on t.emp_no = de.emp_no
JOIN departments d on de.dept_no = d.dept_no
WHERE d.dept_name = 'Research' and t.to_date = '9999-01-01'
GROUP BY t.title


