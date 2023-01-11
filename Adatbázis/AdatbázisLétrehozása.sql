CREATE DATABASE brakingpoint
	CHARACTER SET utf8
	COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.users (
  PK_user INT(11) NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (PK_user)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.sports (
  PK_sport INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (PK_sport)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.teams (
  PK_team INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  FK_sport INT(11) NOT NULL,
  PRIMARY KEY (PK_team)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


ALTER TABLE brakingpoint.teams
  ADD CONSTRAINT FK_sport FOREIGN KEY (PK_sport)
    REFERENCES brakingpoint.sports(PK_sport);


CREATE TABLE brakingpoint.competitors (
  PK_competitor INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  FK_team INT(11) NOT NULL,
  PRIMARY KEY (PK_competitor)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


ALTER TABLE brakingpoint.competitors
  ADD CONSTRAINT FK_team FOREIGN KEY (PK_team)
    REFERENCES brakingpoint.teams(PK_team);


CREATE TABLE brakingpoint.available_bets (
  PK_available_bets INT(11) NOT NULL AUTO_INCREMENT,
  date DATE NOT NULL,
  category VARCHAR(255) NOT NULL,
  odds DOUBLE NOT NULL,
  status VARCHAR(255) NOT NULL,
  FK_sport INT(11) DEFAULT NULL,
  PRIMARY KEY (PK_available_bets)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


ALTER TABLE brakingpoint.available_bets
  ADD CONSTRAINT FK_sport FOREIGN KEY (PK_sport)
    REFERENCES brakingpoint.sports(PK_sport);


CREATE TABLE brakingpoint.tickets (
  PK_ticket INT(11) NOT NULL AUTO_INCREMENT,
  status VARCHAR(255) NOT NULL,
  debt INT(11) NOT NULL,
  sum_odds DOUBLE NOT NULL,
  races VARCHAR(255) NOT NULL,
  payment_date DATE DEFAULT NULL,
  FK_user INT(11) NOT NULL,
  FK_bets INT(11) NOT NULL,
  PRIMARY KEY (PK_ticket)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

ALTER TABLE brakingpoint.tickets
  ADD CONSTRAINT FK_user FOREIGN KEY (PK_user)
  ADD CONSTRAINT FK_bets FOREIGN KEY (PK_available_bets)
    REFERENCES brakingpoint.users(PK_user)
    REFERENCES brakingpoint.available_bets(PK_available_bets);
