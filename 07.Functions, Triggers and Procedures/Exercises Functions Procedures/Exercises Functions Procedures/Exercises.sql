USE SoftUni
--Problem 1.	Employees with Salary Above 35000
CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
BEGIN 
	SELECT FirstName,LastName FROM Employees
	WHERE Salary > 35000
END
EXEC usp_GetEmployeesSalaryAbove35000 
GO

--Problem 2.	Employees with Salary Above Number
CREATE PROC usp_GetEmployeesSalaryAboveNumber (@SalaryBorder DECIMAL(18,4))
AS
BEGIN
	SELECT FirstName,LastName FROM Employees
	WHERE Salary >= @SalaryBorder
END

EXEC usp_GetEmployeesSalaryAboveNumber 48100


--Problem 3.	Town Names Starting With
GO
CREATE PROCEDURE usp_GetTownsStartingWith (@STRING NVARCHAR(MAX))
AS
SELECT Name AS Town FROM Towns
WHERE Name LIKE CONCAT(@STRING, '%')
GO

--Problem 4.	Employees from Town

CREATE PROC usp_GetEmployeesFromTown  (@TownName NVARCHAR(MAX))
AS
SELECT FirstName,LastName FROM Employees AS e
JOIN Addresses AS a ON a.AddressID = e.AddressID
JOIN Towns AS t ON t.TownID = a.TownID
WHERE t.Name = @TownName


EXEC usp_GetEmployeesFromTown 'Sofia'

GO
--Problem 5.	Salary Level Function
GO
CREATE FUNCTION ufn_GetSalaryLevel(@Salary MONEY)
RETURNS nvarchar(10)
BEGIN
	DECLARE @SalaryLevel NVARCHAR(10);
	IF(@Salary<30000) SET @SalaryLevel = 'Low' ;
	ELSE IF(@Salary BETWEEN 30000 AND 50000) SET @SalaryLevel = 'Average';
	ELSE SET @SalaryLevel = 'High';

	RETURN @SalaryLevel;
END
GO
SELECT dbo.ufn_GetSalaryLevel(50001) FROM Employees


GO
--Problem 6.	Employees by Salary Level

CREATE PROC usp_EmployeesBySalaryLevel (@SalaryLevel NVARCHAR(200))
AS
SELECT FirstName,LastName FROM Employees
WHERE dbo.ufn_GetSalaryLevel(Salary) =  @SalaryLevel
GO
EXEC usp_EmployeesBySalaryLevel 'Average'

--Problem 7.	Define Function
GO
CREATE FUNCTION ufn_IsWordComprised(@SetOfLetters NVARCHAR(MAX), @Word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @CurrentIndex INT = 1;
	DECLARE @CurrentLetter NVARCHAR;
	WHILE(@CurrentIndex < LEN(@Word))
		BEGIN
			SET @CurrentLetter = SUBSTRING(@Word,@CurrentIndex,1);
			IF(CHARINDEX(@CurrentLetter, @setOfLetters) = 0)
				RETURN 0;
			ELSE 
			SET	@CurrentIndex +=1;
		END
	RETURN 1
END

GO

SELECT dbo.ufn_IsWordComprised('kopele','pele') FROM Employees

