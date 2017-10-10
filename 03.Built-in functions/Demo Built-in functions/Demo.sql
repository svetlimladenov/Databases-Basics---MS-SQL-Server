SELECT CONCAT(FirstName,' ',LastName) AS [Full Name],
	   LEFT(PaymentNumber,6) + REPLICATE('*',LEN(PaymentNumber) - 6) FROM Customers
GO

SELECT UPPER(REVERSE(FirstName)) AS [Reversed Name] FROM Customers
