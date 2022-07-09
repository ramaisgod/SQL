/********************************************************************************************
SQL SERVER - CASE STUDY

Name: Code for Supplier Database
Author: Ram
Date: 01-Feb-2022

Purpose:- This script will create a database and some tables
*********************************************************************************************/

use master
go

create database Supplier
go

use Supplier
go

-- SupplierMaster
create table SupplierMaster
(
SID integer primary key,
NAME VARCHAR(40) NOT NULL,
CITY CHAR(6) NOT NULL,
GRADE TINYINT NOT NULL CHECK(GRADE > 0 AND GRADE < 5)
)
go

/*
alter table SupplierMaster
alter column NAME varchar(40)
*/

-- INSERT DATA
insert into SupplierMaster values(10, 'Mahesh Dukande', 'Mumbai', 1)
insert into SupplierMaster values(20, 'Prochi Mistri', 'Mumbai', 3)
insert into SupplierMaster values(30, 'Sayali Gorpade', 'Pune', 2)
insert into SupplierMaster values(40, 'Amudha', 'HYD', 4)
insert into SupplierMaster values(50, 'Alisha', 'Mumbai', 1)
insert into SupplierMaster values(60, 'Sherry', 'Delhi', 2)
insert into SupplierMaster values(70, 'Mubin Shaikh', 'Delhi', 3)
insert into SupplierMaster values(80, 'Rohit Vadiya', 'HYD', 2)
insert into SupplierMaster values(90, 'Sameer Khan', 'Pune', 1)
insert into SupplierMaster values(100, 'Deepak Lalwani', 'HYD', 4)
go

select * from SupplierMaster
go
-- PartMaster

create table PartMaster
(
PID tinyint primary key,
NAME VARCHAR(40) NOT NULL,
PRICE MONEY NOT NULL,
CATEGORY TINYINT NOT NULL,
QTYONHAND INTEGER NULL
)
go

-- INSERT DATA
insert into PartMaster values(1, 'Keyboard', 800, 1, 100)
insert into PartMaster values(2, 'Mouse', 600, 1, 150)
insert into PartMaster values(3, 'Processor', 64000, 2, 20)
insert into PartMaster values(4, 'Hard Disk', 6000, 3, 50)
insert into PartMaster values(5, 'DDR3 RAM', 3000, 3, 100)
insert into PartMaster values(6, 'Pen Drive', 1000, 1, 200)
insert into PartMaster values(7, 'LED Monitor', 15000, 4, 70)
go

select * from Partmaster
go

-- SupplyDetails

CREATE TABLE SupplyDetails
(
PID TINYINT FOREIGN KEY REFERENCES PartMaster(PID),
SID INTEGER FOREIGN KEY REFERENCES SupplierMaster(SID),
DATEOFSUPPLY DATETIME NOT NULL,
CITY VARCHAR(40) NOT NULL,
QTYSUPPLIED INTEGER NOT NULL
)
go

-- INSERT DATA
insert into SupplyDetails values(1, 70, '2021/06/22', 'Mumbai', 50)
insert into SupplyDetails values(1, 50, '2021/07/25', 'Pune', 10)
insert into SupplyDetails values(1, 30, '2020/09/27', 'Delhi', 5)
insert into SupplyDetails values(1, 40, '2020/12/03', 'Mumbai', 20)
insert into SupplyDetails values(2, 60, '2022/01/11', 'Kolkata', 60)
insert into SupplyDetails values(2, 10, '2020/05/25', 'Delhi', 20)
insert into SupplyDetails values(2, 90, '2021/11/12', 'Pune', 3)
insert into SupplyDetails values(2, 40, '2019/12/29', 'Goa', 12)
insert into SupplyDetails values(3, 50, '2020/07/04', 'Goa', 4)
insert into SupplyDetails values(3, 80, '2019/09/18', 'HYD', 2)
insert into SupplyDetails values(4, 30, '2021/11/13', 'Delhi', 12)
insert into SupplyDetails values(4, 20, '2019/12/16', 'Mumbai', 10)
insert into SupplyDetails values(5, 40, '2022/01/31', 'Mumbai', 5)
insert into SupplyDetails values(5, 20, '2021/02/29', 'Pune', 15)
insert into SupplyDetails values(6, 70, '2021/04/30', 'Delhi', 50)
insert into SupplyDetails values(6, 40, '2019/05/31', 'Kolkata', 40)
insert into SupplyDetails values(6, 50, '2019/10/30', 'HYD', 30)
insert into SupplyDetails values(4, 60, '2021/08/15', 'Mumbai', 11)
insert into SupplyDetails values(3, 20, '2021/12/20', 'Goa', 7)
go

select * from SupplyDetails
go

use Supplier
go

/**********************************************************************************************************
1.	List the month-wise average supply of parts supplied for all parts. Provide the information only 
if the average is higher than 20.
***********************************************************************************************************/
select DATENAME(mm, DATEOFSUPPLY), PartMaster.[NAME], avg(QTYSUPPLIED) as AVGERAGE from SupplyDetails 
	join PartMaster on PartMaster.PID = SupplyDetails.PID group by SupplyDetails.PID, PartMaster.[NAME] ,DATENAME(mm, DATEOFSUPPLY)

