/****************************************************************************************
Union, Union ALL

Notes:-
****************************************************************************************/
use INDIAN_BANK
go

-- select e1.empid, e1.name as EmployeeName, e1.doj, e1.managerid, e2.name as ManagerName from Employee as e1 left join Employee as e2 on e1.managerid = e2.empid


/*********************************** UNION ******************************************

-- Combine the results of two or more select query
-- duplicates will be removed by default
-- No. of column should be same in each query
-- Data type should be same in each correspendent columns
-- sorts the data

*************************************************************************************/

select name from Employee
union
select name from AccountMaster

/*********************************** UNION ALL **************************************
-- keep duplicates 
-- Union All is faster
*************************************************************************************/
select name from Employee
union all
select name from AccountMaster


/*********************************** LIKE & NOT LIKE**************************************
-- wild card charecter
*************************************************************************************/

-- contains 'john'
select * from AccountMaster where Name like '%john%'

-- not contains 'john'
select * from AccountMaster where Name not like '%john%'


-- 1st letter is r
select * from AccountMaster where Name like 'r%'

-- 2nd letter is r
select * from AccountMaster where Name like '_r%'

-- 1st lettter should not k
select * from AccountMaster where Name not like 'k%'

-- last letter should be k
select name from AccountMaster where Name like '%k'

-- last second letter should be k
select name from AccountMaster where Name like '%k_'

-- start with J and ends with N
select name from AccountMaster where Name like 'J%N'

-- ends with Brown
select name from AccountMaster where Name like '%brown'



/*********************************** NULL **************************************

*************************************************************************************/

update AccountMaster
set UnclearBalance = null 
where ACID='105'

select ACID, Name, ClearBalance from AccountMaster

-- Replacing null by 0 
select ACID, Name, ISNULL(ClearBalance, 0) as balance from AccountMaster

-- Replacing null by 0 and get null value rows
select ACID, Name, ISNULL(ClearBalance, 0) as balance from AccountMaster where ClearBalance is null

-- all customer balance increment by 100
--(wrong approach)--null cells will not update because Null+5000 = NUll
update AccountMaster 
set ClearBalance = ClearBalance+100


--(correct approach)
update AccountMaster
set ClearBalance = ISNULL(ClearBalance,0)+100


select * from AccountMaster


/*********************************** Coalesce Function **************************************


*************************************************************************************/

create table emp
(
id int primary key,
FirstName varchar(40),
MiddleName varchar(40),
LastName varchar(40)
)

--alter table emp
--alter column Lastname varchar(40)

insert into emp values(1, 'ram', 'krishna', 'prasad')
insert into emp values(2, 'abhisheak', null, 'saraswat')
insert into emp values(3, null, 'prakash', 'singh')
insert into emp values(4, null, null, 'pooja')
insert into emp values(5, null, null, null)

select * from emp

--delete emp where Id=5

-- get first non-null value
select Coalesce(FirstName, MiddleName, Lastname) as EmpName from emp 

-- get full name -- this approach will give error becasue Null + anything = Null
select FirstName + MiddleName + LastName as Fullname from emp

-- get full name --
select ISNULL(Firstname, ' ') + ISNULL(MiddleName, ' ') + ISNULL(LastName, ' ') as FullName from emp


-- Using Concat Function -- new sql server 2012 onwards...
select CONCAT(FirstName, MiddleName, LastName) as FullName from emp



