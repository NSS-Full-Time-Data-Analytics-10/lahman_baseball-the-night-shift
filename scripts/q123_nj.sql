-- Q1
SELECT MIN(yearid), MAX(yearid), MAX(yearid) - MIN(yearid) AS num_of_years
FROM batting;

--Q2

SELECT namefirst, namelast, namegiven, height, teams.name, g_all
FROM people
INNER JOIN appearances
USING (playerid)
INNER JOIN teams
USING (teamid)
WHERE height = (SELECT MIN(height) FROM people)
GROUP BY namefirst, namelast, namegiven, height, teams.name, g_all;

--Q3

