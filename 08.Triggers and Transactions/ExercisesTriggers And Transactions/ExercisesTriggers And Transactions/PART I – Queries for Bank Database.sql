--Problem 1.	Create Table Logs
UPDATE Accounts
SET Balance += 30
WHERE Id = 1

CREATE TABLE Logs(
LogId INT IDENTITY PRIMARY KEY,
AccountId INT NOT NULL,
OldSum DECIMAL(15,2) NOT NULL,
NewSum DECIMAL(15,2) NOT NULL
)
GO

CREATE TRIGGER tr_AccountBalanceChange 
ON Accounts
AFTER UPDATE
AS
BEGIN
	DECLARE @accId INT = (SELECT Id FROM inserted)
	DECLARE @OldSum MONEY = (SELECT Balance FROM deleted)
	DECLARE @NewSum MONEY = (SELECT Balance FROM inserted)

	if(@OldSum <> @NewSum)
		INSERT INTO Logs VALUES (@accId,@OldSum,@NewSum)

END

SELECT * FROM Logs

--Problem 2.	Create Table Emails
CREATE TABLE NotificationEmails(
Id INT IDENTITY PRIMARY KEY,
Recipient INT NOT NULL,
Subject NVARCHAR(MAX) NOT NULL,
Body NVARCHAR(MAX) NOT NULL
)

GO
--droped
CREATE TRIGGER tr_InsertNotificationEmails
ON Logs
AFTER INSERT
AS
BEGIN
	DECLARE @Recipient INT = (SELECT AccountId FROM inserted );
	DECLARE @OldBalance NVARCHAR(MAX) = CAST((SELECT OldSum FROM inserted) AS nvarchar);
	DECLARE @NewBalance NVARCHAR(MAX) = CAST((SELECT NewSum FROM inserted) AS nvarchar)	;
	DECLARE @Subject NVARCHAR(MAX) = 'Balance change for account: ' + CAST(@Recipient AS nvarchar)
	DECLARE @Body NVARCHAR(MAX) = 'On ' +
			CAST(LEFT(DATENAME(MONTH,GETDATE()),3) AS nvarchar) + ' ' +
			CAST(DATEPART(DAY,GETDATE()) AS nvarchar)+ ' ' +
			CAST(DATEPART(YEAR,GETDATE()) AS nvarchar )+ ' ' +
		    RIGHT(CONVERT(VarChar(19), GETDATE(), 0), 7) + ' ' +
			'your balance was changed from ' +
			@OldBalance + ' to ' + @NewBalance + '.'
	INSERT INTO NotificationEmails(Recipient,Subject,Body) VALUES
	(@Recipient,@Subject,@Body)			
END

SELECT * FROM NotificationEmails
UPDATE Accounts
SET Balance += 30
WHERE Id = 1

--Problem 3.	Deposit Money
GO
--droped
CREATE OR ALTER PROC usp_DepositMoney (@AccountId INT, @MoneyAmount DECIMAL(15,4)) 
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE Id = @AccountId

	IF(@MoneyAmount < 0)
	BEGIN
		RAISERROR('Cant depostio zero or negatime number',16,1)
		ROLLBACK
		RETURN
	END

	COMMIT
END

SELECT * FROM Accounts
SELECT * FROM NotificationEmails
SELECT * FROM Logs
EXEC usp_DepositMoney 1,33.33



GO
--Problem 4.	Withdraw Money
--DROPED
CREATE OR ALTER PROC usp_WithdrawMoney (@AccountId INT, @MoneyAmount DECIMAL(15,4)) 
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance -= @MoneyAmount
	WHERE Id = @AccountId

	IF(@MoneyAmount < 0)
	BEGIN
		RAISERROR('Cant withdraw zero or negatime number',16,1)
		ROLLBACK
		RETURN
	END

	COMMIT
END
