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

mysql < employees_partitioned.sql

Testing the Installation
After installation, you can test the setup by running one of the following commands:

   ```bash
   mysql -t < test_employees_md5.sql
   

Example Output
bash
Copy code
mysql  -t < test_employees_md5.sql
+----------------------+
| INFO                 |
+----------------------+
| TESTING INSTALLATION |
+----------------------+
+--------------+------------------+----------------------------------+
| table_name   | expected_records | expected_crc                     |
+--------------+------------------+----------------------------------+
| employees    |           300024 | 4ec56ab5ba37218d187cf6ab09ce1aa1 |
| departments  |                9 | d1af5e170d2d1591d776d5638d71fc5f |
| dept_manager |               24 | 8720e2f0853ac9096b689c14664f847e |
| dept_emp     |           331603 | ccf6fe516f990bdaa49713fc478701b7 |
| titles       |           443308 | bfa016c472df68e70a03facafa1bc0a8 |
| salaries     |          2844047 | fd220654e95aea1b169624ffe3fca934 |
+--------------+------------------+----------------------------------+
+--------------+------------------+----------------------------------+
| table_name   | found_records    | found_crc                        |
+--------------+------------------+----------------------------------+
| employees    |           300024 | 4ec56ab5ba37218d187cf6ab09ce1aa1 |
| departments  |                9 | d1af5e170d2d1591d776d5638d71fc5f |
| dept_manager |               24 | 8720e2f0853ac9096b689c14664f847e |
| dept_emp     |           331603 | ccf6fe516f990bdaa49713fc478701b7 |
| titles       |           443308 | bfa016c472df68e70a03facafa1bc0a8 |
| salaries     |          2844047 | fd220654e95aea1b169624ffe3fca934 |
+--------------+------------------+----------------------------------+
+--------------+---------------+-----------+
| table_name   | records_match | crc_match |
+--------------+---------------+-----------+
| employees    | OK            | ok        |
| departments  | OK            | ok        |
| dept_manager | OK            | ok        |
| dept_emp     | OK            | ok        |
| titles       | OK            | ok        |
| salaries     | OK            | ok        |
+--------------+---------------+-----------+
Disclaimer
To the best of our knowledge, this data is fabricated and does not correspond to real people. Any similarity to existing individuals is purely coincidental.

License
This work is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported License. For more details, visit Creative Commons License.

css
Copy code

This `README.md` provides a clear overview of the project, its origins, installation instructions, testing procedures, and licensing information.





