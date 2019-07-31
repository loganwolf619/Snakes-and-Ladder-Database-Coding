USE SnakesAndLadder;

drop procedure if exists EnteringCorrectGame;
DELIMITER //

CREATE PROCEDURE EnteringCorrectGame(pGameID int)
BEGIN
Declare lcGameStatus varchar (20);
Declare lcPlayerNumber int;
Declare lcColor varchar (20);

Select StatusOfGame
from Game
where GameID = pGameID 
into lcGameStatus;



if lcGameStatus = 'Running'  then
	Select 'Check the total number of players in that game' as message;
    
    Select NumberOfPlayer
		from Game
		where GameID = pGameID 
		into lcPlayerNumber;
    
    if lcPlayerNumber >= 1 and lcPlayerNumber <= 6 then 
		Update Game
		Set NumberOfPlayer = NumberOfPlayer + 1 
        WHERE GameID = pGameID;
	
	Select PlayerColor
		from GamePlayToken
		where GameID = pGameID
		into lcColor;
     if lcColor != 'Red' then 
		Update GamePlayToken
		Set PlayerColor =  'Yellow'
        WHERE GameID = pGameID;
	end if;
else
	Select 'Please Enter the correct Running GameID' as message;
end if;
end if;
END//
DELIMITER ;