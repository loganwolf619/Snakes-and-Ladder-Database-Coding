USE SnakesAndLadder;

drop procedure if exists CreateGame;
DELIMITER //

CREATE PROCEDURE CreateGame(pUsername varchar(50), pGameID int)
BEGIN
START TRANSACTION;
	Select count(GameID)
	from Game
	where Username = pUsername and GameID = pGameID
	into @countGameID;
    
	if @countGameID = 1 then
		Select 'The game already exists' as message;
	else
        insert into Game (GameID, Username, StatusOfGame, DatePlayed)
		values (pGameID, pUsername, 'Running', SysDate());  
		call CountPlayerSetColor (pUsername, pGameID);
    end if;
commit;
END //
DELIMITER ;
call CreateGame("Fienza781", 3030);
select * from Game
where GameID = '3030';
Select * from Game;
