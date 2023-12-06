CREATE DATABASE IF NOT EXISTS finalprojectdb;
USE finalprojectdb;

DROP TABLE IF EXISTS Quarterbacks, Running_Backs, Full_Backs, Wide_Receivers, Tight_Ends, Kickers, Offensive_Line, Defensive_Line, Linebackers, Defensive_Backs, Punters, Player_Game_Statistics, Team_Game_Statistics, Games, Teams, Conferences, Stadiums;

CREATE TABLE User(
  userID INT PRIMARY KEY NOT NULL,
  firstName VARCHAR(20) NOT NULL,
  lastName VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  password varchar(25) NOT NULL
);

