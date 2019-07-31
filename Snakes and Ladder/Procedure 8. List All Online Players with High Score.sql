USE SnakesAndLadder;

drop procedure if exists ListAllOnlinePlayers;
DELIMITER //

Create procedure ListAllOnlinePlayers (pStatus varchar(10))
BEGIN

START TRANSACTION;
Select AccountStatus from Account
where AccountStatus = pStatus;
	if pStatus = 'Online' or 'Playing' then
		SELECT Username, HighScore
		FROM ACCOUNT
		WHERE AccountStatus = pStatus
		order  by Username and HighScore;
	end if;
commit;
END //
DELIMITER ;
call ListAllOnlinePlayers('Online');
