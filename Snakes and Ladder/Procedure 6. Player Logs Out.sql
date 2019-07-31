USE SnakesAndLadder;

drop procedure if exists PlayerLogsOut;
DELIMITER //

create procedure PlayerLogsOut(pUsername varchar(50))
begin
START TRANSACTION;	
Select count(Username) from account
where Username = pUsername
into @countUser;
if @countUser = 1 then
	Update Account
    Set AccountStatus = 'Offline'
    where Username = pUsername;
end if;    
commit;
END //
DELIMITER ;
call PlayerLogsOut('Russel32');
Select * from Account
where Username = 'Russel32';



