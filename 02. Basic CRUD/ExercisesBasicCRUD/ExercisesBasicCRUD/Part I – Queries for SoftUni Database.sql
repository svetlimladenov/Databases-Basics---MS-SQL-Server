--SELECT FirstName + '.' + LastName + '@softuni.bg' AS [Full Email Address ] FROM Employees

SELECT DISTINCT Salary FROM Employees 
ORDER BY Salary
GO

SELECT * FROM Employees WHERE JobTitle = 'Sales Representative'

SELECT FirstName, LastName, JobTitle FROM Employees WHERE Salary BETWEEN 20000 AND 30000

GO
SELECT FirstName + ' ' +  MiddleName +' ' + LastName AS [Full Name] FROM Employees 
WHERE Salary In (25000, 14000, 12500,23600)

SELECT TOP 5 FirstName , LastName FROM Employees 
ORDER BY Salary DESC

SELECT FirstName, LastName FROM Employees
WHERE DepartmentID != 4

SELECT * FROM Employees ORDER BY Salary DESC,FirstName,LastName DESC,MiddleName
GO

CREATE VIEW V_EmployeesSalaries AS
SELECT FirstName , LastName,Salary FROM Employees
GO

GO
CREATE VIEW V_EmployeeNameJobTitle AS
SELECT FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS [Full Name], JobTitle 
FROM Employees
GO

SELECT ISNULL(MiddleName,'KOPELE') FROM Employees WHERE MiddleName IS NULL

SELECT DISTINCT JobTitle FROM Employees


SELECT TOP 10 * FROM Projects
ORDER BY StartDate , Name


SELECT TOP 7 FirstName,LastName,HireDate FROM Employees
ORDER BY HireDate DESC