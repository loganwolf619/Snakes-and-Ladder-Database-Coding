USE SnakesAndLadder;

drop procedure if exists PlayerTurn;
DELIMITER //
SET autocommit = 0;
CREATE PROCEDURE PlayerTurn(pTokenID int, pUsername varchar(50), pGameID int)
BEGIN
declare diceNumber int;
declare TurnPlayer varchar (10);
declare playerLocation int;
   DECLARE exit handler for sqlexception
	BEGIN
      ROLLBACK;
      
      -- SHOW ERRORS LIMIT 1 ;
      CALL DIAGNOSTIC('PlayerTurn');
    END;

    DECLARE exit handler for sqlwarning
	BEGIN
     ROLLBACK;
     SHOW WARNINGS LIMIT 1;
    END;
START TRANSACTION;
	Select NumberOnDice 
	from Game
	where GameID = pGameID
	into diceNumber;

	update GamePlayToken
	set LocationNumber = LocationNumber + diceNumber
	where TokenID = pTokenID;

	if diceNumber = 6 then
		call GenerateNumberOnDice(pUsername, pGameID);
		call PlayerTurn (pTokenID, pUsername, pGameID);
	end if;
commit;
END //
DELIMITER ;
call PlayerTurn(1, 'Milton619', 3021);
select * from GamePlayToken
where Username = 'Milton619';
