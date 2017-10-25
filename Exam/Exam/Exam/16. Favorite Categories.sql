SELECT d.Name,c.Name FROM Departments AS d
JOIN Categories AS c ON c.DepartmentId = d.Id
WHERE 