--Problem 12.	Games from 2011 and 2012 year

SELECT TOP 50 Name,FORMAT(Start,'yyyy-MM-dd') AS [Start] FROM Games
	WHERE DATEPART(YEAR,Start) BETWEEN 2011 AND 2012
	ORDER BY Start,Name

--Problem 13.	 User Email Providers
SELECT Username,
       SUBSTRING(Email,CHARINDEX('@',Email) + 1,
	   LEN(Email) - CHARINDEX('@',Email) + 1) AS [Email Provider]
	FROM Users
	ORDER BY [Email Provider],Username

--Problem 14.	 Get Users with IPAdress Like Pattern

SELECT Username,IpAddress FROM Users
	WHERE IpAddress LIKE '___.1%.%.___'
	ORDER BY Username

--Problem 15.	 Show All Games with Duration and Part of the Day

SELECT G.Name , 
	CASE
		WHEN DATEPART(HOUR,G.Start) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR,G.Start) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(HOUR,G.Start) BETWEEN 18 AND 24 THEN 'Evening'
		END AS [Part of Day],
	CASE
		WHEN Duration <= 3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		WHEN Duration IS NULL THEN 'Extra Long'
		END AS [Duration]
	FROM Games AS G 
	ORDER BY Name,Duration,[Part of Day]
	