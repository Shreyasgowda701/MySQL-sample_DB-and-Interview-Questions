# Sample Employee Database with Integrated Test Suite

This repository contains a sample database with an integrated test suite, designed to test your applications and database servers. The database includes approximately 300,000 employee records with 2.8 million salary entries, making it suitable for non-trivial testing scenarios.

**Note:** This repository was migrated from Launchpad.

## Where It Comes From

The original data was created by Fusheng Wang and Carlo Zaniolo at Siemens Corporate Research. The data was originally in XML format and can be found [here](http://timecenter.cs.aau.dk/software.htm).

Giuseppe Maxia created the relational schema, and Patrick Crews exported the data into a relational format. 

This data was generated, and as such, there are inconsistencies and subtle problems. These issues have been left intact for use as data cleaning exercises.

## Prerequisites

To use this database, you need a MySQL database server (version 5.0 or later). You should run the commands through a user with the following privileges:

- SELECT, INSERT, UPDATE, DELETE
- CREATE, DROP, RELOAD, REFERENCES
- INDEX, ALTER, SHOW DATABASES
- CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW

## Installation

1. **Download the repository.**
2. **Change directory to the repository.**
3. **Run the following command:**

   ```bash
   mysql < employees.sql
