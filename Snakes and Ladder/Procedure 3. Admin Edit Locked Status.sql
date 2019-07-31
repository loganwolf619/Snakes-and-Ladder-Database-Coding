USE SnakesAndLadder;

drop procedure if exists AdminEditLockedStatus;
DELIMITER //

CREATE PROCEDURE AdminEditLockedStatus(pName Varchar (50))
BEGIN
START TRANSACTION;

Select Username from account
where Username = pName;

	update Account
	set LockedStatus = 'Locked'
	where Username = pName;
    
commit;
END//
DELIMITER ;
call AdminEditLockedStatus('Kiamon32');
select * from account
where LockedStatus = 'Locked';