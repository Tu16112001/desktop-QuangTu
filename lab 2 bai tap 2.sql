IF EXISTS (SELECT * FROM sys.databases WHERE Name='BookLibrary')
	DROP DATABASE BookLibrary
GO
CREATE DATABASE BookLibrary
GO
USE BookLibrary
GO
--Tạo bảng Book (Lưu thông tin các cuốn sách)
CREATE TABLE Book (
	BookCode int PRIMARY KEY ,
	BookTitle varchar (100) NOT NULL,
	Author varchar (50) NOT NULL,
	Edition int,
	BookPrice money,
	Copies int
)
GO

CREATE TABLE Member (
	MemberCode int PRIMARY KEY,
	Name varchar (50) NOT NULL,
	Address varchar (100) NOT NULL,
	PhoneNumber int 
)
GO
CREATE TABLE IssueDetails (
	BookCode int,
	MemberCode int,
	IssueDate datetime PRIMARY KEY,
	ReturnDate datetime
	CONSTRAINT fk_Book FOREIGN KEY (BookCode) REFERENCES Book (BookCode),
	CONSTRAINT fk_Member FOREIGN KEY (MemberCode) REFERENCES Member (MemberCode)
)
GO
--xoa rang buoc khoa ngoai IssueDetails 
ALTER TABLE IssueDetails 
DROP CONSTRAINT fk_Book

ALTER TABLE IssueDetails 
DROP CONSTRAINT fk_Member
GO
--Xoa rang buoc khoa chinh Book va Member
ALTER TABLE Book 
DROP CONSTRAINT Bookcode;

ALTER TABLE Member
DROP CONSTRAINT Membercode;
GO

/* Thêm rang buoc khóa chính. */
ALTER TABLE Book ADD CONSTRAINT pk_BookCode PRIMARY KEY (Bookcode);
ALTER TABLE Member ADD CONSTRAINT pk_MemberCode PRIMARY KEY (Membercode);

--4. /* thêm rang buoc khóa ngoài */

ALTER TABLE IssueDetails ADD CONSTRAINT fk_Book FOREIGN KEY (Bookcode) REFERENCES Book

ALTER TABLE IssueDetails ADD CONSTRAINT fk_Member FOREIGN KEY (Membercode) REFERENCES Member
GO

--6. /* thêm độc đáo */

ALTER TABLE Member ADD CONSTRAINT PhoneNumber UNIQUE;

ALTER TABLE Member ADD CONSTRAINT PhoneNumber UNIQUE;

--7. Bổ sung thêm ràng buộc NOT NULL cho BookCode, MemberCode trong bảng IssueDetails

ALTER TABLE IssueDetails ALTER COLUMN BookCode int NOT NULL

ALTER TABLE IssueDetails ALTER COLUMN  MemberCode int NOT NULL
--8. /* thêm khóa chính cho khóa ngoại */

ALTER TABLE IssueDetails ADD CONSTRAINT pk_BookCode PRIMARY KEY (BookCode);

ALTER TABLE IssueDetails ADD CONSTRAINT pk_MemberCode PRIMARY KEY (MemberCode);
GO

--9. /* thêm dữ liệu */

INSERT INTO Book VALUES (01 ,'Java', 'Oracle', 7, 200, 10);

INSERT INTO Member VALUES (100, 'James', '1234 Henley street', 0908021389);

INSERT INTO IssueDetails VALUES (01,100, 25/05/22, 26/05/22);
GO
