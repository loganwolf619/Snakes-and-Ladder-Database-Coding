USE SnakesAndLadder;

drop procedure if exists JoinGame;
DELIMITER //

CREATE PROCEDURE JoinGame(pGameID int, pUsername varchar(50))
BEGIN

declare GameStatus varchar (50);
declare countGame int;
declare countExistingPlayer int;
declare colorPlayer varchar (10);
declare countPlayingGame int;

select count(GameID) 
from Game 
where GameID = pGameID
into countGame;

	if countGame = 1 then   -- if the game exists or not, if the game exists it will run the game accordingly.
		select StatusOfGame, NumberOfPlayer 
		from Game 
		where GameID = pGameID
		into GameStatus, countExistingPlayer;
        
		if countExistingPlayer > 5 then -- it counts the number of players
			select 'Maximum number of Player has reached' as message;
		elseif GameStatus = 'Waiting to Start' or GameStatus = 'Running' then
        
			select count(Username) -- how many players are in the game
			from Account
			where Username = pUsername 
			into countPlayingGame;
            
			update Player
			set ColorOfPlayer = 
			CASE round(Rand() * (5-1)) + 1
				WHEN 1 THEN 'Red'
				WHEN 2 THEN 'Yellow'
				when 3 then 'Green'
				when 4 then 'Blue'
				ELSE 'None'
			END
			where Username = pUsername and GameID = pGameID;
				update Game
				set NumberOfPlayer = countPlayingGame + 1
				where GameID = pGameID;  
			end if;
		end if;

END //
DELIMITER ;
call JoinGame (3021, 'Milton619');

 select * from Player 
where Username = 'Milton619';
