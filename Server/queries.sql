--Inserts the newly registered user into the User table of the database.
--URL Path: http://localhost:8081/register
INSERT INTO User (firstName, lastName, email, password) VALUES (?, ?, ?, ?);

--Queries the user information from the User table that matches the entered email and checks if the passwords match
--URL Path: http://localhost:8081/login
SELECT email, password, firstName, lastName FROM User WHERE email = ?;

--Queries the name, team, and season passing yards for Quarterbacks for the 2013 College Football Season with the top 5 passing yards
--URL Path: http://localhost:8081/top_5_yards
SELECT P.first_name, P.last_name, T.team_name AS school, SUM(PGS.pass_yards) AS total_passing_yards FROM Player_Game_Statistics PGS JOIN Players P ON PGS.player_id = P.player_id JOIN Quarterbacks QB ON PGS.player_id = QB.player_id JOIN Teams T ON QB.team_id = T.team_id GROUP BY PGS.player_id, P.first_name, P.last_name, T.team_name ORDER BY total_passing_yards DESC LIMIT 5;

--Queries the name, team, and season receiving yards for Wide Receivers for the 2013 College Football Season with the top 5 receiving yards
--URL Path: http://localhost:8081/top_5_yards
SELECT P.first_name, P.last_name, T.team_name AS school, SUM(PGS.rec_yards) AS total_receiving_yards FROM Player_Game_Statistics PGS JOIN Players P ON PGS.player_id = P.player_id JOIN Wide_Receivers WR ON PGS.player_id = WR.player_id JOIN Teams T ON WR.team_id = T.team_id GROUP BY PGS.player_id, P.first_name, P.last_name, T.team_name ORDER BY total_receiving_yards DESC LIMIT 5;

--Queries the name, team, and season rushing yards for Running Backs for the 2013 College Football Season with the top 5 receiving yards
--URL Path: http://localhost:8081/top_5_yards
SELECT P.first_name, P.last_name, T.team_name AS school, SUM(PGS.rec_yards) AS total_receiving_yards FROM Player_Game_Statistics PGS JOIN Players P ON PGS.player_id = P.player_id JOIN Wide_Receivers WR ON PGS.player_id = WR.player_id JOIN Teams T ON WR.team_id = T.team_id GROUP BY PGS.player_id, P.first_name, P.last_name, T.team_name ORDER BY total_receiving_yards DESC LIMIT 5;

--Queries teams and sacks for the 2013 College Football Season with the top 5 most sacks per game
--URL Path: http://localhost:8081/def_efficiency
SELECT T.team_name, ROUND(unioned_sacks.sacks / 12.0, 1) AS avg_sacks_per_game FROM Teams T JOIN (SELECT team_id, SUM(PGS.sack) AS sacks FROM Player_Game_Statistics PGS INNER JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPlayers ON PGS.player_id = AllPlayers.player_id GROUP BY team_id) AS unioned_sacks ON T.team_id = unioned_sacks.team_id GROUP BY T.team_id, T.team_name ORDER BY avg_sacks_per_game DESC LIMIT 5;

--Queries teams and solo tackles for the 2013 College Football Season with the top 5 most solo tackles per game
--URL Path: http://localhost:8081/def_efficiency
SELECT T.team_name, ROUND(SUM(unioned_tackles.solo_tackles) / 12.0, 1) AS avg_solo_tackles_per_game FROM Teams T JOIN (SELECT team_id, SUM(PGS.solo_tackles) AS solo_tackles FROM Player_Game_Statistics PGS INNER JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPlayers ON PGS.player_id = AllPlayers.player_id GROUP BY team_id) AS unioned_tackles ON T.team_id = unioned_tackles.team_id GROUP BY T.team_id, T.team_name ORDER BY avg_solo_tackles_per_game DESC LIMIT 5;

--Queries teams and interceptions for the 2013 College Football Season with the top 5 most interceptions per game
--URL Path: http://localhost:8081/def_efficiency
SELECT T.team_name, ROUND(SUM(unioned_ints.ret_int) / 12.0, 1) AS avg_int_per_game FROM Teams T JOIN (SELECT team_id, SUM(PGS.ret_int) AS ret_int FROM Player_Game_Statistics PGS INNER JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPlayers ON PGS.player_id = AllPlayers.player_id GROUP BY team_id) AS unioned_ints ON T.team_id = unioned_ints.team_id GROUP BY T.team_id, T.team_name ORDER BY avg_int_per_game DESC LIMIT 5;

--Queries teams and forced fumbles for the 2013 College Football Season with the top 5 most forces fumbles per game
--URL Path: http://localhost:8081/def_efficiency
SELECT T.team_name, ROUND(SUM(unioned_fumbles.forced_fumbles) / 12.0, 1) AS avg_forced_fumbles_per_game FROM Teams T JOIN (SELECT team_id, SUM(PGS.forced_fumbles) AS forced_fumbles FROM Player_Game_Statistics PGS INNER JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPlayers ON PGS.player_id = AllPlayers.player_id GROUP BY team_id) AS unioned_fumbles ON T.team_id = unioned_fumbles.team_id GROUP BY T.team_id, T.team_name ORDER BY avg_forced_fumbles_per_game DESC LIMIT 5;

