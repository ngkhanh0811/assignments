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
MaSach references Sach(MaSach),

)