/****************************************************************************************
Derive Table and Interview questions

What is Derive Table:- A query in the FROM clause is called as a derived table
                       Derived Table must have alias
					   Derived Table can also be used in Joins



****************************************************************************************/
use INDIAN_BANK
go


select * from (select * from AccountMaster) as am

-- List the account id, name, and no. of txns where account holder has done more than 3 txns  for the year 2017
-- Good approach using Derived Table
select am.ACID, NAME, NoOFTxns  
from AccountMaster as am
join 
	(select ACID, COUNT(*) as NoOFTxns
	from TxnMaster as tm
	where DATEPART(YY, DOT) = 2017
	group by ACID) as t
on am.ACID = t.ACID



--or--bad approach
select am.ACID, am.Name, COUNT(*) as NoOFTxns
from AccountMaster as am join TxnMaster as tm on am.ACID=tm.ACID
where DATEPART(YY, DOT)=2017
group by am.ACID, am.Name 





if not exists (select * from sys.tables where name='customersales')
create table customersales
(
SaleDate date,
Customer varchar(40),
SalesAmount money 
)
go
insert into customersales values('2022-01-10', 'C1', 1000)
insert into customersales values('2022-01-12', 'C2', 1000)
insert into customersales values('2022-02-11', 'C3', 1000)
insert into customersales values('2022-02-17', 'C1', 1000)
insert into customersales values('2022-02-19', 'C4', 1000)
insert into customersales values('2022-03-18', 'C3', 1000)
insert into customersales values('2022-03-22', 'C5', 1000)
insert into customersales values('2022-04-08', 'C6', 1000)
insert into customersales values('2022-04-10', 'C7', 1000)
insert into customersales values('2022-05-12', 'C4', 1000)
insert into customersales values('2022-06-24', 'C5', 1000)
insert into customersales values('2022-06-28', 'C8', 1000)

select * from customersales
--Interview question :-- Month-wise no. of new customers

select DATENAME(mm, MinDate) as DateOFSale, COUNT(*) as NewCustomer
from 
(
	select customer, MIN(SaleDate) as MinDate
	from customersales
	group by customer
) as t
group by DATENAME(mm, MinDate)

/*output
DateOFSale	NewCustomer
April	     2
February	 2
January	     2
June	     1
March	     1
*/

