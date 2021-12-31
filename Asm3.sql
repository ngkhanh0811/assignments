create database asm3
go

use asm3
create table ThongTin(
TenKH nvarchar(100),
SoCMT int primary key,
DiaChi nvarchar(100)
)

insert into ThongTin values
(N'Nguyễn Bá Khánh', 00123456789, N'Hà Nội'),
(N'Đinh Quang Anh', 00123456788, N'Ninh Bình'),
(N'Tạ Duy Linh', 0012345687, N'Thái Nguyên'),
(N'Nguyễn Mạnh Kiên', 00123456786, N'Nhà Thầy'),
(N'Tạ Văn Minh', 00123456785, N'Thanh Hóa'),
(N'Lương Viết Hoàng', 00123456784, N'Hạ Long')

create table GiayDK(
TenKH nvarchar(100),
SoCMT int references ThongTin(SoCMT),
DiaChi nvarchar(100) references ThanhPho(DiaChi),
ThueBao varchar(100) primary key,
LoaiTB nvarchar(40),
NgayDK date
)

insert into GiayDK values 
(N'Nguyễn Bá Khánh', 00123456789, N'Hà Nội', '0987729543', N'Trả trước', '2021-12-31')
(N'Nguyễn Bá Khánh', 00123456789, N'Hà Nội', '0392652354', N'Trả trước', '2021-12-31')
(N'Tạ Duy Linh', 00123456787, N'Hà Nội', '0912531353', N'Trả trước', '2021-12-31')
(N'Dinh Quang Anh', 00123456788, N'Hà Nội', '091242353', N'Trả trước', '2021-12-28')
(N'Nguyễn Mạnh Kiên', 00123456786, N'Hà Nội', '092351543', N'Trả trước', '2021-12-30')
(N'Vũ Viết Quý', 00123456785, N'Hà Nội', '012412453', N'Trả trước', '2021-12-30')
(N'Lương Viết Hoàng', 00123456784, N'Hà Nội', '03512541231', N'Trả trước', '2021-12-26')

create table ThanhPho(
MaTP int,
DiaChi nvarchar(100) primary key
)