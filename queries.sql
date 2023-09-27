SHOW DATABASES;
USE sakila;
SHOW TABLES;
DESCRIBE actor;
DESC actor;

-- DQL
SELECT * FROM actor;
SELECT actor_id,first_name FROM aCtOr;
DESC actor_info;

-- projection and selection
-- selecting a column is projection
-- selecting a row is selection

SELECT  actor_id, actor_id+5 FROM actor_info;
SELECT actor_id FROM actor_info; -- this is projection
SELECT * FROM actor_info WHERE actor_id=2; -- this is selection
SELECT actor_id,first_name FROM actor_info WHERE actor_id>2; -- this is both projection and selection both

SELECT first_name FROM actor_info WHERE actor_id<10;
SELECT * FROM actor_info WHERE first_name="ED";

-- 24 august
SELECT DATABASE();  --  gives current working database 
SHOW COLUMNS FROM actor_info;
DESC actor_info;

SELECT * FROM sakila.actor; -- access db table without going into that DB

SELECT name FROM language;

-- where 
SELECT * FROM language WHERE name='English';
SELECT * FROM language WHERE language_id != 3;

SELECT * FROM actor WHERE first_name > 'm';

-- wild card character 
SELECT * FROM film;
SELECT * FROM film WHERE title LIKE '%dinosaur%';
SELECT * FROM film WHERE description LIKE "%drama%";
SELECT title,description,release_year FROM film WHERE description LIKE "a%s";
SELECT * FROM film WHERE title LIKE 'A_A%';

-- Question
SELECT title,film_id,release_year,description FROM film WHERE title LIKE '_c%';
SELECT title,film_id,release_year,description FROM film WHERE title LIKE 'A%AN';
SELECT title,film_id,release_year,description FROM film WHERE title LIKE '%T___';
SELECT title,film_id,release_year,description FROM film WHERE title LIKE '_f_i%egg';
SELECT title,film_id,release_year,description FROM film WHERE title LIKE '__A__%';

-- logical operators

SELECT * FROM actor WHERE first_name="nick" AND actor_id=2;
SELECT * FROM actor WHERE first_name='nick' OR actor_id=3;

SHOW TABLES;
SELECT * FROM actor_info ;

SELECT * FROM actor_info WHERE film_info LIKE "ANIMATION%" AND first_name="GOLDIE";
SELECT * FROM actor_info WHERE film_info LIKE "ANIMATION%" AND first_name="GOLDIE" OR first_name="nick";
SELECT * FROM actor_info WHERE film_info LIKE "ANIMATION%" OR first_name="GOLDIE" AND first_name="nick";

SELECT * FROM film_list;
SELECT category,title,rating FROM film_list WHERE category LIKE 'SCI-FI' AND rating LIKE "PG";
SELECT category,rating,title FROM film_list WHERE (category LIKE 'sci-fi' OR category LIKE 'family') AND rating='pg';

SELECT 2 + 2 * 3;
SELECT (2 + 2) * 3;

SELECT * FROM actor
WHERE actor_id BETWEEN 2 AND 5; -- between is inclusive 

SELECT * FROM actor 
WHERE first_name BETWEEN 'b' AND 'e';

SELECT * FROM actor 
WHERE actor_id IN (1,5,10,15);

SELECT * FROM actor
WHERE NOT(actor_id=1);

SELECT * FROM actor 
WHERE actor_id BETWEEN 2 AND 7 
AND (first_name="nick" OR first_name='ed');

SELECT * FROM actor
WHERE NOT(last_name LIKE "%a%" AND last_name LIKE'%e%');

SELECT * FROM actor 
WHERE first_name NOT IN("grace","matthew","joe") 
AND actor_id<15; 

SELECT * FROM actor
 WHERE NOT(last_name LIKE '%a%' AND first_name LIKE '%i%') 
 AND actor_id BETWEEN 10 AND 20;
 
 SELECT fid,title FROM film_list
 WHERE fid<7 AND NOT(fid=4 OR fid=6);

-- We do not use % in starting in LIKE for better optimization ,it is bad practice , use order by for sorting and then use like 

SELECT * FROM film_list ORDER BY category DESC;

