create database asm5
go

use asm5 
create table ThongTin(
Ten nvarchar(100) primary key,
DiaChi nvarchar(100),
NgaySinh date
)

insert into ThongTin values 
(N'Nguyễn Bá Khánh', N'Hà Nội', '2003-11-08'),
(N'Đinh Quang Anh', N'Ninh Bình', '1999-9-19'),
(N'Vũ Viết Quý', N'Thái Bình', '2003-3-8'),
(N'Tạ Duy Linh', N'Thái Nguyên', '2003-8-3')

create table DanhBa(
Ten nvarchar(100) references ThongTin(Ten),
DiaChi nvarchar(100),
DienThoai varchar(100),
NgaySinh date
)

insert into DanhBa values
(N'Nguyễn Bá Khánh', N'Hà Nội', '0934695662', '2003-11-08'),
(N'Nguyễn Bá Khánh', N'Hà Nội', '0392652354', '2003-11-08'),
(N'Nguyễn Bá Khánh', N'Hà Nội', '0987729543', '2003-11-08'),
(N'Đinh Quang Anh', N'Ninh Bình', '0971254124', '1999-9-19'),
(N'Vũ Viết Quý', N'Thái Bình', '097126546', '2003-3-8'),
(N'Vũ Viết Quý', N'Thái Bình', '092352351', '2003-3-8'),
(N'Tạ Duy Linh', N'Thái Nguyên', '0361253162', '2003-8-3')

--Hiển thị toàn bộ tên có trong danh bạ
select Ten from ThongTin

--Hiển thị toàn bộ số điện thoại có trong danh bạ
select DienThoai from DanhBa

--Hiển thị toàn bộ tên có trong danh bạ sắp xếp theo thứ tự alphabet
select Ten from ThongTin order by Ten ASC

--Hiển thị toàn bộ số điện thoại của Nguyễn Bá Khánh
select DienThoai from DanhBa where Ten=N'Nguyễn Bá Khánh'

--Hiển thị tên người sinh ngày 8 tháng 11 năm 2003
select Ten from ThongTin where NgaySinh='2003-11-8'

--Tổng số điện thoại của người tên Nguyễn Bá Khánh
select COUNT(DienThoai) from DanhBa where Ten=N'Nguyễn Bá Khánh' --Thay đổi tên để đếm tổng số điện thoại của từng người

--Tổng số người trong danh bạ sinh vào tháng 12
select COUNT(Ten) from ThongTin where NgaySinh datepart(month, '2003-11-8')

--Lấy ra toàn bộ thông tin trong danh bạ
select * from DanhBa

--Lấy ra toàn bộ thông tin của người có số điện thoại 0987729543
select * from DanhBa where DienThoai = '0987729543'

--Thêm ràng buộc ngày sinh phải nhỏ hơn ngày hiện tại
alter table ThongTin
add constraint check_date check (NgaySinh<getdate())

--Thêm trường StartDate cho bảng Danh Bạ
alter table DanhBa
add StartDate date

--Tạo index và view 
create index IX_HoTen on DanhBa(Ten)
create index IX_DienThoai on DanhBa(DienThoai)

create view View_SoDienThoai as
select Ten, DienThoai from DanhBa
create view View_SinhNhat as 
select Ten, NgaySinh, DienThoai from DanhBa where month(NgaySinh) = 3

create proc SP_Them_DanhBa as
insert into DanhBa values (N'Nguyễn Bá Khánh', N'Hà Nội', '0934695342', '2003-11-08', '')
go
exec SP_Them_DanhBa 
go

create proc SP_Tim_DanhBa 
@Ten nvarchar(100)
as
select * from DanhBa where @Ten = Ten
go
exec SP_Tim_DanhBa N'Nguyễn Bá Khánh'
go