create database task4
GO

use task4
--Tạo bảng thông tin hàng có trong kho
create table MatHang(
TenHang nvarchar(100) NOT NULL,
MoTa nvarchar(100),
DonVi nvarchar(100),
Gia int NOT NULL,
SoLuong int,
ThanhTien int,
MatHangID int NOT NULL primary key
)

insert into MatHang(TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MatHangID) values (N'Điện thoại Nokia6750', N'Còn mới', N'Chiếc', 1000, 10, 10000, 1)
insert into MatHang(TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MatHangID) values (N'LapTop Lenovo ThinkPad 2760', 'Còn mới', N'Chiếc', 25000, 1, 25000, 2)
insert into MatHang(TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MatHangID) values (N'Iphone 13 Promax', N'99%', N'Chiếc', 29000, 1, 29000, 3)
insert into MatHang(TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MatHangID) values (N'Cáp sạc Iphone', N'Còn mới', N'Chiếc', 100, 1, 100, 4)
insert into MatHang(TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MatHangID) values (N'Tai nghe cổng lightning', N'Còn mới', N'Chiếc', 129, 1, 129, 5)
insert into MatHang(TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MatHangID) values (N'Chân đế laptop Lenovo', N'Còn mới', N'Chiếc', 300, 1, 300, 6)

--Thông tin khách hàng
create table DonHang(
TenKhach nvarchar(100) NOT NULL,
DiaChi nvarchar(100),
DienThoai bigint NOT NULL,
NgayDat date NOT NULL,
KhachHangID int primary key
)

insert into DonHang values (N'Nguyễn Bá Khánh', N'Thanh Cao-Thanh Oai-Hà Nội', 987729543, '2021-12-24', 1)
insert into DonHang values (N'Lương Viết Hoàng', N'Hạ Long-Quảng Ninh', 9823515, '2021-12-24', 2)
insert into DonHang values (N'Vũ Viết Quý', N'Quý ở đâu khum nhớ', 98123566, '2021-12-24', 3)
insert into DonHang values (N'Tạ Duy Linh', N'Thái Nguyên', 91235715, '2021-12-24', 4)

--Tạo bảng lưu trữ đơn hàng
create table LuuTru(
KhachHangID int,
MatHangID int,
constraint fk_idhang foreign key (MatHangID) references MatHang(MatHangID),
constraint fk_idkhach foreign key (KhachHangID) references DonHang(KhachHangID)
)

insert into LuuTru values (1, 1)
insert into LuuTru values (3, 2)
insert into LuuTru values (3, 5)

--Tạo bảng thông tin chi tiết đơn hàng 
create table Bill(
MatHangID int foreign key references MatHang(MatHangID),
KhachHangID int foreign key references DonHang(KhachHangID),
ThanhTien int,
SoLuong int,
)

insert into Bill values (1, 1, 1000, 1)
insert into Bill values (2, 3, 129, 1)
insert into Bill values (5, 3, 25000, 1)


--Ex4
select * from DonHang
select * from MatHang
select * from LuuTru
select * from Bill

--Ex5
--Liệt kê danh sách đơn hàng theo thứ tự alphabet
select * from DonHang
order by TenKhach ASC

--Liệt kê thứ tự mặt hàng theo giá giảm dần
select * from MatHang
order by Gia DESC

--Liệt kê các sản phẩm mà khách hàng Vũ Viết Quý đã mua
select TenHang from MatHang where MatHangID in (
select MatHangID from Bill where KhachHangID in (
select KhachHangID from LuuTru
where KhachHangID = 3
)
)

--Ex6
select COUNT(KhachHangID) from DonHang
select COUNT(MatHangID) from LuuTru
select KhachHangID, SUM(ThanhTien * SoLuong) as 'ThanhTien' from Bill group by KhachHangID

--Ex7
alter table MatHang 
add constraint ck_gia check (Gia>0)
alter table Bill
add constraint ck_thanhtien check (ThanhTien>0)
alter table DonHang 
add constraint ck_ngaydat check (NgayDat < getDate())
alter  table MatHang
add NgayXuat date