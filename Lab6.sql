use AdventureWorks2019
--Lấy ra dữ liệu của bảng Contact có ContactID > 00 và ContactId <=200
select * from Person.Contact
where ContactID >= 00 and ContactID <= 200

--Lấy ra dữ liệu của bảng Contact có ContactID trong khoảng 100 - 200
select * from Person.Contact 
where ContactID between 100 and 200

--Lấy ra những Contact có LastName kết thúc bởi kí tự e
select * from Person.Contact 
where LastName like '%e'

--Lấy ra những Contact có LastName bắt đầu bởi kí tự R, A hoặc kết thúc bằng kí tự e
select * from Person.Contact 
where LastName like '[RA]%e'

--Lấy ra những Contact có LastName có 4 kí tự bắt đầu bởi kí tự R hoặc A kết thúc bởi kí tự e
select * from Person.Contact 
where LastName like '[RA]__%e'

--Sử dụng inner join
select Person.Contact * from Person.Contact inner join HumanResources.Employee on
		Person.Contact.ContactID = HumanResources.Employee.ContactID 
select Title, COUNT(*) [Tittle Number]
from Person.Contact 
where Title like 'Mr%'
group by all Title 

--Group by với having : mệnh đề having sẽ lọc kết quả trong lúc gộp nhóm
select Title, COUNT(*) [Title Number]
from Person.Contact
group by all Title 
having Title like 'Mr%'

--III Bài tập tự làm :
create table PhongBan(
MaPB varchar(7) primary key,
TenPB nvarchar(50)
)

create table NhanVien(
MaNV varchar(7) primary key,
TenNV nvarchar(50),
NgaySinh date check (NgaySinh <= getdate()),
SoCMND char(9),
GioiTinh char(1) check (GioiTinh = 'M' or GioiTinh = 'F'),
DiaChi nvarchar(100),
NgayVaoLam date,
MaPB varchar(7) references PhongBan(MaPB)
)

create table LuongDA(
MaDA varchar(8) primary key,
MaNV varchar(7) references NhanVien(MaNV),
NgayNhan date not null,
SoTien money check (SoTien > 0)
)

select * from LuongDA
select * from NhanVien
select * from PhongBan