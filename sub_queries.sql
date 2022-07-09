/****************************************************************************************
Sub queirs(inner query / Nested query) :-
A query in the WHERE/SELECT/HAVING clause is called sub-query
use '=' operator if sub query return single value
use 'in' operator if sub query return single column


*Sub-query can return only one value
*single column single value
*single column multiple value

***SQL server does not support multiple column in sub query

Two Types of sub queries:-
(1) Sub Queries
(2) Co-relation Sub Queries --	It is similar to Loop in a Loop concept. In this, outer query is executed first, and then 
								result is passed to inner query.
								Inner query always depends on outer query.
								Here, Execution is from Top to Bottom


Q1. When I will use Joins ?
Ans:- To display data from all tables

Q2. When I use sub-query / Co-relation sub-query ?
Ans:- Whenever If we want use other table to check condition or validate the data.


Two types of Database:-
(1) System database
(2) User database


Two types of table:-
(1) System tables
(2) User tables


Notes:-
Sub query will execute first.
Execution Level--> Bottom to Top

Max 32 levels nesting  is allowed in the sub-queries

****************************************************************************************/
use INDIAN_BANK
go

-- NULLIF -- It is used to compare two values
-- It takes 2 parameters if both value are same then it returns NULL otherwise it returns 1st value
select nullif(5,5)
select nullif(5,10)
select nullif(-5,-10)
select nullif('ram', 'ram')
select nullif('ram', 'shyam')

select acid, name, ClearBalance, UnclearBalance,  nullif(ClearBalance, UnclearBalance) as Balance
from AccountMaster


-- who have the highest balance in bank
-- wrong approach
select top 1 ACID, Name, ClearBalance
from AccountMaster
order by ClearBalance desc

-- correct approach
select name 
from AccountMaster 
where ClearBalance = (select MAX(clearbalance) 
from AccountMaster)

-- get account info with diff ClearBalance and Average balance
select acid, name, ClearBalance-(select AVG(ClearBalance) from AccountMaster) as diff
from AccountMaster

select AVG(clearbalance) from AccountMaster

-- Who has the 2nd highest balance in the Bank?
select Name, ClearBalance 
from AccountMaster
where ClearBalance = 
				(
					select MAX(ClearBalance)
					from AccountMaster
					where ClearBalance <(
										select MAX(ClearBalance)
										from AccountMaster
										))

/*************** Example of Co-relation Sub Queries ***********************************************/
--List the details of accouts who does not have any transaction

select * 
from AccountMaster
where not exists (
			select * 
			from TxnMaster 
			where  AccountMaster.ACID = TxnMaster.ACID
			)

-- EXISTS is boolean function will find the at least one records present or not and return True or False


/****************************************************************************************/

-- exec sp_tables

-- List of the tables created in Indian_bank database
use INDIAN_BANK
select * from sys.tables

select COUNT(*) from sys.tables

-- Get the total no of columns 
select * from sys.all_columns


-- Get the total no of columns in AccountMaster table using object_id
select * from sys.all_columns where object_id=1221579390

-- Get the total no of columns in AccountMaster table
select * from sys.all_columns where object_id=(select OBJECT_ID from sys.tables where name='AccountMaster')


-- how to find specific column in a database
-- i'm searching Status column 
select * from sys.all_columns where name = 'status'
select * from sys.tables where object_id=34099162

 -- search the column name
 select col.name as COlName, tbl.name as TableName 
 from sys.all_columns as col 
		inner join sys.tables as tbl on col.object_id = tbl.object_id
where COl.name='ClearBalance'

-- check the table exists or not if exits then drop otherwise create

if exists (select * from sys.tables where name = 'employee')
drop table employee
go
create table employee
(
empid int primary key,
name varchar(40),
doj datetime,
managerid int foreign key references employee(empid)
)
go

select * from employee

-- drop the database if exists otherwise create


if exists(select * from sys.databases where name='School')
drop database School
go
create database School


-- if database not available then create database

if not exists (select * from sys.databases where name='School')
	create database School


select * from sys.tables
exec sp_tables

-- all stored procedures
select * from sys.procedures


-- all triggers
select * from sys.triggers

-- if I want to drop all the tables. we can do magic like run the below query the copy the output and execute 
select 'drop table ' + name from sys.tables
