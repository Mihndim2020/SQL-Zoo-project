-- 1
SELECT matchid, player
FROM goal 
WHERE teamid = 'GER'

-- 2
SELECT id,stadium,team1,team2
FROM game
WHERE id = '1012'

-- 3
SELECT player, teamid,stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER';

-- 4
SELECT team1, team2, player
FROM game JOIN goal ON (id = matchid)
WHERE player LIKE 'Mario%';

-- 5
SELECT player, teamid, coach,  gtime
FROM goal JOIN eteam ON (teamid = id) 
WHERE gtime<=10

-- 6
SELECT mdate, teamname
FROM game JOIN eteam ON (team1 = eteam.id)
WHERE coach = 'Fernando Santos';

-- 7 
SELECT player 
FROM goal JOIN game ON (goal.matchid = game.id)
WHERE stadium = 'National Stadium, Warsaw'; 

-- 8 
SELECT DISTINCT player
FROM game JOIN goal ON (goal.matchid = game.id)
WHERE 'GER' IN (team1, team2) AND teamid <> 'GER';

-- 9
SELECT teamname, COUNT(*)
FROM eteam JOIN goal ON (id=teamid)
GROUP BY teamname;
 
-- 10
SELECT stadium, COUNT(*)
FROM goal JOIN game ON matchid = id
GROUP BY stadium;

-- 11
SELECT matchid, mdate, COUNT(player) AS goals_scored
FROM game JOIN goal
ON game.id = goal.matchid
WHERE 'POL' IN (team1, team2)
GROUP BY matchid, mdate;

-- 12
SELECT matchid, mdate, COUNT(*)
FROM goal JOIN game ON goal.matchid = game.id
WHERE 'GER' IN (team1, team2) AND teamid = 'GER'
GROUP BY matchid, mdate;

-- 13
SELECT mdate, team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1,
              team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal
ON game.id = goal.matchid
GROUP BY mdate, matchid, team1, team2
ORDER BY mdate, matchid, team1, team2;