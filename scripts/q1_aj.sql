
-- 1. What range of years for baseball games played does the provided database cover? 

SELECT MAX(yearid) AS most_recent_year, MIN(yearid) AS first_year, (MAX(yearid) - MIN(yearid)) AS number_of_years
FROM teams;

-- 2. Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?

SELECT DISTINCT height, namefirst, namelast, teams.name, appearances.g_all AS total_games_played
FROM people INNER JOIN appearances ON appearances.playerid = people.playerid
			INNER JOIN teams ON teams.teamid = appearances.teamid
WHERE height = (SELECT MIN(height) FROM people);

-- 3. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?

SELECT namelast, namefirst, SUM(salary::numeric::money) AS total_earned
FROM people INNER JOIN collegeplaying as cp ON cp.playerid = people.playerid
			INNER JOIN schools USING (schoolid)
			LEFT JOIN salaries ON salaries.playerid = people.playerid
WHERE schoolname = 'Vanderbilt University'
GROUP BY namefirst, namelast
ORDER BY total_earned DESC NULLS LAST

