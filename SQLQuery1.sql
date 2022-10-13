use master
go
if EXISTS (select * from sys.databases where name='BookCustomer')
drop database BookCustomer
go

CREATE DATABASE BookCustomer
GO

USE BookCustomer
Go

CREATE TABLE Customer(
	CustomerID int PRIMARY KEY IDENTITY,
	CustomerName varchar(50),
	Address varchar(100),
	Phone varchar(12)
)
GO
SELECT*FROM Customer

CREATE TABLE Book(
	BookCode int PRIMARY KEY,
	Category varchar(50),
	Author varchar(50),
	Publisher varchar(50),
	Title varchar(100),
	Price int,
	InStore int
)
GO
SELECT*FROM Book

CREATE TABLE BookSold(
	BookSoldID int PRIMARY KEY,
	CustomerID int,
	BookCode int,
	Date datetime,
	Price int,
	Amount int,
	FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY(BookCode) REFERENCES Book(BookCode)
)
SELECT*FROM BookSold

--1 chen ban ghi
INSERT INTO Customer(CustomerName,Address,Phone) VALUES('Tu','HN','01');
INSERT INTO Customer(CustomerName,Address,Phone) VALUES('HA','HP','02');
INSERT INTO Customer(CustomerName,Address,Phone) VALUES('SON','ND','03');
INSERT INTO Customer(CustomerName,Address,Phone) VALUES('Long','HD','04');
INSERT INTO Customer(CustomerName,Address,Phone) VALUES('Dat','QN','05');

INSERT INTO Book(BookCode,Category,Author,Publisher,Title,Price,InStore) VALUES ('1','Amnhac','Trana','11/12/2022','Nhac','21','1000');
INSERT INTO Book(BookCode,Category,Author,Publisher,Title,Price,InStore) VALUES ('2','Sinhhoc','Tranb','1/12/2022','Sinh','22','1000');
INSERT INTO Book(BookCode,Category,Author,Publisher,Title,Price,InStore) VALUES ('3','Toanhoc','Tranc','21/12/2022','Toan','23','1000');
INSERT INTO Book(BookCode,Category,Author,Publisher,Title,Price,InStore) VALUES ('4','Vanhoc','Trand','22/12/2022','Van','24','1000');
INSERT INTO Book(BookCode,Category,Author,Publisher,Title,Price,InStore) VALUES ('5','Tinhoc','Trane','15/12/2022','Tin','25','1000');

INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('72365','1','1/1/2023','31','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('36363','2','1/1/2023','32','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('12312','3','1/1/2023','33','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('46535','4','1/1/2023','34','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('23525','5','1/1/2023','35','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('35235','6','1/1/2023','36','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('35234','7','1/1/2023','37','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('52335','8','1/1/2023','38','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('56234','9','1/1/2023','39','1000');
INSERT INTO BookSold(BookSoldID,BookCode,Date,Price,Amount) VALUES ('45635','10','1/1/2023','40','1000');

--2. Tạo một khung nhìn chứa danh sách các cuốn sách (BookCode, Title, Price) kèm theo số lượng đã
--bán được của mỗi cuốn sách.
--Gợi ý: Trường Amout của bảng BookSold chứa số lượng sách đã bán cho một khách hàng.
CREATE VIEW View_Book_BookSold
AS
SELECT Book.B_ID,B_Category,B_Price,BS_Price,BS_Amount FROM Book
inner join BookSold ON
BookSold.B_ID = Book.B_ID

SELECT * FROM View_Book_BookSold
--3. Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) kèm
--theo số lượng các cuốn sách mà khách hàng đó đã mua.
CREATE VIEW view_cus_booksold
AS
SELECT Customer.C_ID,C_Name,C_Address,BS_Amount FROM Customer
inner join BookSold ON
BookSold.C_ID = Customer.C_ID

--4. Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) đã
--mua sách vào tháng trước, kèm theo tên các cuốn sách mà khách hàng đã mua.
CREATE VIEW view_cus_book_sold
AS
SELECT Customer.C_ID,C_Name,C_Address,B_Title,BS_Date FROM Customer
left join BookSold ON
BookSold.C_ID = Customer.C_ID 
left join Book ON
BookSold.B_ID = Book.B_ID WHERE (DATEDIFF(month,BS_Date,getdate())>1)

select getdate()

--5. Tạo một khung nhìn chứa danh sách các khách hàng kèm theo tổng tiền mà mỗi khách hàng đã chi
--cho việc mua sách.
--Gợi ý: Tiền mỗi lần mua = Giá mỗi cuốn sách * Số lượng sách đã mua.
CREATE VIEW  view_cus_amount
AS
SELECT C_Name,SUM(BookSold.BS_Amount * BookSold.BS_Price) as [Total cost] FROM Customer
JOIN BookSold ON
BookSold.C_ID = Customer.C_ID WHERE Customer.C_Name like '%son%'
GROUP BY C_Name