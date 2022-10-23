use master
go
if EXISTS (select * from sys.databases where name='SanPhamTriToc')
drop database SanPhamTriToc
go

CREATE DATABASE SanPhamTriToc
GO

USE SanPhamTriToc
Go

Create table [Admin](
	MaAD INT PRIMARY KEY IDENTITY,
	HoTen Nvarchar(50),
	TaiKhoan varchar(30),
	MatKhau char(30),
	Email char(50),
	SDT char(11),
	NgayTao date
)
Go

Create table ThanhVien(
	MaTV INT PRIMARY KEY IDENTITY,
	TenTV nvarchar(30),
	Taikhoan varchar(30),
	Matkhau char(30),
	Email char(50),
	DienThoai char(11),
	DiaChi nvarchar(50),
)
Go


Create table [Benh](
	MaBenh INT PRIMARY KEY IDENTITY,
	TenBenh nvarchar(50),
	DieuTri ntext,
	MaTV int,
	MaSP int,
	MaNV int,
	TenSP nvarchar(30)
	FOREIGN KEY(MaTV)  REFERENCES ThanhVien(MaTV),
	FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP),
	FOREIGN KEY(MaNV) REFERENCES NhanVien(MaNV)
)
Go

Create table SanPham(
	MaSP INT PRIMARY KEY,
	TenSP nvarchar(30),
	MaHang int,
	GiaBan char(30),
	GiaKM char(30),
	BaoHanh date,
	MoTa nvarchar(200),
	Soluong char(30)
	FOREIGN KEY (MaHang) REFERENCES CongTySanXuat(MaHang)
)
Go

Create table HoaDon(
	MaHD INT PRIMARY KEY,
	MaSP int,
	TenSP nvarchar(30),
	MaTV int,
	TenTV nvarchar(30),
	DiaChi Nvarchar(50),
	SDT char(11)
	FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP)
)
Go

Create table CongTySanXuat(
	MaHang int PRIMARY KEY,
	TenSP nvarchar(30),
	DiaChi nvarchar(50)
)
Go

Create table NhanVien(
	MaNV int PRIMARY KEY,
	TenNV nvarchar(30),
	SDT char(11),
	Luong char(30),
)
Go

Create table AnhSanPham(
	MaAnh char(20) PRIMARY KEY,
	TenAnh varchar(30),
	MaSP int,
	FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
)
Go

Create table CongDungSanPham(
	MaCDSP char(20) PRIMARY KEY,
	MaSP int,
	TenSP nvarchar(30),
	CongDungSP ntext
	FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
)
Go