SELECT * FROM film_list ORDER BY 4; -- column no = but column no <= selected column number

SELECT price,fid,title FROM film_list ORDER BY 1;

-- missing value are lowest priotity 
SELECT * FROM address ORDER BY district;
SELECT * FROM address ORDER BY district DESC, address_id ASC;

SELECT * FROM address 
LIMIT 3; -- we can't use limit with order by 

SELECT * FROM address LIMIT 3,2; -- 3 is offset 
SELECT * FROM address LIMIT 3 OFFSET 2 ;
 
SELECT 2+2;

-- dummy table/dual table to check logic 
-- pseudo column -> column -> specific meaning->already avaible with the system  
SELECT 1+2 FROM DUAL;
SELECT NOW() FROM DUAL;

-- concat,concat-ws, substring 
-- string functions,DDL create ,data types, alter ,drop

SELECT CHAR_LENGTH('jay'); -- give length
SELECT LENGTH('jay'); -- give length in the memory
SELECT CONCAT('H','i');
SELECT CONCAT_WS("-" ,"hiI","heLlo");
SELECT UPPER("JAY");
SELECT UCASE("JAY");
SELECT SUBSTR("HELlo",1,3);
SELECT SUBSTR(SUBSTR("HELlo",1,3),2);
SELECT INSTR("HELLO","e");
SELECT LOCATE('A', 'rAJasthan', 3);
SELECT LTRIM("     jay");

SELECT TRIM(LEADING " " FROM "     xyz ");
SELECT TRIM(TRAILING " " FROM "     xyz");
SELECT TRIM(BOTH "Z" FROM "ZZazz     xyz zz");

SELECT LPAD("hell",5,"#");
SELECT RPAD("hell",7,"#");

SELECT REPLACE("tushars","s","@");

SELECT id,name FROM customer_list;
DESC customer;
DESC language;
SELECT * FROM language;
SELECT COUNT(*) FROM language;
-- DML
INSERT INTO language VALUES(NULL, "Gujarati",NOW());
INSERT INTO language VALUES(NULL,"punjabi",'2020-09-12 04:02:59');
INSERT IGNORE INTO language VALUES(14,"Delhi",NOW());   -- ignore used to ignore error and give warning  

INSERT INTO language(language_id,last_update,name) VALUES(NULL,NOW(),"japanese");
DESC language;
INSERT INTO language (name) VALUES ("tamil"); 

INSERT INTO language(last_update,name) 
VALUES(NOW(),"arab"),
(NOW(),"arab"),
(NOW(),"arab");

INSERT INTO language SET name="hungarian";

CREATE DATABASE test;
CREATE DATABASE IF NOT EXISTS test;

USE test;
SHOW TABLES;

-- create => table,index,view
CREATE TABLE employee(id INT,name CHAR(20),email CHAR(20) );
DESC employee;
INSERT INTO employee VALUE(1,"jay","jay@123");
SELECT * FROM employee;
INSERT INTO employee VALUE(1,"jp","jp@456");
INSERT INTO employee VALUE(3,"moto",NULL);
INSERT INTO employee(name) VALUE("patlu");

CREATE TABLE employee1(id INT DEFAULT 0,name CHAR(20),email CHAR(20) );

INSERT INTO employee1(name, email) VALUES("raman","raman@gmail.com");
SELECT * FROM employee1;

CREATE TABLE company 
(
 company_id INT NOT NULL AUTO_INCREMENT,
 name CHAR(20), dates DATE DEFAULT NOW(),
 PRIMARY KEY(company_id)
 );
SHOW TABLES;
DESC company;

INSERT INTO company(name) 
VALUES("abc"),("abc2");
SELECT * FROM company;

CREATE TABLE student2
(sid INT , email CHAR(20) DEFAULT "not given");
INSERT INTO student2 (sid) VALUES (4);
SELECT * FROM student2;

-- constaraints=> condition => invalid data cant be inserted
-- not Null
CREATE TABLE student4
(sid INT NOT NULL DEFAULT 0 , email CHAR(20) DEFAULT "gmail.com");

