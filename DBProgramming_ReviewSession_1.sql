
						/*********** Database Programming Review Session 1 ***********************/

CREATE DATABASE DatabaseReview_1;

USE DatabaseReview_1;

/******************************************************************************
---------------------- 1) Employee Management---------------------------------------------
Create an Employees table with columns: EmployeeID, Name, Age, Department, and Salary.
Write queries to:
	- Insert 5 sample employee records.
	- Update the salary of an employee with EmployeeID = 3.
	- Delete an employee whose Name = 'John Doe'.
	- Retrieve all employee records.

*/

--1. Create EmployeeManagement Table
CREATE TABLE EmployeeManagement (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(30),
    Age INT,
    Department VARCHAR(30),
    Salary Float
);


--2.Insert 5 sample employee records.
INSERT INTO EmployeeManagement
	(EmployeeID, Name, Age, Department,Salary)
VALUES
	(1, 'Alice Smith', 28, 'HR', 50000),
	(2, 'Bob Johnson', 35, 'Finance', 60000),
	(3, 'Charlie Brown', 30, 'IT', 70000),
	(4, 'David Lee', 25, 'Marketing', 45000),
	(5, 'John Doe', 40, 'Operations', 55000);
SELECT * from EmployeeManagement;


--3.Update the salary of an employee with EmployeeID = 3.
UPDATE EmployeeManagement
	SET Salary = 60000
WHERE EmployeeID = 3;

SELECT  * FROM EmployeeManagement;

--4 Delete an employee whose Name = 'John Doe'.

DELETE FROM EmployeeManagement 
WHERE Name = 'John Doe';

SELECT * FROM EmployeeManagement;
	
--5 Retrieve all employee records.
SELECT * FROM EmployeeManagement;



/******************************************************************************
-------------------------- 2) Student Management System ------------------------------------------------------------

2.Student Management System

Create a Students table with columns: StudentID, Name, Class, DOB, and Grade.
	Insert records for 10 students.
	Update the Grade of a student with StudentID = 5.
	Delete all students who belong to Class = '10th'.
*/

--1. Create a Students table
CREATE TABLE Students(
    StudentID INT PRIMARY KEY, 
    Name VARCHAR(50),
    Class VARCHAR(10),
    DOB DATE, 
    Grade CHAR(2));

-- 2.	Insert records for 10 students.
INSERT INTO Students (StudentID , Name , Class , DOB ,Grade)
values
(1, 'Puja Borse', '10th', '2002-05-12', 'A'),
(2, 'Punnya Joshi', '9th', '2000-07-25', 'B'),
(3, 'Prtibha Tonpe', '8th', '1998-01-15', 'A'),
(4, 'Asmita Girehpunje', '10th', '2003-09-30', 'C'),
(5, 'Amol Patil', '7th', '2011-06-22', 'B'),
(6, 'Prathm Pawar', '9th', '2009-04-18', 'A+'),
(7, 'Kunal Desle', '10th', '2008-11-05', 'B'),
(8, 'Rohan Roy', '7th', '2006-08-12', 'C'),
(9, 'Neha Sharma', '8th', '2004-02-27', 'A'),
(10, 'Vikas Sonawane', '9th', '2009-12-10', 'B+');

SELECT * FROM Students;

--3.Update the Grade of a student with StudentID = 5.
UPDATE Students	SET Grade = 'C'
WHERE StudentID = 5;

SELECT * FROM Students;


--4.Delete all students who belong to Class = '10th'.
DELETE FROM Students 
where Class = '10th';

SELECT * FROM Students;


/****************************************************************************** 
------------------- 3.Product Inventory ----------------------------

Create a Products table with columns: ProductID, ProductName, Price, Stock.
	Insert 7 sample products into the table.
	Increase the price of all products by 10%.
	Delete products where the stock is below 5.
*/

-- 1. Create a Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,  
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),  
    Stock INT);


--2.Insert 7 sample products into the table.
INSERT INTO Products (ProductID, ProductName, Price, Stock) 
VALUES
(1, 'Laptop', 50000.00, 10),
(2, 'Smartphone', 25000.30, 15),
(3, 'Headphones', 2000.60, 5),
(4, 'Smartwatch', 7000.00, 2),
(5, 'Tablet', 30000.06, 8),
(6, 'Wireless Mouse', 1500.24, 3),
(7, 'Gaming Keyboard', 4000.10, 12);

