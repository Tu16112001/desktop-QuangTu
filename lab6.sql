CREATE DATABASE Lab11
GO
USE Lab11
GO
CREATE VIEW ProductList
AS
SELECT ProductID, Name FROM AdventureWorks.Production.Product
Go
SELECT * FROM ProductList
--Nhận xét: Ta có thể truy cập đến dữ liệu của bảng Production.Product của CSDL AdventureWorks thông qua khung nhìn ProductList.

CREATE VIEW SalesOrderDetail
AS
SELECT pr.ProductID, pr.Name, od.UnitPrice, od.OrderQty,
od.UnitPrice*od.OrderQty as [Total Price]
FROM AdventureWorks.Sales.SalesOrderDetail od
JOIN AdventureWorks.Production.Product pr
ON od.ProductID=pr.ProductID

SELECT * FROM SalesOrderDetail