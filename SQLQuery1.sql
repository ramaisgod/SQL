-- Single Line Comments

/********
Multi 
Line 
comments
****/


-- Get Database Names
select name from sys.databases

select name from sysdatabases

exec sp_databases

-- display the list of databases except for system databases
select database_id, name from sys.databases where database_id > 4

select database_id, name from sys.databases where name not in ('master', 'model', 'msdb', 'tempdb')

-- get server name
select @@servername

/****
DDL (Data Difinition Language) Commands
CREATE
ALTER
DROP
TRUNCATE
*****/

--1) Create database
create database company
go

-- Find schema of database
sp_helpdb company

sp_helpdb 'company'


--2) Drop database
drop database ramdb
go

--3) Modify database
--alter database ramdb
--go

--Change the db context
use company
go

-- Create table syntax
/****************
create table [TableName]
(
ColumnName datatype primary key identity(seed, incr),
ColumnName datatype null,
ColumnName datatype not null,
Columnname datatype default(value),
ColumnName datatype not null check(expression),
ColumnName datatype null foreign key references PKTableName(PKColumnName)
)
******************/

create table Dept
(
DeptID		int				primary key,
DeptName	varchar(100)	not null
)
go

-- Find schema of the table
-- sp_help [TableName]
sp_help Dept

sp_help 'Dept'



/****
DML (Data Manipulation Language) Commands
SELECT
INSERT
UPDATE
DELETE
****/
-- see the table data
select * from Dept

-- insert data in table
insert into Dept values(10, 'Sales')
insert into Dept values(20, 'Purchase')
insert into Dept values(30, 'Technical')
insert into Dept values(40, 'Accounts')

-- another way to insert
insert into Dept values(50, 'Security'), (60, 'Audit')


-- Ctrl + R to show/hide result window 

-- Delete all rows from table
delete from dept

-- Delete a row from table
delete from dept where DeptID = 10

-- Update/Modify the specific data
update dept
set DeptName = 'Auditing'
where DeptID = 60

-- Update all rows 
update dept
set DeptName = 'R&D'


/**** 
TCL (Transaction Control Language) 
COMMIT
ROLLBACK
SAVE POINT
*****/

-- Rollback --
begin tran
	update dept set DeptName = 'R&D'
rollback

/*******
Note:- We cannot rollback without switch on the begin tran command 
We cannot rollback after commit command executed
******/

begin tran
	delete from dept

rollback

-- insert a row
begin tran
insert into Dept values (70, 'aaa')
update dept set DeptName='abc' where DeptID=10

rollback

commit


