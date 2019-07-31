USE SnakesAndLadder;

drop procedure if exists AddingPlayer;
DELIMITER //
SET autocommit = 0;
CREATE PROCEDURE AddingPlayer(pGameID int, pUsername varchar(50))
BEGIN

declare playerNumber int;
declare countUsername int;
declare countExistingPlayer int;
declare GameStatus varchar (50);
declare countGame int;
   DECLARE exit handler for sqlexception
	BEGIN
      ROLLBACK;
      
      -- SHOW ERRORS LIMIT 1 ;
      CALL DIAGNOSTIC('AddingPlayer');
    END;

    DECLARE exit handler for sqlwarning
	BEGIN
     ROLLBACK;
     SHOW WARNINGS LIMIT 1;
    END;
START TRANSACTION;
	select count(GameID) 
	from Game 
	where GameID = pGameID
	into countGame;
	
	if 	countGame = 1 then   -- if the game exists or not, if the game exists it will run the game accordingly.
		select StatusOfGame, NumberOfPlayer 
		from Game 
		where GameID = pGameID
		into GameStatus, countExistingPlayer;
	
		select count(Username)
		from Game
		where Username = pUsername
		into countUsername;

		if 	countUsername > 5 then
			Select GameID from Game
			where GameID = pGameID
			into playerNumber;
			
            Select PlayerNumber from Game
            where playerNumber = PlayerNumber + 1
            into playerNumber;
            
			Update Game
			set NumberOfPlayer = playerNumber
			where GameID = pGameID;
		else
			Select 'The Number of Player is more than 4. Please Join another Game' as message;
		end if;
	end if;
commit;
END //
DELIMITER ;
call AddingPlayer(3021, 'Daniel452');
select * from Game
where GameID = '3021';