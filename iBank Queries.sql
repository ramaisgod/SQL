/****************************************************************************************

iBank Queries

****************************************************************************************/
use INDIAN_BANK
go

-- II. VIEW REQUIREMENTS --
-- Only the Account Number, Name and Address from the ‘Account Master’
select ACID, Name, Address 
from AccountMaster


--Account Number, Name, Date of last Transaction, total number of transactions in the Account
select am.ACID, Name, COUNT(*) as TotalTxn, MAX(tm.DOT) as LastTxnDate
from AccountMaster as am inner join TxnMaster as tm
on am.ACID = tm.ACID
group by am.ACID, Name


--Branch-wise, Product-wise, sum of Uncleared balance      
select BRID, PID, sum(UnclearBalance) as TotalUnclearedBalance
from AccountMaster
group by BRID, PID


--Customer-wise, number of accounts held                   
select Name, COUNT(*)
from AccountMaster
group by Name

--TransactionType-wise, Account-wise, sum of transaction amount for the current month
select TXN_TYPE, tm.ACID, SUM(TXN_AMOUNT) as Total
from AccountMaster as am inner join TxnMaster as tm
on am.ACID=tm.ACID
where DATEDIFF(mm,DOT,getdate())=0
group by TXN_TYPE, tm.ACID


--III. QUERY REQUIREMENTS 
--List the transactions that have taken place in a given Branch during the  previous month
select am.ACID, Name, tm.BRID, DOT
from AccountMaster as am inner join TxnMaster as tm
on am.ACID=tm.ACID
where am.BRID=tm.BRID and DATEDIFF(mm,dot,getdate())=1


--Give the branch-wise total cash deposits that have taken place during the last 5 days
select BRID, SUM(Txn_Amount) as TxnAmount
from TxnMaster
where TXN_TYPE='CD' and DATEDIFF(dd,DOT,getdate())=5
group by BRID


--Give the branch-wise total cash withdrawals during the last month, where the total cash withdrawals are greater than Rs 50000
select BRID, SUM(Txn_Amount) as amount 
from TxnMaster
where TXN_TYPE='CW' and DATEDIFF(MM,DOT, getdate())=1
group by BRID
having SUM(Txn_Amount) > 50000


--List the names of the account holders with corresponding branch names, in respect of the maximum and minimum Cleared balance 
select * from
(select *, DENSE_RANK() over(order by  ClearBalance asc) as newrank, DENSE_RANK() over(order by  ClearBalance desc) as newrank2
from AccountMaster) as t
where newrank=1 or newrank2=1


--List the names of the account holders with corresponding branch names, in respect of the second-highest maximum and minimum Cleared balance
select ACID,Name,BRID,ClearBalance
from
(select *, DENSE_RANK() over(order by ClearBalance asc) as newRankMin, DENSE_RANK() over(order by ClearBalance desc) as newRankMax 
from AccountMaster) as t
where newRankMin=2 or newRankMax = 2


--List the name of the account holder who has the second-highest cleared balance in the branch having the account with the maximum cleared balance.
select *, DENSE_RANK() over(order by ClearBalance desc) as myrank3
from
(select *, DENSE_RANK() over(order by ClearBalance desc) as myrank2
from AccountMaster
where BRID =
(select BRID from
(select *, DENSE_RANK() over(order by ClearBalance desc) as myrank
from AccountMaster) temp1
where myrank=1)) as temp2
where myrank2=2


--Give the TransactionType-wise, branch-wise, total amount for the day
select TXN_TYPE, BRID, SUM(TXN_AMOUNT) as total
from TxnMaster 
where DATEDIFF(dd,DOT,getdate()) <= 15
group by TXN_TYPE, BRID


--Give the names of the account holders who have not put thru not even a single Cash deposit transaction during the last 90 days

select * 
from AccountMaster left join 
(select distinct ACID
from TxnMaster
where TXN_TYPE != 'CD' and DATEDIFF(dd,DOT,getdate()) <= 90) as temp
on AccountMaster.ACID=temp.ACID

--List the product having the maximum number of accounts

select top 1 PID, COUNT(*) as total
from AccountMaster
group by PID
order by total desc

--List the product having the maximum monthly, average number of transactions (consider the last 6 months data)
select PID, DATENAME(MM,DOT)+'-'+convert(char, DATEPART(YY,DOT)) as TxnDate, COUNT(*) as TotalTxn
from TxnMaster left join AccountMaster on TxnMaster.ACID = AccountMaster.ACID
where DATEDIFF(MM, DOT, getdate()) <= 6
group by PID, DATENAME(MM,DOT)+'-'+convert(char, DATEPART(YY,DOT))


--List the product showing an increasing trend in average number of transactions per month.
--List the names of the account holders and the number of transactions put thru by them, in a given day.
--List the account holder’s name, account number and sum amount for customers who have made more than one cash withdrawal transaction in the same day (Consider the transactions in the last 20 days for this query)
--List the account holder’s name, account number and amount for customers who have made at least one transaction in each transaction type in the last 10 days
--List the number of transactions that have been authorized by the Manager so far today
--Considering all transactions which took place in the last 3 days, give the region-wise, branch-wise breakup of number of transactions only for those regions where the total number of transactions exceeds 100.
--List the names of the clients who have accounts in all the products
--List the accounts that are likely to become “Inoperative” next month
--List the user who has entered the maximum number of transactions today
--Given a branch, list the heaviest day in terms of number of transactions/value of Cash Deposits during the last one month
--List the clients who have not used their cheque books during the last 15 days
--List the transactions that have happened wherein the transacting branch is different from the branch in which the account is opened, but the Region is the same 
--List the transactions that have happened wherein the transacting branch is different from the branch in which the account is opened, and the two branches belong to different regions
--List the average transaction amount, TransactionType-wise for a given branch and for a given date
--Provide the following information from the ‘Account Master’ table:
--Product-wise, month-wise, number of accounts
--Total number of accounts for each product
--Total number of accounts for each month
--Total number of accounts in our bank
