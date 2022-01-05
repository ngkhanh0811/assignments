create database lab11
go 
use lab11

create view ProductList as 
select ProductID, Name from AdventureWorks2019.Production.Product

select * from ProductList
create view SaleOrderDetail as 
select pr.ProductID, pr.Name, od.UnitPrice, od.Orderqty, od.UnitPrice * od.Orderqty as [TotalPrice]
from AdventureWorks2019.Sales.SalesOrderDetail od
join AdventureWorks2019.Production.Product pr
on od.ProductID = pr.ProductID

select * from SaleOrderDetail

create database lab9
go 
use lab9 

create table Customer(
CustomerID int primary key,
CustomerName nvarchar(50),
Address varchar(100),
Phone varchar(12)
)

insert into Customer values 
(1, N'Nguyễn Bá Khánh', 'HN', '0987729543'),
(2, N'Đinh Quang Anh', 'NB', '098123462'),
(3, N'Tạ Duy Linh', 'TN', '03612476124'),
(4, N'Vũ Viết Quý', 'TB', '098151254'),
(5, N'Nguyễn Mạnh Kiên', 'NT', '087126541')

create table Book(
BookCode int primary key,
Category nvarchar(50),
Author nvarchar(50),
Publisher nvarchar(50),
Title nvarchar(100),
Price int,
InStore int
)

insert into Book values 
(1, N'Văn học', N'Nguyễn Nhật Ánh', N'Kim Đồng', N'Một ngày không mưa', 25000, 10),
(2, N'Khoa học xã hội', '', N'ĐH Sư Phạm Hà Nội', N'Tìm hiểu về các nét đẹp văn hóa cổ truyền', 40000, 6),
(3, N'Văn học', N'Vũ Trọng Phụng', N'Kim Đồng', N'Trò đời', 35000, 8),
(4, N'Văn học', N'Nguyễn Nhật Ánh', N'Phương Nam', N'Tôi thấy hoa vàng trên cỏ xanh', 28000, 20),
(5, N'Văn học', N'Trịnh Khởi', N'Phương Nam', N'Đôi chân trần', 23000, 3)

create table BookSold(
BookSoldID int primary key,
CustomerID int references Customer(CustomerID),
BookCode int references Book(BookCode),
Date datetime,
Price int,
Amount int
)

insert into BookSold values 
(1, 1, 2, '20210809', 40000, 2),
(2, 2, 3, '20200703', 35000, 1),
(3, 2, 4, '20210909', 28000, 1),
(4, 2, 5, '20210809', 23000, 1),
(5, 1, 4, '20210907', 28000, 1),
(6, 1, 5, '20210605', 23000, 1),
(7, 3, 3, '20220101', 35000, 2),
(8, 3, 1, '20211203', 25000, 1),
(9, 4, 2, '20210408', 40000, 1),
(10, 5, 4, '20220104', 28000, 2)

create view ViewBook as
select Book.BookCode, Book.Title, Book.Price, BookSold.Amount from Book
left join BookSold 
on Book.BookCode = BookSold.BookCode

select * from ViewBook

drop view ViewBook

create view ViewCustomer as 
select Customer.CustomerID, Customer.CustomerName, Customer.Address, BookSold.Amount from Customer 
left join BookSold 
on Customer.CustomerID = BookSold.CustomerID

select * from ViewCustomer


create view ViewSold as
select Customer.CustomerName, Customer.CustomerID, Customer.Address check ()