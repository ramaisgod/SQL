/********************************************************************************************
SQL SERVER - CASE STUDY

Name: Code for Indian Bank
Author: Ram
Date: 03-Feb-2022

Purpose:- This script will create a database and some tables
‘O’ for ‘OPERATIVE’,     ‘I’ for ‘INOPERATIVE’, ‘C’ for ‘CLOSED’;
*********************************************************************************************
Ctrl + Shift + L   ------ for Lower case
Ctrl + Shift + U   ------ for Upper case
*********************************************************************************************/

use master
go

create database INDIAN_BANK
go

use Indian_Bank
go

-- PRODUCT MASTER
create table ProductMaster
(
PID CHAR(2) PRIMARY KEY,
ProductName varchar(25) not null
)
go

--insert data
insert into ProductMaster values('SB', 'Saving Bank')
insert into ProductMaster values('LA', 'Loan Account')
insert into ProductMaster values('FD', 'Fixed Deposit')
insert into ProductMaster values('RD', 'Recurring Deposit')
go

select * from ProductMaster
go

-- REGION MASTER
create table RegionMaster
(
RID integer primary key,
RegionName varchar(6) not null
)
go

--insert data
insert into RegionMaster values(1, 'South')
insert into RegionMaster values(2, 'North')
insert into RegionMaster values(3, 'East')
insert into RegionMaster values(4, 'West')
go

select * from RegionMaster
go

--BRANCH MASTER	
create table BranchMaster
(
BRID char(3) primary key,
BranchName varchar(30) not null,
BranchAddress varchar(50) not null,
RID int foreign key references RegionMaster(RID) not null
)
go

-- insert data
insert into BranchMaster values('BR1', 'Goa', 'Opp: Caculo Mall, Panaji, Goa-403001', 2)
insert into BranchMaster values('BR2', 'Hyd', 'Near Hi-Tech City, Hyderabad-500012', 1)
insert into BranchMaster values('BR3', 'Manipur', 'Nagaon, Manipur-782105', 3)
insert into BranchMaster values('BR4', 'Mumbai', 'Pushpa Park, Malad, Mumbai-400096', 4)
go

select * from BranchMaster
go

--USER MASTER
create table UserMaster
(
UserID integer primary key,
UserName varchar(30) not null,
Designation char(1) check(Designation in ('M', 'T', 'C', 'O')) not null
)
go

--insert data
insert into UserMaster values(1, 'Ram Krishna', 'M')
insert into UserMaster values(2, 'Abhisheak Saraswat', 'O')
insert into UserMaster values(3, 'Vivek Singh', 'M')
insert into UserMaster values(4, 'Satyam Jagrit', 'C')
insert into UserMaster values(5, 'Priya', 'T')
insert into UserMaster values(6, 'Mahima', 'C')
go

select * from UserMaster
go

--ACCOUNT MASTER
create table AccountMaster
(
ACID integer primary key,
Name varchar(40) not null,
Address varchar(50) not null,
BRID char(3) not null foreign key references BranchMaster(BRID),
PID char(2) not null foreign key references ProductMaster(PID),
DateOfOpening datetime not null,
ClearBalance money null,
UnclearBalance money null,
Status char(1) not null check(Status in ('O', 'I', 'C')) default('O')
)
go

--insert data
insert into AccountMaster values(101, 'Priyanka', 'USA', 'BR1', 'SB', '2018/10/22', 1000, 1000, 'O')
insert into AccountMaster values(102, 'Usha Singh', 'Mumbai', 'BR2', 'SB', '2020/02/10', 2000, 2000, 'O')
go

select * from AccountMaster
go

--TRANSACTION MASTER
create table TxnMaster
(
TNO int primary key identity(1,1),
DOT datetime not null,
ACID integer foreign key references AccountMaster(ACID) not null,
BRID char(3) foreign key references BranchMaster(BRID) not null,
TXN_TYPE char(3) check(TXN_TYPE in ('CW', 'CD', 'CQD')) not null,
CHQ_NO int null,
CHQ_DATE smalldatetime null,
TXN_AMOUNT money not null,
UserID int foreign key references UserMaster(UserID) not null
)
go

--insert data
insert into TxnMaster values('2021/05/25', 101, 'BR1', 'CD', null, null, 1000, 1)
insert into TxnMaster values('2022/01/03', 102, 'BR1', 'CD', null, null, 500, 3)

select * from TxnMaster
go


-- add check constraint to TxnMaster
alter table TxnMaster
add check (TXN_AMOUNT >= 0)

--or
alter table TxnMaster
add constraint CK__TxnMaster__TxnAmount_Cannot_Negative check(TXN_AMOUNT >=0)


go

sp_help TxnMaster

-- drop FK 
alter table TxnMaster
drop constraint FK__TxnMaster__BRID__5165187F

-- add FK
alter table TxnMaster
add foreign key (BRID) references BranchMaster(BRID)

-- rename column
sp_rename 'AccountMaster.DateOfOpening', 'DOO'
go

select * from AccountMaster
go

truncate table AccountMaster

alter table AccountMaster
add foreign key (PID) references ProductMaster(PID) 

sp_help AccountMaster
