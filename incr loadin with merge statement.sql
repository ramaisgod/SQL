/****************************************************************************************
incr loadin with merge statement

****************************************************************************************/
use INDIAN_BANK
go


if exists(select * from sys.databases where name = 'mergedb')
drop database mergedb
go
create database mergedb
go

use mergedb
go


-- Merge in SQL server
-- Incremental data loading

-- create source table
create table Emp
(
eid int primary key,
name varchar(100) not null,
salary money not null
)
go


insert into Emp values(1, 'Sanjana', 1000)
insert into Emp values(2, 'Ram', 2000)
go



-- create destination table
create table DimEmp
(
eid int primary key,
name varchar(100) not null,
salary money not null
)
go


---- Merge command ---------------------------------------------------
merge DimEmp as T
using Emp as S
on T.eid = S.eid
--insert
when not matched by target 
Then
insert (eid, name, salary) values (s.eid, s.name, s.salary)
--update
when matched and t.name <> s.name or t.salary <> s.salary 
then
update
set t.name = s.name, t.salary = s.salary
--delete
when not matched by source
then delete;
-----------------------------------------------------------------------
 
select * from Emp  -- soruce table
select * from DimEmp  -- destination table


insert into Emp values(3, 'Kiran', 4000)
insert into Emp values(4, 'Pooja', 5000)
go	

update Emp
set name='ram k prasad'
where eid=2

delete Emp where eid=4

-- adding a new column in destination table to capture updated_on date
alter table DimEmp
add Updated_on datetime

truncate table DimEmp


---- Merge command ---------------------------------------------------
merge DimEmp as T
using Emp as S
on T.eid = S.eid
--insert
when not matched by target 
Then
insert (eid, name, salary, Updated_on) values (s.eid, s.name, s.salary, getdate())
--update
when matched and t.name <> s.name or t.salary <> s.salary 
then
update
set t.name = s.name, t.salary = s.salary, t.Updated_on = getdate()
--delete
when not matched by source
then delete;
-----------------------------------------------------------------------
 

select * from Emp  -- soruce table
select * from DimEmp  -- destination table
