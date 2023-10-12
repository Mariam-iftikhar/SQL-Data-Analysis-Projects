--Question 1: How many accidents have occurred in urban areas versus rural areas?
select area,COUNT( [AccidentIndex]) as Total_occured_accidents
 FROM [Practice Db].[dbo].[accident$] group by area

 --Question 2: Which day of the week has the highest number of accidents?
 select day,COUNT( [AccidentIndex]) as Total_occured_accidents
 FROM [Practice Db].[dbo].[accident$] group by DAY order by 2 desc

 --Question 3: What is the average age of vehicles involved in accidents based on their type?
 select [VehicleType],round(Avg([AgeVehicle]),1) as Avg_age_of_vehicle ,COUNT([AccidentIndex]) AS TotalAccident
 FROM [Practice Db].[dbo].[vehicle$] 
 WHERE [AgeVehicle] IS NOT NULL group by [VehicleType]  order by 3 desc

 --Question 4: Can we identify any trends in accidents based on the age of vehicles involved?
SELECT AgeGroup,COUNT([AccidentIndex]) AS 'Total Accident',	AVG([AgeVehicle]) AS 'Average Year'
FROM (
	SELECT [AccidentIndex],[AgeVehicle],
CASE WHEN [AgeVehicle] BETWEEN 0 AND 5 THEN 'New'
WHEN [AgeVehicle] BETWEEN 6 AND 10 THEN 'Regular' ELSE 'Old'
END AS AgeGroup
FROM [Practice Db].[dbo].[vehicle$] 
) AS SubQuery
GROUP BY AgeGroup;

--Question 5: Are there any specific weather conditions that contribute to severe accidents?
SELECT [WeatherConditions],[Severity],COUNT([Severity]) AS AccidentsSevirity
FROM [dbo].[accident$] GROUP BY [WeatherConditions],[Severity] order by 3 desc

--Question 6: Do accidents often involve impacts on the left-hand side of vehicles?
SELECT [LeftHand], COUNT([AccidentIndex]) AS 'Total Accident'
FROM [dbo].[vehicle$]
GROUP BY [LeftHand]
HAVING [LeftHand] IS NOT NULL

--Question 7: Are there any relationships between journey purposes and the severity of accidents?
SELECT 	V.[JourneyPurpose], COUNT(A.[Severity]) AS 'Total Accident',
CASE 
WHEN COUNT(A.[Severity]) BETWEEN 0 AND 1000 THEN 'Low'
WHEN COUNT(A.[Severity]) BETWEEN 1001 AND 3000 THEN 'Moderate'
ELSE 'High'
END AS 'Level'
FROM [dbo].[accident$] A
JOIN [dbo].[vehicle$] V ON A.[AccidentIndex] = V.[AccidentIndex]
GROUP BY V.[JourneyPurpose]
ORDER BY 'Total Accident' DESC;

--Question 8: Calculate the average age of vehicles involved in accidents , considering Day light and point of impact:
SELECT 
	A.[LightConditions], 
	V.[PointImpact], 
	AVG(V.[AgeVehicle]) AS 'Average Vehicle Year'
FROM 
	[dbo].[accident$]  A 
JOIN 
	[dbo].[vehicle$] V ON A.[AccidentIndex] = V.[AccidentIndex] where A.[LightConditions]='Daylight'
GROUP BY 
	V.[PointImpact], A.[LightConditions]

--Question 9: Are there any specific severity conditions that contribute to severe accidents?
SELECT [Severity],COUNT([Severity]) AS AccidentsSevirity
FROM [dbo].[accident$] GROUP BY [Severity] order by 2 desc



