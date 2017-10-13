--Problem 1.	Employee Address
SELECT TOP 5
       e.EmployeeID,
       e.JobTitle,
	   e.AddressID,
	   a.AddressText 
  FROM Employees AS e
  JOIN Addresses AS a ON a.AddressID = e.AddressID
ORDER BY e.AddressID ASC
GO
--Problem 2.	Addresses with Towns
SELECT TOP 50 
	   e.FirstName,
	   e.LastName,
	   t.Name AS TownName,
	   ad.AddressText   
	FROM Employees AS e
	JOIN Addresses AS ad ON ad.AddressID = e.AddressID
	JOIN Towns AS t ON t.TownID = ad.TownID
	ORDER BY e.FirstName,e.LastName
GO
--Problem 3.	Sales Employee

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
--Problem 4.	Employee Departments

SELECT TOP 5
	   e.EmployeeID,
       e.FirstName,
	   e.Salary,
	   d.Name AS DepartmentName
  FROM Employees AS e
  JOIN Departments AS d 
    ON d.DepartmentID = e.DepartmentID
 WHERE e.Salary > 15000
ORDER BY e.DepartmentID

GO
--Problem 5.	Employees Without Project

SELECT TOP 3 
           e.EmployeeID,
           e.FirstName 
      FROM Employees AS e
 LEFT JOIN EmployeesProjects AS ep 
        ON ep.EmployeeID = e.EmployeeID
     WHERE ep.EmployeeID IS NULL
  ORDER BY e.EmployeeID

--Problem 6.	Employees Hired After

SELECT e.FirstName,
       e.LastName,
	   e.HireDate,
	   d.Name AS DeptName
  FROM Employees AS e
  JOIN Departments As d 
    ON d.DepartmentID = e.DepartmentID
 WHERE e.HireDate > '1/1/1999' AND d.Name IN ('Sales','Finance')
ORDER BY e.HireDate

GO
--Problem 7.	Employees with Project

SELECT TOP 5
       e.EmployeeID,
       e.FirstName,
	   p.Name AS ProjectName
  FROM Employees AS e
  JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
  JOIN Projects AS p ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > '08/13/2002' AND p.EndDate IS NULL
ORDER BY EmployeeID ASC

GO
--Problem 8.	Employee 24

SELECT e.EmployeeID,
       e.FirstName,
	   CASE
	      WHEN p.StartDate < '2005' 
		  THEN p.Name
		  ELSE NULL
		END AS ProjectName
  FROM Employees AS e
  JOIN EmployeesProjects AS ep
    ON ep.EmployeeID = e.EmployeeID AND e.EmployeeID = 24
  JOIN Projects AS p 
    ON p.ProjectID = ep.ProjectID

GO
--Problem 9.	Employee Manager

SELECT e.EmployeeID,
       e.FirstName,
	   e.ManagerID,
	   m.FirstName AS ManagerName
  FROM Employees AS e
  JOIN Employees AS m 
    ON m.EmployeeID = e.ManagerID
 WHERE e.ManagerID IN (3 , 7)
ORDER BY e.EmployeeID

GO
--Problem 10.	Employee Summary
SELECT TOP 50
           e.EmployeeID,
	       e.FirstName + ' ' + e.LastName AS EmployeeName,
	       e2.FirstName + ' ' + e2.LastName AS MaganerName,
		   d.Name AS DepartmentName
      FROM Employees AS e
INNER JOIN Employees AS e2 
        ON e2.EmployeeID = e.ManagerID
INNER JOIN Departments AS d 
       ON d.DepartmentID = e.DepartmentID	
 ORDER BY e.EmployeeID

GO
--Problem 11.	Min Average Salary

SELECT MIN(AvgSalary) AS MinAverageSalary FROM
(SELECT DepartmentID,AVG(Salary) AS AvgSalary FROM Employees
GROUP BY DepartmentID) AS MinAvarageSalary

GO
--Problem 12.	Highest Peaks in Bulgaria

SELECT mc.CountryCode,
	   m.MountainRange,   
	   p.PeakName,
       p.Elevation
  FROM Peaks AS p
  JOIN Mountains AS m ON m.Id = p.MountainId
  JOIN MountainsCountries AS mc ON mc.MountainId = p.MountainId
  WHERE mc.CountryCode = 
  (SELECT CountryCode FROM Countries WHERE CountryName = 'Bulgaria')
   AND p.Elevation > 2835
ORDER BY p.Elevation DESC

GO
--Problem 13.	Count Mountain Ranges

SELECT mc.CountryCode,
	   COUNT(*) AS MountainRanges
  FROM Mountains AS m
  JOIN MountainsCountries AS mc ON mc.MountainId = m.Id
  WHERE mc.CountryCode IN ('US','RU','BG')
GROUP BY mc.CountryCode
 
 GO
--Problem 14.	Countries with Rivers
SELECT TOP 5 
       c.CountryName,
       r.RiverName 
  FROM Countries AS c 
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
JOIN Continents AS cont ON cont.ContinentCode = c.ContinentCode
WHERE cont.ContinentName = 'Africa'
ORDER BY c.CountryName


--Problem 15.	*Continents and Currencies

WITH CCYContUsage_CTE (CurrencyCode,ContinentCode,CurrencyUsage) AS (
SELECT CurrencyCode,ContinentCode,COUNT(*) AS CurrencyUsage 
FROM Countries
GROUP BY ContinentCode,CurrencyCode
HAVING COUNT(CountryCode) > 1  
)

SELECT ContMax.ContinentCode,ccy.CurrencyCode,ContMax.CurrencyUsage FROM
(SELECT ContinentCode, MAX(CurrencyUsage) AS CurrencyUsage
   FROM CCYContUsage_CTE 
   GROUP BY ContinentCode) AS ContMax
   JOIN CCYContUsage_CTE AS ccy
   ON (ContMax.ContinentCode = ccy.ContinentCode AND ContMax.CurrencyUsage = ccy.CurrencyUsage)
ORDER BY ContMax.ContinentCode

GO

--Problem 16.	Countries without any Mountains

SELECT COUNT(*) AS CountryCode FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
WHERE MountainId IS NULL

GO

--Problem 17.	Highest Peak and Longest River by Country
SELECT TOP 5
       c.CountryName,
	   MAX(p.Elevation) AS HighestPeakElevation,
	   MAX(r.Length) AS LongestRiverLength
  FROM Countries AS c
  LEFT JOIN MountainsCountries AS mc 
    ON mc.CountryCode = c.CountryCode
  LEFT JOIN Peaks AS p
    ON p.MountainId = mc.MountainId
  LEFT JOIN CountriesRivers AS cr
    ON cr.CountryCode = c.CountryCode
  LEFT JOIN Rivers AS r
    ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC,LongestRiverLength DESC