-- Q13

-- number of lefty and righty pitcher since the CY young award started
WITH pitcher_since_cy AS (SELECT COUNT(throws) AS num_lefty,
(SELECT COUNT(throws) AS num_righty
FROM pitching
LEFT JOIN people
USING (playerid)
WHERE throws LIKE 'R'
AND yearid > 1955)
FROM pitching
LEFT JOIN people
USING (playerid)
WHERE throws LIKE 'L'
AND yearid > 1955),

--number of pitchers
pitcher_total AS (SELECT COUNT(throws) AS num_lefty,
(SELECT COUNT(throws) AS num_righty
FROM pitching
LEFT JOIN people
USING (playerid)
WHERE throws LIKE 'R')
FROM pitching
LEFT JOIN people
USING (playerid)
WHERE throws LIKE 'L'),

--Right handed Cy Young winners
right_cy AS (SELECT namefirst, namelast, awardid, throws, yearid
FROM people
INNER JOIN awardsplayers
USING (playerid)
WHERE awardid LIKE 'Cy%'
AND throws LIKE 'R'),

-- Left handed Cy Young winners
left_cy AS (SELECT namefirst, namelast, awardid, throws, yearid
FROM people
INNER JOIN awardsplayers
USING (playerid)
WHERE awardid LIKE 'Cy%'
AND throws LIKE 'R'),


-- Left handed hall of fame pitchers
left_hof AS (SELECT namefirst, namelast, inducted, throws, halloffame.yearid
FROM halloffame
INNER JOIN pitching
USING (playerid)
INNER JOIN people
USING (playerid)
INNER JOIN appearances
USING (playerid)
WHERE inducted LIKE 'Y'
AND throws LIKE 'L'
AND g_p > 10
GROUP BY namefirst, namelast, inducted, throws, halloffame.yearid
ORDER BY yearid),

-- Right handed hall of fame pitchers
right_hof AS (SELECT namefirst, namelast, inducted, throws, halloffame.yearid
FROM halloffame
INNER JOIN pitching
USING (playerid)
INNER JOIN people
USING (playerid)
INNER JOIN appearances
USING (playerid)
WHERE inducted LIKE 'Y'
AND throws LIKE 'R'
AND g_p > 10
GROUP BY namefirst, namelast, inducted, throws, halloffame.yearid
ORDER BY yearid)

--percentages
SELECT ((COUNT(right_hof.namefirst))::DECIMAL/(SELECT num_righty FROM pitcher_total)::DECIMAL)*100 AS righty_hof_perct
FROM right_hof;



-- Left handed pitchers are more likely to win the Cy Young but not more likely to make it to the hof
-- .4% of lefty pitchers have won the cy young and .3% of righty pitchers have won the cy young since the award was created
-- however .15% of lefty pitchers make the hall of fame and .19% of righty pitchers make the hof