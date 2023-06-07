-- 6. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.

SELECT *
FROM batting
WHERE yearid = 2016;


SELECT SUM(sb) AS successful, 
	   SUM(cs) + SUM(sb) AS total_steal_attempts, 
	   ROUND((SUM(sb::numeric)) / (SUM(cs::numeric) + SUM(sb::numeric)), 4) AS success_rate,
	   p.namefirst || ' ' || p.namelast AS name,
	   yearid	  
FROM batting INNER JOIN people as p ON p.playerid = batting.playerid
WHERE yearid = 2016
GROUP BY batting.playerid, yearid, p.namefirst, p.namelast
HAVING (SUM(cs) + SUM(sb)) >= 20
ORDER BY total_steal_attempts DESC;

--only player name with best steal success % for 2016
SELECT ROUND((SUM(sb::numeric)) / (SUM(cs::numeric) + SUM(sb::numeric)), 4) AS success_rate,
	   p.namefirst || ' ' || p.namelast AS name	  
FROM batting INNER JOIN people as p ON p.playerid = batting.playerid
WHERE yearid = 2016
GROUP BY p.namefirst, p.namelast
HAVING (SUM(cs) + SUM(sb)) >= 20
ORDER BY success_rate DESC
LIMIT 1;