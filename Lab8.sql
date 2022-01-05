create database lab8
use AdventureWorks2019
select * into lab8.dbo.WorkOrder from Production.WorkOrder
use lab8 
select * into WorkOrderIX from WorkOrder 
select * from WorkOrder
select * from WorkOrderIX

create index IX_WorkOrderID on WorkOrderIX(WorkOrderID)

select * from WorkOrder where WorkOrderID=72000
select * from WorkOrderIX where WorkOrderID=72000

create database Aptech
go

use Aptech 
create table Classes (
Classname char(6),
Teacher varchar(30),
TimeSlot varchar(30),
Class int,
Lab int
)

create unique index MyClusteredIndex on Classes(ClassName) with (Pad_index = on, fillfactor = 70, ignore_dup_key = on)
create index TeacherInex on Classes(Teacher)

drop index TeacherInex on Classes
create index ClassLabIndex on Classes(Class, Lab) 

use Aptech 
select * from sys.indexes 