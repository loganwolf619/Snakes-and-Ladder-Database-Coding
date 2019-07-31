USE SnakesAndLadder;

drop procedure if exists OrderListOfGames;
DELIMITER //
SET autocommit = 0;
CREATE PROCEDURE OrderListOfGames()
BEGIN
   -- DECLARE exit handler for sqlexception
-- 	BEGIN
--       ROLLBACK;
--       
--       -- SHOW ERRORS LIMIT 1 ;
--       CALL DIAGNOSTIC('OrderListOfGames');
--     END;

--     DECLARE exit handler for sqlwarning
-- 	BEGIN
--      ROLLBACK;
--      SHOW WARNINGS LIMIT 1;
--     END;
START TRANSACTION;
	select Username, GameID, NumberOfPlayer
	from Game
	order by Username asc;
commit;
END //
DELIMITER ;
call OrderListOfGames();