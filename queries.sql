show databases;
use sakila;
show tables;
describe actor;
desc actor;

-- DQL
select * from actor;
select actor_id,first_name from aCtOr;
desc actor_info;

-- projection and selection
-- selecting a column is projection
-- selecting a row is selection

select  actor_id, actor_id+5 from actor_info;
select actor_id from actor_info; -- this is projection
select * from actor_info where actor_id=2; -- this is selection
select actor_id,first_name from actor_info where actor_id>2; -- this is both projection and selection both

select first_name from actor_info where actor_id<10;
select * from actor_info where first_name="ED";

-- 24 august
select database();  --  gives current working database 
show columns from actor_info;
desc actor_info;

select * from sakila.actor; -- access db table without going into that DB

select name from language;

-- where 
select * from language where name='English';
select * from language where language_id != 3;

select * from actor where first_name > 'm';

-- wild card character 
select * from film;
select * from film where title like '%dinosaur%';
select * from film where description like "%drama%";
select title,description,release_year from film where description like "a%s";
select * from film where title like 'A_A%';

-- Question
select title,film_id,release_year,description from film where title like '_c%';
select title,film_id,release_year,description from film where title like 'A%AN';
select title,film_id,release_year,description from film where title like '%T___';
select title,film_id,release_year,description from film where title like '_f_i%egg';
select title,film_id,release_year,description from film where title like '__A__%';






