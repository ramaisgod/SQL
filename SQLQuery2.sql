
use company
go

-- create table
create table employee
(
empid		int				primary key identity(1001,1),
name		varchar(100)	not null,
salary		money			not null check(salary > 0),
gender		char(1)			not null check(gender = 'M' or gender = 'F'),
dob			datetime		not null,
phone		char(10)		null unique,
email		varchar(50)		null unique,
passport_no varchar(10)		not null unique,
deptID		int				null foreign key references Dept(DeptID)
)
go

select * from employee

-- Find schema/Meta Data 
sp_help 'employee'

-- insert data
insert into employee([name], [salary], [gender], [dob], [phone], [email], [passport_no], [deptID]) 
values('Pooja', 50000, 'F', '02/10/1988', '9818863759', 'ramaisgod2@gmail.com', 'PJ2435JI23', 20)

insert into employee values('Neha', 30000, 'F', '02/11/1999', '9818868859', 'nehisgod2@gmail.com', 'NE2435JI23', 30)



-- create table
create table Product
(
PID int primary key identity(100,1),
ProductName varchar(100) not null,
Qty int null default(0),
UnitPrice money not null
)
go
-- delete table
drop table Product
go
-- Find schema of the table
sp_help 'product'

-- Implicit insert
insert into Product values('Pen', 1000, 10)
insert into Product values('Pencil', 800, 5)
insert into Product values('Lux', 100, 35)
insert into Product values('Dove', 1200, 44)
insert into Product values('Nirma', 300, 5)

-- read table
select * from Product

-- last (latest) inserted identity value
select @@IDENTITY

-- delete all rows (Identity column will not be reset)
delete from product

delete from product where productname = 'Pen'

-- delete all rows using Truncate command (Identity column will be reset, cannot rollback)
Truncate Table product

-- no default value capture if pass null for that column
insert into Product values('Sanitizer', null, 100)

-- default value capture if pass blank ''
insert into Product values('Arial', '', 149)

-- Explicit Insert (default value will auto insert for column)
insert into Product(ProductName, UnitPrice) values('Thinkpad T470', 90000)
insert into Product(UnitPrice, ProductName) values(150000, 'MacBook Pro M1')


