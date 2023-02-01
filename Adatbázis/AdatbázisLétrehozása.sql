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


CREATE TABLE IF NOT EXISTS brakingpoint.competitors (
  competitorID INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  teamID INT(11) NOT NULL,
  PRIMARY KEY (competitorID),
  FOREIGN KEY (teamID) REFERENCES brakingpoint.teams(teamID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


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
