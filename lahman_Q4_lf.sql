--Q4. Using the fielding table, group players into three groups based on their position: 
--label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", 
--and those with position "P" or "C" as "Battery". 
--Determine the number of putouts made by each of these three groups in 2016.

WITH pos_group AS(SELECT playerid, yearid, pos, po,
					CASE WHEN pos = 'OF' THEN 'Outfield'
					WHEN pos IN ('SS','1B','2B','3B') THEN 'Infield'
					WHEN pos IN ('P', 'C') THEN 'Battery' END AS pos_group
				FROM fielding
				WHERE yearid = '2016'
				GROUP BY playerid, yearid, pos, po)
SELECT SUM(po), pos_group
FROM pos_group
GROUP BY pos_group;

--