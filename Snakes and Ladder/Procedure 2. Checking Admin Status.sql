USE SnakesAndLadder;

drop procedure if exists CheckingAdminStatus;
DELIMITER //

CREATE PROCEDURE CheckingAdminStatus(pName VARCHAR (50), pPassword varchar (50))
begin

declare lcUserAdminOrNot varchar (5);
declare lcPassOk int;
declare lcLoginAttempts int;
declare lcCountUserAccess int;

START TRANSACTION;
	SELECT count(Username)
	from Account
	where Username = pName AND UserPassword = pPassword
	into lcPassOk;

		If lcPassOk = 1 then
			SELECT count(Username) 
			from Account
			where Username = pName AND AccountStatus != 'Locked'
			into lcCountUserAccess;
		
				If lcCountUserAccess = 1 then
					Select AdminPermission
					from Account
					where Username = pName
					into lcUserAdminOrNot;
				
					Update Account
					SET DateLastActive = SYSDATE(),
					AccountLoginAttempts = AccountLoginAttempts + 1,
					AccountStatus = 'Online'
					where Username = pName;
					
						If lcUserAdminOrNot = 'Yes' then
							Select 'Successful' as message;
						Else 
							Select 'Successful User Login' as message;
						End If;
				Else
				Select 'Send Email to Admin to Unlock' as Message;
				End IF;
				Else
				Update Account
				set AccountLoginAttempts = AccountLoginAttempts + 1
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
  Commit;
END //
DELIMITER ;
call CheckingAdminStatus('Daniel451', 'Password@2');