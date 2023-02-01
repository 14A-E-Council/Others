CREATE DATABASE brakingpoint
	CHARACTER SET utf8
	COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.users (
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


CREATE TABLE brakingpoint.sports (
  sportID INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (sportID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.teams (
  teamID INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  sportID INT(11) NOT NULL,
  PRIMARY KEY (teamID),
  UNIQUE INDEX sportID(sportID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.competitors (
  competitorID INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  teamID INT(11) NOT NULL,
  PRIMARY KEY (competitorID),
  UNIQUE INDEX teamID(teamID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.available_bets (
  available_betID INT(11) NOT NULL AUTO_INCREMENT,
  date DATE NOT NULL,
  category VARCHAR(255) NOT NULL,
  odds DOUBLE NOT NULL,
  status VARCHAR(255) NOT NULL,
  sportID INT(11) DEFAULT NULL,
  PRIMARY KEY (available_betID),
  UNIQUE INDEX sportID(sportID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.tickets (
  ticketID INT(11) NOT NULL AUTO_INCREMENT,
  status VARCHAR(255) NOT NULL,
  debt INT(11) NOT NULL,
  sum_odds DOUBLE NOT NULL,
  races VARCHAR(255) NOT NULL,
  payment_date DATE DEFAULT NULL,
  userID INT(11) NOT NULL,
  PRIMARY KEY (ticketID),
  UNIQUE INDEX userID(userID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;
    

CREATE TABLE brakingpoint.connection_user_sport (
  connectionID INT(11) NOT NULL AUTO_INCREMENT,
  sportID INT(11) NOT NULL,
  userID INT(11) NOT NULL,
  PRIMARY KEY (connectionID),
  UNIQUE INDEX userID(userID),
  UNIQUE INDEX sportID(sportID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.connection_available_bet_ticket (
  connectionID INT(11) NOT NULL AUTO_INCREMENT,
  available_betID INT(11) NOT NULL,
  ticketID INT(11) NOT NULL,
  PRIMARY KEY (connectionID),
  UNIQUE INDEX available_betID(available_betID),
  UNIQUE INDEX ticketID(TicketID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


ALTER TABLE brakingpoint.users 
  ADD CONSTRAINT FK_users_connection_user_sport FOREIGN KEY (userID)
    REFERENCES brakingpoint.connection_user_sport(userID);
    
    
ALTER TABLE brakingpoint.sports 
  ADD CONSTRAINT FK_sports_connection_user_sport FOREIGN KEY (sportID)
    REFERENCES brakingpoint.connection_user_sport(sportID);


ALTER TABLE brakingpoint.teams
  ADD CONSTRAINT FK_sport_team FOREIGN KEY (sportID)
    REFERENCES brakingpoint.sports(sportID);
    
    
ALTER TABLE brakingpoint.competitors
  ADD CONSTRAINT FK_team_competitor FOREIGN KEY (teamID)
    REFERENCES brakingpoint.teams(teamID);
    
    
ALTER TABLE brakingpoint.available_bets
  ADD CONSTRAINT FK_sport_available_bets FOREIGN KEY (sportID)
    REFERENCES brakingpoint.sports(sportID);
   
ALTER TABLE brakingpoint.available_bets 
  ADD CONSTRAINT FK_available_bets_connection_available_bet_ticket FOREIGN KEY (available_betID)
    REFERENCES brakingpoint.connection_available_bet_ticket(available_betID);

    
ALTER TABLE brakingpoint.tickets
  ADD CONSTRAINT FK_user_ticket FOREIGN KEY (userID)
    REFERENCES brakingpoint.users(userID);
    
ALTER TABLE brakingpoint.tickets 
  ADD CONSTRAINT FK_tickets_connection_available_bet_ticket FOREIGN KEY (ticketID)
    REFERENCES brakingpoint.connection_available_bet_ticket(ticketID);

