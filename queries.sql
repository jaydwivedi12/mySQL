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
INSERT INTO employee VALUE(3,"moto",Null);
insert into employee(name) value("patlu");

CREATE TABLE employee1(id INT default 0,name CHAR(20),email CHAR(20) );

insert into employee1(name, email) values("raman","raman@gmail.com");
select * from employee1;

create table company 
(
 company_id int NOT NULL AUTO_INCREMENT,
 name char(20), dates date default now(),
 primary key(company_id)
 );
show tables;
desc company;

insert into company(name) 
values("abc"),("abc2");
select * from company;