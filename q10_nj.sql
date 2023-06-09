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