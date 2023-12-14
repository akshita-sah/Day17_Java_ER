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