--EMPLOYEE PAYROLL

--UC 1 - Create, show and use database
mysql> create database payroll_service;
Query OK, 1 row affected (0.01 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| address_book       |
| information_schema |
| mysql              |
| payroll_service    |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.00 sec)

mysql> use payroll_service;
Database changed

--UC 2 - Create a employee payroll table
mysql> create table employee_payroll(id INT NOT NULL AUTO_INCREMENT, name VARCHAR(20) NOT NULL, salary DOUBLE NOT NULL, start DATE NO
T NULL, PRIMARY KEY (id) );
Query OK, 0 rows affected (0.04 sec)

mysql> desc employee_payroll;
+--------+-------------+------+-----+---------+----------------+
| Field  | Type        | Null | Key | Default | Extra          |
+--------+-------------+------+-----+---------+----------------+
| id     | int         | NO   | PRI | NULL    | auto_increment |
| name   | varchar(20) | NO   |     | NULL    |                |
| salary | double      | NO   |     | NULL    |                |
| start  | date        | NO   |     | NULL    |                |
+--------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

--UC 3 - Insert into table
mysql> INSERT INTO employee_payroll (name,salary,start) VALUES ("Bill",100000,'2023-12-12'),('Emily',120000,'2023-11-12'),('John',130
00,'2023-10-12');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

--UC 4 - View table
mysql> SELECT * from employee_payroll;
+----+-------+--------+------------+
| id | name  | salary | start      |
+----+-------+--------+------------+
|  1 | Bill  | 100000 | 2023-12-12 |
|  2 | Emily | 120000 | 2023-11-12 |
|  3 | John  |  13000 | 2023-10-12 |
+----+-------+--------+------------+
3 rows in set (0.00 sec)

--UC 5 - View according to query
mysql> SELECT salary FROM employee_payroll WHERE name = "Bill";
+--------+
| salary |
+--------+
| 100000 |
+--------+
1 row in set (0.00 sec)

mysql> SELECT salary FROM employee_payroll WHERE start BETWEEN CAST('2023-11-12' AS DATE) AND DATE(NOW());
+--------+
| salary |
+--------+
| 100000 |
| 120000 |
+--------+
2 rows in set (0.00 sec)

--UC 6 - Add a column
mysql> ALTER TABLE employee_payroll ADD gender VARCHAR(2) NOT NULL AFTER name;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> UPDATE employee_payroll set gender = 'M' where name = 'Bill' or name = 'John';
Query OK, 2 rows affected (0.01 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> Select * from employee_payroll;
+----+-------+--------+--------+------------+
| id | name  | gender | salary | start      |
+----+-------+--------+--------+------------+
|  1 | Bill  | M      | 100000 | 2023-12-12 |
|  2 | Emily |        | 120000 | 2023-11-12 |
|  3 | John  | M      |  13000 | 2023-10-12 |
+----+-------+--------+--------+------------+
3 rows in set (0.00 sec)

--UC 7 - Find Sum, avg, min
mysql> SELECT SUM(salary) FROM employee_payroll WHERE gender = 'M' GROUP BY gender;
+-------------+
| SUM(salary) |
+-------------+
|      113000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(salary) FROM employee_payroll WHERE gender = 'M' GROUP BY gender;
+-------------+
| AVG(salary) |
+-------------+
|       56500 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(salary) FROM employee_payroll WHERE gender = 'M' GROUP BY gender;
+-------------+
| MIN(salary) |
+-------------+
|       13000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT MAX(salary) FROM employee_payroll WHERE gender = 'M' GROUP BY gender;
+-------------+
| MAX(salary) |
+-------------+
|      100000 |
+-------------+
1 row in set (0.00 sec)

--UC 9 - Ability to extend
mysql> ALTER TABLE employee_payroll RENAME COLUMN salary TO basic_pay;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD deductions Double NOT NULL AFTER basic_pay;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD taxable_pay Double NOT NULL AFTER deductions;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD income_tax Double NOT NULL AFTER taxable_pay;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD net_pay Double NOT NULL AFTER income_tax;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>  SELECT * FROM employee_payroll;
+----+-------+--------+-----------+------------+-------------+------------+---------+------------+
| id | name  | gender | basic_pay | deductions | taxable_pay | income_tax | net_pay | start      |
+----+-------+--------+-----------+------------+-------------+------------+---------+------------+
|  1 | Bill  | M      |    100000 |          0 |           0 |          0 |       0 | 2023-12-12 |
|  2 | Emily |        |    120000 |          0 |           0 |          0 |       0 | 2023-11-12 |
|  3 | John  | M      |     13000 |          0 |           0 |          0 |       0 | 2023-10-12 |
+----+-------+--------+-----------+------------+-------------+------------+---------+------------+
3 rows in set (0.00 sec)

--UC 11 - Create multiple tables
mysql> CREATE TABLE company (company_id INT PRIMARY KEY,name VARCHAR(50) NOT NULL);
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE department (department_id INT PRIMARY KEY,name VARCHAR(50) NOT NULL);
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE employee (employee_id INT PRIMARY KEY,company_id INT,name VARCHAR(255) NOT NULL,
FOREIGN KEY (company_id) REFERENCES company(company_id));
Query OK, 0 rows affected (0.09 sec)

mysql> CREATE TABLE payroll (payroll_id INT PRIMARY KEY, employee_id INT UNIQUE,basic_pay INT,
deductions INT,taxable_pay INT,FOREIGN KEY (employee_id) REFERENCES employee(employee_id));
Query OK, 0 rows affected (0.07 sec)

mysql> CREATE TABLE employee_department (employee_id INT, department_id INT,
PRIMARY KEY (employee_id, department_id),FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
FOREIGN KEY (department_id) REFERENCES department(department_id));
Query OK, 0 rows affected (0.06 sec)