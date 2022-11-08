ALTER TABLE brakingpoint.availablebets
  ADD FOREIGN KEY (sportID) REFERENCES brakingpoint.sports (sportID)