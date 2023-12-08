LOAD DATA INFILE '/var/lib/mysql-files/conference.csv'
INTO TABLE Conferences
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@conference_id, @conference_name, @subdivision)
SET
  conference_id = @conference_id,
  conference_name = @conference_name,
  subdivision = @subdivision;

LOAD DATA INFILE '/var/lib/mysql-files/team.csv'
INTO TABLE Teams
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@team_id, @team_name, @conference_id)
SET
  team_id = @team_id,
  conference_id = @conference_id,
  team_name = @team_name;

LOAD DATA INFILE '/var/lib/mysql-files/stadium.csv'
INTO TABLE Stadiums
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@stadium_id, @stadium_name, @city, @state, @capacity, @surface, @year_opened)
SET
  stadium_id = @stadium_id,
  stadium_name = @stadium_name,
  city = @city,
  state = @state,
  capacity = @capacity,
  surface = @surface,
  year_opened = @year_opened;

LOAD DATA INFILE '/var/lib/mysql-files/game.csv'
INTO TABLE Games
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@game_id, @date, @visiting_team_id, @home_team_id, @stadium_id, @site)
SET
  game_id = @game_id,
  visiting_team_id = @visiting_team_id,
  home_team_id = @home_team_id,
  stadium_id = @stadium_id,
  date = @date,
  site = @site;

LOAD DATA INFILE '/var/lib/mysql-files/players.csv'
INTO TABLE Players
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @last_name, @first_name)
SET
  player_id = @player_id,
  last_name = @last_name,
  first_name = @first_name;

LOAD DATA INFILE '/var/lib/mysql-files/qb.csv'
INTO TABLE Quarterbacks
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight, @dummy, @dummy, @dummy, @dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/rb.csv'
INTO TABLE Running_Backs
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/fb.csv'
INTO TABLE Fullbacks
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/wr.csv'
INTO TABLE Wide_Receivers
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/te.csv'
INTO TABLE Tight_Ends
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/pk.csv'
INTO TABLE Kickers
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/ol.csv'
INTO TABLE Offensive_Line
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/dl.csv'
INTO TABLE Defensive_Line
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/lb.csv'
INTO TABLE Linebackers
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/db.csv'
INTO TABLE Defensive_Backs
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/p.csv'
INTO TABLE Punters
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @team_id, @last_name, @first_name, @uniform_number, @class, @height, @weight,	@dummy,	@dummy,	@dummy,	@dummy)
SET
  player_id = @player_id,
  team_id = @team_id,
  last_name = @last_name,
  first_name = @first_name,
  uniform_number = NULLIF(@uniform_number, ''),
  class = NULLIF(@class, ''),
  height = NULLIF(@height, ''),
  weight = NULLIF(@weight, '');

LOAD DATA INFILE '/var/lib/mysql-files/team_game_statistics.csv'
INTO TABLE Team_Game_Statistics
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@team_id, @game_id, @rush_att, @rush_yards, @rush_td, @pass_att, @pass_comp, @pass_yards, @pass_td, @pass_int)
SET
  team_id = @team_id,
  game_id = @game_id,
  rush_att = @rush_att,
  rush_yards = @rush_yards,
  rush_td = @rush_td,
  pass_att = @pass_att,
  pass_comp = @pass_comp,
  pass_yards = @pass_yards,
  pass_td = @pass_td,
  pass_int = @pass_int;

LOAD DATA INFILE '/var/lib/mysql-files/player_game_statistics.csv'
INTO TABLE Player_Game_Statistics
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@player_id, @game_id, @rush_att, @rush_yards, @rush_td, @pass_att, @pass_comp, @pass_yards, @pass_td, @pass_int, @rec, @rec_yards, @rec_td, @field_goal_att, @field_goal_made, @points, @fumble, @solo_tackles, @sack, @forced_fumbles, @ret_int, @punts, @punt_yards)
SET
  player_id = @player_id,
  game_id = @game_id,
  rush_att = @rush_att,
  rush_yards = @rush_yards,
  rush_td = @rush_td,
  pass_att = @pass_att,
  pass_comp = @pass_comp,
  pass_yards = @pass_yards,
  pass_td = @pass_td,
  pass_int = @pass_int,
  rec = @rec,
  rec_yards = @rec_yards,
  rec_td = @rec_td,
  field_goal_att = @field_goal_att,
  field_goal_made = @field_goal_made,
  points = @points,
  fumble = @fumble,
  solo_tackles = @solo_tackles,
  sack = @sack,
  forced_fumbles = @forced_fumbles,
  ret_int = @ret_int,
  punts = @punts,
  punt_yards = @punt_yards;

