-- 11. Is there any correlation between number of wins and team salary? Use data from 2000 and later to answer this question. As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want to look on a year-by-year basis.

--sum of wins/year
WITH team_wins AS (SELECT SUM(w) AS total_wins,
				   teamid, 
				   yearid
				   FROM teams 
				   WHERE yearid >= 2000
				   GROUP BY teamid, yearid
				   ORDER BY yearid DESC),
--sum of salaries/year
salaries AS (SELECT SUM(salary) AS total_salary,
		    yearid, 
			teamid 
			FROM salaries
			WHERE yearid >= 2000
			GROUP BY yearid, teamid),
--combine 2 above queries
combined AS (SELECT team_wins.teamid,
			 team_wins.yearid,
			 team_wins.total_wins,
			 salaries.total_salary
			 FROM team_wins
			 INNER JOIN salaries ON team_wins.teamid = salaries.teamid AND team_wins.yearid = salaries.yearid
			 ORDER BY team_wins.yearid DESC)
--checking for correlation
SELECT CORR(total_wins, total_salary) AS correlation
FROM combined
--there is a positive correlation between them, but it is a relatively weak correlation (correlation closer to 1 = strong, correlation closer to -1 = weak)