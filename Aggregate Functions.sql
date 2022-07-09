/********************************************************************************************
SQL SERVER - Aggregate Function

Execution of query
1) FROM
2) WHERE
3) Aggregation
4) SELECT (to display)
*********************************************************************************************/

use INDIAN_BANK
go

/**************** COUNT *********************************/
-- Get the no of rows
select count(*) from AccountMaster
-- here * doesn't matter. it is like junk latter. we can put any number any thing like below
select count(1) from AccountMaster
--or
select count(3443788434387) from AccountMaster
--or
select count('ram') from AccountMaster
--or
select count('%%#^*()@!#') from AccountMaster
--or
select count('%%#^*()@!#') from AccountMaster where BRID='BR1'

--If we pass column name inside count() then it will count only that particular column value and it will not count null
-- count(ColumnName) will not count null value
select count(Name) from AccountMaster  

select count(ClearBalance) from AccountMaster


select count(*) as 'CustomerCount' from AccountMaster

-- Get the no of rows with condition
select count(*) 
from AccountMaster
where BRID = 'BR1'

-- Get the no of customer in BR1 and BR2 branch
select count(*) 
from AccountMaster
where BRID = 'BR1' or BRID = 'BR2'

--or

select count(*)
from AccountMaster
where BRID in ('BR1', 'BR2')

/**************** SUM *********************************/
-- Get total balance in BR1
select sum(ClearBalance) as "Total"
from AccountMaster
where BRID='BR1'

/**************** MIN *********************************/
select min(ClearBalance) as "Minimum"
from AccountMaster

/**************** MAX *********************************/
select max(ClearBalance) as "Maximum"
from AccountMaster

/**************** Average *********************************/
select avg(ClearBalance) as "Average"
from AccountMaster

-- all

select count(*) as "No of Customer",
       Min(ClearBalance) as "Minimum",
	   Max(ClearBalance) as "Maximum",
	   Sum(ClearBalance) as "Total"
from AccountMaster


select count(*) as "No of Customer",
       Min(ClearBalance) as "Minimum",
	   Max(ClearBalance) as "Maximum",
	   Sum(ClearBalance) as "Total"
from AccountMaster 
where BRID='BR1'