--Queries conferences and the average point scored per game by each conference's respective teams and displays them from highest to lowest
--URL Path: http://localhost:8081/points_scored
SELECT C.conference_name, ROUND((SUM(PGS.points) / TeamCounts.team_count) / 12.0, 1) AS avg_points_per_conference FROM Player_Game_Statistics PGS JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPositions ON PGS.player_id = AllPositions.player_id JOIN Teams T ON AllPositions.team_id = T.team_id JOIN Conferences C ON T.conference_id = C.conference_id JOIN (SELECT conference_id, COUNT(*) AS team_count FROM Teams GROUP BY conference_id) AS TeamCounts ON C.conference_id = TeamCounts.conference_id GROUP BY C.conference_id, C.conference_name ORDER BY avg_points_per_conference DESC;

--Queries the name and passing yards of the Georgia Quarterback with the most passing yards
--URL Path: http://localhost:8081/top_uga
SELECT P.first_name, P.last_name, SUM(PGS.pass_yards) AS total_passing_yards FROM Quarterbacks QB JOIN Player_Game_Statistics PGS ON QB.player_id = PGS.player_id JOIN Players P ON QB.player_id = P.player_id JOIN Teams T ON QB.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY QB.player_id ORDER BY total_passing_yards DESC LIMIT 1;

--Queries the name and receiving yards of the Georgia Tight End with the most receiving yards
--URL Path: http://localhost:8081/top_uga
SELECT P.first_name, P.last_name, SUM(PGS.rec_yards) AS total_receiving_yards FROM Tight_Ends TE JOIN Player_Game_Statistics PGS ON TE.player_id = PGS.player_id JOIN Players P ON TE.player_id = P.player_id JOIN Teams T ON TE.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY TE.player_id ORDER BY total_receiving_yards DESC LIMIT 1;

--Queries the name and solo tackles of the Georgia Linebacker with the most solo tackles
--URL Path: http://localhost:8081/top_uga
SELECT P.first_name, P.last_name, SUM(PGS.solo_tackles) AS total_solo_tackles FROM Linebackers LB JOIN Player_Game_Statistics PGS ON LB.player_id = PGS.player_id JOIN Players P ON LB.player_id = P.player_id JOIN Teams T ON LB.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY LB.player_id ORDER BY total_solo_tackles DESC LIMIT 1;

--Queries the name and punting yards of the Georgia Punter with the most punting yards
--URL Path: http://localhost:8081/top_uga
SELECT PL.first_name, PL.last_name, SUM(PGS.punt_yards) AS total_punt_yards FROM Punters P JOIN Player_Game_Statistics PGS ON P.player_id = PGS.player_id JOIN Players PL ON P.player_id = PL.player_id JOIN Teams T ON P.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY P.player_id ORDER BY total_punt_yards DESC LIMIT 1;

--Queries the name and points of the Georgia Kicker with the most points
--URL Path: http://localhost:8081/top_uga
SELECT P.first_name, P.last_name, SUM(PGS.points) AS total_points FROM Kickers PK JOIN Player_Game_Statistics PGS ON PK.player_id = PGS.player_id JOIN Players P ON PK.player_id = P.player_id JOIN Teams T ON PK.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY PK.player_id ORDER BY total_points DESC LIMIT 1;

--Queries the name, city, state, year opened, capacity, and surface of the stadiums in the database and orders them from newest to oldest
--URL Path: http://localhost:8081/stadiums
SELECT stadium_name, city, state, year_opened, capacity, surface FROM Stadiums ORDER BY year_opened DESC;

--Inserts a new stadium into the Stadiums table
--URL Path: http://localhost:8081/add_stadium
INSERT INTO Stadiums (stadium_name, city, state, capacity, surface, year_opened) VALUES (?, ?, ?, ?, ?, ?);

--Queries the id of the stadium with the matching stadium name
--URL Path: http://localhost:8081/remove_stadium
SELECT stadium_id FROM Stadiums WHERE stadium_name = ?;

--Removes a stadium into the Stadiums table based on the stadium id
--URL Path: http://localhost:8081/remove_stadium
DELETE FROM Stadiums WHERE stadium_id = ?;

--Removes all instances of a stadium appearing in the Games table based on the stadium id
--URL Path: http://localhost:8081/remove_stadium
DELETE FROM Games WHERE stadium_id = ?;

--Updates of the capacity and surface of the stadium with the match name
--URL Path: http://localhost:8081/update_stadium
UPDATE Stadiums SET capacity = ?, surface = ? WHERE stadium_name = ?