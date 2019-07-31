USE SnakesAndLadder;

drop procedure if exists GenerateNumberOnDice;
DELIMITER //

CREATE PROCEDURE GenerateNumberOnDice(pUsername varchar (50), pGameID int, pRange int)
BEGIN
		DECLARE lcRollDice int;
		SET lcRollDice =  round(RAND() * (pRange -1)) + 1;
		
		

		Insert into GamePlayToken (Username, GameID, NumberOnDice)
		values (pUsername, pGameID, lcRollDice);
			


END //
DELIMITER ;
Select * from GamePlayToken where Username = 'Milton619';