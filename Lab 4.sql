use master
go
if EXISTS (select * from sys.databases where name='labselect')
drop database labselect
go
create database labselect
go
use labselect
create table PhongBan (
	MaPB varchar(7) primary key,
	TenPB nvarchar(50),
	);
create table NhanVien (
	MaNV varchar(7) primary key,
	TenNV nvarchar(50),
	NgaySinh datetime check((DATEDIFF(year,ngaysinh,getdate()) > 0)) default '1970-01-01',
	SoCmnd char(9) check (Socmnd not like '%[^0-9]%'),
	Gioitinh char(1) check(Gioitinh='M' or Gioitinh='F')  default 'M',
	DiaChi nvarchar(100),
	Ngayvaolam datetime default getdate(),
	MaPB varchar(7),
	constraint NV_MaPB_FK foreign key (MaPB) references PhongBan(MaPB) on delete cascade,
	constraint chk_nhanvien check(datediff(year,ngaysinh,ngayvaolam)>20)
	);
create table LuongDA (
	MaDA varchar(8) ,
	MaNV varchar(7),
	constraint NV_MaNV_FK foreign key (MaNV) references NhanVien(MaNV) on delete cascade,
	Ngaynhan datetime not null default getdate(),
	sotien money check(sotien>0),
	constraint pk_LuongDA primary key(MaDA,MaNV)
	);

	--1. Thực hiện chèn dữ liệu vào các bảng vừa tạo (ít nhất 5 bản ghi cho mỗi bảng).

	Insert into PhongBan (MaPB,TenPB) values ('a1','congtac');
	Insert into PhongBan (MaPB,TenPB) values ('a2','taichinh');
	Insert into PhongBan (MaPB,TenPB) values ('a3','taivu');
	Insert into PhongBan (MaPB,TenPB) values ('a4','kho');
	Insert into PhongBan (MaPB,TenPB) values ('a5','quantri');

	Insert into NhanVien values ('cnv01','Duc','1996-05-05','012345678','M','Hanoi','2021-5-1','a2');
	Insert into NhanVien values ('cnv02','Son','1999-06-22','034637687','M','Yenbai','2021-5-1','a3');
	Insert into NhanVien values ('cnv03','Nam','2000-06-15','984113575','M','Hanoi','2021-5-2','a1');
	Insert into NhanVien values ('cnv04','Kim','1991-05-05','012345654','F','HoChiMinh','2021-5-2','a4');
	Insert into NhanVien values ('cnv05','Hue','1995-11-12','987463145','F','LangSon','2021-5-2','a5');
	Insert into NhanVien values ('cnv06','Cuong','1995-11-12','987454111','M','HoChiMinh','2021-5-3','a5');
	Insert into NhanVien values ('cnv07','Dung','1998-01-15','987441361','f','CaoBang','2021-5-7','a4');
	Insert into NhanVien values ('cnv08','Hai','1998-02-19','887541363','M','CaoBang','2021-5-7','a4');
	Insert into NhanVien values ('cnv09','Ha','1997-05-09','012345679','F','Hanoi','2021-5-1','a2');

	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('FLC','cnv02','2022-02-02','5000');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('FLC','cnv01','2022-02-02','1000');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('VIN','cnv03','2022-02-02','30000');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('VIN','cnv05','2022-02-02','300');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('Group','cnv04','2022-02-02','7000');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('VIN','cnv04','2022-02-02','7000');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('Group','cnv05','2022-02-02','7000');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('Group','cnv06','2022-02-03','5500');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('Group','cnv09','2022-02-03','9500');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('VIN','cnv09','2022-02-03','3500');
	Insert into LuongDA (MaDA,MaNV,Ngaynhan,sotien) values('CAI','cnv08','2022-02-06','2500');

	--2. Viết một query để hiển thị thông tin về các bảng LUONGDA, NHANVIEN, PHONGBAN.
	select * from LuongDA
	select * from NhanVien
	select * from PhongBan

	--3. Viết một query để hiển thị những nhân viên có giới tính là ‘F’.
	select * from NhanVien where Gioitinh like 'F'

	--4. Hiển thị tất cả các dự án, mỗi dự án trên 1 dòng.
	select distinct MaDA from LuongDA

	--5. Hiển thị tổng lương của từng nhân viên (dùng mệnh đề GROUP BY).
	select MaNV, SUM(SoTien) as 'Tong luong nhan vien'
	from LuongDA
	group by MaNV

	--6. Hiển thị tất cả các nhân viên trên một phòng ban cho trước (VD: ‘a5’).
	select * from NhanVien where MaPB like 'a5'

	--7. Hiển thị mức lương của những nhân viên phòng quản trị.
	select LuongDA.sotien, LuongDA.MaDA, LuongDA.MaNV, NhanVien.TenNV, PhongBan.TenPB
	from (LuongDA inner join NhanVien on LuongDA.MaNV = NhanVien.MaNV) 
	right join PhongBan on NhanVien.MaPB=PhongBan.MaPB where TenPB='quantri'; 
	
	--8. Hiển thị số lượng nhân viên của từng phòng.
	select count(manv) as'So luong nhan vien tung phong',PhongBan.TenPB from NhanVien left join PhongBan on NhanVien.MaPB=PhongBan.MaPB
	group by TenPB

	--9. Viết một query để hiển thị những nhân viên mà tham gia ít nhất vào một dự án.
	select  NhanVien.TenNV, count(luongda.MaDA) as 'So du an tham gia' from NhanVien left join LuongDA on NhanVien.MaNV=LuongDA.MaNV 
	group by TenNV 

	--10. Viết một query hiển thị phòng ban có số lượng nhân viên nhiều nhất.
	select PhongBan.TenPB from PhongBan inner join NhanVien on PhongBan.MaPB=NhanVien.MaPB 
	where NhanVien.MaNV=(select count(nhanvien.manv) from nhanvien )

	--11. Tính tổng số lượng của các nhân viên trong phòng kho.
	select count(manv) as'So luong NV phong kho' from NhanVien left join PhongBan on NhanVien.MaPB=PhongBan.MaPB
	where PhongBan.TenPB='kho' 

	--12. Hiển thị tống lương của các nhân viên có số CMND tận cùng bằng 9.
	select LuongDA.MaNV,sum(sotien) as 'Tong luong cua nguoi co so cuoi CMND la 9' from LuongDA left join NhanVien on LuongDA.MaNV=NhanVien.MaNV
	where NhanVien.SoCmnd like '%9' group by LuongDA.MaNV

	--13. Tìm nhân viên có số lương cao nhất.
	select NhanVien.MaNV,NhanVien.TenNV from NhanVien right join LuongDA on NhanVien.MaNV=LuongDA.MaNV 
	where Luongda.sotien=(select MAX(SoTien) from LuongDA)

	--14. Tìm nhân viên ở phòng Hành chính có giới tính bằng ‘F’ và có mức lương > 1200000.
	select TenNV,MaNV from NhanVien where GioiTinh = 'F' and MaPB in
	(select MaPB from PhongBan where TenPB like '%kho%') and MaNv in
	(select MaNV from LuongDA where SoTien > 3500)

	--15. Tìm tổng lương trên từng phòng.
	select PhongBan.TenPB,sum(LuongDA.sotien) as 'Tong luong cua tung phong ban'
	from (LuongDA inner join NhanVien on LuongDA.MaNV = NhanVien.MaNV) 
	right join PhongBan on NhanVien.MaPB=PhongBan.MaPB group by PhongBan.TenPB

	--16. Liệt kê các dự án có ít nhất 2 người tham gia.
	select LuongDA.MaDA,count(LuongDA.MaDA) as 'So nguoi tham gia' from LuongDA 
	group by LuongDA.MaDA having count(LuongDA.MaDA)>1

	--17.Liệt kê thông tin chi tiết của nhân viên có tên bắt đầu bằng ký tự ‘N’.
	select * from NhanVien full join LuongDA on NhanVien.MaNV=LuongDA.MaNV 
	where NhanVien.TenNV like 'n%'

	--18. Hiển thị thông tin chi tiết của nhân viên được nhận tiền dự án trong năm 2003.

	--19. Hiển thị thông tin chi tiết của nhân viên không tham gia bất cứ dự án nào.
	select * from NhanVien left Join  LuongDA
	on NhanVien.MaNV = LuongDA.MaNV  WHERE MaDA is null

	--20. Xoá dự án có mã dự án là DXD02.
	delete from LuongDA where MaDA like 'Dxd02'

	--21. Xoá đi từ bảng LuongDA những nhân viên có mức lương 2000000.
	delete from LuongDA where SoTien = 2000000
	--22. Cập nhật lại lương cho những người tham gia dự án XDX01 thêm 10% lương cũ.
	--23. Xoá các bản ghi tương ứng từ bảng NhanVien đối với những nhân viên không có mã nhân viên tồn tại trong bảng LuongDA.
	delete from NhanVien WHERE TenNV = 
	(SELECT TenNV FROM NhanVien left Join  LuongDA
	on NhanVien.MaNV = LuongDA.MaNV  WHERE MaDA is null)

	--24. Viết một truy vấn đặt lại ngày vào làm của tất cả các nhân viên thuộc phòng hành chính(kho) là ngày 12/02/1999
	UPDATE NhanVien SET Ngayvaolam=12-02-1999 where MaPB =(select MaPB from PhongBan where TenPB like '%kho%' )

