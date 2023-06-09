--Q5
--Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. 
--Do the same for home runs per game. Do you see any trends?


WITH so_hr_by_year AS
	(SELECT CONCAT(LEFT(yearid::text, 3), '0s') AS years, 
	 	SUM(g):: numeric AS totgames, 
	 	SUM(so):: numeric AS totso, 
	 	SUM(hr):: numeric AS tothr
	FROM teams
WHERE yearid >=1920
GROUP BY years
ORDER BY years)

SELECT years, 
	ROUND((totso/totgames), 2) AS avg_so_year, 
	ROUND((tothr/totgames), 2) AS avg_hr_year
FROM so_hr_by_year

--Trends would be that so and hr both dropped in the 1970s, possibly adjusting to a new style of ball or bat. 