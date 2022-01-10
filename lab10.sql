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

-- Xem định nghĩa thủ tục lưu trữ bằng OBJECT_DEFINITION
select 
OBJECT_DEFINITION(OBJECT_ID('HumanResource.uspUpdateEmployeePersonalInfo')) as definition