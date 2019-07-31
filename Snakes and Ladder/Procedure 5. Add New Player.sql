USE SnakesAndLadder;

drop procedure if exists AddNewPlayer;
DELIMITER //
Create procedure AddNewPlayer (pUsername varchar(50), pPassword varchar(50), pEmail varchar(50))
begin

START TRANSACTION;
Select count(Username) from Account
where Username = pUsername 
into @countUser;

if @countUser = 1 then
	Select 'The Name already exists, please enter a new user/player' as message;
else
	Select count(Email) from Account
    where Email = pEmail
    into @countEmail;
    if @countEmail = 1 then
		Select 'The Email already exists, please enter a new email address' as message;
	else 
		insert into Account (Username, UserPassword, Email, AdminPermission) 
        value (pUsername, pPassword, pEmail, 'No');
        Select 'The Player/User has been added to the system' as message;
    end if;
end if;    
commit;
END //
DELIMITER ;
call AddNewPlayer ('Kyle32', 'Password@Kyle', 'kyle.32@gmail.com');
Select * from account
where Username = 'Kyle32';