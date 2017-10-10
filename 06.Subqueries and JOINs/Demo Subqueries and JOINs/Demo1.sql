USE SoftUni

SELECT TOP 50 
	       e.FirstName,
	       e.LastName,
		   t.Name AS TownName,
	       ad.AddressText   
	  FROM Employees AS e
INNER JOIN Addresses AS ad ON ad.AddressID = e.AddressID
INNER JOIN Towns AS t ON t.TownID = ad.TownID
  ORDER BY e.FirstName,e.LastName
GO

SELECT E.EmployeeID,
	   e.FirstName,
	   e.LastName,
	   d.Name AS DepartmentName
  FROM Employees AS e
  JOIN Departments AS d 
    ON d.DepartmentID = e.DepartmentID
 WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID
  
GO

SELECT e.FirstName,
       e.LastName,
	   e.HireDate,
	   d.Name AS DeptName
  FROM Employees AS e
  JOIN Departments AS d 
    ON d.DepartmentID = e.DepartmentID
 WHERE e.HireDate > '01/01/1999' 
   AND d.Name IN ('Sales','Finance')
 ORDER BY HireDate

GO

SELECT TOP 50
           e.EmployeeID,
	       e.FirstName + ' ' + e.LastName AS EmployeeName,
	       e2.FirstName + ' ' + e2.LastName AS MaganerName,
		   d.Name AS DepartmentName
      FROM Employees AS e
 LEFT JOIN Employees AS e2 
        ON e2.EmployeeID = e.ManagerID
 LEFT JOIN Departments AS d 
        ON d.DepartmentID = e.DepartmentID	
  ORDER BY e.EmployeeID

GO

SELECT e.FirstName,
       e.DepartmentID
  FROM Employees AS e 
WHERE e.DepartmentID IN 
(SELECT d.DepartmentID 
  FROM Departments AS d
 WHERE d.Name = 'Finance' OR d.Name = 'Sales')