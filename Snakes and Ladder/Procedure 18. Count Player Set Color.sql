USE SnakesAndLadder;
drop procedure if exists CountPlayerSetColor;
DELIMITER //
CREATE PROCEDURE CountPlayerSetColor(pUsername varchar(50), pGameID int)
begin
START TRANSACTION;
	Select count(NumberOfPlayer) from Game
	where GameID = pGameID and Username = pUsername
	into @countPlayer;
    
    if @countPlayer = 1 then
		Select ColorOfPlayer from Player
		where Username = pUsername and GameID = pGameID
		into @playerColor;
		
        Set @playerColor = 'Red';
		Update Player
        Set ColorOfPlayer = @playerColor
        where Username = pUsername and GameID = pGameID;
        
	elseif @countPlayer = 2 then
		Select ColorOfPlayer from Player
		where Username = pUsername and GameID = pGameID
		into @playerColor;
		
        Set @playerColor = 'Blue';
		Update Player
        Set ColorOfPlayer = @playerColor
        where Username = pUsername and GameID = pGameID;
        
	elseif @countPlayer = 3 then
		Select ColorOfPlayer from Player
		where Username = pUsername and GameID = pGameID
		into @playerColor;
		
        Set @playerColor = 'Green';
		Update Player
        Set ColorOfPlayer = @playerColor
        where Username = pUsername and GameID = pGameID;
  	elseif @countPlayer = 4 then
		Select ColorOfPlayer from Player
		where Username = pUsername and GameID = pGameID
		into @playerColor;
		
        Set @playerColor = 'Yellow';
		Update Player
        Set ColorOfPlayer = @playerColor
        where Username = pUsername and GameID = pGameID;      
	end if;
commit;
	END //
DELIMITER ;
Call CountPlayerSetColor('Banther6126', 3028);
Select * from Player;
