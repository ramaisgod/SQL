/********************************************************************************************
SQL SERVER - Queries

Execution of query
1) FROM
2) WHERE
3) GROUP BY
4) Aggregation
5) Having
6) Order By
7) SELECT (to display)

Note:-
We should not use HAVING clause without GROUP BY and AGGREGATION
HAVING clause is used to filter the data based on AGGREGATION 

IN clause means like OR
Branch in ('BR1', 'BR2')


Put # before table name for TEMP TABLE like below
into #DiwaliSales2021

Temp Table is always created in tempdb database

Temp table will be auto drop by default once connection is close

********************************************************************************************/

use INDIAN_BANK
go

-- get first 5 rows and all columns
select top 5 * from AccountMaster

-- get first 5 rows and limited columns
select top 5 ACID,name from AccountMaster
-- or
select top(5) ACID, name from AccountMaster


-- calculate Percent using total no of rows
select 1524*5.0/100  

-- get first 5 percent rows and all columns
select top 5 percent * from AccountMaster

-- get first 20 perent rows and few columns
select top 20 percent ACID,name from AccountMaster

-- get last 5 rows 
select top 5 * from AccountMaster order by Name desc


-- latest rows with entire columns
select top 5 * from AccountMaster order by DOO desc

-- latest rows with few columns
select top 5 ACID, name, doo from AccountMaster order by DOO desc


-- month wise total account opened in 2017
select DATENAME(mm, doo) as MonthNam, COUNT(*) as TotalAccount
from AccountMaster
where DATEPART(YY,DOO)=2017
group by DATEPART(MM,DOO), DATENAME(mm, doo)
order by DATEPART(MM,DOO) asc


-- Product wise no of customers in branch-1
select PID, COUNT(*) as total
from AccountMaster
where BRID='BR1'
group by PID

-- Product wise no of customers in branch-1 if exceeds 9
select PID, COUNT(*) as total
from AccountMaster
where BRID='BR1'
group by PID
having COUNT(*)>9

-- Product wise balance in branch-1 if exceeds 9
select PID, SUM(ClearBalance) as total
from AccountMaster
where BRID='BR1'
group by PID
having SUM(ClearBalance) > 18000
order by SUM(ClearBalance) desc

-- Branch wise total amount in the month of January. Provide details if Total amount exceeds Rs 5000
select BRID, SUM(ClearBalance) as TotalAmount
from AccountMaster
where MONTH(DOO) = 1
group by BRID
having SUM(ClearBalance)>5000

--
select BRID, SUM(TXN_AMOUNT)
from TxnMaster
where BRID in ('BR1', 'BR2')
group by BRID	
having SUM(TXN_AMOUNT) > 50000


-- Branch wise total amount in the month if OCTOBER, provide details if Branch = BR2
select BRID, SUM(ClearBalance) as Amount
from AccountMaster
where MONTH(DOO)=10 and BRID='BR2'
group by BRID

--or-- not recommended beacuse HAVING clause should be use with aggregated function only 
select BRID, SUM(ClearBalance) as Amount
from AccountMaster
where MONTH(DOO)=10
group by BRID
having BRID='BR2'



-- Branch wise Total amount in last year Sept and Dec
select BRID, SUM(ClearBalance) as Total
from AccountMaster
where DATEDIFF(yy,DOO,getdate())=1 and DATEPART(MM, DOO) in (9,10)
group by BRID

-- Creating new permanent table for below query
select BRID, SUM(ClearBalance) as Total into BranchWiseSalesLastYear
from AccountMaster
where DATEDIFF(yy,DOO,getdate())=1
group by BRID

select * from BranchWiseSalesLastYear
where BRID in ('BR1', 'BR4')

-- Creating a new temporary table for below query
select BRID, SUM(ClearBalance) as Total into #DiwaliSales2021
from AccountMaster
where DATEDIFF(yy,DOO,getdate())=1
group by BRID

select * from #DiwaliSales2021

drop table #DiwaliSales2021


-- create backup table
select * into AccountMasterBackupOn13Feb2022 
from AccountMaster 

select * from AccountMasterBackupOn13Feb2022

/************************************************
What is difference between ORIGINAL TABLE and created using INTO statement
Answer:-
***When we use INTO statement, only data got copied and ALL THE CONSTRAINTS GOT DELETED. 
It means Primary key, Foreign key, etc will be deleted 

*************************************************/

-- Create a blank table -- permanent table
select * into New_Table from AccountMaster where 1=2   -- here give any false condition

select * from New_Table

-- create blank table for temp table
select * into #New_TEMP_Table 
from AccountMaster where 1=2

select * from #New_TEMP_Table 
