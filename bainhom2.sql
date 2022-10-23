use master
go
if EXISTS (select * from sys.databases where name='BanTinh')
drop database BanTinh
go

CREATE DATABASE BanTinh
GO

USE BanTinh
Go

Create table [Admin](
	MaAD INT PRIMARY KEY IDENTITY,
	HoTen Nvarchar(50),
	TaiKhoan varchar(30),
	MatKhau char(30),
	Email char(50),
	SDT char(11),
	NgayTao date,
	Tuoi int,
	DiaChi nvarchar(100),
)
Go


Create table ThanhVien(
	MaTV INT PRIMARY KEY IDENTITY,
	HoTen Nvarchar(50),
	TaiKhoan varchar(30),
	MatKhau char(30),
	Email char(50),
	SDT char(11),
	NgayTao date,
	Tuoi int,
	DiaChi nvarchar(100),
	HinhAnh varbinary(max),
	Gioithieu ntext	
)
Go

Create table NhanVien(
	MaNV int PRIMARY KEY IDENTITY,
	TenNV nvarchar(30),
	SDT char(11),
	Luong char(30),
	MaTV int
	FOREIGN KEY(MaTV) REFERENCES ThanhVien(MaTV)
)
Go

Create table Tuoi(
	MaTuoi int PRIMARY KEY IDENTITY,
	Tuoi int,
	MaTV int,
	MaTVK int
	FOREIGN KEY(MaTV) REFERENCES ThanhVien(MaTV),
	FOREIGN KEY(MaTVK) REFERENCES ThanhVienKhac(MaTVK)
)
Go

Create table GioiTinh(
	MaGioiTinh int PRIMARY KEY IDENTITY,
	LoaiGioiTinh nvarchar(20),
	MaTV int,
	MaTVK int
	FOREIGN KEY(MaTV) REFERENCES ThanhVien(MaTV),
	FOREIGN KEY(MaTVK) REFERENCES ThanhVienKhac(MaTVK)
)
Go

Create table ViTriDiaLy(
	MaVTDL int PRIMARY KEY IDENTITY,
	ViTri nvarchar(50),
	QuocGia nchar(30),
	MaTV int,
	MaTVK int
	FOREIGN KEY(MaTV) REFERENCES ThanhVien(MaTV),
	FOREIGN KEY(MaTVK) REFERENCES ThanhVienKhac(MaTVK)
)
Go

Create table SoThich(
	MaSoThich int PRIMARY KEY IDENTITY,
	LoaiSoThich nvarchar(50),
	ChieuCao nchar(10),
	MaTV int,
	MaTVK int
	FOREIGN KEY(MaTV) REFERENCES ThanhVien(MaTV),
	FOREIGN KEY(MaTVK) REFERENCES ThanhVienKhac(MaTVK)
)
Go

Create table ThanhVienKhac(
	MaTVK int PRIMARY KEY IDENTITY,
	HoTen Nvarchar(50),
	NgayTao date,
	Tuoi int,
	DiaChi nvarchar(100),
	HinhAnh varbinary(max),
	Gioithieu ntext	
)
Go

