USE SnakesAndLadder;
drop procedure if exists UpdatePlayerPosition;
DELIMITER //

CREATE PROCEDURE UpdatePlayerPosition(pUsername varchar(50), pGameID int)
begin
declare lclocation int;
declare lcstartPosition int;

START TRANSACTION;
Select Username from Player 
where Username = pUsername and GameID = pGameID;
set lclocation = (floor(RAND() * (6-1+1)) + 1);
if lclocation > 0  then

	Select PlayerStartPosition from Player
	where Username = pUsername and GameID = pGameID
	into lcstartPosition;
    
	update Player
	set PlayerEndPosition = lcstartPosition + lclocation
	where Username = pUsername and GameID = pGameID;
  else
	Select 'Winner' as message;
end if; 
commit;

	END //
DELIMITER ;
Call UpdatePlayerPosition('Miles87T', 3024);
Select * from Player
where Username = 'Miles87T';