/********************************************************************************************
SQL SERVER - Queries

WHERE --- clause is used to filter the row
SELECT --- clause is used to filter what columns
	       it is also used to Print something	
* --- is used for entire rows and entire columns
ORDER BY  --- clause is used to sort the data
*********************************************************************************************/

use INDIAN_BANK
go

-- Single Table

-- All rows and all columns
select * from AccountMaster

-- All rows and few columns
select ACID, NAME from AccountMaster

-- Some rows and all columns
select * from AccountMaster where BRID='BR1'

select * from AccountMaster where BRID='BR1' and ClearBalance < 1000

-- Some rows and some columns
select ACID, Name from AccountMaster where PID='SB' and ClearBalance < 1000

-- list ACID and Name only for SB accounts and list the names in descending order
select acid, name 
from accountmaster 
where pid='SB' 
order by name desc

-- correct or not ?   Answer:- Yes. All columns will get repeated and merged 
select *, *, *
from AccountMaster

-- correct or not ?   Answer:- Yes 
select acid, name, acid, name 
from AccountMaster

-- correct or not ?   Answer:- Yes 
select acid, name, acid, name, *
from AccountMaster

-- Is it valid? Answer:- Yes
select 5  --5 is a constant
select 'Python'  --Python is a constant

-- Is it valid? Answer:- Yes, 5 will print total no. of rows times
select 5
from AccountMaster

select 'Python' as courseName
from AccountMaster

-- Is it valid? Answer:- Yes, 'Python' will print together with all columns & all rows
select *, 'Python'
from AccountMaster

-- Is it valid? Answer:- Yes,
select acid, name, 'USD' as Currency, clearbalance, '18%' as Tax
from AccountMaster

-- alias
select 'Python' Course
-- or
select 'Python' as Course
-- or
select 'Python' as [Course Name]


-- Concatenate  -- use + operator
select name + ' is a human' as Name2
from AccountMaster

select str(clearbalance) + ' is a balance' as balance
from AccountMaster

-- Type casting
-- Below functions can be used to change the data type:
-- CAST(col as datatype)              -- Does not have styleNumber      
-- CONVERT(datatype, col, StyleNum)   -- it has sytleNumber which is used to print date in various format

select cast(clearbalance as varchar) + ' is a balance' as balance
from AccountMaster

select convert(varchar, clearbalance) + ' INR' as balance
from AccountMaster

-- Use of CONVERT function
/***************************************
Syntax:-
Convert(DataType, ColumnName, StyleNumber)
StyleNumber is Optional

Oct 22 2015 12:00AM  -- without style number

StyleNumber is 1 to 21   (two digit year (yy) will print)
StyleNumber is 101 to 131  (four digit year (yyyy) will print)

***************************************/

select acid, name, clearbalance, doo, convert(varchar, doo) as acOpenDate
from accountmaster

select acid, name, clearbalance, doo, convert(varchar, doo, 1) as acOpenDate
from accountmaster

select acid, name, clearbalance, doo, convert(varchar, doo, 104) as acOpenDate
from accountmaster

select try_cast('ram' as int) -- it error then return NULL

select try_convert(int, 'ram') -- it error then return NULL

select parse('333' as int)

select try_parse('ram' as int) -- it error then return NULL

select try_cast('12/23/2022' as date) -- it error then return NULL


