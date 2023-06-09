-- 7.  From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? What is the smallest number of wins for a team that did win the world series? Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?

--largest # of wins by team that did not win world series: 116 - seattle mariners, 2001
SELECT SUM(w) AS total_wins, 
	   name, yearid, 
	   COALESCE(wswin, 'unknown') AS world_series_won
FROM teams 
WHERE yearid BETWEEN 1970 AND 2016
GROUP BY name, yearid, wswin
ORDER BY total_wins DESC;

--fewest wins by team that won world series: 63, l.a. dodgers, 1981
SELECT SUM(w) AS total_wins, 
	   name, yearid, 
	   COALESCE(wswin, 'unknown') AS world_series_won
FROM teams 
WHERE yearid BETWEEN 1970 AND 2016
	AND wswin = 'Y'
GROUP BY name, yearid, wswin
ORDER BY total_wins;

--query excluding the 1981 players strike season
SELECT SUM(w) AS total_wins, 
	   name, yearid, 
	   COALESCE(wswin, 'unknown') AS world_series_won
FROM teams 
WHERE yearid BETWEEN 1970 AND 2016 AND yearid <> 1981
	AND wswin = 'Y'
GROUP BY name, yearid, wswin
ORDER BY total_wins;

--how often the team with the most wins won the world series
WITH most_wins AS (SELECT SUM(w) AS total_wins,
    				name,
    				yearid,
    				COALESCE(wswin, 'unknown') AS world_series_won,
    				ROW_NUMBER() OVER (PARTITION BY yearid ORDER BY SUM(w) DESC) AS rank
  					FROM teams
  					WHERE yearid BETWEEN 1970 AND 2016
    					AND yearid <> 1981
  					GROUP BY name,
    						yearid,
   							 wswin),
grouped_wins AS (SELECT MAX(total_wins) AS best_record,
				 yearid,
				 world_series_won,
				 name
				 FROM most_wins
				 WHERE rank = 1
				 GROUP BY yearid, world_series_won, name
				 ORDER BY yearid, best_record DESC)
SELECT ROUND(((SELECT COUNT(*)::decimal AS total_wsw FROM grouped_wins WHERE world_series_won = 'Y') / (SELECT COUNT(*)::decimal FROM grouped_wins WHERE world_series_won <> 'unknown')), 4) * 100 AS percent_won
FROM grouped_wins
WHERE world_series_won <> 'unknown'
	   
