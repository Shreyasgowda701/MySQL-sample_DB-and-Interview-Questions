-- Active: 1721841987536@@127.0.0.1@3306@employees

-- Question 1
SELECT e.first_name, e.Last_name, CONCAT(e.first_name, " ", e.last_name) as Full_name ,de.to_date, d.dept_name
 FROM employees  e
 JOIN dept_emp de on e.emp_no = de.emp_no
 JOIN departments d on de.dept_no = d.dept_no
 WHERE de.to_date = '9999-01-01'
 -- if to_date year is 9999 then they are still active in that dept
 ORDER BY to_date asc;


-- Question 2
SELECT t.title, CONCAT(e.first_name, e.Last_name) as full_name, d.dept_name
 FROM employees e
 JOIN dept_emp de on e.emp_no = de.emp_no
 join departments d on de.dept_no = d.dept_no
JOIN titles t on e.emp_no = t.emp_no
 WHERE d.dept_name = 'Sales'
 and de.to_date = '9999-01-01' and t.to_date = '9999-01-01';


-- Question 3
SELECT s.emp_no, s.salary FROM salaries as s WHERE salary = (SELECT MAX(salary) from salaries)

    --easy method
SELECT s.emp_no, s.salary from salaries s ORDER BY salary desc LIMIT 1;


-- Question 4

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


-- Question 5
SELECT d.dept_name,ROUND(AVG(s.salary)) as Avg_salary from departments as d
JOIN dept_emp as de ON d.dept_no = de.dept_no
JOIN salaries as s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name;


-- Question 6
SELECT e.emp_no, CONCAT(e.first_name,' ',e.Last_name) as Full_name, COUNT(t.title) as no_of_title from employees e
JOIN titles t on e.emp_no = t.emp_no
GROUP BY e.emp_no, Full_name
HAVING no_of_title > 1
ORDER BY COUNT(t.title) desc

-- Question 7
SELECT * from employees 
ORDER BY hire_date asc
LIMIT 1;


-- Question 8
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

-- Question 9
SELECT * from employees
WHERE YEAR(hire_date) = '1995';

-- Question 10
SELECT d.dept_no, d.dept_name, ROUND(AVG(s.salary)) as Avg_salary from departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN salaries s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_no, d.dept_name
ORDER BY Avg_salary asc
limit 1;

-- Question 11
SELECT d.dept_name, COUNT(t.title) as Total_Engineer from departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN titles t ON de.emp_no = t.emp_no
WHERE t.title = 'Engineer' AND de.to_date = '9999-01-01'
GROUP BY d.dept_name;

-- Question 12
SELECT e.emp_no,e.first_name,dm.emp_no from employees e
LEFT JOIN dept_manager dm on e.emp_no = dm.emp_no
WHERE dm.emp_no is NULL;


-- Question 13
SELECT t.title, AVG(s.salary) from employees e
JOIN titles t on e.emp_no = t.emp_no
JOIN salaries s on e.emp_no = s.emp_no
WHERE t.title = 'Senior Engineer' AND s.to_date = '9999-01-01'
GROUP BY title;


-- Question 14
SELECT e.emp_no, e.first_name, COUNT(de.dept_no) as no_of_dept from employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
GROUP BY e.emp_no, e.first_name
HAVING no_of_dept > 1;
-- Simple one
SELECT de.emp_no, COUNT(de.emp_no) from dept_emp de
GROUP BY de.emp_no HAVING COUNT(de.emp_no) > 1;


-- Question 15
SELECT t.title, COUNT(emp_no) as total_emp from titles t
GROUP BY t.title
ORDER BY total_emp DESC
LIMIT 1;


-- Question 16
SELECT COUNT(DISTINCT emp_no) AS employees_left from dept_emp
WHERE to_date <> '9999-01-01';

-- Question 17
SELECT d.dept_name, dm.emp_no, e.first_name from departments d
JOIN dept_manager dm on d.dept_no = dm.dept_no
JOIN employees e on dm.emp_no = e.emp_no
---- add this is you want current managers
WHERE dm.to_date = '9999-01-01';


-- Question 18
SELECT e.emp_no, e.first_name as total_days from employees e
WHERE e.gender = 'F' and DATEDIFF(CURRENT_DATE, e.hire_date) > 3650;


-- Question 19
SELECT d.dept_name, MAX(s.salary) as Max_salary from departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no=s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name;

-- Question 20
SELECT e.emp_no, e.first_name, e.last_name, COUNT(t.title) as total_title from employees e
JOIN titles t on e.emp_no = t.emp_no
GROUP by e.emp_no, e.first_name, e.last_name
HAVING total_title > 2;


-- Question 21
SELECT d.dept_name, COUNT(de.emp_no) as retention_count FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY retention_count DESC
LIMIT 1;



-- Question 22
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


-- Question 23
SELECT d.dept_name, SUM(s.salary) as total_salary from departments d
JOIN dept_emp de ON d.dept_no=de.dept_no
JOIN salaries s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name;


-- Question 24
SELECT d.dept_name,e.gender,  COUNT(e.emp_no) as gender from departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e on de.emp_no = e.emp_no
GROUP BY d.dept_name, e.gender;


-- Question 25
SELECT (max(s.salary) - min(s.salary)) as salary_difference from salaries s


-- Question 26
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date from employees e
ORDER BY e.hire_date DESC
limit 1;


-- Question 27
SELECT emp_no, COUNT(dept_no) manager_count from dept_manager
GROUP BY emp_no
HAVING manager_count > 1;

-- Using employee Table
SELECT e.emp_no, e.first_name, e.last_name, COUNT(dm.dept_no) AS manager_count
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name
HAVING COUNT(dm.dept_no) > 1;


-- Question 28
SELECT e.emp_no, CONCAT(e.first_name,' ', e.last_name)as full_name, s.salary from employees e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN dept_manager dm on de.dept_no = dm.dept_no
JOIN salaries ms on dm.emp_no = ms.emp_no and ms.to_date = '9999-01-01'
WHERE s.salary > ms.salary and s.to_date = '9999-01-01';


-- Question 29
SELECT d.dept_name from departments d
LEFT JOIN dept_emp de on d.dept_no = de.dept_no and de.to_date = '9999-01-01'
WHERE de.emp_no is not NULL;


-- Question 30
SELECT t.title, COUNT(t.emp_no) as total_emp , de.dept_no, d.dept_name from titles t
JOIN dept_emp de on t.emp_no = de.emp_no
JOIN departments d on de.dept_no = d.dept_no
WHERE d.dept_name = 'Research' and t.to_date = '9999-01-01'
GROUP BY t.title