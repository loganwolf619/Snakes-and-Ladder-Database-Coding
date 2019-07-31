USE SnakesAndLadder;

drop procedure if exists MovePlayer;
DELIMITER //
CREATE PROCEDURE MovePlayer(pTokenID int, pGameID int, pUsername varchar(50))
BEGIN

declare lcRollResult int;
declare lcLocation int;
declare lcObstacleEnd int;
declare lcCountObstacleStart int;
   
START TRANSACTION;
     select LocationNumber
     from GamePlayToken
     where TokenID = pTokenID and GameID = pGameID
     into lcLocation;

	SET lcRollResult = floor(RAND() * (6-1+1)) + 1; 
	if lcLocation + lcRollResult >= 100 then
		call UpdateGameWon(pUsername,pGameID);
	   Select 'The Player Won the Game' as message;
       
	else
		Update GamePlayToken
		set LocationNumber = LocationNumber + lcRollResult
		where TokenID = pTokenID;
        
		Select ObstacleEndPosition
		from SnakeLadder
		where ObstacleStartPosition = lcLocation + lcRollResult
		into lcObstacleEnd;
		if lcObstacleEnd is not null then
          Update GamePlayToken
		  set LocationNumber =lcObstacleEnd
		  where TokenID = pTokenID;
        end if;
		
       select 'player moved' as message;
	end if;
    


END //
DELIMITER ;
call MovePlayer(1, 3021, 'Milton619');
select * from Player
where Username = 'Milton619';

