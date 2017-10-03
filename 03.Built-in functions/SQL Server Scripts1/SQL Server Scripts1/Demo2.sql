USE SoftUni

SELECT * FROM Employees

SELECT EmployeeId,
	   FirstName + ' ' + LastName AS [Full Name],
	   DATEDIFF(YEAR,HireDate,GETDATE()) AS [Mounths Of Work]    
	   FROM Employees 
	   ORDER BY [Mounths Of Work] DESC


SELECT DATENAME(WEEKDAY,'11-30-2017')


SELECT FORMAT(DATEADD(MONTH,1,'11-30-2017'),'dd-MMM-yyyy')


