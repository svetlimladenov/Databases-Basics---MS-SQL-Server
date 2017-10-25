CREATE FUNCTION udf_ProjectDurationWeeks(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS
BEGIN
	IF(@EndDate IS NULL)
	BEGIN
		SET @EndDate = GETDATE();
	END
	DECLARE @ProjectsWeeks INT = DATEDIFF(WEEK,@StartDate,@EndDate);
	--SET @ProjectsWeeks = DATEDIFF(WEEK,@StartDate,@EndDate)

	RETURN @ProjectsWeeks;
END

GO

SELECT Name,
       StartDate,
	   EndDate,
	   dbo.udf_ProjectDurationWeeks(StartDate,EndDate) AS WeeksBetween
  FROM Projects


GO

CREATE OR ALTER FUNCTION udf_GetSalaryLevel(@Salary INT)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @SalaryLevel VARCHAR(50);
	--IF(@Salary < 30000)
	--BEGIN
	--	SET @SalaryLevel = 'Low'
	--END
	--ELSE IF(@Salary BETWEEN 30000 AND 50000)
	--BEGIN 
	--	SET @SalaryLevel = 'Avarage'
	--END
	--ELSE
	--BEGIN
	--	SET @SalaryLevel = 'High'
	--END

	SET @SalaryLevel =
		CASE
		WHEN @Salary < 30000 THEN 'Low'
		WHEN @Salary BETWEEN 30000 AND 50000 THEN 'Avarage'
		ELSE 'High'
		END

	RETURN @SalaryLevel
END

GO

SELECT FirstName,
	   LastName,
	   Salary,
       dbo.udf_GetSalaryLevel(Salary) AS SalaryLevel
  FROM Employees


USE Gringotts

SELECT * FROM WizzardDeposits
GO

CREATE OR ALTER FUNCTION udf_GetAgeGroup(@Age INT)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @AgeGroup VARCHAR(10);
	SET @AgeGroup =
	CASE
		WHEN @Age < 10 THEN 'Childern'
		WHEN @Age BETWEEN 10 AND 18 THEN 'Teen'
		WHEN @Age BETWEEN 19 AND 30 THEN 'Adults'
		ELSE 'Old'
	END

	RETURN @AgeGroup
END
GO

CREATE OR ALTER FUNCTION udf_GetAgeGroupFormula(@Age INT)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @LowerBound INT = LEFT(CAST(@Age - 1 AS VARCHAR),1) * 10 + 1
	--DECLARE @LowerBound INT = ((@Age - 1 )/ 10) * 10 + 1
	DECLARE @UpperBound INT = @LowerBound + 9
	DECLARE @Result VARCHAR(10) = 
	'[' + CAST(@LowerBound AS varchar) + '-' + CAST(@UpperBound AS varchar) + ']'
	RETURN @Result
END

GO

SELECT dbo.udf_GetAgeGroupFormula(Age) AS AgeRange,
	   COUNT(*)
  FROM WizzardDeposits
GROUP BY dbo.udf_GetAgeGroupFormula(Age)


GO


CREATE OR ALTER PROCEDURE usp_GetEmployeesBySeniority @HireYears INT = 5
AS
BEGIN
	SELECT * FROM Employees
	WHERE DATEDIFF(YEAR,HireDate,GETDATE()) > @HireYears
	RETURN 0
END

EXEC dbo.usp_GetEmployeesBySeniority 17

GO

CREATE PROC usp_AddEmployeeToProject (@EmployeeID INT)
AS
BEGIN
	DECLARE @EmployeeProjectsCount =
	 (SELECT COUNT(*) FROM EmployeesProjects WHERE EmployeeID = @EmployeeID)
END



SELECT COUNT(*) FROM EmployeesProjects
WHERE EmployeeID = 5