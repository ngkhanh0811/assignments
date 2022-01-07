--vd24
use AdventureWorks2019
update vwProductInfo set SafetyStockLevel = 2500
where ProductID = 321

--vd25
create view vwNewProductInfo with schemabinding as 
select ProductID, ProductNumber, Name, SafetyStockLevel 
from Production.Product;
go

--vd26
create table vwCustomers
(
CustID int,
CustName varchar(50),
Address varchar(60)
)

--vd27
create view viewCustomers
as
select * from vwCustomers 

--vd28
select * from vwCustomers

--vd29
alter table vwCustomers ADD Age int

--vd30
select * from vwCustomers

--vd31
EXEC sp_refreshview 'vwCustomers'

--vd32 
alter table Production.Product alter column ProductID varchar(7)