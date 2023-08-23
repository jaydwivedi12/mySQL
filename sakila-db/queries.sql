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
