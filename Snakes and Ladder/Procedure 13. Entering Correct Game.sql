USE SnakesAndLadder;

drop procedure if exists EnteringCorrectGame;
DELIMITER //

CREATE PROCEDURE EnteringCorrectGame(pGameID int, pUsername varchar(50))
BEGIN
START TRANSACTION;
	Select StatusOfGame from Game 
    where GameID = pGameID
    into @gameStatus;
    
    if @gameStatus = 'Running' then
		Select NumberOfPlayer from Game
		where GameID = pGameID
		into @totalPlayers;
    
		if @totalPlayers > 4 then
			Select 'Maximum 4 players can play the game. So, please enter new GameID to join the game' as message;
		else
			call CountPlayerSetColor(pUserame, pGameID);
			Select 'The Player can enter the game' as message;
    
		end if;
    end if;
commit;
END//
DELIMITER ;
call EnteringCorrectGame(3028, 'Banther6126');
select * from Player;
