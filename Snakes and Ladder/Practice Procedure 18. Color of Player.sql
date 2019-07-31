USE SnakesAndLadder;

drop procedure if exists ColorOfPlayer;
DELIMITER //

CREATE PROCEDURE ColorOfPlayer(pGameID int, pUsername varchar(50))
BEGIN

declare GameStatus varchar (50);
declare countGame int;
declare countExistingPlayer int;
declare colorPlayer varchar (10);
declare countPlayingGame int;
declare scoreofPlayer int;
DECLARE lcColor varchar (10);

select count(GameID) 
from Game 
where GameID = pGameID
into countGame;

	if countGame = 1 then
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
            
			if round(Rand() * (4-1)) + 1 = 1 then 
				update Player 
				set ColorOfPlayer = 'Blue'
				where Username = pUsername and GameID = pGameID;
		   elseif round(Rand() * (4-1)) + 1 = 2 then 
				update Player 
				set ColorOfPlayer = 'Red'
				where Username = pUsername and GameID = pGameID;
			elseif round(Rand() * (4-1)) + 1 = 3 then 
				update Player 
				set ColorOfPlayer = 'Green'
                where Username = pUsername and GameID = pGameID;
			elseif round(Rand() * (4-1)) + 1 = 4 then 
				update Player 
				set ColorOfPlayer = 'Blue'
                where Username = pUsername and GameID = pGameID;
                
				update Game
				set NumberOfPlayer = countPlayingGame + 1
				where GameID = pGameID;
                
				insert into Player (Username, GameID, PlayerTurn, ColorOfPlayer,PlayerScore)
				values (pUsername, pGameID, turnPlayer, lcColor, scoreofPlayer);
                
			end if;
		end if;
    end if;

END //
DELIMITER ;
call ColorOfPlayer (3021, 'Milton619');

 select * from Player 
where Username = 'Milton619';
