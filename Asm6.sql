create database asm6
go

use asm6
create table LoaiSach(
TenLoai nvarchar(100),
MaLoai varchar(50)
)

insert into LoaiSach values
(N'Văn học cổ điển', 'CD'),
(N'Văn học nước ngoài', 'NN'),
(N'Văn học hiện đại', 'HD'),
(N'Truyện, ký', 'TK'),
(N'Khoa học và xã hội', 'KHXH'),

create table Sach(
TenSach nvarchar(100),
MaSach varchar(50) primary key,
TacGia nvarchar(100),
NhaXuatBan nvarchar(100)
)

insert into Sach values
(N'', '', N'', N''),
(N'', '', N'', N''),
(N'', '', N'', N''),
(N'', '', N'', N''),
(N'', '', N'', N''),

create table ThongTin(
MaSach varchar(50) references Sach(MaSach),
TenSach nvarchar(100),
TacGia nvarchar(100),
NoiDung nvarchar(100),
NamXB int,
LanXB int,
NhaXuatBan nvarchar(100),
DiaChi nvarchar(100),
Gia int,
SoLuong int,
MaLoai varchar(50) references LoaiSach(MaLoai) 
)