INSERT INTO student4(email) VALUES("a@gmail.com");
INSERT INTO student4(sid,email) VALUES(NULL,"temp@gmail.com");
SELECT * FROM student4;

-- unique
CREATE TABLE student_unique
(sid INT UNIQUE , email CHAR(20) DEFAULT "gmail.com");
INSERT INTO student_unique(sid) VALUES(3);
SELECT * FROM student_unique;

-- primary key
-- drop table employee;

CREATE TABLE employee(eid INT PRIMARY KEY , ename CHAR(20));  

CREATE TABLE employee2
(
 eid INT NOT NULL AUTO_INCREMENT,
 name CHAR(20),
 PRIMARY KEY (eid)
 );
 
-- learn check key and foreign key 
 
CREATE TABLE employee(eid INT PRIMARY KEY , ename CHAR(20));
INSERT INTO employee(eid,ename) VALUES(1,"jay");

-- data types
 -- int 4 byte , big int 8 byte, tiny int 1 byte
DROP TABLE ex2;
CREATE TABLE ex2(eid INT UNSIGNED);
INSERT INTO ex2 VALUES(33);
SELECT * FROM ex2;

CREATE TABLE test_bigint(id BIGINT UNSIGNED);

-- all numeric perform by big int by internal

INSERT INTO test_bigint VALUES(18446744073709551614);

SELECT id*100 FROM test_bigint;

-- boolean=>true/false => use tiny int 

CREATE TABLE test_bool(i BOOL);
INSERT INTO test_bool VALUES(TRUE),(FALSE);
SELECT * FROM test_bool;
INSERT INTO test_bool VALUES(TRUE),(FALSE),(1),(0),(24),(-14);

-- acid property in rdbms and how acid propert implemented in rdbms 
-- constraints 
USE test;
CREATE TABLE characters(name CHAR(20));
INSERT INTO characters VALUES("A B");
SELECT name ,LENGTH(name) FROM characters;

CREATE TABLE var_c(name VARCHAR(3));
INSERT INTO var_c VALUES("Ja      ");
SELECT name ,LENGTH(name) FROM var_c;

-- varchar removes last spaces  
-- char doesnt take spaces from back side 

DROP TABLE employee;

CREATE TABLE employee(name CHAR(20), age INT,CHECK(age>=18));
INSERT INTO employee (name, age) VALUES("jay",21),("jjjay",18);

CREATE TABLE ep1(gender CHAR(1), CHECK(gender IN('M','F','O')));
INSERT INTO ep1 VALUES("M");
SELECT * FROM ep1;

CREATE TABLE ep2(name CHAR(20), age INT , gender CHAR(1),
CHECK(age>=18 AND gender IN('M','F','O')));

INSERT INTO ep2 (name, age,gender) 
VALUES("jay",NULL,'M'),
("jjjay",19,'M'),("pp",129,'M'),("ja",123,'M');

SELECT * FROM ep2;

-- Delete DMl 
DELETE FROM ep2;
DELETE FROM ep2 WHERE age = 19;
DELETE FROM ep2 ORDER BY age LIMIT 1;
SELECT * FROM ep2;

-- Update DML
UPDATE ep2 SET age=180;
UPDATE ep2 SET age=20 WHERE name="pp";
UPDATE ep2 SET age=29 LIMIT 2;

-- drop remove schema as well as data  but it can be recovered ,can be rollback
-- delete remove data only but it can also be recovered 
-- truncate remove data of table, it is faster than delete,we cannot use rollback here , 
-- and also cannot use where clause here
-- internally truncate drop table and recreate table with same scheme 
-- truncate is DDL;

TRUNCATE TABLE ep2;
-- HW - Group By ,distinct , filter using group by 

-- cant uses alias in where
-- also cant use join in alias 
-- but we can use order by in alias
-- alias means temporary name
USE sakila;
SELECT first_name ,
CONCAT("MR ",first_name) AS FullName 
FROM actor
ORDER BY fullname;

-- group by and aggregate function-- it is multi row function
USE world;
SHOW TABLES;
DESC country;
CREATE TABLE t1 (id INT, city VARCHAR(20));
INSERT INTO t1 VALUES(1,"hii")
,(2,"this"),(3,"jay");
INSERT INTO t1 VALUES(4,NULL);
INSERT INTO t1 VALUES(NULL,NULL);