SELECT * FROM Products;


--3.Increase the price of all products by 10%.
UPDATE Products
SET Price = Price + (Price * 0.10);

SELECT * FROM Products;

--4.Delete products where the stock is below 5.
DELETE FROM Products 
WHERE Stock < 5;

SELECT * FROM Products;




/****************************************************************************** 
-------------------- 4) Create a Users table -------------------
Create a Users table with columns: UserID, Username, Email, and Password.
Apply constraints:
	Make UserID the primary key.
	Ensure Email is unique.
	Ensure Password has a minimum length of 8 characters.
Write SQL queries to test these constraints by inserting and updating data.
*/

-- 1.Create a Users table with columns: UserID, Username, Email, and Password.
CREATE TABLE Users (
    UserID INT PRIMARY KEY,   --UserID the primary key.
    Username VARCHAR(50),
    Email VARCHAR(100) UNIQUE, --Email is unique.
    Password VARCHAR(255) ,
    CONSTRAINT chk_Password_Length CHECK (LEN(Password) >= 8)); --Password has a minimum length of 8 characters


-- 2. Insert a valid record.
INSERT INTO Users (UserID, Username, Email, Password)
VALUES (2, 'jonny roy', 'jonny22@gmail.com', 'jonny1234');


INSERT INTO Users (UserID, Username, Email, Password)
VALUES (3, 'David Lee', 'david1@gmail.com', 'david1234');

SELECT * FROM Users;



-- 3 Test UNIQUE constraint on Email.
   -- This insert should fail because the email 'jonny22@gmail.com' is already exists

INSERT INTO Users (UserID, Username, Email, Password)
VALUES(4, 'jane amay', 'jonny22@gmail.com', 'securepass');


-- 4 Test the CHECK constraint on Password length.
-- This insert should fail because 'mark' is less than 8 characters.
INSERT INTO Users (UserID, Username, Email, Password)
VALUES (5, 'mark twain', 'mark11@gmail.com', 'mark');


-- 5. Test Primary key constraint on User ID
   -- This insert should fail because the userId 1 is already exists

INSERT INTO Users (UserID, Username, Email, Password)
VALUES (1, 'goyal stive', 'goyal stive@gmail.com', 'goyalss34');


-- 6 Test updating a record to a password that violates the CHECK constraint.
-- This update should fail because the new password 'short' is under 8 characters.
UPDATE Users
SET Password = 'john1'
WHERE UserID = 1;

SELECT * FROM Users





/******************************************************************************
--------------------- 5) Create a Departments table ---------------------------
Create a Departments table (DepartmentID, DepartmentName) and 
Employees table (EmployeeID, Name, DepartmentID).

Add a foreign key constraint on DepartmentID in Employees referencing Departments.
Insert valid and invalid records to test the constraint.
*/

-- 1.Create a Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50));

-- 2.Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT,
    CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID));

--3.Insert valid records
		--Insert valid records in Departments table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'IT');

		--Insert valid records in Employees table
INSERT INTO Employees (EmployeeID, Name, DepartmentID) VALUES
(1, 'Disha Kamble', 1),
(2, 'Mansi Patil', 2),
(3, 'Rushi Borse', 3);


--4.Insert Invalid records
INSERT INTO Employees (EmployeeID, Name, DepartmentID) VALUES
(4, 'Asmita Wagh', 99);
 
  -- fail due to the foreign key constraint. 
  -- invalid record into Employees with a non-existent DepartmentID

SELECT * FROM Employees;



/******************************************************************************
---------------------- 6) Create a Products  ---------------------------
6)Create a Products table with a column Price.
Add a check constraint to ensure the Price is always greater than 0.
Test the constraint by inserting valid and invalid data.
*/

---1. Create a Products table
CREATE TABLE ProductsData (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    CONSTRAINT chk_Price CHECK (Price > 0));


--2.Insert Valid Records 
--. Test constraint by inserting a valid record
INSERT INTO ProductsData(ProductID, ProductName, Price)
VALUES (1, 'Laptop', 1500.00);

INSERT INTO ProductsData(ProductID, ProductName, Price)
VALUES (2, 'Mouse', 500.00);

select * from ProductsData;

--3.Insert Invalid records 
 --fail because the Price is less than or equal to 0.
INSERT INTO ProductsData(ProductID, ProductName, Price)
VALUES (3, 'Keyboard', -300);


