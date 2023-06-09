--Q1 

SELECT  MAX(DISTINCT yearid), MIN(DISTINCT yearid), (MAX(DISTINCT yearid)- MIN(DISTINCT yearid))
FROM teams;

--Q2

SELECT namefirst, namelast, MIN(height), g_all, teamid, name
FROM people
INNER JOIN appearances
USING (playerid)
INNER JOIN teams
USING(teamid)
GROUP BY namefirst, namelast, g_all, teamid, name
ORDER BY min NULLS LAST
LIMIT 1;


--Q3

SELECT namefirst, namelast, SUM(salary::numeric::money), 
debut, finalgame, schoolname
FROM people
INNER JOIN salaries
USING(playerid)
INNER JOIN collegeplaying
USING(playerid)
INNER JOIN schools
USING (schoolid)
WHERE schoolname = 'Vanderbilt University'
GROUP BY namefirst, namelast, debut, finalgame, schoolname
ORDER BY SUM(salary) DESC;

