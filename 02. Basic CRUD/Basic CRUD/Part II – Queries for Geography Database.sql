--22.	 All Mountain Peaks
SELECT PeakName FROM Peaks 
	ORDER BY PeakName
--23.	 Biggest Countries by Population
SELECT TOP 30 CountryName,Population FROM Countries
	WHERE ContinentCode = 
	(SELECT ContinentCode FROM Continents WHERE ContinentName = 'Europe')
	ORDER BY Population DESC,CountryName 

SELECT * FROM Countries
	WHERE ContinentCode = 
	(SELECT ContinentCode FROM Continents WHERE ContinentName = 'Europe')

--24.	 *Countries and Currency (Euro / Not Euro)
SELECT CountryName,
	   CountryCode,
	   CASE WHEN CurrencyCode = 'EUR' THEN 'Euro'
	   ELSE 'Not Euro' END  AS [Currency] 
	FROM Countries
	ORDER BY CountryName
	