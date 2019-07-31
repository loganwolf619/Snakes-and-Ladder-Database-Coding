USE SnakesAndLadder;

drop procedure if exists GenerateColorForPlayer;
DELIMITER //

CREATE PROCEDURE GenerateColorForPlayer
	(pUsername varchar (50), pGameID int, pObstacleName varchar (10), pTokenID int, pColorNumberRange int)
BEGIN
	DECLARE lcColorGenerator int;
    DECLARE lcColor varchar (10);
	if lcColorGenerator = 1 then 
        Select ColorOfPlayer from Player
        where lcColor = ColorOfPlayer;
        
		set lcColorGenerator =  round(RAND() * (pColorNumberRange -1)) + 1;
		
			if lcColorGenerator = 1 then 
				Select ColorOfPlayer from Player
				where lcColor = ColorOfPlayer = 'Red';
		   else if lcColorGenerator = 2 then 
				Select ColorOfPlayer from Player
				where lcColor = ColorOfPlayer = 'Blue';
			else if lcColorGenerator = 3 then 
				Select ColorOfPlayer from Player
				where lcColor = ColorOfPlayer = 'Green';
			else if lcColorGenerator = 4 then 
				Select ColorOfPlayer from Player
				where lcColor = ColorOfPlayer = 'Yellow';
                
                insert into Player (Username, ColorOfColor, GameID, TokenD, ObstacleName)
                values (pUsername, lcColor, pGameID, pTokenID, pObstacleName);
              
              
			end if;
			end if;
            end if;
            end if;
            end if;
          
END //
DELIMITER ;

call GenerateColorForPlayer ('Milton619', 3022, 'Ladder', 1, 5);
select * from Player 
where Username = 'Milton619';