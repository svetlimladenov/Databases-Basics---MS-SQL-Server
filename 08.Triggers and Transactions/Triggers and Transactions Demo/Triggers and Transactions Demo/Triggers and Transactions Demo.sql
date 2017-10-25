
CREATE OR ALTER PROC usp_TransferFunds @AccountIdSource INT, @AccountIdDestination INT,
	@Amount DECIMAL(15,2)
AS
BEGIN
	BEGIN TRANSACTION
	IF(@Amount <= 0) 
	BEGIN
		RAISERROR('Zero or Negative Amount Specified',16,1);
		RETURN;
	END
	
	UPDATE Accounts
	SET Balance -= @Amount
	WHERE Id = @AccountIdSource
	IF(@@ROWCOUNT <> 1)
	BEGIN
		RAISERROR ('Invalid Source Accound Id',16,1);
		ROLLBACK;
		RETURN;
	END
	UPDATE Accounts
	SET Balance +=@Amount
	WHERE Id = @AccountIdDestination
	IF(@@ROWCOUNT <> 1)
	BEGIN
		RAISERROR ('Invalid Destination Accound Id',16,2);
		ROLLBACK;
		RETURN;
	END

	DECLARE @FinalAmount DECIMAL(15,2);
	SET @FinalAmount = (SELECT Balance FROM Accounts WHERE Id = @AccountIdSource)
	
	IF(@FinalAmount <= 0) 
	BEGIN
		RAISERROR('Insuficient Funds',16,1)
		ROLLBACK;
		RETURN
	END
	
	COMMIT
END

EXEC usp_TransferFunds 1,500,1200

SELECT * FROM Accounts

SELECT * FROM Transactions

