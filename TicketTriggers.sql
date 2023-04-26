CREATE DEFINER=`root`@`localhost` TRIGGER brakingpoint.deductDebt
	AFTER INSERT
	ON brakingpoint.tickets
	FOR EACH ROW
BEGIN
  DECLARE user_balance DECIMAL(10,2);
    SELECT balance INTO user_balance FROM users WHERE userID = NEW.userID;
    IF user_balance >= NEW.debt THEN
        UPDATE users SET balance = balance - NEW.debt WHERE userID = NEW.userID;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient balance';
    END IF;
END;
CREATE DEFINER=`root`@`localhost` TRIGGER brakingpoint.bet_status_update_trigger
	AFTER UPDATE
	ON brakingpoint.available_bets
	FOR EACH ROW
BEGIN
  IF NEW.status <> OLD.status THEN
    UPDATE tickets SET status = NEW.status WHERE betID = NEW.available_betID;
  END IF;
END;
CREATE DEFINER=`root`@`localhost` TRIGGER ticket_update
AFTER UPDATE ON tickets
FOR EACH ROW
BEGIN
   IF (NEW.status <> OLD.status) THEN
      UPDATE users 
      SET balance = balance + (NEW.sum_odds * NEW.debt)
      WHERE userID = NEW.userID;
   END IF;
END