CREATE DATABASE IF NOT EXISTS finalprojectdb;
USE finalprojectdb;

DROP TABLE IF EXISTS Players, Quarterbacks, Running_Backs, Fullbacks, Wide_Receivers, Tight_Ends, Kickers, Offensive_Line, Defensive_Line, Linebackers, Defensive_Backs, Punters, Player_Game_Statistics, Team_Game_Statistics, Games, Teams, Conferences, Stadiums;

-- CREATE TABLE User(
--   userID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
--   firstName VARCHAR(20) NOT NULL,
--   lastName VARCHAR(20) NOT NULL,
--   email VARCHAR(50) NOT NULL,
--   password varchar(255) NOT NULL
-- );

CREATE TABLE Conferences(
  conference_id INT PRIMARY KEY NOT NULL,
  conference_name VARCHAR(30) NOT NULL,
  subdivision VARCHAR(3) NOT NULL
);

CREATE TABLE Teams(
  team_id INT PRIMARY KEY NOT NULL,
  conference_id INT NOT NULL,
  team_name VARCHAR(30) NOT NULL,
  CONSTRAINT team_conference_fk
    FOREIGN KEY(conference_id)
    REFERENCES Conferences(conference_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Stadiums(
  stadium_id INT PRIMARY KEY NOT NULL,
  stadium_name VARCHAR(50) NOT NULL,
  city VARCHAR(30) NOT NULL,
  state VARCHAR(2) NOT NULL,
  capacity INT NOT NULL,
  surface VARCHAR(50) NOT NULL,
  year_opened INT NOT NULL
);

CREATE TABLE Games(
  game_id BIGINT PRIMARY KEY NOT NULL,
  visiting_team_id INT NOT NULL,
  home_team_id INT NOT NULL,
  stadium_id INT NOT NULL,
  date VARCHAR(10) NOT NULL,
  site VARCHAR(7) NOT NULL,
  CONSTRAINT visiting_team_fk
    FOREIGN KEY(visiting_team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT home_team_fk
    FOREIGN KEY(home_team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT stadium_fk
    FOREIGN KEY(stadium_id)
    REFERENCES Stadiums(stadium_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Players(
  player_id BIGINT PRIMARY KEY NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL
);

CREATE TABLE Quarterbacks(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT qb_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT qb_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT qb_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Running_Backs(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT rb_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT rb_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT rb_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Fullbacks(
player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT fb_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fb_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fb_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Wide_Receivers(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT wr_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT wr_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT wr_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Tight_Ends(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT te_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT te_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT te_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Kickers(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT k_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT k_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT k_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Offensive_Line(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT ol_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT ol_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT ol_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Defensive_Line(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT dl_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT dl_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT dl_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Linebackers(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT lb_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT lb_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT lb_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Defensive_Backs(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT db_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT db_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT db_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Punters(
  player_id BIGINT PRIMARY KEY NOT NULL,
  team_id INT NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  uniform_number INT,
  class VARCHAR(2),
  height INT,
  weight INT,
  CONSTRAINT p_team_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT p_players_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT p_id_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Team_Game_Statistics(
  teamgame_id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  team_id INT NOT NULL,
  game_id BIGINT NOT NULL,
  rush_att INT NOT NULL,
  rush_yards INT NOT NULL,
  rush_td INT NOT NULL,
  pass_att INT NOT NULL,
  pass_comp INT NOT NULL,
  pass_yards INT NOT NULL,
  pass_td INT NOT NULL,
  pass_int INT NOT NULL,
  CONSTRAINT team_game_fk
    FOREIGN KEY(team_id)
    REFERENCES Teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT game_game_fk
    FOREIGN KEY(game_id)
    REFERENCES Games(game_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Player_Game_Statistics(
  playergame_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  player_id BIGINT NOT NULL,
  game_id BIGINT NOT NULL,
  rush_att INT NOT NULL,
  rush_yards INT NOT NULL,
  rush_td INT NOT NULL,
  pass_att INT NOT NULL,
  pass_comp INT NOT NULL,
  pass_yards INT NOT NULL,
  pass_td INT NOT NULL,
  pass_int INT NOT NULL,
  rec INT NOT NULL,
  rec_yards INT NOT NULL,
  rec_td INT NOT NULL,
  field_goal_att INT NOT NULL,
  field_goal_made INT NOT NULL,
  points INT NOT NULL,
  fumble INT NOT NULL,
  solo_tackles INT NOT NULL,
  sack NUMERIC(2, 1) NOT NULL,
  forced_fumbles INT NOT NULL,
  ret_int INT NOT NULL,
  punts INT NOT NULL,
  punt_yards INT NOT NULL,
  CONSTRAINT player_playergame_fk
    FOREIGN KEY(player_id)
    REFERENCES Players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT game_playergame_fk
    FOREIGN KEY(game_id)
    REFERENCES Games(game_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);