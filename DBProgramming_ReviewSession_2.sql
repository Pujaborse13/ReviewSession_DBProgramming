
/******************** Review Session:2 Database Programming *******************/

------------*************** Task 1 : stored procedure **********************--------------------------
-- 1) Use a stored procedure PlaceOrder that adds a new order and updates the product stock.

-- i have Use Previous Created table
select * from Products
select * from orders


create procedure PlaceOrder
	@CustomerName varchar(100),
	@CustomerID int,
	@ProductID INT,
	@Quantity int
As 
begin 
	declare @AvailableStock int , @Price decimal(10,2) , @TotalAmount decimal(10,2) , @OrderID int;
	select @AvailableStock = Stock, @Price = Price from Products where ProductID = @ProductID;

	if @AvailableStock < @Quantity
	begin 
		print 'Insufficient stock. order cannot be placed'
		return;
	end

	set @TotalAmount = @Quantity * @Price

	insert into Orders(CustomerName,TotalAmount,CustomerID)
	values(@CustomerName,@TotalAmount,@CustomerID)

	set @OrderID = SCOPE_IDENTITY();

	Update Products
	set Stock = Stock - @Quantity
	where ProductID = @ProductID
	print 'Stock Updated Sucessfully'

End

--Execution
exec PlaceOrder @CustomerName = 'David Smith', @CustomerID = 4, @ProductID = 1, @Quantity = 2;


--------------------------------------------------------------------------------------------
------------*************** Task 2 : stored procedure **********************--------------------------

--2)Write a stored procedure ProcessPayment that:
--Accepts payment details (customer ID, amount, date).
--Checks if the customer exists.
--Updates the customer’s balance after the payment.


CREATE TABLE CustomerDeatils(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) ,
    Balance DECIMAL(10,2)
);

INSERT INTO CustomerDeatils (CustomerID, CustomerName, Balance)
VALUES 
    (1, 'Puja Borse', 5000.00),
    (2, 'John Doe', 3000.00),
    (3, 'Alice Smith', 7000.00),
	(4, 'Pratibha Tonpe', 6000.00);



Create procedure ProcessPayment
@CustomerId INT,
@Amount decimal(10,2),
@PaymentDate date

As
Begin 

	if not exists(select 1 from CustomerDeatils where CustomerID = @CustomerId)
	begin 
		print 'Cutsomer Not Found'
		return;
	end

		update CustomerDeatils
		set Balance = Balance - @Amount
		where CustomerID = @CustomerId
		print 'Balance Updated'
print 'Payment processed successfully.'
end

----Exceution 
EXEC ProcessPayment @CustomerId = 1, @Amount = 1000.00, @PaymentDate = '2025-03-22';

-----------------------------------------------------------------------------------------------
------------*************** Task 3 : Trigger **********************--------------------------

-- 3)Create a trigger on the Employees table 
-- that logs any INSERT, UPDATE, or DELETE operations into an EmployeeAudit table, storing old and new values.
select * from Employee

CREATE TABLE EmployeeAudit (
    Audit_ID INT IDENTITY(1,1) PRIMARY KEY,
    Operation_Type VARCHAR(10),  -- INSERT, UPDATE, DELETE
    Emp_ID INT NOT NULL,
    Field_Name VARCHAR(100), 
    Old_Value VARCHAR(100), 
    New_Value VARCHAR(100), 
    Record_DateTime DATETIME NOT NULL DEFAULT GETDATE()
);


--After Insert
Create trigger trgAfterInsert On Employee
After Insert

as 
begin 

    INSERT INTO EmployeeAudit (Operation_Type, Emp_ID, Field_Name, Old_Value, New_Value, Record_DateTime)
	SELECT 'INSERT', i.Id,'Emp_Name', NULL,i.Name, GETDATE() FROM inserted i;

    PRINT 'Employee details inserted successfully.';
end


INSERT INTO Employee(Id,Name,Salary,dept, DepartmentID)
VALUES (11,'John Doe', 60000, 'HR', 2);

select * from EmployeeAudit

---------------------------------------------
-- after delete trigger

