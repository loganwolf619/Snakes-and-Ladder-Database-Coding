USE SnakesAndLadder;
drop procedure if exists ListAllGames;
DELIMITER //
Create procedure ListAllGames (pStatus varchar(20))
BEGIN

START TRANSACTION;
Select StatusOfGame from Game
where StatusOfGame = pStatus;
	if pStatus = 'Running' then
		SELECT GameID, NumberOfPlayer
		FROM Game
		where StatusOfGame = pStatus
		order by GameID and NumberOfPlayer;
		
	end if;
commit;
END //
DELIMITER ;
Call ListAllGames('Running');
