create database asm6
go

use asm6
create table LoaiSach(
TenLoai nvarchar(100),
MaLoai varchar(50)
)

create table Sach(
TenSach nvarchar(100),
MaSach varchar(50) primary key,
TacGia nvarchar(100),
NhaXuatBan nvarchar(100)
)

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