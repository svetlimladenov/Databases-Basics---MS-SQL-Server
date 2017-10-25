--5.	Clients by Name
SELECT FirstName,
	   LastName,
	   Phone 
  FROM Clients
ORDER BY LastName,ClientId

--6.	Job Status

SELECT Status,IssueDate FROM Jobs
WHERE Status <> 'Finished'
ORDER BY IssueDate,JobId

--7.	Mechanic Assignments
SELECT m.FirstName + ' ' + m.LastName,
	   j.Status,
	   j.IssueDate
  FROM Mechanics AS m
JOIN Jobs AS j on j.MechanicId = m.MechanicId
ORDER BY m.MechanicId,j.IssueDate,j.JobId

--8.	Current Clients

SELECT c.FirstName + ' ' + c.LastName AS [Client],
       DATEDIFF(DAY,IssueDate,'2017-04-24') AS [Days going],
	   Status
  FROM Jobs AS j
JOIN Clients AS c ON c.ClientId = j.ClientId
WHERE j.Status <> 'Finished'
ORDER BY [Days going] DESC,c.ClientId

--9.	Mechanic Performance

SELECT m.FirstName + ' ' + m.LastName as [Mechanic],
	   AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate)) FROM Jobs AS j
JOIN Mechanics AS m ON m.MechanicId = j.MechanicId
GROUP BY j.MechanicId,m.FirstName,m.LastName

--10.	Hard Earners
SELECT TOP 3
       m.FirstName + ' ' + m.LastName as [Mechanic],
	   COUNT(*) AS Jobs
  FROM Jobs AS j
JOIN Mechanics AS m ON m.MechanicId = j.MechanicId
WHERE j.Status <> 'Finished'
GROUP BY j.MechanicId,m.FirstName,m.LastName
HAVING COUNT(*) > 1
ORDER BY Jobs DESC,J.MechanicId

--11.	Available Mechanics

SELECT FirstName + ' ' + LastName AS Avaivable FROM Mechanics
WHERE MechanicId NOT IN (SELECT MechanicId FROM Jobs
WHERE MechanicId IS NOT NULL AND Status <> 'Finished')

SELECT MechanicId FROM Jobs
WHERE MechanicId IS NOT NULL AND Status <> 'Finished'

--12.	Parts Cost
SELECT ISNULL(SUM(p.Price * op.Quantity),0) as [Parts Total] FROM Parts AS p
JOIN OrderParts AS op ON op.PartId = p.PartId
JOIN Orders AS o ON o.OrderId = op.OrderId
WHERE DATEDIFF(WEEK,o.IssueDate,'2017-04-24') <= 3
--13.	Past Expenses

SELECT j.JobId,ISNULL(SUM(p.Price * op.Quantity),0) AS Total FROM Jobs AS j
LEFT JOIN Orders AS o ON o.JobId = j.JobId
LEFT JOIN OrderParts AS op ON op.OrderId = o.OrderId
LEFT JOIN Parts AS p ON p.PartId = op.PartId
WHERE j.Status = 'Finished'
GROUP BY j.JobId
ORDER BY Total DESC, j.JobId ASC

--14.	Model Repair Time
