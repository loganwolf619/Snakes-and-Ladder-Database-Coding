USE SnakesAndLadder;

drop procedure if exists SetAdminStatus;
DELIMITER //

CREATE PROCEDURE SetAdminStatus(pName Varchar (50))
BEGIN

START TRANSACTION;
Select AdminPermission from Account
where Username = pName;
	UPDATE Account
	SET AdminPermission = 'Yes'
	WHERE Username = pName;

END //
DELIMITER ;
call SetAdminStatus('Russel32');
Select * from  Account
where Username = 'Russel32';
