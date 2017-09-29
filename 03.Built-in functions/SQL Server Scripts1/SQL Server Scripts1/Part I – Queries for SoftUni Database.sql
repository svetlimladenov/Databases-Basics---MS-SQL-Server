Use SoftUni

SELECT FirstName,LastName FROM Employees
	WHERE CHARINDEX('ei',LastName) > 0

SELECT FirstName FROM Employees
	WHERE (DATEPART(YEAR,HireDate) BETWEEN 1995 AND 2005) AND
	(DepartmentID = 3 OR DepartmentID = 10)


SELECT FirstName,LastName FROM Employees
	WHERE CHARINDEX('engineer',JobTitle) <= 0

SELECT Name FROM Towns
	WHERE LEN(Name) = 5 OR LEN(Name) = 6
	ORDER BY Name

SELECT TownId,Name FROM Towns
	WHERE LEFT(Name,1) IN ('M','K','B','E')
	ORDER BY Name


SELECT TownId,Name FROM Towns
	WHERE LEFT(Name,1) NOT IN ('R','B','D')
	ORDER BY Name
GO	
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName,LastName FROM Employees
	WHERE DATEDIFF(DAY,'12-31-2000',HireDate) > 0 
GO

SELECT FirstName,LastName FROM Employees
	WHERE LEN(LastName) = 5
SELECT * FROM INFORMATION_SCHEMA.TABLES