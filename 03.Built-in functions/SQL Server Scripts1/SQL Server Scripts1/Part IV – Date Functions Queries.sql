USE Orders
--Problem 16.	 Orders Table
SELECT ProductName,
	   OrderDate,
	   DATEADD(DAY,3,OrderDate) AS [Pay Due],
	   DATEADD(MONTH,1,OrderDate) AS [Deliver Due]
	FROM Orders

--Problem 17.	 People Table

CREATE TABLE People (
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR NOT NULL,
Birthdate DATETIME NOT NULL
)

SELECT * FROM People


