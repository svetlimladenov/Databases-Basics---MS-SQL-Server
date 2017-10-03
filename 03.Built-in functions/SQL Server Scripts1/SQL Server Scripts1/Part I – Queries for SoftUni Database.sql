Use SoftUni
--Problem 1.	Find Names of All Employees by First Name
SELECT FirstName,LastName FROM Employees
WHERE FirstName LIKE 'sa%'

--Problem 2.	  Find Names of All employees by Last Name 
SELECT FirstName,LastName FROM Employees
	WHERE CHARINDEX('ei',LastName) > 0

--Problem 3.	Find First Names of All Employees
SELECT FirstName FROM Employees
	WHERE (DATEPART(YEAR,HireDate) BETWEEN 1995 AND 2005) AND
	(DepartmentID = 3 OR DepartmentID = 10)

--Problem 4.	Find All Employees Except Engineers
SELECT FirstName,LastName FROM Employees
	WHERE CHARINDEX('engineer',JobTitle) <= 0

--Problem 5.	Find Towns with Name Length
SELECT Name FROM Towns
	WHERE LEN(Name) = 5 OR LEN(Name) = 6
	ORDER BY Name

--Problem 6.	 Find Towns Starting With
SELECT TownId,Name FROM Towns
	WHERE LEFT(Name,1) IN ('M','K','B','E')
	ORDER BY Name

--Problem 7.	 Find Towns Not Starting With
SELECT TownId,Name FROM Towns
	WHERE LEFT(Name,1) NOT IN ('R','B','D')
	ORDER BY Name
GO	

--Problem 8.	Create View Employees Hired After 2000 Year
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName,LastName FROM Employees
	WHERE DATEDIFF(DAY,'12-31-2000',HireDate) > 0 
GO

--Problem 9.	Length of Last Name
SELECT FirstName,LastName FROM Employees
	WHERE LEN(LastName) = 5

SELECT * FROM INFORMATION_SCHEMA.TABLES