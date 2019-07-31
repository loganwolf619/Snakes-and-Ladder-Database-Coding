USE SnakesAndLadder;

drop procedure if exists AdminListingAllGames;
DELIMITER //
SET autocommit = 0;
Create procedure AdminListingAllGames ()
BEGIN
   -- DECLARE exit handler for sqlexception
-- 	BEGIN
--       ROLLBACK;
--       
--       -- SHOW ERRORS LIMIT 1 ;
--       CALL DIAGNOSTIC('AdminListingAllGames');
--     END;

--     DECLARE exit handler for sqlwarning
-- 	BEGIN
--      ROLLBACK;
--      SHOW WARNINGS LIMIT 1;
--     END;
START TRANSACTION;
	SELECT GameID, NumberOfPlayer, StatusOfGame, AccountStatus
		FROM Game
		JOIN Account
		ON Account.Username = Game.Username
		order by GameID;
commit;
END //
DELIMITER ;
Call AdminListingAllGames();
