--Q9

WITH manager_win AS ((SELECT playerid, namefirst, namelast, awardid
FROM awardsmanagers
LEFT JOIN people
USING (playerid)
WHERE awardid LIKE 'TSN%'
	AND lgid LIKE 'NL')
INTERSECT
(SELECT playerid, namefirst, namelast, awardid
FROM awardsmanagers
LEFT JOIN people
USING (playerid)
WHERE awardid LIKE 'TSN%'
	AND lgid LIKE 'AL'))

SELECT manager_win.namefirst, manager_win.namelast, teamid
FROM manager_win
LEFT JOIN awardsmanagers
USING (playerid)
LEFT JOIN people
USING (playerid)
INNER JOIN managers
ON awardsmanagers.playerid = managers.playerid AND awardsmanagers.yearid = managers.yearid
WHERE awardsmanagers.awardid LIKE 'TSN%'
AND awardsmanagers.lgid IN ('NL','AL');



	
--Q10
(SELECT namefirst, namelast, MAX(hr) AS most_hr
FROM batting
INNER JOIN people
USING (playerid)
WHERE hr > 0 AND (finalgame::DATE - debut::DATE) >=3650 AND yearid = 2016
GROUP BY playerid, namefirst, namelast)
INTERSECT
(SELECT namefirst, namelast, MAX(hr) AS most_hr
FROM batting
INNER JOIN people
USING (playerid)
WHERE hr > 0 AND (finalgame::DATE - debut::DATE) >=3650
GROUP BY playerid, namefirst, namelast)
ORDER BY most_hr DESC;



