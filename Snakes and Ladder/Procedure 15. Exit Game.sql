/USE SnakesAndLadder;

drop procedure if exists ExitGame;
DELIMITER //

CREATE PROCEDURE ExitGame(pGameID int, pUsername varchar(50), pHighScore int, pTotalGamePlayed int, pTotalGameWon int, pGameWon varchar(10))
BEGIN	
START TRANSACTION;  
Select * from Account
where Username = pUsername;      
		update Account 
		set AccountStatus = 'Online', 
										HighScore = CASE when pHighScore > HighScore THEN pHighScore 
														 when pHighScore <= HighScore THEN HighScore
														 end,
										TotalGameWon = CASE when pGameWon = 'Yes' then TotalGameWon + 1
															when pGameWon = 'No' then TotalGameWon
                                                            when TotalGameWon is null and pGameWon = 'Yes' then 1
                                                            when TotalGameWon is null and pGameWon = 'No' then 0
															end,
										TotalGamePlayed = TotalGamePlayed + 1
		where Username = pUsername;
	
commit;
END //
DELIMITER ;
call ExitGame (3021, 'Milton619', 70, 2, 1, 'No');
select *  from Account 
where Username = 'Milton619';


