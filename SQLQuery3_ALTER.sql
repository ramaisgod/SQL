use company
go

select * from Product

------------------ ALTER-------------------------------
-- add new column
alter table Product
add Rating tinyint

-- update data
update Product
set Rating = 3 where PID = 103
--
update Product
set Rating = 0 where PID > 103 or PID < 103

-- drop a column from the table
alter table Product
drop column Rating

-- drop Qty column
alter table Product
drop column Qty
/*
Qty column having default constraint so it will not delete directly
we need to delete its constraint first then it will delete
*/
sp_help 'Product'

alter table Product
drop constraint DF__Product__Qty__70DDC3D8
--
alter table Product
drop column Qty

