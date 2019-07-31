USE SnakesAndLadder;

drop function if exists GeneratingRandomNumber;
DELIMITER //

CREATE FUNCTION GeneratingRandomNumber( pRange INT) RETURNS INT
DETERMINISTIC 
BEGIN
  DECLARE lcRollDice int;
  SET lcRollDice =  round(RAND() * (pRange -1)) + 1;
  RETURN lcRollDice;

END//
DELIMITER ;

select GeneratingRandomNumber(6);
