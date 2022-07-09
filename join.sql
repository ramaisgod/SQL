/****************************************************************************************
Q. Why Joins ?
Ans. To retrieve the data from more than 1 table.

Q. How many tables can we join in sql ?
Ans. We can join upto 255 tables

Note:- To join the tables, we must have a common column.

There are 4 types of join:-
1) Inner Join / Simple Join / Natural Join / Equi Join
2) Outer Join
	Left
	Right
	Full
3) Corss Join (It is also called Cartesian Product)
4) Self Join


Old Syntax:

Inner Join (2 Tables):-
select * from T1, T2 where T1.PK = T2.FK

Inner Join (3 Tables):-
select * from T1, T2, T3 where T1.PK = T2.FK and T3.PK = T1.PK

Note:- When we join n tables, we must have n-1 joining conditions
****************************************************************************************/

use school
go

select * from CourseMaster
select * from EnrollmentMaster
select * from StudentMaster

-- Old Syntax (1970 by IBM)
select * from StudentMaster, EnrollmentMaster where StudentMaster.SID = EnrollmentMaster.SID

select * from StudentMaster, CourseMaster, EnrollmentMaster
	where StudentMaster.SID = EnrollmentMaster.SID and CourseMaster.CID = EnrollmentMaster.CID


-- New Syntax (1992 by ANSI) - SQL 92 Syntax
-- inner join 2 Table
/*********************************************
select * from T1 
		join T2 on T1.PK=T2.FK

*********************************************/
select * from StudentMaster join EnrollmentMaster on StudentMaster.SID = EnrollmentMaster.SID

select * from StudentMaster as sm join EnrollmentMaster as em on sm.SID=em.SID

select * from StudentMaster sm join EnrollmentMaster em on sm.SID=em.SID

-- inner join 3 Table
/*********************************************
select * from T1 
		join T2 on T1.PK=T2.FK
		join T3 on T3.PK=T2.FK
		join T4 on T4.PK=T1.FK
*********************************************/
select * from CourseMaster
		join EnrollmentMaster on EnrollmentMaster.CID = CourseMaster.CID
		join StudentMaster on StudentMaster.SID=EnrollmentMaster.SID

-- left join
select * from StudentMaster 
	left join EnrollmentMaster on EnrollmentMaster.SID = StudentMaster.SID

-- right join
select * from StudentMaster 
	right join EnrollmentMaster on EnrollmentMaster.SID = StudentMaster.SID

--full join
select * from StudentMaster
	full join EnrollmentMaster on EnrollmentMaster.SID = StudentMaster.SID

-- join 3 Table
select * from StudentMaster 
		inner join EnrollmentMaster on EnrollmentMaster.SID=StudentMaster.SID
		right join CourseMaster on CourseMaster.CID=EnrollmentMaster.CID


-- Some query
select Name, CourseName, SUM(CourseMaster.Fee) as total_fee from EnrollmentMaster 
		inner join CourseMaster on CourseMaster.CID = EnrollmentMaster.CID
		right join StudentMaster on StudentMaster.SID=EnrollmentMaster.SID
		group by Name, CourseName

-- change dhowner
use AdventureWorks2014 EXEC sp_changedbowner 'sa'

