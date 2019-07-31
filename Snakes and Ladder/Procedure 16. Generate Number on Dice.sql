USE SnakesAndLadder;
drop procedure if exists GenerateNumberOnDice;

DELIMITER //
SET autocommit = 0;
CREATE PROCEDURE GenerateNumberOnDice(pUsername varchar (50), pGameID int)
BEGIN
declare lcRollDice int;
   -- DECLARE exit handler for sqlexception
-- 	BEGIN
--       ROLLBACK;
--       
--       -- SHOW ERRORS LIMIT 1 ;
--       CALL DIAGNOSTIC('GenerateNumberOnDice');
--     END;

--     DECLARE exit handler for sqlwarning
-- 	BEGIN
--      ROLLBACK;
--      SHOW WARNINGS LIMIT 1;
--     END;
START TRANSACTION;
	SET lcRollDice = floor(RAND() * (6-1+1)) + 1; 
		
	Update Game
	set NumberOnDice = lcRollDice
	where Username = pUsername and GameID = pGameID;
			
	Select NumberOnDice
	from Game
	where pUsername = Username;
commit;
END //
DELIMITER ;
call GenerateNumberOnDice ('Milton619', 3021);

