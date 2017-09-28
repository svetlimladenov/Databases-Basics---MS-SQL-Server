--SELECT EmployeeID AS [Employee Id],FirstName,LastName,Salary FROM Employees
--WHERE Salary > 20000 
--ORDER BY Salary DESC

CREATE VIEW v_EmployeesNamesAndDepartments AS
SELECT d.DepartmentID ,
	   d.Name AS [Department Name],
	   e.FirstName + ' ' + e.LastName AS [Manager Name]
FROM Departments AS d
JOIN Employees AS e ON  d.ManagerID = e.EmployeeID

GO
SELECT e.FirstName + ' ' + e.LastName AS[Full Name] , 
	   e.JobTitle AS [Job Title],
	   e.Salary
  FROM Employees As e


SELECT * FROM Employees 
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE Name = 'Marketing')


SELECT * FROM Employees
WHERE NOT (ManagerID = 3 OR ManagerID = 4 )

SELECT * FROM Employees
WHERE ManagerID NOT IN(3,4)

SELECT * FROM Employees
WHERE MiddleName IS NULL


SELECT * FROM v_EmployeesNamesAndDepartments
GO

CREATE VIEW v_HighestPeak AS
SELECT TOP 1 * FROM Peaks 
ORDER BY Elevation DESC 
GO

SELECT * FROM v_HighestPeak

SELECT * FROM Employees

INSERT INTO Employees(FirstName,MiddleName,LastName,DepartmentID,HireDate,Salary,JobTitle) VALUES
('Svetlin', 'E', 'Mladenov',1,GETDATE(),12456,'CEO')

SELECT * FROM Employees WHERE FirstName = 'Svetlin'

SELECT *
INTO EmployeesNamesAndDepartments
FROM v_EmployeesNamesAndDepartments

SELECT * FROM Departments

UPDATE Employees
SET Salary *= 1.12
WHERE DepartmentID IN 
	(SELECT DepartmentID 
	FROM Departments 
	WHERE Name IN ('Engineering', 'Tool Design', 'Marketing' ,'Information Services'))

						
SELECT [Salary] FROM [Employees] 
	WHERE DepartmentID IN
	(SELECT DepartmentID FROM Departments
	WHERE Name IN ('Engineering', 'Tool Design', 'Marketing' ,'Information Services'))