SELECT COUNT(*) FROM t1; 
--  count(*) it count by counting rows and 
-- if primary key is given then it count by primary key
SELECT COUNT(id) FROM t1;
SELECT COUNT(DISTINCT id) FROM t1;

SELECT * FROM city;

SELECT countrycode,COUNT(name),SUM(population) FROM city
GROUP BY countrycode
ORDER BY SUM(population); 

SELECT CONCAT("country ",countrycode," Has total count ",COUNT(*),
" and sum is ",SUM(population)) FROM city GROUP BY(countrycode);
 
 -- having clause , we cant use where in group by, alias works here 
SELECT countrycode,COUNT(name),
SUM(population) AS Total_population FROM city
GROUP BY countrycode HAVING total_population>5000 AND COUNT(id)>1 
ORDER BY SUM(population); 

SELECT countrycode,SUM(population) FROM city 
WHERE population>200000 GROUP BY countrycode; 

SELECT * FROM country;

-- multiple group by 
SELECT continent,region ,COUNT(*) FROM country 
GROUP BY continent,region;

 -- multiple group by with order by 
SELECT continent,region ,COUNT(*) FROM country 
GROUP BY continent,region ORDER BY continent,region;

SELECT COUNT(continent) FROM country;

SELECT continent,COUNT(*),SUM(population) FROM country
GROUP BY continent HAVING COUNT(*)>50;

-- set operations 

USE sakila;
SHOW TABLES;
DESC actor;
DESC actor_info;
SELECT first_name FROM actor LIMIT 3;
SELECT first_name FROM actor_info
ORDER BY first_name LIMIT 3;

-- union

SELECT first_name FROM actor
UNION 
SELECT first_name FROM actor_info;


CREATE TABLE abc(num INT);
INSERT INTO abc VALUES(10),(5);

CREATE TABLE xyz(num INT);
INSERT INTO xyz VALUES(10),(20);

SELECT * FROM abc
UNION 
SELECT * FROM xyz;

-- union all gives all the values not filter disctinct but union gives distinct values
SELECT * FROM abc
UNION ALL
SELECT * FROM xyz;

-- intersect 
-- gives common element 

-- select * from abc
-- intersect
-- select * from xyz;

-- except
-- gives only first result set data but not into another one

-- select * from abc
-- except 
-- select * from xyz;

-- limitation in sets 
-- no. of column should be same also there data type should be compatible
-- if there data type will be different it will typecast into string type char or varchar 
-- but column name can be different

-- join

-- inner join -gives common value from both table
-- left join - gives value from left table 
-- right join - gives value from right table
-- full outer join means - all data - left and right and inner

-- cross join - it matches each row with another each row of tables
-- inner join - if we have similiar colimn name then it works as inner join and if column name
-- is different then it work as cross join
-- natural join - it given distinct column name with common rows value ,  no need to use any using, where , on clause in inner join 

DESC actor;
DESC actor_info;
SELECT * FROM actor_info;
SELECT * FROM actor;

SELECT actor.actor_id,first_name ,film_id
FROM actor INNER JOIN film_actor USING (actor_id);

DROP TABLE student;
CREATE TABLE student (id INT ,sname VARCHAR(20));
INSERT INTO student VALUES(1,"jay");
INSERT INTO student VALUES(2,"jp");
INSERT INTO student VALUES(5,"dwivedi");

CREATE TABLE student_hobby (id INT ,hobby VARCHAR(20));
INSERT INTO student_hobby VALUES(1,"cricket");
INSERT INTO student_hobby VALUES(2,"badm");
INSERT INTO student_hobby VALUES(3,"football");

-- method 1
SELECT student.id,sname,hobby FROM student INNER JOIN student_hobby USING(id);
-- method 2
SELECT student.id,sname FROM student INNER JOIN student_hobby
WHERE student.id = student_hobby.id;

SELECT student.id,sname FROM student,student_hobby
WHERE student.id = student_hobby.id;
-- method 3 
SELECT student.id,sname FROM student INNER JOIN student_hobby
ON student.id = student_hobby.id;

