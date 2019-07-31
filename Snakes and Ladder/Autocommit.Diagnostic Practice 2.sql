USE SnakesAndLadder;

drop procedure if exists CheckUserAccount;

SET autocommit = 0;

DELIMITER //
CREATE PROCEDURE DIAGNOSTIC(IN Context VARCHAR(255))
BEGIN
	GET DIAGNOSTICS CONDITION 1
	@P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
    
	SELECT Context, @P1 AS ERROR_NUM, @P2 AS MESSAGE;
END//

CREATE PROCEDURE CheckUserAccount(pName varchar(50), pPassword varchar(50))
begin
    DECLARE exit handler for sqlexception
	BEGIN
      ROLLBACK;
      
      -- SHOW ERRORS LIMIT 1 ;
      CALL DIAGNOSTIC('CheckUserAccount');
    END;

    DECLARE exit handler for sqlwarning
	BEGIN
     ROLLBACK;
     SHOW WARNINGS LIMIT 1;
    END;
      
declare lcOkPasswordCount int;
declare lcUserNameCount int;
declare lcLoginAttempts int;
START TRANSACTION;
select count(Username)
from Account
where Username = pName
into lcUserNameCount;

	If lcUserNameCount = 1 THEN
		select count(Username)
		from Account
		where Username = pName AND UserPassword = pPassword
		into lcOkPasswordCount;
		
			if lcOkPasswordCount = 1 then
				Select 'Go To Lobby Zone' as message;
			else 
				Update Account
				SET AccountLoginAttempts = AccountLoginAttempts + 1
				where Username = pName;
        
				Select AccountLoginAttempts
				from Account
				where Username = pName
				into lcLoginAttempts;
            
				if lcLoginAttempts > 5 then
					update Account
					set AccountStatus = 'Locked'
					where Username = pName;
					Select 'Locked Out. Send email to the admin. Admin Email: ashkar.milton@gmail.com' as message;
				else
					Select 'Go to Login Page' as message;
				end if;
			end if;
          else  
          Select 'Go to Lobby Page to finish registration' as message;
          end if;
          	COMMIT;
END //
DELIMITER ;
call CheckUserAccount('Daniel451', 'Password@2');