create trigger trg_AfterDelete ON Employee
after delete
AS
Begin
    insert INTO EmployeeAudit (Operation_Type, Emp_ID, Field_Name, Old_Value, Record_DateTime)
    select  'DELETE', i.ID, 'Emp_Name', i.Name, GETDATE() FROM deleted i;

    PRINT 'Employee details deleted successfully.';
END;

--Exceution 
DELETE FROM Employee WHERE ID = 1;
select * from EmployeeAudit

--------------------------------------------
--After Update
create trigger trg_AfterUpdate 
On Employee
after  UPDATE
As
Begin
    If UPDATE(Name)
    Begin
        INsert Into EmployeeAudit (Operation_Type, Emp_ID, Field_Name, Old_Value, New_Value, Record_DateTime)
        Select 'UPDATE', i.Id, 'Emp_Name', d.Name, i.Name, GETDATE()
        From inserted i
        JOIN deleted d On i.Id = d.Id;
    END

    If UPDATE(Salary)
    Begin
        Insert into EmployeeAudit (Operation_Type, Emp_ID, Field_Name, Old_Value, New_Value, Record_DateTime)
        Select 'UPDATE', i.Id, 'Salary', CAST(d.Salary AS Varchar), CAST(i.Salary AS Varchar), GETDATE()
        From inserted i
        JOIN deleted d ON i.Id = d.Id;
    END

    PRINT 'Employee details updated successfully.';
END;



--------------------------------------------------------------------------------
------------*************** Task 4 : Cursor **********************--------------------------
--4)Use a cursor to iterate through the Payments table and update the CustomerBalance column 
-- in the Customers table based on the payments.

--use privious created table CustomerDeatils
select * from CustomerDeatils

--create table Payments

create table Payments (
    PaymentID int primary key identity(1,1),
    CustomerID INT,
    PaymentAmount DECIMAL(10,2),
    PaymentDate DATE,
);

insert into Payments(CustomerID, PaymentAmount, PaymentDate)
VALUES 
    (1, 1000.00, '2024-03-01'),
    (2, 500.00, '2024-03-02'),
    (3, 2000.00, '2024-03-03');

------------------------------------------------------
-- Create Cursor 

Declare @CustID INT;
Declare @Amount DECIMAL(10,2);

Declare payment_cursor CURSOR FOR 
Select CustomerID, PaymentAmount FROM Payments;

Open payment_cursor;
Fetch Next FROM payment_cursor INTO @CustID, @Amount;

While @@FETCH_STATUS = 0
Begin
	PRINT CONCAT('Processing Payment for Customer ID: ', @CustID);
    PRINT CONCAT('Payment Amount: ', @Amount);

    UPDATE CustomerDeatils
    Set Balance = Balance - @Amount
    where CustomerID = @CustID;
   
    Fetch Next FROM payment_cursor INTO @CustID, @Amount;

END;

Close payment_cursor;
Deallocate payment_cursor;

Select * from CustomerDeatils

----------------------------------------------------------------------------------------
------------*************** Task 5 : scalar-valued function **********************--------------------------

-- 5)Write a scalar-valued function CalculateAge that takes a date of birth as 
	-- input and returns the age in years

Create function dbo.udfCalculateAge(
    @DOB DATE
)
returns INT 
As
Begin
    Return DATEDIFF(YEAR, @DOB, GETDATE()) 
           - Case
                 When (MONTH(@DOB) > MONTH(GETDATE())) 
                      OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) 
                 Then 1 
                 Else 0 
             End;
End;

--call function
Select dbo.udfCalculateAge('2000-05-10') AS Age;

--------------------------------------------------------------------------------
------------*************** Task 6 : scalar-valued function **********************--------------------------


-- 6) Write a function IsValidEmail that accepts an email address and returns 1 if it is valid, 0 otherwise.

Create Function dbo.IsValidEmail(@Email NVARCHAR(255))  
Returns BIT  
As
Begin  
    Return
        CASE  
            When @Email LIKE '_%@_%._%' Then 1    
            Else 0  
        End
End;

--Exceution
Select dbo.IsValidEmail('test@example.com') As IsValid; -- it is valid email retun 1
Select dbo.IsValidEmail('invalid-email.com') As IsValid;  -- it is invalid email return 0

