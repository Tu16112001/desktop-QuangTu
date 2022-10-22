use master
go
if EXISTS (select * from sys.databases where name='Aptech')
drop database Aptech
go

CREATE DATABASE Aptech
GO

USE Aptech
Go

CREATE TABLE Classes(
	ClassName char(6),
	Teacher varchar(30),
	TimeSlot varchar(30),
	Class int,
	Lab int,
)
--Tạo an unique, clustered index tên là MyClusteredIndex trên trường ClassName với thuộc tính sau:
CREATE UNIQUE CLUSTERED INDEX MyClusteredIndex ON Classes(ClassName)
WITH(Pad_index = on, FillFactor = 70, Ignore_Dup_key = on)
--Tạo a nonclustered index tên là TeacherIndex trên trường Teacher
CREATE INDEX TeacherIndex ON Classes(Teacher)
--Xóa chỉ mục TeacherIndex
DROP INDEX Classes.TeacherIndex
/*DROP INDEX Classes.MyClusteredIndex*/

--Tạo lại MyClusteredIndexvới các thuộc tính sau:DROP_EXISTING, ALLOW_ROW_LOCKS,
--ALLOW_PAGE_LOCKS= ON, MAXDOP = 2.
--(Tìm hiểu thêm về các thuộc tính trên)
CREATE UNIQUE CLUSTERED INDEX MyClusteredIndex ON Classes(ClassName)
WITH(DROP_EXISTING = on , ALLOW_ROW_LOCKS = on ,ALLOW_PAGE_LOCKS=On,MAXDOP=2)
--Tạo một composite index tên là ClassLabIndex trên 2 trường Class và Lab.
CREATE INDEX ClassLabIndex ON Classes(Class,lab)
--Viết câu lệnh xem toàn bộ các chỉ mục của cơ sở dữ liệu Aptech.
EXEC sys.sp_helpindex N'Classes'