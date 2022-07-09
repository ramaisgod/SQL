/********************************************************************************************
SQL SERVER - Group by 

Execution of query
1) FROM
2) WHERE
3) GROUP BY
4) Aggregation
5) Order By
6) SELECT (to display)

Description:- 
It is used to group the data

Note:-
Any field present in the SELECT clause other than aggregate, should be also present in the GROUP BY clause.

Purpose of Group by:-
(1) Group By must be used alonwith aggregations.
(2) Do not use GROUP BY clause if there is not aggregation

*********************************************************************************************/

use INDIAN_BANK
go


-- Branch wise number of customer
select BRID, count(*) as 'totalCustomer'
from AccountMaster
group by BRID

-- Branch wise no. of  'Saving Account' customer 
select BRID, count(*) as 'Total Saving Account'
from accountmaster
where PID='SB'
group by BRID
-- in above query if count is zero then that particular will not display in result


-- Product wise no. of customer
select PID, count(*) as 'Total Customer'
from AccountMaster
group by PID

-- Product wise no. of customer in  order highest first
select PID, count(*) as 'Total Customer'
from AccountMaster
group by PID
order by 'Total Customer' desc

--or order using column number
select PID, count(*) as 'Total Customer'
from AccountMaster
group by PID
order by 2 desc

-- Product wise no. of customer, total balance, min  in  order highest first
select PID, count(*) as 'Total Customer', sum(ClearBalance) as 'TotalBalance', min(ClearBalance) as 'MinBal'
from AccountMaster
group by PID
order by 'Total Customer' desc


/********************************* Group in a Group ***************************************/
-- Branch and Product wise No. of customer, total balance
select BRID, PID, count(*) as TotalCustomer, sum(ClearBalance) as TotalBalance
from accountmaster
group by BRID, PID
order by BRID 

-- Branch and Product wise No. of customer, total balance which account opened in 2015
select BRID, PID, count(*) as TotalCustomer, sum(ClearBalance) as TotalBalance
from accountmaster
where year(DOO) = '2015'
group by BRID, PID
order by BRID 

-- List of all unique branches
-- Not recommended
select BRID 
from AccountMaster 
Group by BRID

-- Recommended
select distinct BRID 
from AccountMaster

/********************************* Using Distinct with aggregate ***************************************/

select count(distinct BRID) from AccountMaster

