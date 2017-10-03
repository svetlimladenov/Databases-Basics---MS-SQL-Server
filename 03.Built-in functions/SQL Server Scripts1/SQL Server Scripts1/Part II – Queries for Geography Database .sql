USE Geography

--Problem 10.	Countries Holding ‘A’ 3 or More Times

SELECT 
  CountryName AS [Country Name], IsoCode AS [ISO Code]
FROM Countries
WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode


--Problem 12.	Games from 2011 and 2012 year

SELECT PeakName,RiverName,LOWER(PeakName + SUBSTRING(RiverName,2,LEN(RiverName))) AS Mix FROM Peaks,Rivers
	WHERE RIGHT(PeakName,1) = LEFT(RiverName,1)
	ORDER BY Mix
