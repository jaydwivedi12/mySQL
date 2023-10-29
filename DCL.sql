/*
databases have evolved to support multiple users
 and roles and provide a means to control privileges and 
 access on a very fine-grained 
level to guarantee secure shared environments.


 Users in MySQL are special objects used for the purpose of:

Authentication (making sure that a user can access the MySQL server)
Authorization (making sure that a user can interact
 with objects in the database)

Some DBMSs support the concept of object ownership. 
That is, when the user creates a database object—a database or schema,
 a table, or a stored procedure—that user automatically 
 becomes the new object’s owner. 
 The owner usually has the ability to modify objects it owns 
 and grant other users access to them. The important thing here 
 is that MySQL does not in any way have a concept of object ownership.

 Privileges can be thought of as sets of rules controlling what 
 actions users are
 allowed to perform and what data they can access. 
 
 Users in MySQL are also a bit different than in other databases,
 because the user object includes a network access control list (ACL). 
 Usually, 
 a MySQL user is represented not just by its name, like bob,
 but with an appended network address, like bob@localhost. 
10.0.3
CREATE USER 1
'bob'@'10.0.2.%' 2
IDENTIFIED BY 'password'; 3
*/


create user bob12 identified by 'bob';



/*
CREATE USER 1
'bob'@'10.0.2.%' 2
IDENTIFIED WITH mysql_native_password 3
BY 'password' 4
DEFAULT ROLE 'user_role' 5
REQUIRE SSL 6
AND CIPHER 'EDH-RSA-DES-CBC3-SHA' 7
WITH MAX_USER_CONNECTIONS 10 8
PASSWORD EXPIRE NEVER; 9

1
SQL statement to create a user

2
User and host definition

3
Authentication plugin specification

4
Authentication string/password

5
Default role set once user is authenticated and connected

6
Require SSL for connections for this user

7
Require specific ciphers

8
Limit maximum number of connections from this user

9
Override global password expiration settings

'bob'@'10.0.2.%', where bob is the username and
 10.0.2.% is a hostname specification. In fact, it’s a hostname specification with a wildcard. Each time someone connects with the username bob using TCP, MySQL will do a few things:

- Get the IP address of the connecting client.
- Perform a reverse DNS lookup of the IP address to a hostname.
- Perform a DNS lookup for that hostname 
(to make sure the reverse lookup wasn’t compromised).
- Check the hostname or IP address with the user’s hostname specification.

*/

# You specify the user and password, 
# and MySQL authenticates you with that user and your origin host. 
SELECT CURRENT_USER();

SELECT * FROM mysql.user;
SELECT * FROM mysql.user where user='sammy';
CREATE USER 'sammy' IDENTIFIED BY 'password';

DROP USER 'sammy'@'192.16.10.%';
SELECT * FROM mysql.user;
CREATE USER 'sammy'@'192.16.10.%' IDENTIFIED BY 'password';

CREATE USER 'bob' IDENTIFIED BY 'bob';

select * from sakila.test;

use sakila;
show tables;

GRANT ALL PRIVILEGEs ON sakila.test TO 'sammy';

 FLUSH PRIVILEGES;
SHOW GRANTS FOR 'root'@'localhost';

-- dcl ( indexing)

-- checking plugin
SELECT plugin FROM mysql.user WHERE user = 'bob' AND host = 'localhost';

-- changing plugin using alter
ALTER USER 'bob'@'localhost' IDENTIFIED WITH mysql_native_password;


-- changing user password
ALTER USER 'bob' IDENTIFIED by 'newpassword';

-- setting password
 SET PASSWORD = 'new password';
 
 -- for other use 
 SET PASSWORD FOR 'bob'@'localhost' = 'new password';
 
 
 -- locking user
 ALTER USER 'bob' ACCOUNT LOCK;
 
 -- to unlock 
  ALTER USER 'bob' ACCOUNT UNLOCK;
  
/*
pASSWORD EXPIRE option of the ALTER USER command. 
After this command is executed, the user will still
 be able to connect to the server using the previous password.
 run a query from the new connection—that is, as soon as
 their privileges are checked—the
 user will be presented with an error and forced to change the password. 
*/

ALTER USER 'bob'@'localhost' PASSWORD EXPIRE;

/*
RENAME USER. It requires the CREATE USER privilege,
 or the UPDATE privilege on the mysql database or just the grant tables
*/
RENAME USER 'robert' TO 'bob';