/******************************************************************************
--------------- 7. Create a Books table  ---------------------------
7)Create a Books table with columns: BookID, Title, and Author.
	Add a new column PublicationYear to the table.
	Modify the Author column to have a maximum length of 150 characters.
	Drop the PublicationYear column.
*/


--1.Create a Books table columns: BookID, Title, and Author.
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200),
    Author VARCHAR(100));


--2.Add a new column PublicationYear to the table.
ALTER TABLE Books
ADD PublicationYear INT;

--3.Modify the Author column to have a maximum length of 150 characters.
ALTER TABLE Books
ALTER COLUMN Author VARCHAR(150);

--4.Drop the PublicationYear column.
ALTER TABLE Books
DROP COLUMN PublicationYear;




/******************************************************************************
----------------- 8) Create a Customers table----------------------------------

8)Create a Customers table with columns: CustomerID, Name, and Phone.
	Rename the column Phone to ContactNumber.
	Change the data type of ContactNumber to VARCHAR(15).
*/

-- 1.Create a Customers table with columns: CustomerID, Name, and Phone.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(20));  

-- 2.Rename the column Phone to ContactNumber.
EXEC sp_rename 'Customers.Phone', 'ContactNumber', 'COLUMN';

-- 3.Change the data type of ContactNumber to VARCHAR(15)
ALTER TABLE Customers
ALTER COLUMN ContactNumber VARCHAR(15);




/**************************** 9)Create an Employees table**************************************************
------------------------------------------------------
9) Create an Employees table with columns: EmployeeID, Name, Age, and Salary.
Write queries to:
	Retrieve all employees with a salary greater than 50,000.
	Retrieve all employees whose names start with the letter ‘A’.
	Retrieve employees aged between 25 and 35.
*/

-- 1.Create an Employees table with columns: EmployeeID, Name, Age, and Salary.
CREATE TABLE EmployeeManagement (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(30),
    Age INT,
    Department VARCHAR(30),
    Salary Float
);



INSERT INTO EmployeeManagement
	(EmployeeID, Name, Age, Department,Salary)
VALUES
	(1, 'Alice Smith', 28, 'HR', 50000),
	(2, 'Bob Johnson', 35, 'Finance', 60000),
	(3, 'Charlie Brown', 30, 'IT', 70000),
	(4, 'David Lee', 25, 'Marketing', 45000),
	(5, 'John Doe', 40, 'Operations', 55000);
SELECT * from EmployeeManagement;


-- 2.Retrieve all employees with a salary greater than 50,000.
Select * from EmployeeManagement 
WHERE Salary > 50000;


--.3 Retrieve all employees whose names start with the letter ‘A’.
Select * from EmployeeManagement 
WHERE Name LIKE 'A%';


--4.Retrieve employees aged between 25 and 35.
SELECT * from EmployeeManagement 
WHERE Age BETWEEN 25 AND 35;






/******************************************************************************
-----------------------------10.Create a Sales table-------------------------

10)Create a Sales table with columns: SaleID, ProductID, Quantity, and SaleDate.
Write queries to:
	Group sales by ProductID and calculate total quantity sold for each product.
	Filter out products with total sales less than 50 using the HAVING clause.
*/

--1.Create a Sales table with columns: SaleID, ProductID, Quantity, and SaleDate.
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE);


-- Insert Records for calculation
INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
  (1, 101, 20, '2023-01-10'),
  (2, 101, 40, '2023-01-15'),
  (3, 102, 30, '2023-02-01'),
  (4, 102, 15, '2023-02-05'),
  (5, 103, 50, '2023-03-10'),
  (6, 104, 10, '2023-03-15'),
  (7, 104, 15, '2023-03-18'),
  (8, 104, 5,  '2023-03-20'),
  (9, 105, 25, '2023-04-01'),
  (10, 105, 30, '2023-04-05');



--2.Group sales by ProductID and calculate total quantity sold for each product.
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY ProductID;

--3.Filter out products with total sales less than 50 using the HAVING clause.
SELECT ProductID , SUM(quantity) as TotalQuantity
from Sales
GROUP BY ProductID
HAVING SUM(Quantity) >= 50;




/******************************************************************************
----------------------- 11)Create an Orders table -------------------------------------
11)Create an Orders table with columns: OrderID, CustomerID, OrderAmount, OrderDate.
	Retrieve all orders sorted by OrderAmount in descending order.
	Retrieve the top 5 most recent orders.
*/

