CREATE DATABASE IF NOT EXISTS brakingpoint
	CHARACTER SET utf8
	COLLATE utf8_hungarian_ci;

CREATE TABLE brakingpoint.bans (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  bannable_type VARCHAR(255) NOT NULL,
  bannable_id BIGINT(20) UNSIGNED NOT NULL,
  created_by_type VARCHAR(255) DEFAULT NULL,
  created_by_id BIGINT(20) UNSIGNED DEFAULT NULL,
  comment TEXT DEFAULT NULL,
  expired_at TIMESTAMP NULL DEFAULT NULL,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  created_at TIMESTAMP NULL DEFAULT NULL,
  updated_at TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE brakingpoint.bans 
  ADD INDEX bans_bannable_type_bannable_id_index(bannable_type, bannable_id);

ALTER TABLE brakingpoint.bans 
  ADD INDEX bans_created_by_type_created_by_id_index(created_by_type, created_by_id);

ALTER TABLE brakingpoint.bans 
  ADD INDEX bans_expired_at_index(expired_at);




CREATE TABLE brakingpoint.users (
  userID INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) DEFAULT NULL,
  first_name VARCHAR(255) DEFAULT NULL,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  two_factor_secret TEXT DEFAULT NULL,
  two_factor_recovery_codes TEXT DEFAULT NULL,
  two_factor_confirmed_at TIMESTAMP NULL DEFAULT NULL,
  balance INT(11) NOT NULL DEFAULT 0,
  preferred_category VARCHAR(255) DEFAULT NULL,
  level INT(11) NOT NULL DEFAULT 1,
  picture_frame VARCHAR(255) DEFAULT NULL,
  rank INT(11) NOT NULL DEFAULT 0,
  colour_palette VARCHAR(255) DEFAULT NULL,
  updated_at DATETIME NOT NULL,
  created_at DATETIME NOT NULL,
  profile_picture VARCHAR(255) NOT NULL DEFAULT 'default.png',
  xp INT(11) NOT NULL DEFAULT 0,
  admin TINYINT(2) NOT NULL DEFAULT 0,
  email_verified_at DATETIME DEFAULT NULL,
  google_id VARCHAR(255) DEFAULT NULL,
  facebook_id VARCHAR(255) DEFAULT NULL,
  remember_token VARCHAR(255) DEFAULT NULL,
  banned_at DATETIME DEFAULT NULL,
  PRIMARY KEY (userID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 30,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;


CREATE TABLE brakingpoint.sessions (
  id VARCHAR(255) NOT NULL,
  user_id BIGINT(20) UNSIGNED DEFAULT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  payload LONGTEXT NOT NULL,
  last_activity INT(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE brakingpoint.sessions 
  ADD INDEX sessions_user_id_index(user_id);

ALTER TABLE brakingpoint.sessions 
  ADD INDEX sessions_last_activity_index(last_activity);


CREATE TABLE brakingpoint.personal_access_tokens (
  id BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  tokenable_type VARCHAR(255) NOT NULL,
  tokenable_id BIGINT(20) UNSIGNED NOT NULL,
  name VARCHAR(255) NOT NULL,
  token VARCHAR(64) NOT NULL,
  abilities TEXT DEFAULT NULL,
  last_used_at TIMESTAMP NULL DEFAULT NULL,
  expires_at TIMESTAMP NULL DEFAULT NULL,
  created_at TIMESTAMP NULL DEFAULT NULL,
  updated_at TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;

ALTER TABLE brakingpoint.personal_access_tokens 
  ADD UNIQUE INDEX personal_access_tokens_token_unique(token);

ALTER TABLE brakingpoint.personal_access_tokens 
  ADD INDEX personal_access_tokens_tokenable_type_tokenable_id_index(tokenable_type, tokenable_id);


CREATE TABLE brakingpoint.password_resets (
  email VARCHAR(50) DEFAULT NULL,
  token VARCHAR(255) DEFAULT NULL,
  created_at DATETIME DEFAULT NULL
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

ALTER TABLE brakingpoint.password_resets 
  ADD UNIQUE INDEX email(email);


CREATE TABLE brakingpoint.migrations (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  migration VARCHAR(255) NOT NULL,
  batch INT(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;


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
