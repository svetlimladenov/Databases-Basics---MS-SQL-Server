--PART II – Queries for Bank Database
--Problem 9.	Find Full Name
go
CREATE PROC usp_GetHoldersFullName AS
SELECT FirstName + ' ' + LastName AS [Full Name] FROM AccountHolders
go
EXEC usp_GetHoldersFullName

--Problem 10.	People with Balance Higher Than


--GO
--CREATE OR ALTER PROC usp_GetHoldersWithBalanceHigherThan @Number INT AS
--SELECT FirstName,LastName FROM AccountHolders as ah
--JOIN Accounts AS a ON a.AccountHolderID = ah.Id
--GROUP BY a.AccountHolderId,FirstName,LastName
--HAVING SUM(a.Balance) > @Number
--GO



CREATE PROC usp_GetHoldersWithBalanceHigherThan (@minBalance money)
AS
BEGIN
  WITH CTE_MinBalanceAccountHolders (HolderId) AS (
    SELECT AccountHolderId FROM Accounts
    GROUP BY AccountHolderId
    HAVING SUM(Balance) > @minBalance
  )

  SELECT ah.FirstName AS [First Name], ah.LastName AS [Last Name]
  FROM CTE_MinBalanceAccountHolders AS minBalanceHolders 
  JOIN AccountHolders AS ah ON ah.Id = minBalanceHolders.HolderId
  ORDER BY ah.LastName, ah.FirstName 

END

EXEC usp_GetHoldersWithBalanceHigherThan 6000000

--Problem 11.	Future Value Function
GO
CREATE FUNCTION ufn_CalculateFutureValue (@Sum money,
										  @YearlyInterestRate FLOAT,
										  @NumOfYears INT)
RETURNS money
AS
BEGIN

	RETURN @Sum * (POWER(1 + @YearlyInterestRate,@NumOfYears))

END
GO

SELECT dbo.ufn_CalculateFutureValue(1000,0.10,5)