use AdventureWorks2019

-- Tạo một thủ tục lưu trữ lấy ra toàn bộ nhân viên vào làm theo năm có tham số đầu vào là một năm 
create procedure sp_DisplayEmployeesHireYear
@HireYear int
as 
select * from HumanResources.Employee
where datepart(YY, HireDate) = @HireYear
go 
exec sp_DisplayEmployeesHireYear 2003
go

-- Tạo thủ tục lưu trữ đếm số người vào làm trong một năm xác định có tham số đầu vào là một năm 
-- Tham số đầu ra là số người vào làm trong năm này 
create procedure sp_EmployeesHireYearCount
@HireYear int,
@Count int output
as 
select @Count=count(*) from HumanResources.Employee
where DATEPART(YY, HireDate) = @HireYear
go
declare @Number int
exec sp_EmployeesHireYearCount 2003, @Number output
print @Number
go


-- Tạo thủ tục lưu trữ đếm số người vào làm trong một năm xác định có tham số đầu vào là một năm, hàm trả về là số người vào làm năm đó
create procedure sp_EmployeesHireYearCount2
@HireYear int
as
declare @Count int
select @Count = COUNT(*) from HumanResources.Employee
where DATEPART(YY, HireDate) = @HireYear
Return @Count
go

declare @Number int
exec @Number = sp_EmployeesHireYearCount2 2003
print @Number
go

-- Tạo bảng tạm #Student
create table #Students(
RollNo varchar(6) constraint pk_students primary key,
FullName nvarchar(100),
Birthday datetime constraint DF_StudentsBirthday DEFAULT dateadd(yy, -18, getdate())
)
go

-- Tạo thủ tục lưu trữ tạm để chèn dữ liệu vào bảng tạm 
create procedure #spInsertStudents
@RollNo varchar(6),
@FullName nvarchar(100),
@Birthday datetime
as begin
	if (@Birthday is null)
	set @Birthday = DATEADD(YY, -18, getdate())
	insert into #Students(RollNo, FullName, Birthday)
end
go

-- Sử dụng thủ tục lưu trữ tạm để xóa dữ liệu từ bảng tạm theo RollNo
create procedure #spDeleteStudents
	@RollNo varchar(6),
as begin 
	delete from #Students where RollNo = @RollNo 
end

--Xóa dữ liệu sử dụng thủ tục lưu trữ 
exec #spDeleteStudents 'A12345'
go

-- Tạo một thủ tục lưu trữ sử dụng lệnh return để trả về một số nguyên 
create procedure Cal_Square @num int=0 as 
begin
	return (@num * @num);
end
go

-- Chạy thủ tục lưu trữ 
declare @square int;
exec @square = Cal_Square 10;
print @square;
go

-- Xem định nghĩa thủ tục lưu trữ bằng hàm OBJECT_DEFINITION
select 
OBJECT_DEFINITION(OBJECT_ID('HumanResource.uspUpdateEmployeePersonalInfo')) as definition

-- Xem thủ tục lưu trữ bằng 
select definition from sys.sql_modules
where object_id = OBJECT_ID('HumanResource.uspUpdateEmployeePersonalInfo')
go

-- Xem thủ tục lưu trữ hệ thống xem các thành phần mà thủ tục lưu trữ phụ thuộc
sp_depends 'HumanResource.uspUpdateEmployeePersonalInfo'
go

use AdventureWorks2019
go

-- Tạo thủ tục lưu trữ sp_DisplayEmployees
create procedure sp_DisplayEmployees as
select * from HumanResource.Employee
go

-- Thay đổi thủ tục lưu trữ sp_DisplayEmployees
alter procedure sp_DisplayEmployees as
select * from HumanResources.Employee
where Gender = 'F'
go

-- Chạy thủ tục lưu trữ sp_DisplayEmployees
exec sp_DisplayEmployees
go

-- Xóa một thủ tục lưu trữ 
drop procedure sp_DisplayEmployees
go

-- Ví dụ 
create procedure sp_EmployeeHire
as
	begin	
	-- Hiển thị
	execute sp_DisplayEmployeesHireYear 1999
	declare @Number int 
	exec sp_EmployeesHireYearCount 1000, @Number output
	print 'Số nhân viên vào làm năm 1999 là : ' + convert(varchar(3), @Number)
end
go

-- Chạy thủ tục lưu trữ
exec sp_EmployeeHire
go

-- Thay đổi thủ tục lưu trữ sp_EmployeeHire bằng khối lệnh Try ... Catch
alter procedure sp_EmployeeHire
	@HireYear int 
as 
	begin
		begin Try
			exec sp_DisplayEmployeesHireYear @HireYear
			declare @Number int 
		-- Lỗi xảy ra ở đây có thủ tục sp_EmployeeHireYearCount chỉ truyền 2 tham số mà ta truyền 3
			exec sp_EmployeesHireYearCount @HireYear, @Number output, '123'
			print N'Số nhân viên vào làm năm là : ' + convert(varchar(3), @Number)
