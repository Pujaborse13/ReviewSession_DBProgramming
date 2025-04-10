

--------------------- Review Session -------------------------------

CREATE DATABASE ReviewSession

USE ReviewSession;

CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    CreatedDate DATETIME)

INSERT INtO Customers (CustomerID, Name, CreatedDate) VALUES
(1, 'Aaliya', '2025-01-01'),
(2, 'Disha', '2025-02-15'),
(3, 'Asmita', '2025-03-10'),
(4, 'Puja', '2025-03-20');

SELECT * FROM Customers
-------------------------------------------------
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
)

INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1000.00),
(2, 'Smartphone', 700.00),
(3, 'Headphone', 150.00),
(4, 'Keyboard', 50.00),
(5, 'Mouse', 30.00),
(6, 'Webcam', 120.00),
(7, 'Charger', 25.00)

SELECT * FROM Products

--------------------------------------------------------
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2025-03-01'),  
(102, 2, '2025-03-15'),  
(103, 1, '2025-03-18'), 
(104, 3, '2025-04-01')

SELECT * FROM Orders
-------------------------------------------------

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
)

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1001, 101, 1, 1),
(1002, 101, 2, 1),  
(1003, 102, 3, 2), 
(1004, 103, 4, 1), 
(1005, 104, 5, 3)

SELECT * FROM OrderDetails

-------------------------------------------------
--1)Get each customer’s name and the number of orders they’ve placed
SELECT * FROM Customers
SELECT * FROM Orders

SELECT c.Name,  COUNT(o.OrderID) AS OrderCount
FROM Customers c
	LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
	GROUP BY c.Name;

-------------------------------------------------


--2)List the top 5 most expensive products by price

SELECT * FROM Products

SELECT TOP 5 ProductName , price
fROM Products
	ORDER by Price DESC

-------------------------------------------------
--3)Find products that have never been included in any order.
SELECT * FROM Products
SELECT * FROM OrderDetails


SELECT ProductID ,ProductName
FROM Products
	where ProductID NOT IN(SELECT DISTINCT ProductID FROM OrderDetails)


-------------------------------------------------

--4)Get the latest customer who registered (use CustomerID or CreatedDate)
SELECT * FROM Customers


SELECT TOP 1 * FROM Customers 
	ORDER BY CreatedDate DESC


-------------------------------------------------
--5)Fetch the second most recent order placed in the Orders table
SELECT * FROM Orders
WHERE OrderDate = (SELECT MAX(OrderDate)
    FROM Orders
		WHERe OrderDate < (SELECT MAX(OrderDate) FROM Orders))
-------------------------------------------------


--6)Return all rows except the last 10 from the Products table based on ProductID
SELECT * FROM Products


INSERT INTO Products (ProductID, ProductName, Price) VALUES
(8, 'Monitor', 9000),
(9, 'CPU', 15000),
(10, 'Pen Drive', 600),
(11, 'External HDD', 3500),
(12, 'SSD', 3000),
(13, 'Speaker', 800),
(14, 'Tablet', 12000),
(15, 'Cable', 200),
(16, 'TV', 45000);

SELECT * FROM Products
where ProductID  NOT IN(SELECT TOP 10 ProductID FROM Products 
								ORDER BY ProductID dESC )







							--INNER JION CUSTOMER AND ORDERS

SELECT c.CutomerName , c.CustomerID  as CutomerData
FROM Cuctomer c
INNER JOIN Order o 
on c.customerId = o.CustomerID

