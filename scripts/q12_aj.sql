-- 12. In this question, you will explore the connection between number of wins and attendance.
--      Does there appear to be any correlation between attendance at home games and number of wins?
--      Do teams that win the world series see a boost in attendance the following year? What about teams that made the playoffs? Making the playoffs means either being a division winner or a wild card winner.


WITH total_wins AS (SELECT SUM(w) AS total_wins,
				   teamid, 
				   yearid
				   FROM teams 
				   WHERE yearid >= 1970
				   GROUP BY teamid, yearid
				   ORDER BY yearid DESC),
				  				  
total_attendance AS (SELECT SUM(attendance) AS total_attendance, yearid, teamid, w
					 FROM teams
					 WHERE yearid >= 1970
					 GROUP BY yearid, teamid, w
					 ORDER BY teamid)
					 
--correlation between wins and total attendance: .46 - moderate correlation strength					 
SELECT CORR(tw.total_wins, ta.total_attendance) AS correlation
FROM total_wins tw
INNER JOIN total_attendance ta ON tw.teamid = ta.teamid AND tw.yearid = ta.yearid;

--attendance for wswin year and the following year
SELECT t1.yearid, 
	   t1.teamid, 
	   t1.attendance AS win_year_attendance, 
	   t2.attendance AS following_year_attendance,
	   (t2.attendance - t1.attendance) AS attendance_difference
FROM teams t1 JOIN teams t2 ON t1.teamid = t2.teamid AND t1.yearid + 1 = t2.yearid
WHERE t1.yearid >= 1970
  AND t1.wswin = 'Y';
 
--correlation between wswin and following year attendance: .86 - strong correlation (***data ends at 2016***)
SELECT CORR(t2.attendance, t1.attendance)
FROM teams t1 JOIN teams t2 ON t1.teamid = t2.teamid AND t1.yearid + 1 = t2.yearid
WHERE t1.yearid >= 1970
	AND t1.wswin = 'Y';
	
--attendance in the following year after making the playoffs
SELECT t1.yearid, 
	   t1.teamid,
	   t1.attendance AS winning_year_attendance,
	   t2.attendance AS following_year_attendance,
	   (t2.attendance - t1.attendance) AS attendance_difference	   
FROM teams t1 JOIN teams t2 ON t1.teamid = t2.teamid AND t1.yearid + 1 = t2.yearid
WHERE t1.yearid >= 1970
	AND t1.divwin = 'Y' OR t1.wcwin = 'Y'
	
--correlation between making the playoffs and attendance the following year: .89 - strong correlation (***data ends at 2016***)	
SELECT CORR(t2.attendance, t1.attendance)
FROM teams t1 JOIN teams t2 ON t1.teamid = t2.teamid AND t1.yearid + 1 = t2.yearid
WHERE t1.yearid >= 1970
	AND t1.divwin = 'Y' OR t1.wcwin = 'Y'
