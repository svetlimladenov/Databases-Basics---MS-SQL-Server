--5.	Users by Age
SELECT Username,Age FROM Users
ORDER BY Age,Username DESC
--6.	Unassigned Reports

SELECT Description,OpenDate FROM Reports
WHERE EmployeeId IS NULL
ORDER BY OpenDate,Description

--7.	Employees & Reports
SELECT e.FirstName,
       e.LastName,
	   r.Description,
	   FORMAT(r.OpenDate, 'yyyy-MM-dd')
  FROM Employees AS e
JOIN Reports AS r ON r.EmployeeId = e.Id
ORDER BY EmployeeId,r.OpenDate,r.Id

--8.	Most reported Category

SELECT c.Name,
	   COUNT(r.CategoryId) AS ReportsNumber
  FROM Categories AS c
JOIN Reports AS r ON r.CategoryId = c.Id
GROUP BY r.CategoryId,c.Name
ORDER BY ReportsNumber DESC,c.Name

--9.	Employees in Category

SELECT c.Name,COUNT(e.Id) AS [Employees Number] FROM Categories AS c
JOIN Departments AS d ON d.Id = c.DepartmentId
JOIN Employees AS e ON e.DepartmentId = d.Id
GROUP BY c.Name
ORDER BY c.Name
--10.	Users per Employee 

SELECT FirstName + ' ' + LastName as Name,COUNT(DISTINCT r.UserId) AS [Users Number] FROM Employees AS e
LEFT JOIN Reports AS r ON r.EmployeeId = e.Id
GROUP BY FirstName,LastName
ORDER BY [Users Number] DESC,Name ASC
--11.	Emergency aPatrol

SELECT OpenDate,Description,u.Email AS [Description] FROM Reports AS r
JOIN Categories AS c ON c.Id = r.CategoryId
JOIN Departments AS d ON d.Id = c.DepartmentId
JOIN Users AS u ON u.Id = r.UserId
WHERE CloseDate IS NULL AND
	  LEN(Description) > 20 AND
	  CHARINDEX('str',Description) > 0 AND
	  d.Name IN ('Infrastructure','Emergency','Roads Maintenance')
ORDER BY OpenDate,u.Email,r.Id 

--12.	Birthday Report
SELECT DISTINCT c.Name FROM Categories AS c
JOIN Reports AS r ON r.CategoryId = c.Id
JOIN Users AS u ON u.Id = r.UserId
WHERE DATEPART(DAY,r.OpenDate) = DATEPART(DAY,u.BirthDate) AND
      DATEPART(MONTH,r.OpenDate) = DATEPART(MONTH,u.BirthDate) 
ORDER BY c.Name


--13.	Numbers Coincidence
SELECT Username FROM Users AS u
JOIN Reports AS r ON r.UserId = u.Id
JOIN Categories AS c ON c.Id = r.CategoryId
WHERE (SUBSTRING(Username,LEN(Username),1) IN ('1','2','3','4','5','6','7','8','9','0') AND SUBSTRING(Username,LEN(Username),1) = CAST(c.Id AS nvarchar))
OR (SUBSTRING(Username,1,1) IN ('1','2','3','4','5','6','7','8','9','0') AND SUBSTRING(Username,1,1) = CAST(c.Id as nvarchar))
ORDER BY Username

--14.	Open/Closed Statistics

SELECT COUNT(OpenDate),COUNT(CloseDate) FROM Employees AS e
JOIN Reports AS r ON r.EmployeeId = e.Id


--15.	Average Closing Time

SELECT DISTINCT d.Name, AVG(DATEDIFF(DAY,r.OpenDate,r.CloseDate)) FROM Reports AS r
JOIN Categories AS c ON c.Id = r.Id
JOIN Departments AS d ON d.Id = c.DepartmentId
GROUP BY d.Name
ORDER BY d.Name

SELECT DATEDIFF(DAY,r.OpenDate,r.CloseDate),r.OpenDate,r.CloseDate FROM Reports as r
WHERE CategoryId = 1

SELECT * FROM Reports