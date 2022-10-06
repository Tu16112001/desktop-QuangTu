USE master
GO
--Create structure of database
IF EXISTS (SELECT * FROM sys.databases WHERE Name='StudentCourse')
DROP DATABASE StudentCourse
GO
CREATE DATABASE StudentCourse
GO
USE StudentCourse
GO
CREATE TABLE Student(
 SID INT PRIMARY KEY,
 S_FName VARCHAR(20) NOT NULL,
 S_LName VARCHAR(30) NOT NULL
);

CREATE TABLE Course(
 CID INT PRIMARY KEY,
 C_Name VARCHAR(30) NOT NULL
);

CREATE TABLE Course_Grades(
 CGID INT PRIMARY KEY,
 Semester CHAR(4) NOT NULL,
 CID_CG INT NOT NULL,
 SID_CG INT NOT NULL,
 Grade CHAR(2) NOT NULL,CONSTRAINT CID_CG_FK FOREIGN KEY (CID_CG)REFERENCES Course(CID)ON DELETE CASCADE,
 CONSTRAINT SID_CG_FK FOREIGN KEY (SID_CG) REFERENCES Student(SID) ON DELETE CASCADE
);

--INSERT data

INSERT INTO Student (SID, S_FName, S_LName) VALUES (12345, 'Quan','Le');
INSERT INTO Student (SID, S_FName, S_LName) VALUES (23456, 'Nhung', 'Hong');
INSERT INTO Student (SID, S_FName, S_LName) VALUES (34567, 'Dat', 'Thanh');
INSERT INTO Student (SID, S_FName, S_LName) VALUES (45678, 'Trung', 'Nguyen');
INSERT INTO Student (SID, S_FName, S_LName) VALUES (56789, 'Vinh', 'Duong');

INSERT INTO Course (CID, C_Name) VALUES (101001, 'Intro to Computers');
INSERT INTO Course (CID, C_Name) VALUES (101002, 'Programming');
INSERT INTO Course (CID, C_Name) VALUES (101003, 'Databases');
INSERT INTO Course (CID, C_Name) VALUES (101004, 'Websites');
INSERT INTO Course (CID, C_Name) VALUES (101005, 'IS Management');

insert into Course_Grades(CGID,Semester,CID,StuID,Grade) values(2010101,'SP10',101005,34567,'D+');
insert into Course_Grades(CGID,Semester,CID,StuID,Grade) values(2010308,'FA10',101005,34567,'A-');
insert into Course_Grades(CGID,Semester,CID,StuID,Grade) values(2010309,'FA10',101001,45678,'B+');
insert into Course_Grades(CGID,Semester,CID,StuID,Grade) values(2011308,'FA11',101003,23456,'B-');
insert into Course_Grades(CGID,Semester,CID,StuID,Grade) values(2012206,'SU12',101002,56789,'A+');

INSERT INTO Course (C_Name) VALUE ('intro to Computers', 'Programming', 'Databases', 'Websites', 'IS Management')

--3. Trong bảng Học sinh/sinh viên, hãy thay đổi độ dài tối đa cho tên của Học viên thành 30
ký tự dài.
ALTER TABLE Student ALTER COLUMN S_FName varchar (30) NOT NULL,

ALTER TABLE Student CONSTRAINT S_FNAME varchar (30) NOT NULL

--4. Trong bảng Khóa học, hãy thêm một cột có tên là "Faculty_LName" trong đó họ của Khoa có thể dài tối đa 30 ký tự. Cột này không được null và giá trị mặc định
nên là "TBD".
ALTER TABLE Course ADD Faculty_LName varchar (30) DEFAULT (‘TBD’)

--5.Trong bảng Khóa học, hãy cập nhật CID 101001 nơi sẽ được Faculty_LName là "Potter" vàC_Name là "Giới thiệu về Pháp sư".
UPDATE Course SET C_Name = 'Intro to Wizardry', Faculty_LName = 'Potter' WHERE CID = 101001

--6. Trong bảng Khóa học, hãy thay đổi tên cột "C_Name" thành "Course_Name".
EXEC sp_rename 'C_Name', 'Course_Name', 'Column'

--7. Xóa lớp "Trang web" khỏi bảng Khóa học.
UPDATE Course SET C_Name = 'Websites' WHERE CID = 101004

--8. Loại bỏ bảng Học viên khỏi cơ sở dữ liệu.
DROP TABLE Student

--9.Xóa tất cả dữ liệu khỏi bảng Khóa học, nhưng vẫn giữ lại cấu trúc bảng.
DELETE FROM Course

--10.Loại bỏ các ràng buộc khóa nước ngoài khỏi cột CID và SID trong Course_Grades bàn.
ALTER TABLE Course_Grades DROP CONSTRAINT fk_CID

ALTER TABLE Course_Grands DROP CONSTRAIN fk_SID