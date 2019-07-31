USE SnakesAndLadder;

drop procedure if exists RegisterNewUser;
DELIMITER //
SET autocommit = 0;
Create procedure RegisterNewUser (pUsername varchar(50), pEmail varchar (50), pPassword varchar (50), pRePassword varchar (50))
begin

declare countExistedUsername int;
declare countExistedEmail int;
declare adminPermission varchar (5);
   DECLARE exit handler for sqlexception
	BEGIN
      ROLLBACK;
      
      -- SHOW ERRORS LIMIT 1 ;
      CALL DIAGNOSTIC('RegisterNewUser');
    END;

    DECLARE exit handler for sqlwarning
	BEGIN
     ROLLBACK;
     SHOW WARNINGS LIMIT 1;
    END;
START TRANSACTION;
	SELECT 
		COUNT(Username)
	FROM
		Account
	WHERE
		Username = pUsername INTO countExistedUsername;

	if countExistedUsername = 1 then
		Select 'The username already exists' as messsage;
	else 
		if (pEmail regexp '.*@.*') = 1 then
			Select count(Email) from account
			where Email = pEmail
			into countExistedEmail;

			if countExistedEmail = 1  then
				Select 'The email already exists' as message;
			else 

				Insert into Account (Username, UserPassword, Email)
				values (pUsername, pPassword, pEmail);

			End if;
		End if;
	End if;
commit;
END //
DELIMITER ;

select 'ashkar@gmail' regexp '.+\@.+\..+'
as result;