select * from mysql.user;


-- drop user
 DROP USER 'jeff'@'localhost';
 
 
 /*
 
 Global privileges
either act on every object in every database or act
 on the cluster as a whole
 Privileges in this category are stored
 within the tables mysql.user and mysql.global_grants. 
 The first one stores conventional static privileges, 
 and the second one stores dynamic privileges
 
 
 Database privileges
Privileges granted on a database level
 will allow the user to act upon objects within that database.
 
 Records for these privileges are stored within the 
 mysql.db table and include the ability to run DDL 
 and DML queries within the target database.
 
 
 Object privileges
A logical continuation of database-level privileges, 
these target a particular object. Tracked in mysql.tables_priv, 
mysql.procs_priv, and mysql.proxies_priv, they respectively cover
 tables and views, all types of stored routines, and finally the proxy 
 user permissions.
 
 
 Column privileges
Stored in mysql.columns_priv, these are an interesting set of privileges. 
You can separate permissions within a particular table by column. 
 */
 
 -- to see all privileges
 SHOW PRIVILEGES;
 
 /*
 SUPER is basically a catchall privilege that turns 
 a user to which it is assigned into a superuser.
 
 two huge problems with the SUPER privilege, however. 
 First, starting with MySQL 8.0 it is deprecated, 
 and it is going to be removed in a future release of MySQL. 
 Second, it is a security and operational nightmare. 
 */
 
 
 /*
 The GRANT statement is used to grant users (or roles) permissions
 to perform activities, either in general or on specific objects. 
 The same statement can also be used to assign roles to users, 
 but you cannot at the same time alter permissions and assign roles. 
 To be able to grant a permission (privilege), you need to have that 
 privilege assigned yourself and have the special GRANT OPTION privilege
 */
 
 drop user bob;
 create user bob identified by 'bob';
 
 #  GRANT SELECT ON db.* TO 'john'@'192.168.%';
 
 # to all database
 GRANT SELECT ON *.* TO 'bob';
 
 
 # assinging permission to two user at same time
 GRANT SELECT ON app_db.* TO 'john','kate';
 
 GRANT ALL ON app_db.* TO 'app_db_user';

# GRANT statement updates grant tables. One thing that follows from the fact that there’s an update on grant tables is that if a user has the UPDATE privilege on those tables, 
# that user can grant any account any privilege.
use sakila;
create table t1(id int, name varchar(20));
insert into t1 values(10, "abc");

# granting specific column permission to user
GRANT SELECT(id), INSERT(name)
ON sakila.t1 TO 'bob';

 SHOW GRANTS FOR 'bob';

/*
Revoke do the opposite: 
to revoke privileges you need to have the GRANT 
OPTION privilege and the particular privileges that you are revoking.

. Remember that you need to have all the privileges you are revoking,
 and thus this option is likely to be used only by an administrative user. 
*/

GRANT SELECT ON sakila.* TO bob;
REVOKE SELECT ON *.* FROM bob;

# removing all privilege with ability to assign the same to other use
REVOKE ALL PRIVILEGES, GRANT OPTION FROM bob;
-- all privileges
 SHOW GRANTS FOR 'john'@'192.168.%';
 
 
 -- When a user has every static privilege granted for a particular object, instead of 
 -- listing each and every one of them, MySQL will 
 -- output ALL PRIVILEGES instead.
 
 
 SHOW GRANTS;
SHOW GRANTS FOR CURRENT_USER;
SHOW GRANTS FOR CURRENT_USER();


 CREATE TABLE bobs_private_table
(id int PRIMARY KEY, data TEXT);

REVOKE ALL PRIVILEGES, GRANT OPTION FROM bob;

-- new user from root
create user test identified by 'test';

GRANT SELECT ON bobs_private_table TO bob;
    
    

GRANT SELECT ON sakila.bobs_private_table TO 'bob'
WITH GRANT OPTION;

 SHOW GRANTS FOR 'bob'@'localhost';
 
-- revoking grant privielge to bob as it has got the same grant option
 REVOKE GRANT OPTION ON sakila.bobs_private_table FROM 'bob';
 
 
 -- grant insert on specific table
  GRANT INSERT ON sakila.actor TO 'bob'@'localhost' WITH GRANT OPTION;
  
  
create user bob identified by 'bob';

create database abc;
GRANT ALL PRIVILEGES on abc.* TO 'bob';

drop user bob;