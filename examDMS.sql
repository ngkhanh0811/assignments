--Ex1: Create database AZBank
CREATE DATABASE AZBank
GO

USE AZBank 
GO

--Ex2: Create tables with constraints as design above. 3. Insert into each table at least 3 records
CREATE TABLE Customer(
CustomerId INT NOT NULL PRIMARY KEY,
Name NVARCHAR(50),
City NVARCHAR(50),
Country NVARCHAR(50),
Phone NVARCHAR(15),
Email NVARCHAR(50)
)
GO

CREATE TABLE CustomerAccount(
AccountNumber CHAR(9) NOT NULL PRIMARY KEY,
CustomerId INT NOT NULL references Customer(CustomerId),
Balance MONEY NOT NULL,
MinAccount MONEY
)
GO

CREATE TABLE CustomerTransaction(
TransactionId INT NOT NULL PRIMARY KEY,
AccountNumber CHAR(9) references CustomerAccount(AccountNumber),
TransactionDate SMALLDATETIME,
Amount MONEY,
DepositorWithdraw BIT NOT NULL
)
GO

--Ex3: Insert into each table at least 3 records. 
insert into Customer values 
(123, N'Nguyễn Bá Khánh', N'Hà Nội', N'Việt Nam', N'0987729543', N'nguyenkhanh08112003@gmail.com'),
(124, N'Đinh Quang Anh', N'Ninh Bình', N'Việt Nam', N'09124658127', N'dinhquanganh123@gmail.com'),
(125, N'Tạ Văn Minh', N'Thanh Hóa', N'Việt Nam', N'03612487124', N'minhvan2003@gmail.com'),
(126, N'Lương Viết Hoàng', N'Quảng Ninh', N'Việt Nam', N'09712546', N'hoangluon2003@gmail.com')

insert into CustomerAccount values
('190234124', 123, 1000000, 20000),
('193256734', 124, 2000000, 20000),
('193658295', 125, 1500000, 20000),
('190462847', 126, 5000000, 20000)

insert into CustomerTransaction values
(999, '190234124', '20211209', 20000, 1),
(997, '193256734', '20220115', 100000, 1),
(956, '190462847', '20220116', 200000, 0)

--Ex4: Write a query to get all customers from Customer table who live in ‘Hanoi’
select Name from Customer where Customer.City = N'Hà Nội'

--Ex5: Write a query to get account information of the customers (Name, Phone, Email, AccountNumber, Balance)
select Customer.Name, Customer.Phone, Customer.Email, CustomerAccount.AccountNumber, CustomerAccount.Balance from Customer 
join CustomerAccount 
on Customer.CustomerId = CustomerAccount.CustomerId

/* Ex6: A-Z bank has a business rule that each transaction (withdrawal or deposit) won’t be
over $1000000 (One million USDs). Create a CHECK constraint on Amount column
of CustomerTransaction table to check that each transaction amount is greater than
0 and less than or equal $1000000. */
alter table CustomerTransaction 
add check (Amount < 1000000)

/* Ex7: Create a view named vCustomerTransactions that display Name,
AccountNumber, TransactionDate, Amount, and DepositorWithdraw from Customer,
CustomerAccount and CustomerTransaction tables. */
create view vCustomerTransactions as
select Customer.Name, CustomerAccount.AccountNumber, CustomerTransaction.TransactionDate, CustomerTransaction.Amount, CustomerTransaction.DepositorWithdraw from Customer
join CustomerAccount 
on Customer.CustomerId = CustomerAccount.CustomerId
join CustomerTransaction
on CustomerAccount.AccountNumber = CustomerTransaction.AccountNumber

select * from vCustomerTransactions