end try
begin catch
	print N'Có lỗi xảy ra trong khi thực hiện thủ tục lưu trữ'
end catch
print N'Kết thúc thủ tục lưu trữ'
end 
go

--Chạy thủ tục sp_EmployeeHire
exec sp_EmployeeHire 1999
go

--Thay đổi thủ tục lưu trữ sp_EmployeeHire sử dụng hàm @@ERROR
alter proc sp_EmployeeHire
	@HireYear int 
as
begin
	exec sp_DisplayEmployeesHireYear @HireYear
	declare @Number int
	--Lỗi xảy ra ở đây có thủ tục sp_EmployeeHireYearCount chỉ truyền 2 tham số mà ta truyền 3 
	exec sp_EmployeesHireYearCount @HireYear, @Number output, '123'
	if @@ERROR <>0
		print N'Có lỗi xảy ra khi thực hiện thủ tục lưu trữ'
	print N'Số nhân viên vào làm năm là : ' + convert(varchar(3),@Number)
end
go

-- Chạy thủ tục lưu trữ sp_EmployeeHire
exec sp_EmployeeHire 1999

-- BÀI TẬP TỰ LÀM :
create database ToyzUnlimited 
go

use ToyzUnlimited
go

create table Toys(
ProductCode varchar(5) primary key,
Name varchar(30),
Category varchar(30),
Manufacture varchar(40),
AgeRange varchar(15),
UnitPrice money,
Netweight int,
QtyOnHand int
)

--Ex1
insert into Toys values 
('1', 'LBX', 'Lego', 'Korea', '13-15', 50, 1000, 35),
('2', 'Tanker', 'Lego', 'Korea', '13-15', 60, 1200, 25),
('3', 'Robot', 'Lego', 'Korea', '13-15', 55, 800, 28),
('4', 'Doraemon', 'Puzzle', 'Korea', '3-5', 30, 600, 38),
('5', 'GGO', 'Puzzle', 'Korea', '11-13', 25, 1200, 42),
('6', 'FootBall', 'Lego', 'Japan', '3-5', 45, 900, 45),
('7', 'Basketball', 'Puzzle', 'Japan', '3-5', 20, 700, 68),
('8', 'DragonBall', 'Lego', 'Japan', '13-15', 65, 1200, 74),
('9', 'Onepiece', 'Puzzle', 'Japan', '15-18', 22, 800, 55),
('10', 'Ninja', 'Lego', 'Japan', '9-11', 65, 1500, 52),
('11', 'Dragon', 'Lego', 'Chinese', '13-15', 70, 2000, 31),
('12', 'Soccer', 'Q&A', 'Chinese', '3-5', 20, 800, 26),
('13', 'Music', 'Q&A', 'Chinese', '3-5', 15, 700, 86),
('14', 'Swimming', 'Puzzle', 'Chinese', '3-5', 25, 900, 105),
('15', 'Legion', 'Q&A', 'Chinese', '13-15', 20, 500, 22)

--Ex2
create procedure sp_HeavyToys
@MinWeight int
as 
select * from Toys where Netweight > @MinWeight
go

--Ex3
create procedure sp_PriceIncrease 
as
update Toys
set UnitPrice +=10
go 

--Ex4
create proc sp_QtyOnHand
as
update Toys
set QtyOnHand -=5
go

--Ex5
exec sp_HeavyToys 500
exec sp_PriceIncrease 
exec sp_QtyOnHand 

--BÀI TẬP VỀ NHÀ
--ex1
select OBJECT_DEFINITION(OBJECT_ID('Toys')) as definition
select definition from sys.sql_modules
where object_id = OBJECT_ID('Toys')
go 
sp_helptext 'Toys'
go

--Ex2
sp_depends 'sp_HeavyToys'
go

sp_depends 'sp_PriceIncrease'
go

sp_depends 'sp_QtyOnHand'
go

--Ex3 
alter proc sp_PriceIncrease as
update Toys
set UnitPrice +=10
select UnitPrice from Toys 
go

alter proc sp_QtyOnHand as
update Toys
set QtyOnHand -=5
select QtyOnHand from Toys
go

--Ex4
create proc sp_SpecificPriceIncrease
as
update Toys 
set UnitPrice += QtyOnHand 
select UnitPrice from Toys
go

--Ex5
alter proc sp_SpecificPriceIncrease
as
update Toys
set UnitPrice -= QtyOnHand
rollback;
select UnitPrice from Toys
go

--Ex6
alter proc sp_SpecificPriceIncrease
as 
update Toys
set UnitPrice -= QtyOnHand
rollback;
select UnitPrice from Toys
exec sp_HeavyToys 500
go

--Ex7


--Ex8
drop proc sp_HeavyToys
drop proc sp_PriceIncrease
drop proc sp_QtyOnHand