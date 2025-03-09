CREATE DATABASE SQLTEST;
CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    IsActive BIT DEFAULT 1
);


CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerId),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2),
    Status NVARCHAR(50) CHECK (Status IN ('Pending', 'Processing', 'Completed', 'Cancelled'))
);

CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT DEFAULT 0 CHECK (Stock >= 0)
);

CREATE TABLE OrderDetails (
    OrderDetailId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderId),
    ProductId INT NOT NULL FOREIGN KEY REFERENCES Products(ProductId),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    SubTotal DECIMAL(10, 2) NOT NULL
);

CREATE TABLE AuditLog (
    AuditId INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(100),
    Action NVARCHAR(50),
    RecordId INT,
    ActionBy NVARCHAR(100),
    ActionDate DATETIME DEFAULT GETDATE()
);
------------------------------------1. Stored Procedure Tasks
--Task 1: Customer Data Retrieval
CREATE PROC GetCustomerOrders @CustomerId INT
WITH ENCRYPTION
AS
	SELECT *, TotalAmount
	FROM Orders O
	INNER JOIN Customers C
	ON O.CustomerId = C.CustomerId
	ORDER BY OrderId

--Task 2: Add New Product
CREATE PROC AddProduct 
	@ProductId	INT,
	@Name NVARCHAR(100),
	@Price DECIMAL(10,2),
	@Stock INT
AS
	IF NOT EXISTS (SELECT Name FROM Products WHERE Name = @Name)
		BEGIN
			INSERT INTO Products
			VALUES(@ProductId, @Name, @Price, @Stock)
		END
	ELSE
		SELECT 'SORRY CAN NOT DUPLICATE'



--2. Trigger Tasks-------------------------------
--Task 1: Audit Log
CREATE TRIGGER trg_InsertOrderAudit 
ON Orders
AFTER INSERT
AS
	INSERT INTO AuditLog(RecordId ,ActionBy, ActionDate)
	VALUES((SELECT OrderId FROM inserted), SUSER_NAME(), GETDATE())


--Task 2: Prevent Negative Stock
CREATE TRIGGER trg_PreventNegativeStock 
ON Products
AFTER UPDATE
AS
	IF(UPDATE(Stock))
		BEGIN
			IF EXISTS (SELECT Stock FROM Products WHERE Stock < 0)
				BEGIN
					ROLLBACK
					SELECT 'Stock value can not be zero'
				END
		END


---------------------------------------3. Function Tasks
--Task 1: Calculate Discounted Price
CREATE FUNCTION fn_GetDiscountedPrice (@Price DECIMAL(10,2), @DiscountPrecentage DECIMAL)
RETURNS DECIMAL	
	BEGIN
	DECLARE @Discounted DECIMAL
	SELECT @Discounted = @Price - (@Price * @Discounted/100)
		RETURN @Discounted
	END


--Task 2: Active Customers
CREATE FUNCTION fn_GetActiveCustomers()  
RETURNS TABLE
AS
	RETURN
	(
		SELECT *
		FROM Customers C
		INNER JOIN Orders O
		ON C.CustomerId = O.CustomerId 
		AND C.IsActive = 1 
		AND OrderDate >= DATEADD(Day, -31, GETDATE())
	)


---------------------------4. View Tasks
--Task 1: Create Active Orders View
CREATE VIEW vw_ActiveOrders 
AS
	SELECT C.Name, O.OrderId, O.OrderDate
	FROM Customers C
	INNER JOIN Orders O
	ON C.CustomerId = O.CustomerId
	WHERE Status IN ('Pending', 'Processing')

--Task 2: Sales Summary
CREATE VIEW vw_SalesSummary 
AS
	SELECT P.Name, SUM(OD.Quantity), SUM(OD.SubTotal)
	FROM Products P
	INNER JOIN OrderDetails OD
	ON P.ProductId = OD.ProductId
	GROUP BY P.Name


---------------------------------------5. Aggregate Function Tasks
--Task 1: Total Sales
SELECT SUM(O.TotalAmount)
FROM Products P
INNER JOIN OrderDetails OD
ON P.ProductId = OD.ProductId
INNER JOIN Orders O
ON O.OrderId = OD.OrderId
GROUP BY P.Name

--Task 2: Average Order Value
SELECT AVG(Orders.TotalAmount)
FROM Orders
GROUP BY CustomerId

--Bonus: Combined Task








		