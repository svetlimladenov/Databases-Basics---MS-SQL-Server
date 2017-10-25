USE SoftUni
GO

--Problem 8.	Employees with Three Projects
CREATE PROCEDURE usp_AssignProject(@emloyeeId INT, @projectID INT)
AS
BEGIN

DECLARE @employeeProjectsCount int;

BEGIN TRANSACTION
	INSERT INTO EmployeesProjects(EmployeeID,ProjectID) VALUES
	(@emloyeeId,@projectID)

	SET @employeeProjectsCount = (
	SELECT COUNT(*) FROM EmployeesProjects
	WHERE EmployeeID = @emloyeeId
	)

	IF(@employeeProjectsCount > 3)
	BEGIN
		RAISERROR('The employee has too many projects!',16,1)
		ROLLBACK
		RETURN;
	END

COMMIT

END



GO
SELECT * FROM EmployeesProjects
WHERE EmployeeID = 2

EXEC usp_AssignProject 2,3

--Problem 9.	Delete Employees
SELECT * FROM Employees

CREATE TABLE Deleted_Employees(
EmployeeId INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
MiddleName VARCHAR(50),
JobTitle VARCHAR(50),
DepartmentId INT,
Salary MONEY
)
GO


CREATE TRIGGER tr_Deleted_Employees 
ON Employees
INSTEAD OF DELETE
AS
BEGIN
	INSERT INTO Deleted_Employees(EmployeeId,FirstName,LastName,MiddleName,JobTitle,DepartmentId,
	Salary)
	SELECT d.EmployeeID,
	       d.FirstName,
		   d.LastName,
		   d.MiddleName,
		   d.JobTitle,
		   d.DepartmentID,
		   d.Salary
      FROM deleted as d
END

SELECT * FROM Deleted_Employees

SELECT * FROM Employees

DELETE FROM Employees
WHERE EmployeeID = 293
