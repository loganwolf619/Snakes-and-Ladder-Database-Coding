USE SnakesAndLadder;

drop procedure if exists CheckingSnakesAndLadder;
DELIMITER //

CREATE PROCEDURE CheckingSnakesAndLadder(pTokenID int, pUsername varchar(50), pGameID int)
BEGIN
declare diceNumber int;
declare TurnPlayer varchar (10);
declare playerLocation int;
 
START TRANSACTION;
	Select NumberOnDice 
	from Game
	where GameID = pGameID
	into diceNumber;

	update GamePlayToken
	set LocationNumber = LocationNumber + diceNumber
	where TokenID = pTokenID;

	call MovePlayer(pTokenID, pGameID, pUsername);
	if diceNumber = 6 then
		call GenerateNumberOnDice(pUsername, pGameID);
		call PlayerTurn (pTokenID, pUsername, pGameID);
		
	end if;

END //
DELIMITER ;
call CheckingSnakesAndLadder(1, 'Milton619', 3021);
