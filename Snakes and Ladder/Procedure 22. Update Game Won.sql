USE SnakesAndLadder;

drop procedure if exists UpdateGameWon;
DELIMITER //
CREATE PROCEDURE UpdateGameWon(pUsername varchar(50), pGameID int)
BEGIN
        
Select PlayerScore 
from Player 
where Username = pUsername and GameID = pGameID
into @Score;


Update Game 
Set GameScore = @Score
where GameID = pGameID and Username = pUsername; 

Select TotalGameWon 
from Account
where Username = pUsername
into @GameWon;

Update Account
Set TotalGameWon = @GameWon + 1
where Username = pUsername;

END //
DELIMITER ;
call UpdateGameWon('Milton619', 3021);
select * from Account
where Username = 'Milton619';