SELECT student.id,sname,hobby FROM student LEFT JOIN student_hobby
ON student.id = student_hobby.id;

SELECT student.id,sname,hobby FROM student RIGHT JOIN student_hobby
ON student.id = student_hobby.id;

-- full join is not supported in mysql - for full join use left and right and then have union

-- miltiple joins
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;

SELECT a.actor_id,first_name,last_name,film_id,
title,release_year FROM 
actor AS a 
INNER JOIN 
film_actor AS f
ON a.actor_id=f.actor_id
INNER JOIN
film USING(film_id);

SELECT title,COUNT(rental_id) AS total  FROM 
film INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id) 
GROUP BY title HAVING COUNT(rental_id) >15
ORDER BY total DESC LIMIT 5;

SELECT c.customer_id,r.rental_id,c.email,i.film_id,f.category_id
FROM customer AS c 
INNER JOIN rental AS r USING (customer_id)
INNER JOIN inventory AS i USING (inventory_id)
INNER JOIN film_category AS f USING (film_id)
INNER JOIN category USING (category_id);

SELECT * FROM category;

SELECT cus.email,cat.name,COUNT(fc.category_id) AS categorycount
FROM customer AS cus 
INNER JOIN rental AS r USING (customer_id)
INNER JOIN inventory AS inv USING (inventory_id)
INNER JOIN film_category AS fc USING (film_id)
INNER JOIN category AS cat USING (category_id)
GROUP BY email,name
HAVING categorycount>2;


SELECT * FROM film_category;

-- self join 

CREATE TABLE employee(eid INT ,ename VARCHAR(20),email VARCHAR(20), manager_id INT);
INSERT INTO employee VALUES (1, "jay","jay@gmail.com", NULL);
INSERT INTO employee VALUES (2, "ram","ram@gmail.com", 1);
INSERT INTO employee VALUES (3, "shyam","shyam@gmail.com", 4);
INSERT INTO employee VALUES (4, "yashu","yashu@gmail.com", 2);

SELECT * FROM employee;

SELECT emp.eid,emp.ename, emp.manager_id,
manager.eid AS managerid,manager.ename AS manager
FROM employee AS emp INNER JOIN 
employee AS manager 
WHERE emp.manager_id=manager.eid;

-- NOTE: During multiple joins,if you have used using at once for a join
-- and then you used where/on for another join then it will create where,on as 
-- inner join and other as given which give innaccurate result
-- make sure to follow same way of join in complete query - using/where/on

-- nested queries

SELECT rental_duration FROM film 
WHERE film_id=1; 

SELECT film_id ,rental_duration FROM film 
WHERE rental_duration=6;

-- single result subquery/single result nested query
SELECT film_id ,rental_duration FROM film 
WHERE rental_duration=(SELECT rental_duration FROM film WHERE film_id=1);

SELECT * FROM employees;

SELECT * FROM employees WHERE hire_date>
(SELECT hire_date FROM employees WHERE emp_no=10003); 

SELECT title FROM titles WHERE emp_no IN (10001);

SELECT * FROM titles WHERE title =(SELECT title FROM titles WHERE emp_no=10001);

SELECT title FROM titles WHERE emp_no IN (10001,10002);

-- if subquery return more than 1 row than we cant use conditional operatiom 
-- we use Any here to get result 

SELECT * FROM titles WHERE title = 
ANY (SELECT title FROM titles WHERE emp_no IN (10001,1002));
-- =any (quivalent to all result set value)

SELECT * FROM salaries WHERE emp_no=10001 OR emp_no=10002 ORDER BY salary DESC;
SELECT * FROM salaries WHERE emp_no=10001 OR emp_no=10002 ORDER BY salary ;

SELECT * FROM salaries WHERE salary >
ANY (SELECT salary FROM salaries WHERE emp_no IN (10001,10002));


SELECT * FROM salaries WHERE salary <
ANY (SELECT salary FROM salaries WHERE emp_no IN (10001,10002));

-- < ANY returns rows where the "salary" is less than the maximum salary among employees 10001 and 10002.
-- > ANY returns rows where the "salary" is greater than the minimum salary among employees 10001 and 10002.