--1.Create an Orders table with columns: OrderID, CustomerID, OrderAmount, OrderDate.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderAmount DECIMAL(10,2),
    OrderDate DATE);



--Insert records in order table
INSERT INTO Orders (OrderID, CustomerID, OrderAmount, OrderDate)
VALUES
    (1, 101, 150.50, '2023-07-01'),
    (2, 102, 200.00, '2023-07-03'),
    (3, 103, 120.75, '2023-06-25'),
    (4, 104, 300.00, '2023-07-02'),
    (5, 105, 450.00, '2023-07-05'),
    (6, 106, 99.99,  '2023-06-30'),
    (7, 107, 500.00, '2023-07-04'),
    (8, 108, 75.00,  '2023-06-28'),
    (9, 109, 350.00, '2023-07-06'),
    (10, 110, 250.00, '2023-07-07');


--2.Retrieve all orders sorted by OrderAmount in descending order.
SELECT * FROM Orders 
order BY OrderAmount DESC;

--3.Retrieve the top 5 most recent orders.
SELECT TOP 5 *
From Orders
ORDER By OrderDate;




/******************************************************************************
--------------------- Create two tables: Customers and Orders ---------------------------------
12)Create two tables: Customers (CustomerID, Name) 
	Orders (OrderID, CustomerID, OrderDate, Amount).
Write an inner join query to retrieve all orders along with the customer names.
*/

INSERT INTO Customers (CustomerID, Name , ContactNumber)
VALUES 
    (103, 'Roy Smith',9876532788),
    (106, 'John son',7896543287),
    (109, 'Charlie Brown',8976543459);

Select * from Customers;

Select * from Orders;

--1) Write an inner join query to retrieve all orders along with the customer names.

SELECT 
    o.OrderID,
    o.OrderDate,
    o.OrderAmount,
    c.Name AS CustomerName
FROM Orders o

INNER JOIN Customers c
    ON o.CustomerID = c.CustomerID;







/****************************************************************************************
-------------------- Create two tables: Products and OrderDetails -------------------------------
13) Create two tables: Products (ProductID, ProductName) and
						OrderDetails (OrderDetailID, ProductID, Quantity).
Write a left join query to retrieve all products, including those that have no orders.
*/


-- Create two tables: Products (ProductID, ProductName) 
CREATE TABLE Products2 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100));

 -- insert records
INSERT INTO Products2(ProductID, ProductName)
VALUES 
    (1, 'Laptop'),
    (2, 'Smartphone'),
    (3, 'Tablet'),
    (4, 'Monitor');


-- OrderDetails (OrderDetailID, ProductID, Quantity).
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    --FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--Insert records in order table
INSERT INTO OrderDetails (OrderDetailID, ProductID, Quantity)
VALUES 
    (101, 1, 5),
    (102, 2, 10),
    (103, 1, 3),
    (104, 3, 7);

select * from Products2
select * from OrderDetails


-- Write a left join query to retrieve all products, including those that have no orders.
Select 
p.ProductID,
p.ProductName,
od.OrderDetailID,
od.Quantity

from Products2 p
LEFT JOIN 
	OrderDetails od
	ON p.ProductID = od.ProductID





/******************************************************************************
------------------------14) Create two tables: Employees and Projects--------------------

14) Create two tables: Employees (EmployeeID, Name) and 
					Projects (ProjectID, EmployeeID, ProjectName).
Write a right join query to retrieve all projects and their assigned employees.
*/

--create table Employees (EmployeeID, Name)   

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100));

	select * from Employees;  

	-- I have taken above create Employee table here 

-- create table Projects (ProjectID, EmployeeID, ProjectName).
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    EmployeeID INT, 
    ProjectName VARCHAR(150)
);

INSERT INTO Projects (ProjectID, EmployeeID, ProjectName)
VALUES 
    (101, 1, 'Project Alpha'),
    (102, 2, 'Project Beta'),
    (103, 4, 'Project Gamma'),
    (104, NULL, 'Project Delta');


--Write a right join query to retrieve all projects and their assigned employees.
SELECT
	p.ProjectID, 
	p.ProjectName,
	P.EmployeeID,
	e.Name as EmployeeName

From  Employees e
RIGHT JOIN Projects p
ON e.EmployeeID = p.EmployeeID;


