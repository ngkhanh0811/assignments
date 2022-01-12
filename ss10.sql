use AdventureWorks2019

--vd1
CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, Name ,SafetyStockLevel 
FROM Production. Product;
GO

--vd2
| SELECT * FROM vwProductInfo

--vd3
CREATE VIEW wwPersonDetails AS
SELECT 
p.Title
,p.[FirstName]
,p.[MiddleName]
,p.[LastName]
,e.[JobTitle]
FROM[HumanResources].[Employee]e
	INNER JOIN [Person].[Person]p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]
GO

--vd4
| SELECT * FROM vwPersonDetails

--vd5
CREATE VIEW wwPersonDetailsNew
AS
SELECT 
COALESCE(p.MiddleName,' ')AS  Title
,p.[FirstName]
 ,COALESCE(p.MiddleName,' ')ASMiddleName
 ,p.[LastName]
 ,e.[JobTitle]
 FROM[HumanResources].[Employee]e
	INNER JOIN [Person].[Person]p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]
GO

--vd6
CREATE VIEW wwSortedPersonDetails AS
SELECT TOP 10 COALESCE(p.Title,'') AS Title
,p.[FirstName]
COALESCE(p.MiddleName,' ')AS  Title
,p.[FirstName]
 ,e.[JobTitle]
 FROM [HumanResources].[Employee] e INNER JOIN [Person].[Person] p
 ON p.[BusinessEntityID] = e.[BusinessEntityID] ORDER BY p.FirstName
 GO
 
 SELECT * FROM  wwSortedPersonDetails

 --vd7
 CREATE TABLE Employee_Personal_Details(
 EmpID int NOT NULL,
 FirstName varchar(30)NOT NULL,
 lastName varchar(30)NOT NULL, Address
 varchar (30)
 )

 --vd8
CREATE TABLE Employee_Salary_Details(
EmpID
int NOT NULL,
Designation varchar(30),
Salary int NOT NULL
)

--vd9
CREATE VIEW vwEmployee_Personal_Details
AS
SELECT e1.EmpID, FirstName, LastName, Designation, Salary
FROM Employee_Personal_Details e1
JOIN Employee_Salary_Details e2
ON e1.EmpID=e2.EmpID

--vd10
INSERT INTO vwEmployee_Personal_Details VALUES (2,'Jack','Wilson','Software
Developer',16000)

--vd11
CREATE VIEW vwEmpDetails AS
SELECT FirstName, Address
FROM Employee_Personal_Details

--vd12
INSERT INTO vwEmpDetails VALUES ('Jack', 'NYC')

--vd13
CREATE TABLE Product_Details (
ProductID int, ProductName
varchar(30), Rate money
)

--vd14
CREATE VIEW vwProduct_Details
AS
SELECT ProductName, Rate FROM Product_Details

--vd15
UPDATE vwProduct_Details
SET Rate=3000
WHERE ProductName='DVD Writer'

--vd16
CREATE VIEW vwProduct_Details
AS
SELECT
ProductName,
Description,
Rate FROM Product_Details

--vd17
UPDATE vwProduct_Details
SET DESCRIPTION .WRITE(N'Ex',0,2)
WHERE ProductName='PortableHardDrive'

--vd18
DELETE FROM vwCustDetails WHERE CustID = 'C004'

--vd19
ALTER VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, NAME, SafetyStockLevel, ReOrderPoint
FROM Production.Product;
GO

--vd20
DROP VIEW vwProductInfo

--vd21
EXEC sp_helptext vwProductPrice


--vd22
CREATE VIEW vwProduct_Details
AS
SELECT
ProductName,
AVG(Rate) AS AverageRate
FROM Product_Details
GROUP BY ProductName

--vd23
CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, Name,SafetyStockLevel, ReOderPoint
FROM Production.Product
WHERE SafetyStockLevel<=1000
WITH CHECK OPTION;
GO

--vd24
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

--vd33
execute xp_fileexist'c:\MyTest.txt'

--vd34
create procedure uspGetCustTerritory
as
select top 10 CustomerID, Customer.TerritoryID, Sales.SalesTerritory.Name 
from Sales.Customer join Sales.SalesTerritory on Sales.Customer.TerritoryID = Sales.SalesTerritory.TerritoryID

--vd35
exec uspGetCustTerritory

--vd36 
create procedure uspGetSales @territory varchar(40) as
select BusinessEntityID, B.SalesYTD, B.SalesLastestYear from Sales.SalesPerson A
join Sales.SalesTerritory B
on A.TerritoryID = B, TerritoryID where B.Name = @territory;
uspGetSales'Northwest'

--vd37
create procedure uspGetTotalSales @territory varchar(40), @sum int output as
select @sum = SUM(B.SalesYTD) from Sales.SalesPerson A 
join Sales.SalesTerritory B 
on A.TerritoryID = B.TerritoryID
where B.Name = @territory

--vd38
declare @sumsalesmoney
exec uspGetTotalSales 'Northwest', @sumsales output 
print 'The year-to-date sales figure for this territory is' + convert (varchar(100), @sumsales);

--vd39
alter procedure [dbo].[uspGetTotalSales]
@territory varchar = 40
as
select BusinessEntityID, B.SalesYTD, B.CostYTD, B.SalesLastYear from Sales.SalesPerson A 
join Sales.SalesTerritory B 
on A.TerritoryID = B.TerritoryID
where B.Name = @territory;
go

--vd40
drop procedure uspGetTotals 

--vd41 
create procedure NestedProcedure as
begin 
exec uspGetCustTerritory
exec uspGetSales 'France'
end 

--vd42
select name, object_id, type, type_desc 
from sys.tables;

--vd43
select table_catalog, table_schema, table_name, table_type 
from INFORMATION_SCHEMA.TABLES;

--vd44
select severproperty ('Edition') as EditionName;

--vd45
select session_id, login_time, program_name from sys.dm_exec_sessions
where login_name = 'sa' and is_user_process = 1;
