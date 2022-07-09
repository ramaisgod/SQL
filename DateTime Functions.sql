/********************************************************************************************
SQL SERVER - Date Time Functions

Note:-
if DATEDIFF() return 0 means it is Current
********************************************************************************************/

use INDIAN_BANK
go

-- 1) Getdate() -- it returns current date and time from system

select getdate() as TodayDate

select getdate()-1 as YesterdayDate

select getdate()+1 as TomorrowDate

select convert(varchar, getdate())

-- 2) Datediff() -- it returns difference between two dates interms of days/months/weeks/years etc. It takes 3 parameters


select DATEDIFF(YY, '1988/02/10', GETDATE()) -- display Year
select DATEDIFF(Y, '1988/02/10', GETDATE()) -- display Year
select DATEDIFF(MM, '1988/02/10', GETDATE()) -- display Months
select DATEDIFF(M, '1988/02/10', GETDATE()) -- display Months
select DATEDIFF(DD, '1988/02/10', GETDATE()) -- display Days
select DATEDIFF(D, '1988/02/10', GETDATE()) -- display Days
select DATEDIFF(HH, '1988/02/10', GETDATE()) -- display Hours
select DATEDIFF(HOUR, '1988/02/10', GETDATE()) -- display Hours
select DATEDIFF(MINUTE, '1988/02/10', GETDATE()) -- display Minutes
select DATEDIFF(MI, '1988/02/10', GETDATE()) -- display Minutes
select DATEDIFF(SS, '1988/02/10', GETDATE()) -- display Seconds
select DATEDIFF(MS, '1988/02/10', GETDATE()) -- display mili Seconds
select DATEDIFF(Q, '1988/02/10', GETDATE()) -- display quarter
select DATEDIFF(WK, '1988/02/10', GETDATE()) -- display week

-- Get the list of accounts with its age of accounts opened
select ACID, Name, ClearBalance, DOO, DATEDIFF(YY, DOO, GETDATE()) as Age_of_Accounts
from AccountMaster

-- get the list of accounts which opened in Current Year
select * 
from AccountMaster
where YEAR(DOO)=YEAR(getdate())

--or
select *
from AccountMaster
where DATEDIFF(YY, DOO, getdate())=0

-- get the list of accounts which opened in last Year
select * 
from AccountMaster
where YEAR(DOO)=YEAR(getdate())-1

--or
select *
from AccountMaster
where DATEDIFF(YY, DOO, getdate())=1

-- get the list of accounts which opened in last two quarter
select *, DATEDIFF(QQ, DOO, GETDATE()) as qtr
from AccountMaster
where DATEDIFF(QQ, DOO, getdate())<=1


-- 3) DatePart() -- It returns the part of the date. It always returns INTEGER value. It takes 2 arguments
select DATEPART(YY, '2015/07/20') -- display Year
select DATEPART(MM, '2015/07/20') -- display month
select DATEpart(DD, '2015/07/20') -- display day no.
select DATEPART(QQ, '2015/07/20') -- display quarter
select DATEPART(WW, '2015/07/20') -- display week
select DATEPART(WK, '2015/07/20') -- display week

-- current datepart
select DATEPART(YY, GETDATE()) -- current Year
select DATEPART(MM, GETDATE()) -- current month
select DATEpart(DD, GETDATE()) -- current day no.
select DATEPART(QQ, GETDATE()) -- current quarter
select DATEPART(WW, GETDATE()) -- current week
select DATEPART(WK, GETDATE()) -- current week
select DATEPART(HH, GETDATE()) -- current Hour
select DATEPART(MI, GETDATE()) -- current minutes
select DATEPART(SS, GETDATE()) -- current seconds


-- year wise , no of account opened
select DATEPART(YY, DOO) as 'Year', count(*) as 'NoOfAccountOpened'
from AccountMaster
Group by DATEPART(YY, DOO)

--or
select YEAR(DOO), COUNT(*)
from AccountMaster
group by YEAR(DOO)

-- list of account opened in 2020
select ACID, Name, ClearBalance, DATEPART(YY, DOO) as AccountOpenYear
from AccountMaster
where DATEPART(YY, DOO) = 2020

-- list of account opened in APRIL 2020
select ACID, Name, ClearBalance, DOO
from AccountMaster
where DATEPART(YY, DOO) = 2020 and DATEPART(MM, DOO) = 4 

-- list of account opened on 12-APRIL-2020
select ACID, Name, ClearBalance, DOO
from AccountMaster
where DATEPART(YY, DOO) = 2020 and DATEPART(MM, DOO) = 4 and DATEPART(DD, DOO)=12


-- 4) DateName() -- It returns the name of the day/month. It always return string. It takes 2 arguments.


select DATENAME(MM, getdate()) as DateNam
select DATEPART(MM, getdate()) as DateNo

select DATENAME(DD, getdate()) as DayNo
select DATEPART(DD, getdate()) as DayNo
select DATENAME(DW, getdate()) as DayNam

-- list the account opened on Sunday
select *, DATENAME(DW, DOO) as DayNames
from AccountMaster
where DATENAME(DW, DOO) = 'Sunday'

-- Year wise, quarter wise, month wise total balance
select DATEPART(YY, DOO) as YearNo, 'Q'+CAST(DATEPART(QQ, DOO) as varchar) as Qtr, datename(MM, DOO) as MonthNames, sum(ClearBalance) as TotalBalance
from AccountMaster
where BRID='BR1'
group by DATEPART(YY, DOO), DATEPART(QQ, DOO), datename(MM, DOO)



-- 4) DateAdd() -- 
-- It add/substracts days/months/years to given date and return the future/past date. It takes 3 arguments.

-- add 40 days in current date
select DATEADD(dd,40,getdate())

-- what was the date before 30 months
select DATEADD(mm,-30, getdate())

-- what will be date after 30 years
select DATEADD(yy, 30, getdate())


select *, DATEADD(dd,90,DOO) as DateAfter90Days
from AccountMaster


-- 4) EOMonth() -- It  return the end of the given date month. 
select EOMONTH('02/08/2022')

-- 
select *, EOMONTH(DOO) as MonthEndDate
from AccountMaster




