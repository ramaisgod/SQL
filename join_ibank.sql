/****************************************************************************************
Joins 

Notes:-
below will not work:-
Columnname = null 

Use below to get null records:-
ColumnName is null

below is used to get not null records:-
ColumnName is not null

BETWEEN 10000 and 50000   means included 10000 and 50000

****************************************************************************************/
use INDIAN_BANK
go

-- list of column names with data types and many more from tables 
sp_columns 'AccountMaster'



select ACID,Name,ProductName
from AccountMaster inner join ProductMaster
on AccountMaster.PID = ProductMaster.PID


select ACID,Name,ProductName into accountwiserproduct
from AccountMaster inner join ProductMaster
on AccountMaster.PID = ProductMaster.PID

select * from accountwiserproduct

select * from TxnMaster

-- sp_help TxnMaster

-- Find out customer name wise Txn type wise no. of txns
select Name, TXN_TYPE, COUNT(*) as No_of_Txn
from TxnMaster inner join AccountMaster 
on TxnMaster.ACID = AccountMaster.ACID
group by Name,TXN_TYPE

-- Find out customer name wise Txn type wise no. of txns in last month
select Name, TXN_TYPE, COUNT(*) as NoOFTxn
from TxnMaster as tm inner join AccountMaster as am
on tm.ACID = am.ACID
where DATEDIFF(mm,DOT,getdate()) = 1
group by Name, TXN_TYPE
order by Name asc


-- List Names of the account holders who deposited cash , and their Product name
select distinct Name, TXN_TYPE, ProductName from AccountMaster as a join TxnMaster as t
on a.ACID = t.ACID join ProductMaster as p 
on p.PID = a.PID
where TXN_TYPE='CD'
order by Name asc

-- List of customer who did not deposted cheque yet
select * from AccountMaster left join TxnMaster
on AccountMaster.ACID = TxnMaster.ACID
where CHQ_NO is null


/********************* CROSS JOIN ***************************************************************/
-- it is similar like multiplications Table1 rows X Table2 rows   like 6X5 = 30 rows
-- It is used to create a dummy data and some reporting work, otherwise nothing else
select * from AccountMaster, TxnMaster 
--or
select * from AccountMaster cross join TxnMaster


select * from AccountMaster, TxnMaster, ProductMaster

select 100*802*4



/********************* SELF JOIN ***************************************************************/
-- Note:-  Self Join can be inner join  or  outer join 


create table Employee
(
empid int primary key,
name varchar(50),
doj datetime,
managerid int foreign key references Employee(empid)
)

insert into Employee values(101, 'Ram Krishna', '05/29/2019', null)
insert into Employee values(102, 'Abisheak', '05/29/2019', 101)
insert into Employee values(103, 'Vivek', '05/29/2019', 102)
insert into Employee values(104, 'Pooja', '05/29/2019', null)

select * from Employee
-- List the employee name and their Manager's name
select emp1.name as EmpName, emp2.Name as BossName 
	from Employee as emp1 inner join Employee as emp2 
	on emp2.empid = emp1.managerid

-- or
select e1.name as MyName, e2.name as BossName from Employee as e1 left join Employee as e2 on e1.managerid = e2.empid

 
 -- Interview query
 create table student
 (
 student_id int primary key,
 name varchar(40)
 )

 insert into student values(101, 'Ram')
 insert into student values(102, 'Shyam')
 insert into student values(103, 'Harry')
 insert into student values(104, 'Sonu')
 insert into student values(105, 'Pooja')

 create table marks
 (
 student_id int foreign key references student(student_id),
 sub varchar(20) not null,
 score int not null default(0)
 )
 go

 insert into marks values(101, 'Math', 55)
 insert into marks values(101, 'English', 70)
 insert into marks values(101, 'Science', 60)

 insert into marks values(102, 'Math', 40)
 insert into marks values(102, 'English', 80)
 insert into marks values(102, 'Science', 90)

  insert into marks values(103, 'Math', 30)
 insert into marks values(103, 'English', 60)
 insert into marks values(103, 'Science', 20)

 insert into marks values(104, 'Math', 90)
 insert into marks values(104, 'English', 65)
 insert into marks values(104, 'Science', 35)

 insert into marks values(105, 'Math', 85)
 insert into marks values(105, 'English', 75)
 insert into marks values(105, 'Science', 95)
 go

 select * from student
 select * from marks

-- get the hightest score for each student with subject name
select student_id, sub, score
from
	(select *, DENSE_RANK() over(partition by student_id order by score desc) as finalScore
	from marks) as t
where finalScore=1
