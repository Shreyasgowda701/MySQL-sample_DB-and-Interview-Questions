## SQL Questions and Queries 1

###  1. Retrieve all columns from the employees table.
```sql
SELECT * from employees;

```
### 2. List the first name and last name of all employees.
```sql
SELECT first_name, Last_name from employees;

```
### 3. Find all employees who were hired after the year 2000.
```sql
SELECT emp_no, first_name , Last_name, hire_date from employees
where hire_date >= '2000-01-01';


```
### 4. Count the total number of departments in the company.
```sql
SELECT COUNT(dept_no) as total_departments from departments;

```
### 5. List the distinct job titles in the titles table.
```sql
SELECT DISTINCT(title) from titles;

```
### 6. Find all employees with the first name 'Georgy'.
```sql
SELECT emp_no, first_name, last_name FROM employees
WHERE first_name = 'Georgy';

```
### 7. List the employee numbers and salaries of all employees earning more than $60,000.
```sql
SELECT emp_no, salary from salaries
WHERE salary > 60000;

```
### 8. Retrieve the birth date and gender of all employees.
```sql
SELECT birth_date, gender from employees;

```
### 9. List all department names in alphabetical order.
```sql
SELECT dept_name from departments
ORDER BY dept_name asc;

```
### 10. Find the earliest hire date in the company.
```sql
SELECT min(hire_date) earliest_hire_date from employees;

```
### 11. List all employees' last names and their corresponding hire dates.
```sql
SELECT last_name, hire_date from employees;

````
### 12. Retrieve the department name and department number for all departments.
```sql
SELECT dept_no, dept_name from departments;

```
### 13. Find all employees who were born in the 1960s or (60s).
```sql
SELECT first_name, last_name, birth_date from employees
WHERE birth_date BETWEEN '1960-01-01' and '1969-12-31';

```
### 14. Count the number of employees in the employees table.
```sql
SELECT COUNT(*) from employees;

```
### 15. List the full names of employees with the last name 'Erde'.
```sql
SELECT first_name, Last_name from employees
WHERE last_name = 'Erde';

```
### 16. Retrieve the employee number and title for all employees in the titles table.
```sql
SELECT emp_no, title from titles;

```
### 17. Find all employees who were hired on January 1, 2000.
```sql
SELECT emp_no,first_name, last_name FROM employees
WHERE hire_date = '2000-01-01';

```
### 18. List all unique genders in the employees table.
```sql
SELECT DISTINCT(gender) from employees;

```
### 19. Retrieve the highest salary in the salaries table.
```sql
SELECT MAX(salary) from salaries;

```
### 20. Find the total number of employees hired before 1990.
```sql
SELECT COUNT(*) as total_employees_hired_before_1990 from employees
WHERE hire_date < '1990-01-01';



