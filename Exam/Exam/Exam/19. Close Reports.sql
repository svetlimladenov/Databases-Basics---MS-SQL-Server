CREATE TRIGGER tr_ChangeStautsIdOnUpdate
ON Reports
AFTER UPDATE
AS
BEGIN
	UPDATE Reports
	SET StatusId = 3
	WHERE Id = (SELECT DISTINCT inserted.Id FROM inserted WHERE inserted.CloseDate IS NOT NULL)
END

SELECT * FROM Reports

UPDATE Reports
SET CloseDate = GETDATE()
WHERE EmployeeId = 25;




