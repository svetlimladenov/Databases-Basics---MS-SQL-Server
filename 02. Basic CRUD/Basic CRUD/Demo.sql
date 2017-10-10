--CREATE SEQUENCE seq_Customers_CustomerID 
--	AS INT
--	START WITH 5
--	INCREMENT BY 10

--SELECT NEXT VALUE FOR seq_Customers_CustomerID 


SELECT * FROM EmployeesNamesAndDepartments

DELETE FROM EmployeesNamesAndDepartments

SELECT * FROM Employees

UPDATE Employees
SET MiddleName = 'Ivanov'
WHERE EmployeeID =  3

SELECT * FROM Projects

UPDATE Projects
SET EndDate = GETDATE()
WHERE EndDate IS NULL