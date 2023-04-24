CREATE DATABASE IF NOT EXISTS brakingpoint
	CHARACTER SET utf8
	COLLATE utf8_hungarian_ci;


CREATE TABLE IF NOT EXISTS brakingpoint.users (
  userID INT(11) NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) DEFAULT NULL,
  first_name VARCHAR(255) DEFAULT NULL,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  balance INT(11) NOT NULL,
  registration_date DATE NOT NULL,
  preferred_category VARCHAR(255) DEFAULT NULL,
  level INT(11) NOT NULL,
  picture_frame VARCHAR(255) DEFAULT NULL,
  rank INT(11) NOT NULL,
  colour_palette VARCHAR(255) DEFAULT NULL,
  profile_picture VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (userID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE IF NOT EXISTS brakingpoint.sports (
  sportID INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (sportID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE IF NOT EXISTS brakingpoint.teams (
  teamID INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  sportID INT(11) NOT NULL,
  PRIMARY KEY (teamID),
  FOREIGN KEY (sportID) REFERENCES brakingpoint.sports(sportID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.competitors (
  competitorID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description LONGTEXT NOT NULL,
  permanentNumber INT(11) NOT NULL,
  nationality VARCHAR(255) NOT NULL,
  dateOfBirth DATE NOT NULL,
  teamID BIGINT(20) UNSIGNED NOT NULL,
  created_at TIMESTAMP(1) NULL DEFAULT NULL,
  updated_at TIMESTAMP(1) NULL DEFAULT NULL,
  PRIMARY KEY (competitorID)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;


CREATE TABLE brakingpoint.raceresults (
  raceResultID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  raceName VARCHAR(255) NOT NULL,
  `position` INT(11) NOT NULL,
  points DOUBLE(8, 2) NOT NULL,
  fastestLap INT(11) NOT NULL,
  time VARCHAR(255) NOT NULL,
  laps INT(11) NOT NULL,
  competitorID BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (raceResultID),
  FOREIGN KEY (competitorID) REFERENCES brakingpoint.competitors(competitorID)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS brakingpoint.available_bets (
  available_betID INT(11) NOT NULL AUTO_INCREMENT,
  date DATE NOT NULL,
  category VARCHAR(255) NOT NULL,
  odds DOUBLE NOT NULL,
  status VARCHAR(255) NOT NULL,
  sportID INT(11) DEFAULT NULL,
  PRIMARY KEY (available_betID),
  FOREIGN KEY (sportID) REFERENCES brakingpoint.sports(sportID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE IF NOT EXISTS brakingpoint.tickets (
  ticketID INT(11) NOT NULL AUTO_INCREMENT,
  status VARCHAR(255) NOT NULL,
  debt INT(11) NOT NULL,
  sum_odds DOUBLE NOT NULL,
  races VARCHAR(255) NOT NULL,
  payment_date DATE DEFAULT NULL,
  userID INT(11) NOT NULL,
  PRIMARY KEY (ticketID),
  FOREIGN KEY (userID) REFERENCES brakingpoint.users(userID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;
    

CREATE TABLE IF NOT EXISTS brakingpoint.connection_user_sport (
  connectionID INT(11) NOT NULL AUTO_INCREMENT,
  sportID INT(11) NOT NULL,
  userID INT(11) NOT NULL,
  PRIMARY KEY (connectionID),
  FOREIGN KEY (sportID) REFERENCES brakingpoint.sports(sportID),
  FOREIGN KEY (userID) REFERENCES brakingpoint.users(userID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE IF NOT EXISTS brakingpoint.connection_available_bet_ticket (
  connectionID INT(11) NOT NULL AUTO_INCREMENT,
  available_betID INT(11) NOT NULL,
  ticketID INT(11) NOT NULL,
  PRIMARY KEY (connectionID),
  FOREIGN KEY (available_betID) REFERENCES brakingpoint.available_bets(available_betID),
  FOREIGN KEY (ticketID) REFERENCES brakingpoint.tickets(ticketID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;
