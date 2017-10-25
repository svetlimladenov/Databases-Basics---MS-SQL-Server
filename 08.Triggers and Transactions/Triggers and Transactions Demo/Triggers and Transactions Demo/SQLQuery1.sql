CREATE OR ALTER TRIGGER tr_ProcessTransaction
ON Accounts
AFTER UPDATE
AS
BEGIN
	INSERT INTO Transactions(AccountId,OldBalance,NewBalance,DateTime)
	SELECT deleted.ID,
		   deleted.Amount,
		   inserted.Amount,
		   GETDATE()
	  FROM inserted
	JOIN deleted ON 
	deleted.ID = inserted.ID
END

UPDATE Accounts
SET Amount += 50
WHERE ID = 1

SELECT * FROM Accounts

SELECT * FROM Transactions

--Demo 2

CREATE TABLE Accounts2(
Username VARCHAR(30) NOT NULL PRIMARY KEY,
Password VARCHAR(20) NOT NULL,
Active VARCHAR(1) NOT NULL DEFAULT 'Y'
)

INSERT INTO Accounts2(Username,Password) VALUES
('Svetalin','Mladeanov'),
('Kaalina','Mladenaov')

GO
CREATE TABLE DeletedAcc(
Username VARCHAR(30),
Password VARCHAR(30)
)

CREATE OR ALTER TRIGGER tr_DeleteAccounts
ON Accounts2
INSTEAD OF DELETE
AS
BEGIN
UPDATE Accounts2 
SET Active = 'N'
SELECT * FROM Accounts2 AS a2
JOIN deleted AS d = d.Active

END

DELETE FROM Accounts2
