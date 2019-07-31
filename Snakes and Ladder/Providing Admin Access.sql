USE SnakesAndLadder;

drop procedure if exists ProvidingAdminAccess;
DELIMITER //

Create procedure ProvidingAdminAccess (pUsername varchar(50))
begin

declare countExistedUsername int;
   
START TRANSACTION;
	select count(Username) from Account
	where Username = pUsername
	into countExistedUsername;

		if countExistedUsername = 1 then
			Update Account
			Set AdminPermission = 'Yes'
			where Username = pUsername;
		else 
			 Select 'The Username doesnt exists' as message;
		end if;

END //
DELIMITER ;
call ProvidingAdminAccess ('Bryan902');
select * from account
where (Username = 'Bryan902');