--Address book DB

--UC 1 - Creating and displaying the database
 create database address_book;
Query OK, 1 row affected (0.01 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| address_book       |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

--UC 2 - Create a table with attributes
mysql> create table contacts(id INT NOT NULL AUTO_INCREMENT, firstname VARCHAR(150) NOT NULL,
    -> lastname VARCHAR(150) NOT NULL, address VARCHAR(150) NOT NULL, city VARCHAR(50) NOT NULL,
    -> state VARCHAR(50) NOT NULL, zip VARCHAR(10) NOT NULL,phone_number VARCHAR(10) NOT NULL,
    -> email VARCHAR(150) NOT NULL,PRIMARY KEY(id));
Query OK, 0 rows affected (0.07 sec)

-- UC 3 - Insert into DB
mysql>  INSERT INTO contacts (firstname,lastname,address,city,state,zip,phone_number,email) VALUES
    -> ("John", "Doe", "123 Main St", "Anytown", "CA", "12345", "5555551234", "john.doe@example.com"),
    -> ("Jane", "Smith", "456 Oak Ave", "Springfield", "IL", "67890", "5555555678", "jane.smith@example.com"),
    -> ("Alex", "Johnson", "789 Pine Rd", "Lakeside", "FL", "34567", "5555558765", "alex.j@example.com"),
    -> ("Alex", "Smith", "789 Pine Rd", "Lakeside", "FL", "34567", "5555558766", "alex.smith@example.com");
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

-- UC 4 - Update contact using name
mysql> UPDATE contacts set address = "125 Main St" WHERE firstname="Alex" AND lastname="Johnson";
Query OK, 1 row affected (0.02 sec)
Rows matched: 1  Changed: 1  Warnings: 0

-- UC 5 - Delete using name
mysql> DELETE FROM contacts WHERE firstname = "Alex" AND lastname = "Johnson";
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM contacts;
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
| id | firstname | lastname | address     | city        | state | zip   | phone_number | email                  |
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
|  1 | John      | Doe      | 123 Main St | Anytown     | CA    | 12345 | 5555551234   | john.doe@example.com   |
|  2 | Jane      | Smith    | 456 Oak Ave | Springfield | IL    | 67890 | 5555555678   | jane.smith@example.com |
|  4 | Alex      | Smith    | 789 Pine Rd | Lakeside    | FL    | 34567 | 5555558766   | alex.smith@example.com |
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
3 rows in set (0.00 sec)

-- UC 6 - Ability to Retrieve Person belonging to a City or State
mysql> SELECT * FROM contacts WHERE city = "Anytown" OR state = "CA";
+----+-----------+----------+-------------+---------+-------+-------+--------------+----------------------+
| id | firstname | lastname | address     | city    | state | zip   | phone_number | email                |
+----+-----------+----------+-------------+---------+-------+-------+--------------+----------------------+
|  1 | John      | Doe      | 123 Main St | Anytown | CA    | 12345 | 5555551234   | john.doe@example.com |
+----+-----------+----------+-------------+---------+-------+-------+--------------+----------------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM contacts WHERE city = "Anytown";
+----+-----------+----------+-------------+---------+-------+-------+--------------+----------------------+
| id | firstname | lastname | address     | city    | state | zip   | phone_number | email                |
+----+-----------+----------+-------------+---------+-------+-------+--------------+----------------------+
|  1 | John      | Doe      | 123 Main St | Anytown | CA    | 12345 | 5555551234   | john.doe@example.com |
+----+-----------+----------+-------------+---------+-------+-------+--------------+----------------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM contacts WHERE state = "IL";
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
| id | firstname | lastname | address     | city        | state | zip   | phone_number | email                  |
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
|  2 | Jane      | Smith    | 456 Oak Ave | Springfield | IL    | 67890 | 5555555678   | jane.smith@example.com |
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
1 row in set (0.00 sec)

--UC 7 - Ability to understand the size of address book by City and State
mysql> SELECT COUNT(*) FROM contacts WHERE city ="Springfield" OR state = "CA";
+----------+
| COUNT(*) |
+----------+
|        2 |
+----------+
1 row in set (0.00 sec)

-- UC 8 - Ability to retrieve entries sorted alphabetically by Person’s name for a given city
mysql> SELECT * FROM contacts WHERE city = "Springfield" ORDER BY (firstname);
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
| id | firstname | lastname | address     | city        | state | zip   | phone_number | email                  |
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
|  5 | Jack      | Smith    | 45 Street   | Springfield | IL    | 67890 | 5555555789   | jack_s@example.com     |
|  2 | Jane      | Smith    | 456 Oak Ave | Springfield | IL    | 67890 | 5555555678   | jane.smith@example.com |
+----+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
2 rows in set (0.00 sec)

-- UC 9 - Ability to identify each address book with type
mysql> ALTER TABLE contacts ADD contact_type VARCHAR(10) NOT NULL AFTER id;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM contacts;
+----+--------------+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
| id | contact_type | firstname | lastname | address     | city        | state | zip   | phone_number | email                  |
+----+--------------+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
|  1 |              | John      | Doe      | 123 Main St | Anytown     | CA    | 12345 | 5555551234   | john.doe@example.com   |
|  2 |              | Jane      | Smith    | 456 Oak Ave | Springfield | IL    | 67890 | 5555555678   | jane.smith@example.com |
|  4 |              | Alex      | Smith    | 789 Pine Rd | Lakeside    | FL    | 34567 | 5555558766   | alex.smith@example.com |
|  5 |              | Jack      | Smith    | 45 Street   | Springfield | IL    | 67890 | 5555555789   | jack_s@example.com     |
+----+--------------+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
4 rows in set (0.00 sec)

mysql> UPDATE contacts SET contact_type = "Friend" WHERE firstname = "Alex";
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE contacts SET contact_type = "Family" WHERE firstname = "Jane";
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE contacts SET contact_type = "Family" WHERE firstname = "Jack";
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM contacts;
+----+--------------+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
| id | contact_type | firstname | lastname | address     | city        | state | zip   | phone_number | email                  |
+----+--------------+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
|  1 | Friend       | John      | Doe      | 123 Main St | Anytown     | CA    | 12345 | 5555551234   | john.doe@example.com   |
|  2 | Family       | Jane      | Smith    | 456 Oak Ave | Springfield | IL    | 67890 | 5555555678   | jane.smith@example.com |
|  4 | Friend       | Alex      | Smith    | 789 Pine Rd | Lakeside    | FL    | 34567 | 5555558766   | alex.smith@example.com |
|  5 | Family       | Jack      | Smith    | 45 Street   | Springfield | IL    | 67890 | 5555555789   | jack_s@example.com     |
+----+--------------+-----------+----------+-------------+-------------+-------+-------+--------------+------------------------+
4 rows in set (0.00 sec)

--UC 10 - Ability to get number of contact persons
mysql> SELECT contact_type, COUNT(*) FROM contacts GROUP BY contact_type;
+--------------+----------+
| contact_type | COUNT(*) |
+--------------+----------+
| Friend       |        2 |
| Family       |        2 |
+--------------+----------+
2 rows in set (0.00 sec)

--UC 11 - Ability to add person to both Friend and Family
mysql> UPDATE contacts SET contact_type = "Friend" WHERE firstname = "Alex";
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE contacts SET contact_type = "Family" WHERE firstname = "Jane";
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

