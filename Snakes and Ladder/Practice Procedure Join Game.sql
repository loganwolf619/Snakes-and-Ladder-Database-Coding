USE SnakesAndLadder;

drop procedure if exists JoinGame;
DELIMITER //

CREATE PROCEDURE JoinGame(pGameID int, pUsername varchar(50))
BEGIN

declare GameStatus varchar (50);
declare countGame int;
declare countExistingPlayer int;
declare turnPlayer int;
declare playerToken varchar (100);
declare colorPlayer varchar (10);
declare countPlayingGame int;
declare scoreofPlayer int;

select count(GameID) 
from Game 
where GameID = pGameID
into countGame;

	if countGame = 1 then
        set turnPlayer = 1;
		select StatusOfGame, NumberOfPlayer 
		from Game 
		where GameID = pGameID
		into GameStatus, countExistingPlayer;
            
		if countExistingPlayer = 5 then
			select 'Maximum number of Player has reached' as message;
		elseif GameStatus = 'Waiting to Start' or GameStatus = 'Running' then
            
				select count(Username) 
				from Account
				where (GameID = pGameID) and (Username = pUsername)   
				into countPlayingGame;
                
				
				update Game
				set NumberOfPlayer = countPlayingGame + 1
				where GameID = pGameID;
					
				insert into Player (Username, GameID, PlayerTurn)
				values (pUsername, pGameID, turnPlayer);
				
			   
			elseif 
				GameStatus = 'Finished' then
				select 'Game Is over' as message;
			else 
				Select 'Game is terminated' as message;
			end if;
		else
			select 'Invalid GameID' as message;
		end if;
END //
DELIMITER ;
call JoinGame(3021, 'Milton619');