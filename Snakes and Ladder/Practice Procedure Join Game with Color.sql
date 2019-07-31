USE SnakesAndLadder;

drop procedure if exists JoinGameColor;
DELIMITER //

CREATE PROCEDURE JoinGameColor(pGameID int, pUsername varchar(50))
BEGIN

declare GameStatus varchar (50);
declare countGame int;
declare countExistingPlayer int;
declare playerToken varchar (100);
declare TurnPlayer varchar (10);
declare colorPlayer varchar (10);
declare countPlayingGame int;
  
START TRANSACTION;
	select count(GameID) 
	from Game 
	where GameID = pGameID
	into countGame;

		if countGame = 1 then
			set TurnPlayer = 'Disable';
			select StatusOfGame, NumberOfPlayer 
			from Game 
			where GameID = pGameID
			into GameStatus, countExistingPlayer;
				
			if countExistingPlayer = 4 then
				select 'Maximum number of Player has reached' as message;
			elseif GameStatus = 'Waiting to Start' or GameStatus = 'Running' then
				select count(Username) 
				from Game
				where GameID = pGameID and Username = pUsername 
				into countPlayingGame;
				
				if countPlayingGame = 1 then
					SELECT 'This game has been selected before. Please select another game' as message;
				else
					Call CountPlayerSetColor(pUsername, pGameID);
				end if;
			end if;
		end if;
         
END //
DELIMITER ;
call JoinGameColor (3021, 'Milton619');