CREATE TABLE a(id INT);
INSERT INTO a VALUES(NULL);

CREATE TABLE b(newid INT);
INSERT INTO b VALUES(NULL);


SELECT * FROM b WHERE newid>10;

SELECT * FROM b 
WHERE newid = ANY(SELECT id FROM a);

SELECT * FROM a;
SELECT * FROM b;

SELECT * FROM a
WHERE id < ALL(SELECT newid FROM b);

-- it conflicts in null doesnt not weather its value is greater than null or less than 
SELECT * FROM a
WHERE id < ALL(SELECT newid FROM b WHERE newid IS NOT NULL);

SELECT * FROM b 
WHERE newid IN (SELECT id FROM a);

USE employees;
SELECT * FROM employees 
WHERE emp_no BETWEEN 10001 AND 10005;

SELECT * FROM employees; 
SELECT * FROM titles;

SELECT e.emp_no,title FROM employees AS e
INNER JOIN title AS t USING(emp_no);

SELECT e.emp_no FROM employees AS e
INNER JOIN titles AS t USING(emp_no) WHERE title <> "manager";

SELECT emp_no,first_name,last_name,title FROM employees 
JOIN titles USING(emp_no)
WHERE title="manager"
AND emp_no = ANY (SELECT emp_no FROM employees
JOIN titles USING(emp_no) WHERE title <> "manager");  
-- this give result jo khud manager hai , aur unka jo manager hai vo na dikhe
-- this can also perform using join only no need to use nested

SELECT emp_no, first_name, last_name ,mgr.title
FROM employees JOIN titles mgr USING (emp_no)
JOIN titles nonmgr USING (emp_no)
WHERE mgr.title= "manager"
AND nonmgr.title<>"manager";


SELECT employees.emp_no,first_name,last_name,title
FROM employees,titles
WHERE employees.emp_no=titles.emp_no
AND first_name="georgi"
AND last_name="klassen"
AND title="staff";

SELECT employees.emp_no,first_name,last_name
FROM employees,titles
WHERE (employees.emp_no,first_name,last_name,title)=
(titles.emp_no,"Georgi","klassen","staff");


SELECT mgr.emp_no, YEAR(mgr.from_date), YEAR(other.from_date),
  mgr.from_date AS fd,mgr.title AS mgr_title,other.title AS emp_title
FROM titles AS mgr, titles AS other
WHERE mgr.emp_no= other.emp_no AND mgr.title="manager"
AND mgr.title<>other.title
AND YEAR(mgr.from_date)=YEAR(other.from_date);

SELECT emp_no,YEAR(from_date),title FROM titles WHERE title <> "manager";

-- row subquery
SELECT emp_no, YEAR(from_date) AS fd
FROM titles WHERE title="manager"
AND (emp_no,YEAR(from_date)) IN
  (SELECT emp_no, YEAR(from_date) FROM titles WHERE title<>"manager");
  
  
  -- question 
  -- find out salary and total count of salary for those data where the total number of salary person is greater than the salary person of the salary >=60117;
  SELECT * FROM salaries;
  
  SELECT salary,COUNT(salary) FROM salaries 
  GROUP BY salary 
  HAVING COUNT(salary) >= 
  (SELECT COUNT(salary)FROM salaries WHERE salary=60117);
  
  --  question Find out the emp_no and second higest salary from salaries table using subquery
  
  SELECT * FROM salaries
  ORDER BY salary DESC;
  SELECT MAX(salary) FROM salaries;

SELECT emp_no, salary
FROM salaries
WHERE salary = (
SELECT MAX(salary)
FROM salaries
WHERE salary < (SELECT MAX(salary) FROM salaries)
);

-- exists keyword
SELECT COUNT(*) FROM departments WHERE EXISTS 
(SELECT * FROM dept_emp WHERE emp_no<100);
USE sakila;

SELECT first_name ,last_name FROM staff;
SELECT * FROM customer WHERE first_name="jon";

-- co-related 
SELECT first_name ,last_name FROM staff
WHERE EXISTS(SELECT * FROM customer WHERE
customer.first_name=staff.first_name 
AND customer.last_name=staff.last_name );

