BULK INSERT DemoTry
FROM 'D:\SoftUni\Databases-Basics---MS-SQL-Server\08.Triggers and Transactions\Triggers and Transactions Demo\Employees.txt'
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR = '|',
ROWTERMINATOR = '\n'
)

CREATE TABLE DemoTry(
	Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Salary DECIMAL(15,2) NOT NULL
)