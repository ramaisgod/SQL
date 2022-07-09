/********************************************************************************************
SQL SERVER - Practice Exercise

********************************************************************************************/

use INDIAN_BANK
go

-- (1) week wise no. of accounts opened in last month

select DATEPART(WK,DOO) as WEEKNO, COUNT(*) as TotalCount
from AccountMaster
where DATEDIFF(mm,doo,getdate())=1
group by DATEPART(WK,DOO)

--(2) List the names of account holders who have opened accounts in the last 5 days

select name, doo, DATEDIFF(dd,DOO, getdate())
from AccountMaster
where DATEDIFF(dd,DOO, getdate()) <=5

--(3) List branch wise, product wise, total amount as on last friday

select BRID, PID, SUM(Clearbalance) as Total_Amount
from AccountMaster
where DOO <= '04/02/2022'
group by BRID, PID

--(4) List the customer who opened accounts in the first week of last month.

select name,DOO, DATEDIFF(mm,doo,getdate()) as MonthNo, DATEPART(wk,doo) as WeekNO
from AccountMaster
where DATEDIFF(mm,doo,getdate()) = 1 and DATEPART(wk,DOO)>=1

--(5) How many customers opened accounts in last date of previous month?

select COUNT(*)
from AccountMaster
where DATEDIFF(mm,doo,getdate())=1 and DAY(EOMONTH(DATEADD(m,-1,getdate()))) = DAY(DOO)

--(6) Find out the last month name

select DATENAME(mm,DATEADD(M,-1,getdate()))

--(7) Find out the last day of the current month
select DAY(EOMONTH(getdate()))

--(8) Find out the first day name of the Current Month

select DATENAME(Dw,DATEADD(DD,-day(EOMONTH(getdate()))+1,EOMONTH(getdate())))
