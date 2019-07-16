-- 1 Query to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal
WHERE teamid = 'GER';

-- 2 Query to show id, stadium, team1, team2 for just game 1012.
SELECT id,stadium,team1,team2
FROM game WHERE id = 1012;

-- 3 Query to show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER';

-- 4 Query to show team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'.
SELECT team1, team2, player
FROM game INNER JOIN goal ON (game.id=goal.matchid)
WHERE player LIKE 'Mario%';

-- 5 Query to show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10.
SELECT player, teamid, coach, gtime
FROM goal INNER JOIN eteam ON teamid=id
WHERE gtime<=10;

-- 6 Query to show the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT game.mdate, eteam.teamname FROM eteam
INNER JOIN game ON (eteam.id=game.team1) WHERE eteam.coach = 'Fernando Santos';

-- 7 Query to show the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'.
SELECT goal.player FROM goal
INNER JOIN game ON (goal.matchid=game.id) WHERE game.stadium = 'National Stadium, Warsaw';

-- 8 Query to show the name of all players who scored a goal against Germany.
SELECT DINSTINCT player FROM game
JOIN goal ON matchid = id 
WHERE (team1='GER' OR team2='GER') AND teamid != 'GER';

-- 9 Query to show teamname and the total number of goals scored.
SELECT teamname, COUNT(goal.teamid)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname;

-- 10 Query to show the stadium and the number of goals scored in each stadium.
SELECT game.stadium, COUNT(game.stadium) FROM game
INNER JOIN goal ON (game.id=goal.matchid) GROUP BY game.stadium;

-- 11 Query to show show the matchid, date and the number of goals scored for every match involving 'POL'.
SELECT goal.matchid, game.mdate, COUNT(goal.matchid)
FROM goal JOIN game ON goal.matchid = game.id 
WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY goal.matchid, game.mdate;

-- 12 Query to show matchid, match date and the number of goals scored by 'GER' for every match where 'GER' scored.
SELECT goal.matchid, game.mdate, COUNT(goal.matchid)
FROM goal INNER JOIN game ON goal.matchid=game.id
WHERE goal.teamid = 'GER' GROUP BY goal.matchid, game.mdate;

-- 13 Query to show every match with the goals scored by each team as shown.
SELECT mdate, team1,
SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2,
SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, matchid, team1, team2;