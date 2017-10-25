GO

CREATE PROC usp_AssignEmployeeToReport (@employeeId INT , @reportId INT)
AS
BEGIN
BEGIN TRANSACTION
	UPDATE Reports
	SET EmployeeId = @employeeId
	WHERE @reportId = @reportId
	
	DECLARE @DeparmentEmployee INT = (SELECT DepartmentId FROM Employees WHERE Id = @employeeId)
	DECLARE @DepartmentReport INT = (SELECT DepartmentId FROM Reports AS r JOIN Categories AS c ON c.Id = r.CategoryId WHERE r.Id = @reportId)
	IF(@DeparmentEmployee <> @DepartmentReport)
	BEGIN
		RAISERROR('Employee doesn''t belong to the appropriate department!',17,1)
		ROLLBACK
		RETURN
	END
COMMIT

END


SELECT * FROM Employees WHERE Id = 2

EXEC usp_AssignEmployeeToReport 17, 2;
SELECT EmployeeId FROM Reports WHERE id = 2

