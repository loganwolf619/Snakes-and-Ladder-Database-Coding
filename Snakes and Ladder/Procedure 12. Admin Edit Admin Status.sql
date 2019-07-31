USE SnakesAndLadder;

drop procedure if exists AdminEditAdminStatus;
DELIMITER //

CREATE PROCEDURE AdminEditAdminStatus(pUsername Varchar (50))
BEGIN
START TRANSACTION;
Select AdminPermission from Account
where Username = pUsername
into @adPermission;
Set @adPermission = 'Yes';
	update Account
	set AdminPermission = @adPermission
	where Username = pUsername;
commit;
END//
DELIMITER ;
call AdminEditAdminStatus ('Kanther6125');
select * from Account
where Username = 'Kanther6125';
