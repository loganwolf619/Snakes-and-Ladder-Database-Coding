USE SnakesAndLadder;

drop procedure if exists UpdatingGamePlayed;
DELIMITER //

CREATE PROCEDURE UpdatingGamePlayed(pGameID int, pUsername varchar(50))
BEGIN

Select CurrentTurn 
	from Game where Username = pUsername and GameID = pGameID
	into @GamePlayed;
	
	Update Game
	set CurrentTurn = @GamePlayed 
	where Username = pUsername and GameID = pGameID;
	
	Select TotalGamePlayed
	from Account
	where Username = pUsername
	into @TotalPlayed;
	
	Update Account
	set TotalGamePlayed = @TotalPlayed + 1
	where Username = pUsername;
	
END //
DELIMITER ;
call UpdatingGamePlayed(3021, 'Milton619');
select * from Account
where Username = 'Milton619';