/*************************************************************************************************
Name: Code for School DB
Author: Bhaskar Jogi
Date: 19-Jan-2022
Purpose: This script will create DB and few table to store school information
**************************************************************************************************/

-- SQL SERVER – CASE STUDY          
use model
go

-- create database
create database School
go

-- find database schema
sp_helpdb school

-- change the db context
use school
go


-- CourseMaster
/************************************************
Category ---- B=Basic, M=Medium, A=Advance
*************************************************/
create table CourseMaster
(
	CID			int			primary key,
	CourseName	varchar(40) not null,
	Category	char(1)		null check(Category = 'B' or Category = 'M' or Category = 'A'),
	Fee			smallmoney	not null check(Fee >= 0)
)
go

-- schema of table
sp_help CourseMaster

-- insert data 
insert into CourseMaster values(10, 'Java', 'B', 10000)
insert into CourseMaster values(20, 'Python', 'A', 40000)
insert into CourseMaster values(30, 'SQL Server', 'M', 15000)
insert into CourseMaster values(40, 'Big Data', 'B', 30000)
insert into CourseMaster values(50, 'Oracle', 'B', 41000)
insert into CourseMaster values(60, 'Power BI', 'A', 20000)
insert into CourseMaster values(70, 'Django', 'M', 45000)
insert into CourseMaster values(80, 'Excel', 'A', 5000)

-- read data
select * from CourseMaster

-- StudentMaster
/************************************************
Origin ---- L=Local, F=Foreign
Type ---- U=UnderGraduate , G=Graduate
*************************************************/
create table StudentMaster
(
	SID tinyint primary key,
	Name varchar(40) not null,
	Origin char(1) not null check(Origin = 'L' or Origin = 'F'),
	Type char(1) not null check(Type = 'U' or Type = 'G')
)
go

-- insert data
insert into StudentMaster values(1, 'Ram Krishna', 'L', 'G')
insert into StudentMaster values(2, 'Abhishek Saraswat', 'L', 'G')
insert into StudentMaster values(3, 'Joe Biden', 'F', 'U')
insert into StudentMaster values(4, 'Eric Jonson', 'F', 'G')

-- read data
select * from StudentMaster

--EnrollmentMaster 
/************************************************
DOE = Date of Enrollment
FWF  = Fee Weaver Flag

check(Grade='O' or Grade='A' or Grade='B' or Grade='C')
or
check(Grade in ('O', 'A', 'B', 'C'))
*************************************************/
create table EnrollmentMaster
(
CID		int			not null foreign key references CourseMaster(CID),
SID		tinyint		not null foreign key references StudentMaster(SID),
DOE		datetime	not null,
FWF		bit			not null,
Grade	char(1)		null check(Grade in ('O', 'A', 'B', 'C'))
)
go


-- insert data
insert into EnrollmentMaster values(20, 1, '2022/01/20', 0, 'C')
insert into EnrollmentMaster values(40, 3, '2021/11/15', 0, 'C')
insert into EnrollmentMaster values(20, 4, '2021/07/11', 1, 'B')
insert into EnrollmentMaster values(30, 3, '2022/01/03', 1, 'A')

-- read data
select * from EnrollmentMaster

--  A table can only have one timestamp column. 
create table abc(
name varchar(40),
age int,
--modified_date timestamp,
modified timestamp
)


insert into abc(name, age) values('ram', 23) -- 0x00000000000007D1
											
select * from abc
update abc 
set age=40 where name='ram'

drop table abc


--  A table can have multiple GUID Globally UniqueIdentifier column. 
create table xyz(
name varchar(40),
age int,
barcode uniqueidentifier default newid(),
modified timestamp,
barcode2 uniqueidentifier default newid(),
)

select * from xyz

insert into xyz([name], [age]) values('rhona', 22)

select * from xyz

drop table xyz


select distinct(name) from xyz union select distinct(name) from abc