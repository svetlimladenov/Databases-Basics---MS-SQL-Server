SELECT * FROM Departments



SELECT * FROM (SELECT ISNULL(CAST((DATEDIFF(DAY,OpenDate,CloseDate)) AS varchar),'no info') AS AvarageDuration FROM Reports
GROUP BY Id,CloseDate,OpenDate)