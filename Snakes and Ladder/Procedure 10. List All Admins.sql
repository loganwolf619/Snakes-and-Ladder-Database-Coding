USE SnakesAndLadder;

drop procedure if exists ListAllAdmins;
DELIMITER //
Create procedure ListAllAdmins (pPermission varchar (10))
BEGIN
START TRANSACTION;
Select AdminPermission from Account
where AdminPermission = pPermission;
	if pPermission = 'Yes' then
		SELECT Username, AccountStatus
		FROM Account
		where AdminPermission = pPermission
		order by Username and AccountStatus;
	end if;
commit;
END //
DELIMITER ;
Call ListAllAdmins('Yes');

