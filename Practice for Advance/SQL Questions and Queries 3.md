## SQL Questions and Queries 3

### 1. Calculate the running total of salaries for each employee.
```sql
SELECT emp_no, salary, SUM(salary) OVER (PARTITION BY emp_no ORDER BY from_date) as running_total
from salaries;

```
### 2. List employees' salaries with an additional column indicating whether they are above or below the average salary.
```sql
SELECT emp_no, salary ,
CASE
   WHEN salary > ( SELECT AVG(salary) from salaries) THEN  "Above Average"
   ELSE  "Below Average"
END as salary_level
From salaries
WHERE to_date = '9999-01-01';

```
### 3. Retrieve the highest salary for each department, along with the corresponding employee details.
```sql
WITH DeptHighestSalaries AS (
   SELECT de.dept_no, MAX(s.salary) AS highest_salary
   FROM dept_emp de
   JOIN salaries s ON de.emp_no = s.emp_no
   WHERE s.to_date = '9999-01-01'
   GROUP BY de.dept_no
)
SELECT d.dept_name, e.emp_no, e.first_name, e.last_name, dhs.highest_salary
FROM DeptHighestSalaries dhs
JOIN dept_emp de ON dhs.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no AND s.salary = dhs.highest_salary
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON dhs.dept_no = d.dept_no
WHERE s.to_date = '9999-01-01';

  ```
  #### Method-2
  ```sql
with aa as(
SELECT d.dept_name, s.emp_no, e.first_name , e.last_name, s.salary , de.dept_no from salaries s
JOIN dept_emp de on s.emp_no = de.emp_no
JOIN departments d on de.dept_no = d.dept_no
JOIN employees e on de.emp_no = e.emp_no
WHERE s.to_date = '9999-01-01'
),
rank_salary as(
   SELECT aa.dept_name, aa.emp_no, aa.salary, aa.dept_no, aa.first_name, aa.last_name
, ROW_NUMBER() OVER (PARTITION BY aa.dept_no ORDER BY aa.salary DESC) as rank_salary from aa
)
SELECT  rs.dept_name, rs.emp_no, rs.first_name, rs.last_name, rs.salary from rank_salary rs
WHERE rank_salary = 1;

```
### 4. Find the difference in days between each employee's hire date and the current date.
```sql
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date
, DATEDIFF(CURRENT_DATE(), e.hire_date) as days_with_company from employees e;

```
### 5. List employees who have had more than one job title at the same time using a self-join.
```sql
SELECT t1.emp_no, t1.title AS title1, t2.title AS title2, t1.from_date, t1.to_date
FROM titles t1
JOIN titles t2 ON t1.emp_no = t2.emp_no AND t1.title != t2.title
WHERE t1.from_date <= t2.to_date AND t2.from_date <= t1.to_date;

```
### 6. Retrieve employees who have worked in more than one department using a HAVING clause.
```sql
SELECT e.emp_no, e.first_name, e.last_name, COUNT(DISTINCT de.dept_no) as total_dept from employees e
JOIN dept_emp de on e.emp_no = de.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name
HAVING total_dept > 1;

```
### 7. Calculate the percentage of total salaries for each department.
```sql
SELECT d.dept_name, sum(s.salary) as dept_salary,
sum(s.salary) * 100 / (SELECT sum(ss.salary) from salaries ss WHERE ss.to_date = '9999-01-01') as salary
from departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN salaries s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' and de.to_date = '9999-01-01'
GROUP BY d.dept_name;

```
### 8. Find the second highest salary in the company.
```sql
SELECT DISTINCT salary from salaries
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

```
#### Method-2
```sql
with ss as (
SELECT  salary, ROW_NUMBER() OVER(ORDER BY sub.salary DESC ) as Salary_rank from (SELECT DISTINCT(salary) as salary from salaries) as sub
)
SELECT * from ss
WHERE Salary_rank = '2';

```
### 9. Retrieve the employee(s) with the longest duration in the same department.
```sql
SELECT e.emp_no, e.first_name,de.from_date, e.last_name, d.dept_name,
      DATEDIFF(de.to_date, de.from_date) AS duration_days
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
ORDER BY duration_days DESC
LIMIT 1;

```
### 10. Use a window function to rank employees by their salary within each department.
```sql
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name , s.salary ,
RANK() OVER (PARTITION BY de.dept_no ORDER BY s.salary) as salary_rank
from employees e
JOIN dept_emp as de on e.emp_no = de.emp_no
JOIN departments d on de.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'

```
### 11. Find the average salary for each department, but only include departments with more than 10 employees.
```sql
SELECT d.dept_no, d.dept_name, AVG(s.salary) FROM departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN salaries s on de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_no, d.dept_name
HAVING COUNT(de.emp_no) > 10;

```
### 12. Identify employees whose salaries have increased over time.
```sql
SELECT s.emp_no, MIN(s.salary) as starting_salary, MAX(s.salary) as latest_salary FROM salaries s
GROUP BY s.emp_no
HAVING starting_salary < latest_salary;

```
#### Method-2
```sql
SELECT s.emp_no, MIN(s.salary) as starting_salary, MAX(s.salary) as Highest_salary,
(MAX(s.salary)-MIN(s.salary)) as Salary_Increase from salaries s
GROUP BY s.emp_no
HAVING salary_increase <> 0
ORDER BY salary_increase DESC;

```
### 13. Calculate the year-over-year salary growth for each employee.
```sql
SELECT s.emp_no,YEAR(s.from_date) as salary_year, s.salary
, LAG(s.salary) OVER(PARTITION BY emp_no ORDER BY s.from_date) as previous_salary
, s.salary - (LAG(s.salary) OVER(PARTITION BY emp_no ORDER BY s.from_date)) as salary_growth
from salaries s;

```
### 14. Retrieve the names of employees who are managers and have worked as non-managers as well.
```sql
SELECT DISTINCT e.emp_no, e.first_name, e.last_name
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
WHERE EXISTS (
   SELECT 1
   FROM dept_emp de
   WHERE de.emp_no = e.emp_no AND de.dept_no NOT IN (SELECT dept_no FROM dept_manager WHERE emp_no = e.emp_no)
);

```
### 15. Find the department with the most employees who have not received a raise in the last 3 years.
```sql
SELECT d.dept_name, COUNT(e.emp_no) AS no_raise_count
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
AND NOT EXISTS (
   SELECT 1
   FROM salaries s2
   WHERE s2.emp_no = e.emp_no AND s2.from_date > s.from_date AND s2.salary > s.salary AND s2.from_date > DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
)
GROUP BY d.dept_name
ORDER BY no_raise_count DESC
LIMIT 1;

```
### 16. Use a CASE statement to categorize employees by their length of service.
```sql
SELECT e.emp_no,e.first_name,e.last_name, e.hire_date,
CASE
   WHEN (DATEDIFF(CURRENT_DATE, e.hire_date)) < (25*365)  THEN  '25 Years'
   WHEN (DATEDIFF(CURRENT_DATE, e.hire_date)) < (35*365)  THEN  '25 to 35 Years'
   ELSE  'More than 35 years'
END as service_length
from employees e;

```
### 17. Find the average duration an employee stays in a department.
```sql
SELECT de.dept_no, AVG(DATEDIFF(de.to_date, de.from_date)) AS avg_duration_days
FROM dept_emp de GROUP BY de.dept_no;

```
### 18. Retrieve employees who have been promoted in the last 30 years using a self-join.
```sql
SELECT t1.emp_no , t1.title as previous_title, t2.title as current_title from titles t1
JOIN titles t2 on t1.emp_no = t2.emp_no
WHERE t1.from_date < t2.from_date and t2.from_date > SUBDATE(CURRENT_DATE(), INTERVAL 30 YEAR);

```
### 19. List the departments where the average salary is greater than the overall average salary.
```sql
SELECT d.dept_name, AVG(s.salary) as avg_salary from departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN salaries s on de.emp_no=s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name
HAVING AVG(s.salary) > (SELECT AVG(salary) from salaries WHERE to_date = '9999-01-01');

```
### 20. Find the most common job title for employees who have been with the company for 15 years.
```sql
SELECT t.title,COUNT(t.title) as total_titles from titles t
WHERE DATEDIFF(t.to_date,t.from_date) > (15*365)
GROUP BY t.title
ORDER BY COUNT(t.title) DESC
LIMIT 1;



