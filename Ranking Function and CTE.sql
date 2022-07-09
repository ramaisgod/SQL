/****************************************************************************************
Ranking Function and CTE (Common Table Expression)
Row_Number()
Rank()
Dense_Rank()
NTILE()

Syntax:-

select	Column,
		RankFunctionName()
		OVER(order by Column desc/asc)
		as alias
from TableName

Note:-
Row_Number always start with 1

Difference between Rank() and Dense_Rank() function:-
Rank() function leave gap in ranking if any duplicate 
Dense_Rank() function works without gap

NTILE() :- It equally split the data into given times
like ntile(2) --- split data 50-50% into 2 groups


Derived Table works slow
 

Derived Tables:- Create once use once, Single query scope

CTE:- Create once use many times, Single query scope. It stores in TempDB database

Local Temp Tables (#):- Create once, use many times, Window level scope

Global Temp Tables (##):- Create once, use many times, across window scope
****************************************************************************************/
use INDIAN_BANK
go

-- Row_Number() example
select ACID, Name, ClearBalance, ROW_NUMBER() over(order by ClearBalance asc) as RNo
from AccountMaster

--get 5th row data
select * 
from
	(select ACID, Name, ClearBalance, ROW_NUMBER() over(order by ClearBalance asc) as Rno
	from AccountMaster) as k
where Rno=5


--get from 5th to 10th row data
select * 
from
	(select ACID, Name, ClearBalance, ROW_NUMBER() over(order by ClearBalance asc) as Rno
	from AccountMaster) as k
where Rno between 5 and 10


-- Partition by  Example
select ACID, Name, BRID, ClearBalance, ROW_NUMBER() over(partition by BRID order by Clearbalance asc) as Rno
from AccountMaster 


-- 1st customer in each branch
select *
from
	(select ACID, Name, BRID, ClearBalance, ROW_NUMBER() over(partition by BRID order by ACID asc) as Rno
	from AccountMaster) as t1
where Rno=1

--get Every 5th row
select *
from
	(select ACID, Name, BRID, ClearBalance, ROW_NUMBER() over(order by ACID asc) as Rno
	from AccountMaster) as t
where Rno%5=0


--get alternate row
select *
from
	(select ACID, Name, BRID, ClearBalance, ROW_NUMBER() over(order by ACID asc) as Rno
	from AccountMaster) as t
where Rno%2=0


-- Rank() example
select *, RANK() over(order by ClearBalance desc) as RankNo
from AccountMaster

-- Rank() and Dense_rank()  example
select ACID,Name, BRID, ClearBalance, 
	RANK() over(order by ClearBalance desc) as RankNo,
	DENSE_RANK() over(order by ClearBalance desc) as DenseRankNo
from AccountMaster


-- who is having 2nd Hightest balance in bank
select *
from
	(select ACID, Name, BRID, ClearBalance, DENSE_RANK() over(order by ClearBalance desc) as rnk
	from AccountMaster) as tmp
where rnk=2


-- branch wise 2nd highest balance  in bank
select * 
from
	(select ACID, Name, BRID, ClearBalance, DENSE_RANK() over(partition by BRID order by ClearBalance desc) as rnk
	from AccountMaster) as temp
where rnk=2

-- NTILE() example-- split data into 3 parts
select *, NTILE(3) over(order by ACID asc) as grp
from AccountMaster

-- take 1st part of 1/3rd split of data
select *
from
	(select *, NTILE(3) over(order by ACID asc) as grp
	from AccountMaster) as temp
where grp=1

-- Branch wise split data into 2 parts
select *, NTILE(2) over(partition by BRID order by ACID) as grp
from AccountMaster

-- branch wise 1st split of data
select * 
from
	(select *, NTILE(2) over(partition by BRID order by ACID) as grp
	from AccountMaster) as temp
where grp=1

/********************************************** CTE **************************************************************************

CTE (Common Table Expression) :- It is similar to derived table but it can be declared once and use many times in same query.
It follow reusability 
syntax-

with <CTE Name>
as
(
	Select statement
)
Select * from <CTE Name>

******************************************************************************************************************************/

with My_CTE
as
(
select ACID, Name, BRID, ClearBalance, DENSE_RANK() over(order by ClearBalance desc) as Rnk 
from AccountMaster
)
select name, ClearBalance from My_CTE where Rnk=1


-- Which Branch having 2nd largest customer 
select * 
from 
	(select BRID, COUNT(*) as CustomerCount, DENSE_RANK() over(order by COUNT(*) desc) as Rnk
	from AccountMaster
	group by BRID) as temp
where Rnk=2


-- get max 
select MAX(cnt)
from
	(select COUNT(*) as cnt
	from AccountMaster
	group by BRID) as t


-- or without rank. using derived table
select BRID, cnt
from
	(select BRID, COUNT(*) as cnt
	from AccountMaster
	group by BRID) as temp
where cnt = (
			select MAX(cnt)
			from
				(select COUNT(*) as cnt
				from AccountMaster
				group by BRID) as t
)

-- or using CTE

with k
as
(
select BRID, COUNT(*) as cnt
from AccountMaster
group by BRID
)
select * from k where cnt= (select MAX(cnt) from k)


-- 2nd max 
with k
as
(
select BRID, COUNT(*) as cnt
from AccountMaster
group by BRID
)
select * from k where cnt = (
							select MAX(cnt) 
							from k 
							where cnt < (
										select MAX(cnt) 
										from k
										)
							)


/*********************** Temp Table *********************************************************************************

Local Temp Table  (#) --- It can be used in same window/connection
Global Temp Table  (##) --- It can be used in multiple windows/connection


**********************************************************************/
select BRID, COUNT(*) as cnt into #tempTable
from AccountMaster
group by BRID


-- Which Branch having largest customer -- using temp table

select * 
from #tempTable
where cnt=(
			select MAX(cnt) from #tempTable
		)


--2nd largest customer -- using temp table

select *
from #tempTable
where cnt = (
				select MAX(cnt) from #tempTable where cnt < (select MAX(cnt) from #tempTable)
			)


/*********************** Global Temp Table ********/

select BRID, COUNT(*) as cnt into ##tempTable
from AccountMaster
group by BRID

select * from ##tempTable

/************ Remove duplicate using CTE *******************/

create table empname
(
name varchar(100)
)

insert into empname values('ram')
insert into empname values('shyam')
insert into empname values('vivek')
insert into empname values('simran')
insert into empname values('ram')
insert into empname values('vivek')
insert into empname values('ram')


-- get the duplicate records
select name, COUNT(*) as cnt
from empname
group by name
having COUNT(*) > 1

-- display unique value

select distinct name
from empname

go
 
 -- remove duplicate using cte
with k_cte
as
	(
		select name, ROW_NUMBER() over (partition by name order by name desc) as Rno
		from empname
	)
delete k_cte
where Rno > 1	


select * from empname
 
/************ Running Total *******************/
--window function

select ACID, Name, ClearBalance, SUM(ClearBalance) over(order by ACID asc) as RunningTotal
from AccountMaster

-- Branch wise running total
select ACID, Name, BRID, ClearBalance, SUM(ClearBalance) over(partition by BRID order by ACID asc) as RunningTotal
from AccountMaster


-- get new customer
select * from customersales

create view new_customer as
select CONCAT(DATENAME(mm, minsaledate),'-',DATENAME(YY, minsaledate)) as TransactionMonth, COUNT(*) as newcustomer
from
(select Customer, MIN(SaleDate) as minsaledate
from customersales
group by Customer) as temp
group by CONCAT(DATENAME(mm, minsaledate),'-',DATENAME(YY, minsaledate))


