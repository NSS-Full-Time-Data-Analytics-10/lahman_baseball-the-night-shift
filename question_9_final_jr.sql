--Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? 
--Give their full name and the teams that they were managing when they won the award.



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