SELECT COUNT(*) FROM inventory,film 
WHERE inventory.film_id=film.film_id
GROUP BY film.film_id;

USE employees;

-- nested query in from  Clause
SELECT * FROM 
(SELECT emp_no, YEAR(birth_date) FROM employees) AS xyz;

SELECT emp_no,monthly_salary FROM
(SELECT emp_no,salary/12 AS monthly_salary FROM salaries ) AS ms LIMIT 5;


USE sakila;
SELECT SUM(amount),film_id 
FROM payment 
JOIN rental USING(rental_id)
JOIN inventory USING(inventory_id)
JOIN film USING(film_id)
GROUP BY film_id ;

SELECT AVG(newamount) FROM 
(
SELECT SUM(amount) AS newamount,film_id 
FROM payment 
JOIN rental USING(rental_id)
JOIN inventory USING(inventory_id)
JOIN film USING(film_id)
GROUP BY film_id ) AS moviegroup;

-- case statement 
SELECT * FROM payment;

SELECT 
    CASE 
    WHEN rental_id=76 THEN rental_id+100
    WHEN rental_id>=1000 THEN rental_id-100
    ELSE rental_id=9999
    END  AS newcol,
payment_id ,amount FROM payment;

SELECT 
    CASE rental_id
    WHEN 76 THEN rental_id+100
    WHEN 100 THEN rental_id-100
    ELSE "jay"
    END  AS newcol,
      rental_id, payment_id ,amount FROM payment;
      
-- Q1 - get emp_no,first_name, full name of every person
 -- where the birth year is > greater than birth year emp_no 1003
 -- and hire year is < hire year of 1005 from employees table
SELECT * FROM employees;
 SELECT emp_no, first_name, CONCAT(first_name," ",last_name ) AS full_name
 FROM employees WHERE YEAR(birth_date)>
 ( SELECT YEAR(birth_date) 
    FROM employees WHERE emp_no=10003 );
    
    
-- Q2 - get the info of those user where the hire year > among all hire of emp_no 10003 to 10007 from employees table
SELECT * FROM employees 
WHERE YEAR(hire_date)>
 ALL ( SELECT YEAR(hire_date) 
    FROM employees WHERE emp_no BETWEEN 10003 AND 10007) ;
   
   
-- Q3 -find out the emp_no,dept_no and department name of those user who has work into  company for more than 28 years
-- from departments and  current_dept_emp tables;
SELECT * FROM departments;
SELECT * FROM current_dept_emp; 
 
SELECT  cd.emp_no,d.dept_no,d.dept_name 
FROM departments AS d 
INNER JOIN current_dept_emp AS cd
USING(dept_no)
WHERE YEAR(to_date)-YEAR(cd.from_date)>28 ;


-- Q4- find out emp_name,emp_no, department_no ,department_name , year and total no of months work for company only for those 
-- where total no of months is working is greater than > 400 from departments,employees and  current_dept_emp tables;
SELECT * FROM departments;
SELECT * FROM current_dept_emp; 
SELECT * FROM employees;

SELECT CONCAT(e.first_name," ",e.last_name) AS emp_name, cde.dept_no, d.dept_name,
( YEAR(cde.to_date)-YEAR(cde.from_date) ) AS working_year,
( YEAR(cde.to_date)-YEAR(cde.from_date) )*12 AS working_month
FROM employees AS e
INNER JOIN current_dept_emp AS cde USING(emp_no)
INNER JOIN departments AS d USING(dept_no)
WHERE ( YEAR(cde.to_date)-YEAR(cde.from_date))*12>400;


-- Q5 - deploy and create foreign key from one table to another table
USE test;

CREATE TABLE college(
                      clg_id INT, clg_name VARCHAR(50),PRIMARY KEY(clg_id)
                      );


CREATE TABLE university(
						uni_id INT,uni_name VARCHAR(50),clg_id INT,
                        FOREIGN KEY(clg_id) REFERENCES college(clg_id)
                        );

SELECT * FROM college;
SELECT * FROM university;
INSERT INTO college VALUE(3,"mitrc");
INSERT INTO university VALUES(201,"BTU",2);

