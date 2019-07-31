DROP DATABASE IF EXISTS transactionExample;
CREATE DATABASE transactionExample;
USE transactionExample;

DROP TABLE IF EXISTS tblPlayer; 
CREATE TABLE tblPlayer(
  PlayerID VARCHAR(255) NOT NULL PRIMARY KEY,
  PassWrd VARCHAR(255) NOT NULL,
  PName VARCHAR(255) NOT NULL,
  Description VARCHAR(255)
  );

SET autocommit = 0;

DELIMITER //
CREATE PROCEDURE DIAGNOSTIC(IN Context VARCHAR(255))
BEGIN
	GET DIAGNOSTICS CONDITION 1
	@P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
    
	SELECT Context, @P1 AS ERROR_NUM, @P2 AS MESSAGE;
END//

CREATE PROCEDURE INSERTCHECK()
BEGIN 


    DECLARE exit handler for sqlexception
	BEGIN
      ROLLBACK;
      
      -- SHOW ERRORS LIMIT 1 ;
      CALL DIAGNOSTIC('INSERTCHECK');
    END;

    DECLARE exit handler for sqlwarning
	BEGIN
     ROLLBACK;
     SHOW WARNINGS LIMIT 1;
    END;

	START TRANSACTION;
     
		INSERT INTO tblPlayer(PlayerID,PassWrd,PName,Description)
		VALUES  ('Todd@12345','Z1234','Todd','test');

		INSERT INTO tblPlayer(PlayerID,PassWrd,PName,Description)
		VALUES  ('Todd@12345','Y1234','Todd','test');

	COMMIT;
END\\
DELIMITER ;

CALL INSERTCHECK();

SELECT * FROM tblPlayer;