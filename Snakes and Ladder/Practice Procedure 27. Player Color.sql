USE SnakesAndLadder;

drop procedure if exists PlayerColor;
DELIMITER //

CREATE PROCEDURE PlayerColor(pGameID int, pUsername varchar(50))
BEGIN

update Player
set ColorOfPlayer = 
CASE round(Rand() * (4-1)) + 1
    WHEN 0 THEN 'Red'
    WHEN 1 THEN 'Yellow'
    when 2 then 'Green'
    when 3 then 'Blue'
    ELSE 'None'
END
where Username = pUsername and GameID = pGameID;
END //
DELIMITER ;
call PlayerColor(3021, 'Milton619');

select * from Player 
where Username = 'Milton619';
