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


### 1mdd
