--Q8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 
--average attendance per game in 2016 (where average attendance is defined as total attendance divided by 
--number of games). Only consider parks where there were at least 10 games played. 
--Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

--TOP 5 ATTENDED
WITH avg_attendance AS (SELECT team, ROUND(SUM(attendance), 0)::int/SUM(games) AS avg_attend
						FROM homegames
						WHERE year = '2016'
					   GROUP BY team)
			SELECT teams.name, teams.park, avg_attend
			FROM homegames	INNER JOIN avg_attendance USING (team)
							INNER JOIN teams ON teams.teamid = homegames.team
			WHERE yearid = '2016' AND homegames.attendance > avg_attend AND games > 10
			GROUP BY teams.name, teams.park, avg_attendance.avg_attend
			ORDER BY avg_attend DESC
			LIMIT 5;

SELECT yearid, name, park
FROM teams
WHERE yearid = '2016' 

--5 LEAST ATTENDED
WITH avg_attendance AS (SELECT team, ROUND(SUM(attendance), 0)::int/SUM(games) AS avg_attend
						FROM homegames
						WHERE year = '2016'
					   GROUP BY team)
			SELECT teams.name, teams.park, avg_attend
			FROM homegames	INNER JOIN avg_attendance USING (team)
							INNER JOIN teams ON teams.teamid = homegames.team
			WHERE yearid = '2016' AND homegames.attendance > avg_attend AND games > 10
			GROUP BY teams.name, teams.park, avg_attendance.avg_attend
			ORDER BY avg_attend
			LIMIT 5;

--REFERENCES
SELECT year, team, park, games
FROM homegames
WHERE year = '2016' 

SELECT games
FROM homegames
WHERE year = '2016' 

SELECT SUM(games) --SUM(attendance)
FROM homegames
WHERE year = '2016' 

SELECT ROUND(SUM(attendance), 0)::int/SUM(games) AS avg_attendance
FROM homegames
WHERE year = '2016'
--30131

SELECT *
FROM homegames
WHERE year = '2016' 

SELECT yearid, name, park
FROM teams
WHERE yearid = '2016' 

SELECT *
FROM teams
WHERE yearid = '2016' 