SELECT * FROM university AS u 
INNER JOIN college AS c 
USING(clg_id);

USE employees;
SELECT * FROM employees;

-- float -- 4 byte and double -- 8 byte
USE test;

CREATE TABLE xyz(price1 DOUBLE(5,2));
INSERT INTO xyz VALUES(1.23);
SELECT * FROM xyz;
DROP TABLE xyz;

-- date 
CREATE TABLE xyz (birthdate DATE,birthtime TIME,
birthdata DATETIME);
-- YYYY-MM-DD HH:MM:SS
INSERT INTO xyz VALUE("2020-02-12", "02:38:00","2022-09-27 01:20:00");
INSERT INTO xyz VALUE(CURDATE(),CURTIME(),NOW());
SELECT * FROM xyz;
SELECT birthdata,YEAR(birthdata),WEEK(birthdata),
QUARTER(birthdata),MONTHNAME(birthdata) FROM xyz;

SELECT DATEDIFF(birthdata,birthdate) FROM xyz;
SELECT birthdata,DATE_ADD(birthdata,INTERVAL 2 YEAR)FROM xyz;
SELECT birthdata,DATE_SUB(birthdata,INTERVAL 2 HOUR)FROM xyz;

SELECT CONCAT(
YEAR(birthdata),
" ",MONTHNAME(birthdata),
" " ,DATE(birthdata)," ",WEEK(birthdata),
" ",WEEKDAY(birthdata)) AS ans FROM xyz;

SELECT 
    CONCAT_WS(' ', YEAR(birthdata), MONTHNAME(birthdata), DATE(birthdata), WEEK(birthdata), WEEKDAY(birthdata)) AS ans
FROM xyz;

SELECT birthdata,DATE_FORMAT(birthdata, "%Y %b") FROM xyz;

-- timestamp 1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07'

CREATE TABLE captions
(     text VARCHAR(50),
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

INSERT INTO captions (text) VALUE("hello");

SELECT * FROM captions;

CREATE TABLE captions2
(     text VARCHAR(50),
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

INSERT INTO captions2 (text) VALUE("hello");
INSERT INTO captions2(text,created_at) VALUE("hii","2022-09-27 01:20:00");

UPDATE captions2 SET created_at="2020-08-27 01:20:00" WHERE text="hello";

SELECT * FROM captions2;

USE test;

-- insert palindrome name 
CREATE TABLE palindrome(id INT,primary_name VARCHAR(50),status BOOL,
secondary_name VARCHAR(50), 
CONSTRAINT test_data_palindrome_secName_check
CHECK (REVERSE(secondary_name)=primary_name));

INSERT INTO palindrome VALUES(10,"saras",TRUE,"saras");
SELECT * FROM palindrome;


-- constraint name check
CREATE TABLE house(sales_price LONG, purchase_price LONG,
     CONSTRAINT test_house_sp_check 
     CHECK(sales_price>purchase_price));
     
INSERT INTO house VALUES(230,200);
SELECT * FROM house;

-- understanding foreign key 
CREATE TABLE student(
sno INT ,sname VARCHAR(20),sid INT, 
CONSTRAINT test_student_relation
FOREIGN KEY(sid) REFERENCES s_hobby(sid)
)
;
CREATE TABLE s_hobby(sid INT PRIMARY KEY,hobby VARCHAR(20));

DESC student;
SELECT * FROM student;
DESC s_hobby;
SELECT * FROM s_hobby;

INSERT INTO s_hobby VALUES(2,"football");
-- if we want to insert into student table make sure it foreign key value must present into s_hobby(sid) primary key
INSERT INTO student VALUES(10,"jay",1);
INSERT INTO student VALUES(20,"jp",2);
INSERT INTO student VALUES(40,"jay",2);


create table customer_info (
                           id int primary key, name varchar(40),
                            city varchar(20),
							country varchar(20),
                            constraint test_customer_reference_country
                            foreign key (city,country) 
                            references country_info(country_city,country_name)
                            );
                            

create table country_info(country_id int primary key,
                           country_city varchar(20),
                           country_name varchar(20),
						   index idx_country_city_name (country_city,country_name)
                          );
                          
desc customer_info;
desc country_info;

