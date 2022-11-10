CREATE TABLE brakingpoint.competitors (
  competitorID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  teamID INT(11) UNSIGNED NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (competitorID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.availablebets (
  availableBetsID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  sportID INT(11) UNSIGNED NOT NULL,
  date DATETIME NOT NULL,
  category VARCHAR(255) NOT NULL,
  odds INT(11) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (availableBetsID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.news (
  newsID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  sportID INT(11) UNSIGNED NOT NULL,
  uploadDate DATETIME NOT NULL,
  updateDate DATETIME DEFAULT NULL,
  content TEXT NOT NULL,
  type TINYINT(1) NOT NULL,
  title VARCHAR(100) NOT NULL,
  author VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (newsID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.previousbets (
  previous_betsID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  userID INT(11) UNSIGNED NOT NULL,
  date DATETIME NOT NULL,
  bet INT(11) UNSIGNED NOT NULL,
  odds INT(11) UNSIGNED NOT NULL,
  amount INT(11) UNSIGNED NOT NULL DEFAULT 1,
  endResult TINYINT(1) NOT NULL,
  PRIMARY KEY (previous_betsID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci,
COMMENT = 'bet foreign key?? minimum felrakott összeg eldöntése';

CREATE TABLE brakingpoint.profiles (
  userID INT(11) UNSIGNED NOT NULL,
  profilePicture VARCHAR(255) DEFAULT NULL,
  selectedColorPalette INT(11) UNSIGNED NOT NULL DEFAULT 0,
  pictureFrame VARCHAR(255) DEFAULT NULL,
  rank INT(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (userID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci,
COMMENT = 'Profilképhez és képkerethez default képet állítani';

CREATE TABLE brakingpoint.sports (
  sportID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  description VARCHAR(255) DEFAULT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (sportID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.teams (
  teamID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  sportID INT(11) UNSIGNED NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (teamID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.users (
  userID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) DEFAULT NULL,
  firstName VARCHAR(255) DEFAULT NULL,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  balance INT(11) UNSIGNED NOT NULL DEFAULT 0,
  registrationDate DATETIME NOT NULL,
  prefferedCategory INT(11) NOT NULL DEFAULT 0,
  level INT(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (userID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.users_sports_relationship (
  relationID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  userID INT(11) UNSIGNED NOT NULL,
  sportID INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (relationID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.payments (
  userID INT(11) UNSIGNED NOT NULL,
  date DATETIME NOT NULL,
  amount INT(11) UNSIGNED NOT NULL,
  status INT(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (userID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.availablebets_tickets_relationship (
  relationID INT(11) UNSIGNED NOT NULL,
  ticketID INT(11) UNSIGNED NOT NULL,
  availablebetID INT(11) UNSIGNED NOT NULL
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

ALTER TABLE brakingpoint.availablebets_tickets_relationship 
  ADD CONSTRAINT availablebets_tickets_relationship_ibfk_2 FOREIGN KEY (ticketID)
    REFERENCES brakingpoint.tickets(ticketID);

ALTER TABLE brakingpoint.availablebets_tickets_relationship 
  ADD CONSTRAINT tickets_availablebets_relationship_ibfk_2 FOREIGN KEY (availableBetsID)
    REFERENCES brakingpoint.availablebets(availableBetsID);

ALTER TABLE brakingpoint.payments 
  ADD CONSTRAINT FK_payments_users_userID FOREIGN KEY (userID)
    REFERENCES brakingpoint.users(userID) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE brakingpoint.previousbets 
  ADD CONSTRAINT previousbets_ibfk_1 FOREIGN KEY (userID)
    REFERENCES brakingpoint.users(userID);

ALTER TABLE brakingpoint.profiles 
  ADD CONSTRAINT FK_profiles_users_userID FOREIGN KEY (userID)
    REFERENCES brakingpoint.users(userID) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE brakingpoint.teams 
  ADD CONSTRAINT teams_ibfk_1 FOREIGN KEY (sportID)
    REFERENCES brakingpoint.sports(sportID);

ALTER TABLE brakingpoint.users_sports_relationship 
  ADD CONSTRAINT users_sports_relationship_ibfk_1 FOREIGN KEY (userID)
    REFERENCES brakingpoint.users(userID);

ALTER TABLE brakingpoint.users_sports_relationship 
  ADD CONSTRAINT users_sports_relationship_ibfk_2 FOREIGN KEY (sportID)
    REFERENCES brakingpoint.sports(sportID);

ALTER TABLE brakingpoint.news 
  ADD CONSTRAINT news_ibfk_1 FOREIGN KEY (sportID)
    REFERENCES brakingpoint.sports(sportID);

ALTER TABLE brakingpoint.availablebets 
  ADD CONSTRAINT availablebets_ibfk_1 FOREIGN KEY (sportID)
    REFERENCES brakingpoint.sports(sportID);

ALTER TABLE brakingpoint.competitors 
  ADD CONSTRAINT competitors_ibfk_1 FOREIGN KEY (teamID)
    REFERENCES brakingpoint.teams(teamID);