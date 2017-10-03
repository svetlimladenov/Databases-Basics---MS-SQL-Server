SELECT DepartmentID,
       SUM(Salary) AS [Total Salary] 
FROM Employees
GROUP BY DepartmentID
ORDER BY [Total Salary] DESC

SELECT DepartmentID,
       MIN(Salary) AS [Min Salary]
	FROM Employees
GROUP BY DepartmentID
ORDER BY [Min Salary]

SELECT DepartmentId,
	   ROUND(AVG(Salary),0) AS[Avarage Salary]
	FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 20000	