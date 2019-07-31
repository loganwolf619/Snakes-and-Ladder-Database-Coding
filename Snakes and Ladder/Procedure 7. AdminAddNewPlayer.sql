USE SnakesAndLadder;

drop procedure if exists AdminAddNewPlayer;
DELIMITER //
Create procedure AdminAddNewPlayer (pUsername varchar(50), pPassword varchar(50), pEmail varchar(50),isAdmin varchar(5))
begin

START TRANSACTION;
Select count(Username) from Account
where Username = pUsername 
into @countUser;

if @countUser = 1 then
	Select 'The Name already exists, Admin: Please enter a new user/player' as message;
else
	Select count(Email) from Account
    where Email = pEmail
    into @countEmail;
    if @countEmail = 1 then
		Select 'The Email already exists, Admin: Please enter a new email address' as message;
	else 
		insert into Account (Username, UserPassword, Email, AdminPermission)
	value (pUsername,pPassword, pEmail, isAdmin);
        Select 'The Admin added the playern to the system with Admin Permission' as message;
    end if;
end if;    
commit;
END //
DELIMITER ;
call AdminAddNewPlayer ('Lexus32', 'Lexus@32', 'lexus.32@gmail.com', 'Yes');
Select * from account
where Username = 'Lexus32';