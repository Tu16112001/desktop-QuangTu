use master
go
if EXISTS (select * from sys.databases where name='AZBank')
drop database AZBank
go

CREATE DATABASE AZBank
GO

USE AZBank
Go

CREATE TABLE Customer(
	CustomerID int PRIMARY KEY ,
	Name nvarchar(50),
	City nvarchar(50),
	Country nvarchar(50),
	Phone nvarchar(15),
	Email nvarchar(50)
)
GO

CREATE TABLE CustomerAccount(
	AccountNumber char(9) PRIMARY KEY,
	CustomerID int,
	Balance money,
	MinAccount money
	FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
)
Go

CREATE TABLE CustomerTransaction(
	TransactionID int PRIMARY KEY,
	AccountNumber char(9),
	TransactionData SmallDateTime,
	Amount money,
	DepositorWithdraw bit
	FOREIGN KEY(AccountNumber) REFERENCES CustomerAccount(AccountNumber)
)
Go

INSERT INTO Customer VALUES(1,'HAi Hong Son','HN','VN','0123','HAi@gmail.com')
INSERT INTO Customer VALUES(2,'Tu','HN','VN','2345','Tu@gmail.com')
INSERT INTO Customer VALUES(3,'Long','HN','VN','5678','Long@gmail.com')
SELECT * FROM Customer

INSERT INTO CustomerAccount VALUES('ACQ1',1,2000,100)
INSERT INTO CustomerAccount VALUES('ACQ2',1,100000,100)
INSERT INTO CustomerAccount VALUES('ACQ3',2,40000,100)
SELECT * FROM CustomerAccount

INSERT INTO CustomerTransaction VALUES(1,'ACQ1','2022-07-10',2000,2)
INSERT INTO CustomerTransaction VALUES(2,'ACQ2','2022-07-11',100000,3)
INSERT INTO CustomerTransaction VALUES(3,'ACQ3','2022-07-12',6000,4)
SELECT * FROM CustomerTransaction
--4
SELECT * FROM Customer WHERE City = 'HN'
--5
SELECT Name,Phone,Email,AccountNumber,Balance FROM Customer
join CustomerAccount ON
Customer.CustomerId = CustomerAccount.CustomerId
--6
ALTER TABLE CustomerTransaction
ADD CONSTRAINT CK_Checkwithdrawal 
CHECK (DepositorWithdraw > 0 and DepositorWithdraw <= 1000000)
--7
CREATE VIEW viewCustomerTransactions
AS
SELECT Name,CustomerAccount.AccountNumber,TransactionDate,Amount,DepositorWithdraw FROM Customer
join CustomerAccount ON
Customer.CustomerId = CustomerAccount.CustomerId
Join CustomerTransaction ON
CustomerTransaction.AccountNumber = CustomerAccount.AccountNumber
SELECT * FROM viewCustomerTransactions