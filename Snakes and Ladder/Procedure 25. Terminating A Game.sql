USE SnakesAndLadder;

drop procedure if exists TerminatingAGame;
DELIMITER //

CREATE PROCEDURE TerminatingAGame(pGameID int, pUsername varchar(50))
BEGIN

declare statusGame varchar (50);
declare playerScore int;
START TRANSACTION;
	SELECT StatusOfGame
	from Game
	where GameID = pGameID
	into statusGame;

	if statusGame = 'Running' then
		Select GameScore from Game
        where GameID = pGameID
        into playerScore;
        
        update Game
        set GameScore = playerScore, StatusOfGame = 'Terminated'
        where GameID = pGameID;
        
                call UpdatingGamePlayed(pGameID,pUsername);

        SELECT 'Game is Terminated' as message;
	else
		select 'The game doesnt exist. Please enter a valid game to be Terminated' as message;

	end if;

END //
DELIMITER ;
call TerminatingAGame(3021, 'Milton619');
select * from Game
where GameID = '3021';
