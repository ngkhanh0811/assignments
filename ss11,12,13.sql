use AdventureWorks2019

--Session 11
--vd1
create table Production.parts(
part_id int not null,
part_name nvarchar(100)
)
go

--vd2
create clustered index ix_parts on Production.parts (part_id);

--vd3
exec sp_rename 
	N'Production.parts.ix_parts_id',
	N'index_part_id',
N'INDEX';

--vd4
alter index ix_parts
on Production.parts
disable;

--vd5
alter index all on Production.parts
disable;

--vd6
drop index if exists
ix_parts on Production.parts;

--vd7
create nonclustered index index_customer_storeid
on Sales.Customer(StoreID);

--vd8
create unique index AK_Customer_rowguid
on Sales.Customer(rowguid);

--vd9
create index index_cust_personId on
Sales.Customer(PersonID)
where PersonID is not null;

--vd10
select CustomerID, PersonId, StoreID from Sales.Customer where PersonID = 1700;

--vd11
create partition function partition_function (int)
range left for values (20200630, 20200731, 20200831);

--vd12
(select 20200613 date, $partition.partition_function()20200613)PartitionNumber)
union
(select 20200713 date, $partition.partition_function()20200713)PartitionNumber)
union
(select 20200813 date, $partition.partition_function()20200813)PartitionNumber)
union
(select 20200913 date, $partition.partition_function()20200913)PartitionNumber);

--vd13
create primary xml index pxml_ProductModel_CatalogDescription
on Production.ProductModel (CatalogDescription);

--vd14
create xml index ixml_ProductModel_CatalogDescription_Path
on Production.ProductModel (CatalogDescription)
using xml index pxml_ProductModel_CatalogDescription
for Path;

--vd15
create columnstore index IX_SalesOrderDetails_ProductIDOrderQty_columnstore on Sales.SalesOrderDetail (ProductID, OrderQty);

--vd16
select ProductID, SUM(OrderQty)
from Sales.SalesOrderDetail
group by ProductID;

--Session 12 
--vd1
create table Locations (LocationID int, LocName varchar(100));
create table LocationHistory (LocationID int, ModifiedDate datetime);

--vd2
create trigger trigger_insert_Locations on Locations
for insert 
not for replication
as
	begin 
		insert into LocationHistory
		select LocationID 
		,getdate()
		from inserted 
	end;

--vd3
insert into dbo.Locations (LocationID, LocName) values (443101, 'Alaska'

--vd4
create trigger trigger_upadte_Locations on Locations
for update 
not for replication
as 
	begin 
	insert into LocationHistory
	select LocationID
	,getdate()
	from inserted
end;

--vd5
update dbo.Locations set LocName='Alatka'
where LocationID = '443101';

--vd6
create trigger trigger_delete_Locations on Locations 
for delete
not for replication
as 
	begin
	insert into LocationHistory
	select LocationID ,getdate()
	from deleted
end;

--vd7
delete from dbo.Locations 
where LocationID= '443101'

--vd8
create trigger alter_insert_Locations on Locations 
after insert 
as 
	begin 
	insert into LocationHistory
	select LocationID
	, getdate()
	from inserted
end;

--vd9
insert into dbo.Locations (LocationID, LocName) values (443101, 'SAN ROMAN')

--vd10
create trigger insteadof_delete_Locations on Locations
instead of delete 
as 
	begin 
	select 'Sample Instead of trigger' as 'Khanh sieu dep trai'
end;

--vd11
delete from dbo.Locations
where LocationID = 443101

--vd12
exec sp_settriggerorder @triggername = 'trigger_delete_Locations', @order = 'first', @stmttype = 'delete' 

--vd13
sp_helptext trigger_delete_Locations

--vd14
alter trigger trigger_update_Locations on Locations 
with excryption for insert 
as	
	if '443101' in (select LocationID from inserted)
	begin 
		print 'Location cannot be updated'
		rollback transaction
end;

--vd15
drop trigger trigger_update_Locations

--vd16
create trigger secure on database 
for drop_table, alter_table as 
print 'You must disable Trigger "Secure" to drop or alter tables !'
rollback;

--vd17
create trigger Employee_deletion on HumanResources.Employee
after delete
as
	begin
	print 'Deletion will be affect EmployeePayHistory table'
delete from EmployeePayHistory where BusinessEntityID in (select BusinessEntityID from deleted)
end;

--vd18
create trigger deletion_Confirmation
on HumanResources.EmployeePayHistory after delete
as 
	begin 
	print 'Employee details succesfully deleted from EmployeePayHistory table'
end;
delete from EmployeePayHistory where EmpID = 1

--vd19
create trigger Accounting on Production.TransactionHistory after update 
as 
if (update (TransactionID) or update (ProductID) ) begin
raiserror (5009, 16, 10) end;
go

--vd20
use AdventureWorks2019
go
create trigger PODetails
on Purchasing.PurchaseOrderDetail after insert as
update PurchaseOrderHeader
set SubTotal = SubTotal + LineTotal from inserted
where PurchaseOrderHeader.PurchaseOrderID = inserted.PurchaseOrderID;

--vd21
create trigger PODetailsMultiple
on Purchasing.PurchaseOrderDetail after insert as 
update Purchasing.PurchaseOrderHeader set SubTotal = SubTotal + (select sum(LineTotal) from inserted
where PurchaseOrderHeader.PurchaseOrderID = inserted.PurchaseOrderID)
where PurchaseOrderHeader.PurchaseOrderID in (select PurchaseOrderID from inserted);

--vd22
create trigger track_login on ALL SEVER
for logon as
	begin 
		insert into LoginActivity
		select EVENTDATA()
		,GETDATE()
end;