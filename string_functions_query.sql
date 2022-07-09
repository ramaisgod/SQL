/****************************************************************************************
String Functions

Notes:-
****************************************************************************************/
use INDIAN_BANK
go

select ACID,Name,
           LOWER(Name) as NameLower,
		   UPPER(name) as NameUpper,
		   LEFT(name,4) as NameLeft4Char,
		   RIGHT(name,3) as NameRight3Char,
		   LEN(name) as NameLength,
		   REVERSE(name) as NameInReverseOrder,
		   REPLACE(name, 'r', 'R') as NameReplace, -- condidtion based if given char found then it will replace
		   LTRIM(name) as NameLtrim,
		   RTRIM(name) as NameRtrim,
		   TRIM(name) as NameFullTrim,
		   LTRIM(RTRIM(name)) as NameTrimBothSide,
		   SUBSTRING(name,2,4) as NameSubStr, -- SUBSTRING(ColName, StartLetter, NoOFLetter)  It is similar to Excel mid function to extract string from given string based on char position
		   STUFF(name,2,0,'XXXX') as Namestuff, -- STUFF(ColName, StartLetter, NoOFLetterToBeReplace, ReplaceByLetter) It replace the char by new char as per given position
		   SPACE(25) as BlankSpace, -- It put blank space as per given number of times 
		   Charindex('a',name,4) as NameIndex, -- It search the given string after the given char position and returns index number of string
		   CHARINDEX('a',name) as nameIndex2,
		   PATINDEX('ram',name) as namePatIndex

from AccountMaster

/*********************** Check Constraint example to validate the data *******************************************/
create table customer
(
cid int constraint c_pk primary key,
name varchar(40),
Mobile char(10) unique not null constraint mobile_10_char check (len(Mobile) = 10), -- it should be 10 char only
dob datetime not null check (datediff(yy,dob,getdate()) <= 60),  -- age should be less than equal to 60
email varchar(100) not null check(charindex('@', email)<>0 and charindex('.', email, charindex('@', email)+2)<>0)
)
go

-- sp_help 'customer'
insert into customer values(101, 'ram', '9818863757', '1988-10-02', 'ramais.god@.gmailcom')
insert into customer values(102, 'ram', '9818863800', '1788-10-02', 'mygodisram@gmailcom')
insert into customer values(102, 'ram', '9818863800', '1988-10-02', 'mygodisram@a.gmailcom')


select * from customer

/*******************************************************************************************************************/

select	ACID,
		Name,
		SUBSTRING(Name,1,4) as First4Char,
		REVERSE(SUBSTRING(Name,1,4)) as ReverseFirst4Char
from AccountMaster

-- Replace -- It is condition based if given char found then it will replace
-- Replace(Colname, OldChar, NewChar)

select	ACID,
		Name,
		REPLACE(name, 'a', 'A') as NewName
from AccountMaster

-- STUFF -- It also replace the char with new char but it does not follow condition becasue it is based on char position number
-- STUFF(ColName, StartNumber, NoOFChar, NewChar)
select	ACID,
		Name,
		STUFF(Name,1,3,'XXXXXXXXX') as NewName
from AccountMaster

-- Charindex -- It search the string after given postion and return IndexNumber of first occurance of string
-- It takes 3 parameters where last parameter is optional
select	AcID,
		Name,
		Charindex('a', Name, 6),
		Charindex('a', Name),
		CHARINDEX(' ', Name) as Firstspaceposition  -- it will search the blank space position
from AccountMaster


-- Extract First and Last Name

select	ACID,
		Name,
		LEFT(name,charindex(' ', name)) as FirstName,
		REVERSE(LEFT(reverse(name),charindex(' ',reverse(name)))) as LastName
from AccountMaster

-- Check the email is correct or not
select CHARINDEX('@', 'ramaisgod gmail.com') as Position_no_of_@  -- if it returns 0 means invalid email


-- PATINDEX -- It return the index number of starting position of the first occurance of a pattern
-- syntax
-- PATINDEX('%Pattern%', expression)

select PATINDEX('%god%', 'ramaisgod')


/*************************************** CASE Statement ****************************************************************/
select	ACID,
		Name,
		case
			when ClearBalance >10000 then 'Silver'
			when ClearBalance between 10000 and 50000 then 'Gold'
			else 'Bronze'
		end as CustType
from AccountMaster

-- or
select	ACID,
		Name,
		CustType = 
		case
			when ClearBalance >10000 then 'Silver'
			when ClearBalance between 10000 and 50000 then 'Gold'
			else 'Bronze'
		end 
from AccountMaster


-- create table
create table customerinfo
(
cid int primary key,
name varchar(40),
gender char(1) check(gender in ('M', 'F'))
)


insert into customerinfo values(1, 'Ram', 'M')
insert into customerinfo values(2, 'Shyam', 'M')
insert into customerinfo values(3, 'Priya', 'F')
insert into customerinfo values(4, 'Vivek', 'M')
insert into customerinfo values(5, 'Pooja', 'F')
insert into customerinfo values(6, 'Rubina', 'F')

-- Give list of name including Mr. and Ms as per gender 

select	name,
		case
			when gender='M' then 'Mr. ' + name
			when gender='F' then 'Ms. ' + name
			else name
		end as NewName
from customerinfo

-- interview question
-- update Gender Column and swap the gender like if M update as F and if F then update as M

update customerinfo
set gender = 
			case
			when gender='M' then 'F' 
			else 'M'
			end

select * from customerinfo


/*************************************** String_Agg function ****************************************************************
string aggregation function:-

String_Agg(Colname, Separator) -- It concatenate rows based on condition
STRING_AGG(item_name, ', ')
*****************************************************************************************************************************/
create table orders
(
orderno int,
item_name varchar(40)
)
go

insert into orders values(1001, 'Lux')
insert into orders values(1001, 'Nirma')
insert into orders values(1001, 'Wheel')
insert into orders values(1002, 'Atta')
insert into orders values(1002, 'Rice')
insert into orders values(1003, 'Daal')
insert into orders values(1001, 'Oil')

select orderno, STRING_AGG(item_name, ', ') as PurchasedItem
from orders
group by orderno


/*************************************** BETWEEN operator ****************************************************************/
--list the names of the customer who opened accounts between 2015 2017

select *
from AccountMaster
where DATEPART(YY, DOO) between 2015 and 2017

