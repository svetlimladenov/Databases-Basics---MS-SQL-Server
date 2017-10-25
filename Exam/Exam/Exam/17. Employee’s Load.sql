CREATE FUNCTION udf_GetReportsCount(@employeeId INT, @statusId INT) 
RETURNS INT
AS 
BEGIN
	DECLARE @Count INT;
	SET @Count = (SELECT COUNT(*) FROM Reports AS r
				 WHERE r.StatusId = @statusId AND r.EmployeeId = @employeeId)
	RETURN @Count
END

GO

SELECT Id, FirstName, Lastname, dbo.udf_GetReportsCount(Id, 4) AS ReportsCount
FROM Employees
ORDER BY Id


SELECT * FROM Reports
WHERE StatusId = 4
SELECT COUNT(*) FROM Reports AS r
				 JOIN Status AS s ON s.Id = r.StatusId
				 WHERE s.Id = 0 AND r.EmployeeId = 24
SELECT * FROM Reports
WHERE EmployeeId = 24