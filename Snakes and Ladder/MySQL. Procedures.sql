USE SnakesAndLadder;

-- PROCEDURE "1"

drop procedure if exists CheckUserLogin;
DELIMITER //

CREATE PROCEDURE CheckUserLogin(pName varchar(50), pPassword varchar(50))
begin

declare lcOkPasswordCount int;
declare lcUserNameCount int;
declare lcLoginAttempts int;


   DECLARE exit handler for sqlexception
	BEGIN
      ROLLBACK;
      
      SHOW ERRORS LIMIT 1 ;
      CALL DIAGNOSTIC('CheckUserLogin');
    END;

    DECLARE exit handler for sqlwarning
	BEGIN
     ROLLBACK;
     SHOW WARNINGS LIMIT 1;
    END;

START TRANSACTION;
	select count(Username)
	from Account
	where Username = pName
	into lcUserNameCount;

		If lcUserNameCount = 1 THEN
			select count(Username)
			from Account
			where Username = pName AND UserPassword = pPassword
			into lcOkPasswordCount;
			
				if lcOkPasswordCount = 1 then
					Select 'LobbyZone' as message;
				else 
					Update Account
					SET AccountLoginAttempts = AccountLoginAttempts + 1
					where Username = pName;
			
					Select AccountLoginAttempts
					from Account
					where Username = pName
					into lcLoginAttempts;
				
					if lcLoginAttempts > 5 then
						update Account
						set AccountStatus = 'Locked'
						where Username = pName;
						Select 'LockedOut' as message;
					else
						Select 'LoginPage' as message;
					end if;
				end if;
			  else  
			  Select 'FinishRegistration' as message;
			  end if;
COMMIT;
END //
DELIMITER ;

drop procedure if exists CheckUserAccount;
DELIMITER //
CREATE PROCEDURE CheckUserAccount(pName varchar(50))
begin
declare lcOkPasswordCount int;
declare lcUserNameCount int;
declare lcLoginAttempts int;
	select count(Username)
	from Account
	where Username = pName
	into lcUserNameCount;

		If lcUserNameCount = 1 THEN
			select count(Username)
			from Account
			where Username = pName
			into lcOkPasswordCount;
			
				if lcOkPasswordCount = 1 then
					Select 'LobbyZone' as message;
				else 
					Update Account
					SET AccountLoginAttempts = AccountLoginAttempts + 1
					where Username = pName;
			
					Select AccountLoginAttempts
					from Account
					where Username = pName
					into lcLoginAttempts;
				
					if lcLoginAttempts > 5 then
						update Account
						set LockedStatus = 'Locked'
						where Username = pName;
						Select 'LockedOut' as message;
					else
						Select 'LoginPage' as message;
					end if;
				end if;
			  else  
			  Select 'FinishRegistration' as message;
			  end if;
END //
DELIMITER ;
call CheckUserAccount('Daniel451');


-- Procedure 2
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

-- Procedure 3
drop procedure if exists UpdatePlayerPosition;
DELIMITER //

CREATE PROCEDURE UpdatePlayerPosition(pUsername varchar(50), pGameID int)
begin
declare lclocation int;
declare lcstartPosition int;

START TRANSACTION;
Select Username from Player 
where Username = pUsername and GameID = pGameID;
set lclocation = (floor(RAND() * (6-1+1)) + 1);
if lclocation >= 100  then

	Select PlayerStartPosition from Player
	where Username = pUsername and GameID = pGameID
	into lcstartPosition;
    
	update Player
	set PlayerEndPosition = lcstartPosition + lclocation
	where Username = pUsername and GameID = pGameID;
  else
	Select 'The Player has reacehed 100' as message;
end if; 
commit;

	END //
DELIMITER ;

-- Procedure 2
drop procedure if exists NewPlayerAdd;
DELIMITER //
Create procedure NewPlayerAdd (pUsername varchar(50), pPassword varchar(50), pEmail varchar(50))
begin

START TRANSACTION;
Select count(Username) from Account
where Username = pUsername 
into @countUser;

if @countUser = 1 then
	Select 'NameExists' as message;
else
	Select count(Email) from Account
    where Email = pEmail
    into @countEmail;
    if @countEmail = 1 then
		Select 'EmailExists' as message;
	else 
		insert into Account (Username, UserPassword, Email, AdminPermission) 
        value (pUsername, pPassword, pEmail, 'No');
        Select 'PlayerAdded' as message;
    end if;
end if;    
commit;
END //
DELIMITER ;

-- Procedure 2
drop procedure if exists AddNewPlayer;
DELIMITER //
Create procedure AddNewPlayer (pUsername varchar(50), pPassword varchar(50), pEmail varchar(50))
begin

START TRANSACTION;
Select count(Username) from Account
where Username = pUsername 
into @countUser;

if @countUser = 1 then
	Select 'NameExists' as message;
else
	Select count(Email) from Account
    where Email = pEmail
    into @countEmail;
    if @countEmail = 1 then
		Select 'EmailExists' as message;
	else 
		insert into Account (Username, UserPassword, Email, AdminPermission) 
        value (pUsername, pPassword, pEmail, 'No');
        Select 'PlayerAdded' as message;
    end if;
end if;    
commit;
END //
DELIMITER ;
call AddNewPlayer('Superman', 'Superman','Superman@gmail.com');

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


drop procedure if exists CheckAdminStatus;
DELIMITER //
create procedure CheckAdminStatus(pUsername varchar(50))
begin
Select count(Username) from account
where Username = pUsername
into @countUser;
if @countUser = 1 then
	Select AdminPermission from Account 
    where Username = pUsername
    into @AdPermission;
    if @AdPermission = 'Yes' then
		Select 'UserAdmin' as message;
	else
		Select 'UserNotAdmin' as message;
	end if;
else 
	Select 'UsernameDoesntExit' as message;
    end if;
END //
DELIMITER ;
call CheckAdminStatus('M');

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

drop procedure if exists ListAllOnlinePlayers;
DELIMITER //

Create procedure ListAllOnlinePlayers (pStatus varchar(10))
BEGIN

START TRANSACTION;
Select AccountStatus from Account
where AccountStatus = pStatus;
	if pStatus = 'Online' or 'Playing' then
		SELECT Username, HighScore
		FROM ACCOUNT
		WHERE AccountStatus = pStatus
		order  by Username and HighScore;
	end if;
commit;
END //
DELIMITER ;

drop procedure if exists ListAllPlayers;
DELIMITER //

Create procedure ListAllPlayers ()
BEGIN
	select Username, HighScore
	from Account
	order by HighScore asc;

END //
DELIMITER ;
call ListAllPlayers();


drop procedure if exists AdminLisitingGamesOnAdminZone;
DELIMITER //

Create procedure AdminLisitingGamesOnAdminZone ()
BEGIN
	select Username, UserPassword, Email, LockedStatus, AdminPermission
	from Account
	order by Username asc;

END //
DELIMITER ;
call AdminLisitingGamesOnAdminZone();



drop procedure if exists DisplayGamesAvailable;
DELIMITER //

Create procedure DisplayGamesAvailable ()
BEGIN
	select GameID, Username, NumberOfPlayer, StatusOfGame
	from Game
    WHERE StatusOfGame = 'Running'
	order by GameID asc;

END //
DELIMITER ;
call DisplayGamesAvailable();



drop procedure if exists ListAllGames;
DELIMITER //
Create procedure ListAllGames (pStatus varchar(20))
BEGIN

START TRANSACTION;
Select StatusOfGame from Game
where StatusOfGame = pStatus;
	if pStatus = 'Running' then
		SELECT GameID, NumberOfPlayer
		FROM Game
		where StatusOfGame = pStatus
		order by GameID and NumberOfPlayer;
		
	end if;
commit;
END //
DELIMITER ;

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

drop procedure if exists AdminListingAllGames;
DELIMITER //
SET autocommit = 0;
Create procedure AdminListingAllGames ()
BEGIN
   -- DECLARE exit handler for sqlexception
-- 	BEGIN
--       ROLLBACK;
--       
--       -- SHOW ERRORS LIMIT 1 ;
--       CALL DIAGNOSTIC('AdminListingAllGames');
--     END;

--     DECLARE exit handler for sqlwarning
-- 	BEGIN
--      ROLLBACK;
--      SHOW WARNINGS LIMIT 1;
--     END;
START TRANSACTION;
	SELECT GameID, NumberOfPlayer, StatusOfGame, AccountStatus
		FROM Game
		JOIN Account
		ON Account.Username = Game.Username
		order by GameID;
commit;
END //
DELIMITER ;

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

drop procedure if exists EnteringCorrectGame;
DELIMITER //

CREATE PROCEDURE EnteringCorrectGame(pGameID int, pUsername varchar(50))
BEGIN
START TRANSACTION;
	Select StatusOfGame from Game 
    where GameID = pGameID
    into @gameStatus;
    
    if @gameStatus = 'Running' then
		Select NumberOfPlayer from Game
		where GameID = pGameID
		into @totalPlayers;
    
		if @totalPlayers > 4 then
			Select 'Maximum 4 players can play the game. So, please enter new GameID to join the game' as message;
		else
			call CountPlayerSetColor(pUsername, pGameID);
			Select 'The Player can enter the game' as message;
    
		end if;
    end if;
commit;
END//
DELIMITER ;

drop procedure if exists ExitGameApplication;
DELIMITER //
CREATE PROCEDURE ExitGameApplication(pUsername varchar(50))
begin
Select Username from  Account
where Username = pUsername
into @AccountStat;

Set @AccountStat = 'Offline'; 
Update Account
Set AccountStatus = @AccountStat
where Username = pUsername;
Select 'The User is now offline.' as message;
END //
DELIMITER ;


drop procedure if exists CreateGame;
DELIMITER //

CREATE PROCEDURE CreateGame(pUsername varchar(50), pGameID int)
BEGIN
START TRANSACTION;
	Select count(GameID)
	from Game
	where Username = pUsername and GameID = pGameID
	into @countGameID;
    
	if @countGameID = 1 then
		Select 'The game already exists' as message;
	else
		Select 'Game is created' as message;
        insert into Game (GameID, Username, StatusOfGame, DatePlayed)
		values (pGameID, pUsername, 'Running', SysDate());  
		call CountPlayerSetColor (pUsername, pGameID);
    end if;
commit;
END //
DELIMITER ;

drop procedure if exists ExitGame;
DELIMITER //

CREATE PROCEDURE ExitGame(pGameID int, pUsername varchar(50), pHighScore int, pTotalGamePlayed int, pTotalGameWon int, pGameWon varchar(10))
BEGIN	
START TRANSACTION;  
Select * from Account
where Username = pUsername;      
		update Account 
		set AccountStatus = 'Online', 
										HighScore = CASE when pHighScore > HighScore THEN pHighScore 
														 when pHighScore <= HighScore THEN HighScore
														 end,
										TotalGameWon = CASE when pGameWon = 'Yes' then TotalGameWon + 1
															when pGameWon = 'No' then TotalGameWon
                                                            when TotalGameWon is null and pGameWon = 'Yes' then 1
                                                            when TotalGameWon is null and pGameWon = 'No' then 0
															end,
										TotalGamePlayed = TotalGamePlayed + 1
		where Username = pUsername;
	
commit;
END //
DELIMITER ;

drop procedure if exists GenerateNumberOnDice;
DELIMITER //
SET autocommit = 0;
CREATE PROCEDURE GenerateNumberOnDice(pUsername varchar (50), pGameID int)
BEGIN
declare lcRollDice int;
   -- DECLARE exit handler for sqlexception
-- 	BEGIN
--       ROLLBACK;
--       
--       -- SHOW ERRORS LIMIT 1 ;
--       CALL DIAGNOSTIC('GenerateNumberOnDice');
--     END;

--     DECLARE exit handler for sqlwarning
-- 	BEGIN
--      ROLLBACK;
--      SHOW WARNINGS LIMIT 1;
--     END;
START TRANSACTION;
	SET lcRollDice = floor(RAND() * (6-1+1)) + 1; 
		
	Update Game
	set NumberOnDice = lcRollDice
	where Username = pUsername and GameID = pGameID;
			
	Select NumberOnDice
	from Game
	where pUsername = Username;
    SELECT 'DICE ROLL IS GENERATED' AS MESSAGE;
commit;
END //
DELIMITER ;

drop procedure if exists MovePlayer;
DELIMITER //
CREATE PROCEDURE MovePlayer(pTokenID int, pGameID int, pUsername varchar(50))
BEGIN

declare lcRollResult int;
declare lcLocation int;
declare lcObstacleEnd int;
declare lcCountObstacleStart int;
   
START TRANSACTION;
     select LocationNumber
     from GamePlayToken
     where TokenID = pTokenID and GameID = pGameID
     into lcLocation;

	SET lcRollResult = floor(RAND() * (6-1+1)) + 1; 
	if lcLocation + lcRollResult >= 100 then
		call UpdateGameWon(pUsername,pGameID);
	   Select 'The Player Won the Game' as message;
       
	else
		Update GamePlayToken
		set LocationNumber = LocationNumber + lcRollResult
		where TokenID = pTokenID;
        
		Select ObstacleEndPosition
		from SnakeLadder
		where ObstacleStartPosition = lcLocation + lcRollResult
		into lcObstacleEnd;
		if lcObstacleEnd is not null then
          Update GamePlayToken
		  set LocationNumber =lcObstacleEnd
		  where TokenID = pTokenID;
        end if;
		
       select 'player moved' as message;
	end if;
    


END //
DELIMITER ;

drop procedure if exists CountPlayerSetColor;
DELIMITER //
CREATE PROCEDURE CountPlayerSetColor(pUsername varchar(50), pGameID int)
begin
START TRANSACTION;
	Select count(NumberOfPlayer) from Game
	where GameID = pGameID and Username = pUsername
	into @countPlayer;
    
    if @countPlayer = 1 then
		Select ColorOfPlayer from Player
		where Username = pUsername and GameID = pGameID
		into @playerColor;
		
        Set @playerColor = 'Red';
		Update Player
        Set ColorOfPlayer = @playerColor
        where Username = pUsername and GameID = pGameID;
        
	elseif @countPlayer = 2 then
		Select ColorOfPlayer from Player
		where Username = pUsername and GameID = pGameID
		into @playerColor;
		
        Set @playerColor = 'Blue';
		Update Player
        Set ColorOfPlayer = @playerColor
        where Username = pUsername and GameID = pGameID;
        
	elseif @countPlayer = 3 then
		Select ColorOfPlayer from Player
		where Username = pUsername and GameID = pGameID
		into @playerColor;
		
        Set @playerColor = 'Green';
		Update Player
        Set ColorOfPlayer = @playerColor
        where Username = pUsername and GameID = pGameID;
  	elseif @countPlayer = 4 then
		Select ColorOfPlayer from Player
		where Username = pUsername and GameID = pGameID
		into @playerColor;
		
        Set @playerColor = 'Yellow';
		Update Player
        Set ColorOfPlayer = @playerColor
        where Username = pUsername and GameID = pGameID;      
	end if;
commit;
	END //
DELIMITER ;

drop procedure if exists GameStatus;
DELIMITER //
CREATE PROCEDURE GameStatus (pGameID int)
begin
Select StatusOfGame from Game
where GameID = pGameID
into @StatusGame;

if @StatusGame = 'Running' then
	Select GameScore from Game
	where GameID = pGameID
	into @PlayerScore;

	update Game 
	set GameScore = GameScore + @PlayerScore
	where GameID = pGameID;
end if;
end//
DELIMITER ; 
call GameStatus (3021);



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

drop procedure if exists CheckingSnakesAndLadder;
DELIMITER //

CREATE PROCEDURE CheckingSnakesAndLadder(pTokenID int, pUsername varchar(50), pGameID int)
BEGIN
declare diceNumber int;
declare TurnPlayer varchar (10);
declare playerLocation int;
 
START TRANSACTION;
	Select NumberOnDice 
	from Game
	where GameID = pGameID
	into diceNumber;

	update GamePlayToken
	set LocationNumber = LocationNumber + diceNumber
	where TokenID = pTokenID;

	call MovePlayer(pTokenID, pGameID, pUsername);
	if diceNumber = 6 then
		call GenerateNumberOnDice(pUsername, pGameID);
		call PlayerTurn (pTokenID, pUsername, pGameID);
		
	end if;

END //
DELIMITER ;

drop procedure if exists OrderListOfGames;
DELIMITER //
SET autocommit = 0;
CREATE PROCEDURE OrderListOfGames()
BEGIN
   -- DECLARE exit handler for sqlexception
-- 	BEGIN
--       ROLLBACK;
--       
--       -- SHOW ERRORS LIMIT 1 ;
--       CALL DIAGNOSTIC('OrderListOfGames');
--     END;

--     DECLARE exit handler for sqlwarning
-- 	BEGIN
--      ROLLBACK;
--      SHOW WARNINGS LIMIT 1;
--     END;
START TRANSACTION;
	select Username, GameID, NumberOfPlayer
	from Game
	order by Username asc;
commit;
END //
DELIMITER ;

drop procedure if exists UpdateGameWon;
DELIMITER //
CREATE PROCEDURE UpdateGameWon(pUsername varchar(50), pGameID int)
BEGIN
        
Select PlayerScore 
from Player 
where Username = pUsername and GameID = pGameID
into @Score;


Update Game 
Set GameScore = @Score
where GameID = pGameID and Username = pUsername; 

Select TotalGameWon 
from Account
where Username = pUsername
into @GameWon;

Update Account
Set TotalGameWon = @GameWon + 1
where Username = pUsername;

END //
DELIMITER ;

drop procedure if exists UpdatingGamePlayed;
DELIMITER //

CREATE PROCEDURE UpdatingGamePlayed(pGameID int, pUsername varchar(50))
BEGIN

Select CurrentTurn 
	from Game where Username = pUsername and GameID = pGameID
	into @GamePlayed;
	
	Update Game
	set CurrentTurn = @GamePlayed 
	where Username = pUsername and GameID = pGameID;
	
	Select TotalGamePlayed
	from Account
	where Username = pUsername
	into @TotalPlayed;
	
	Update Account
	set TotalGamePlayed = @TotalPlayed + 1
	where Username = pUsername;
	
END //
DELIMITER ;

drop procedure if exists PlayerTurn;
DELIMITER //
SET autocommit = 0;
CREATE PROCEDURE PlayerTurn(pTokenID int, pUsername varchar(50), pGameID int)
BEGIN
declare diceNumber int;
declare TurnPlayer varchar (10);
declare playerLocation int;
   DECLARE exit handler for sqlexception
	BEGIN
      ROLLBACK;
      
      -- SHOW ERRORS LIMIT 1 ;
      CALL DIAGNOSTIC('PlayerTurn');
    END;

    DECLARE exit handler for sqlwarning
	BEGIN
     ROLLBACK;
     SHOW WARNINGS LIMIT 1;
    END;
START TRANSACTION;
	Select NumberOnDice 
	from Game
	where GameID = pGameID
	into diceNumber;

	update GamePlayToken
	set LocationNumber = LocationNumber + diceNumber
	where TokenID = pTokenID;

	if diceNumber = 6 then
		call GenerateNumberOnDice(pUsername, pGameID);
		call PlayerTurn (pTokenID, pUsername, pGameID);
	end if;
commit;
END //
DELIMITER ;

drop procedure if exists TerminatingAGame;
DELIMITER //

CREATE PROCEDURE TerminatingAGame(pGameID int, pUsername varchar(50))
BEGIN

declare statusGame varchar (50);
declare playerScore int;
START TRANSACTION;
	SELECT StatusOfGame
	from Game
	where GameID = pGameID
	into statusGame;

	if statusGame = 'Running' then
		Select GameScore from Game
        where GameID = pGameID
        into playerScore;
        
        update Game
        set GameScore = playerScore, StatusOfGame = 'Terminated'
        where GameID = pGameID;
        
                call UpdatingGamePlayed(pGameID,pUsername);

        SELECT 'Game is Terminated' as message;
	else
		select 'The game doesnt exist. Please enter a valid game to be Terminated' as message;

	end if;
commit;
END //
DELIMITER ;

drop procedure if exists AddingPlayer;
DELIMITER //
SET autocommit = 0;
CREATE PROCEDURE AddingPlayer(pGameID int, pUsername varchar(50))
BEGIN

declare playerNumber int;
declare countUsername int;
declare countExistingPlayer int;
declare GameStatus varchar (50);
declare countGame int;
   DECLARE exit handler for sqlexception
	BEGIN
      ROLLBACK;
      
      -- SHOW ERRORS LIMIT 1 ;
      CALL DIAGNOSTIC('AddingPlayer');
    END;

    DECLARE exit handler for sqlwarning
	BEGIN
     ROLLBACK;
     SHOW WARNINGS LIMIT 1;
    END;
START TRANSACTION;
	select count(GameID) 
	from Game 
	where GameID = pGameID
	into countGame;
	
	if 	countGame = 1 then   -- if the game exists or not, if the game exists it will run the game accordingly.
		select StatusOfGame, NumberOfPlayer 
		from Game 
		where GameID = pGameID
		into GameStatus, countExistingPlayer;
	
		select count(Username)
		from Game
		where Username = pUsername
		into countUsername;

		if 	countUsername > 5 then
			Select GameID from Game
			where GameID = pGameID
			into playerNumber;
			
            Select PlayerNumber from Game
            where playerNumber = PlayerNumber + 1
            into playerNumber;
            
			Update Game
			set NumberOfPlayer = playerNumber
			where GameID = pGameID;
		else
			Select 'The Number of Player is more than 4. Please Join another Game' as message;
		end if;
	end if;
commit;
END //
DELIMITER ;

drop procedure if exists dropexistingplayer;
DELIMITER //
create procedure dropexistingplayer(pUsername varchar(50))
Begin
START TRANSACTION;
Select count(Username) from Account
where Username = pUsername 
into @countUser;

if @countUser != 1 then
	Select 'The Username doesnt exist.' as message;
else
	delete from Account
    where Username = pUsername;
    Select 'The User has been deleted.ExitGame' as message;
end if;
commit;
END //
DELIMITER ;


drop procedure if exists EditExistingPlayers;
DELIMITER //
create procedure EditExistingPlayers(pUsername varchar(50), pUserPassword varchar(50), pEmail varchar(50), pAdminPermission varchar(20), pLockedStatus varchar(20))
begin

Select count(Username) from Account
where Username = pUsername 
into @countUser;

if @countUser != 1 then
	Select 'The user doesnt exist' as message;
else
	Select count(Email) from Account
    where Email = pEmail
    into @countEmail;
    if @countEmail != 1 then
		Select 'The email doesnt exist' as message;
	else
    
		Select count(UserPassword) from Account
        where UserPassword = pUserPassword
        into @countPassword;
			if @countPassword !=1 then
				Select 'The User password is incorrect' as message;
			else
				Select 'The Player Details is displayed to be edited' as message;	
                
				update Account
				set LockedStatus = 'Unlocked'
				where Username = pUsername;
				
				update Account
				set AdminPermission = 'Yes'
				where Username = pUsername;
			end if;
	end if;
end if;
END //
DELIMITER ;


call CheckUserLogin('Daniel451', 'Password@2');
call AdminEditLockedStatus('Kiamon32');
Call UpdatePlayerPosition('Miles87T', 3024);
call NewPlayerAdd ('Kyle32', 'Password@Kyle', 'kyle.32@gmail.com');
call PlayerLogsOut('Russel32');
call AdminAddNewPlayer ('Lexus32', 'Lexus@32', 'lexus.32@gmail.com', 'Yes');
call ListAllOnlinePlayers('Online');
Call ListAllGames('Running');
Call AdminListingAllGames();
call AdminEditAdminStatus ('Kanther6125');
call EnteringCorrectGame(3028, 'Banther6126');
call CreateGame("Fienza781", 3030);
call ExitGame (3021, 'Milton619', 70, 2, 1, 'No');
call GenerateNumberOnDice ('Milton619', 3021);
call MovePlayer(1, 3021, 'Milton619');
Call CountPlayerSetColor('Banther6126', 3028);
call SetAdminStatus('Russel32');
call CheckingSnakesAndLadder(1, 'Milton619', 3021);
call OrderListOfGames();
call UpdateGameWon('Milton619', 3021);
call UpdatingGamePlayed(3021, 'Milton619');
call PlayerTurn(1, 'Milton619', 3021);
call TerminatingAGame(3021, 'Milton619');
call AddingPlayer(3021, 'Daniel452');
call dropexistingplayer('Kane');
call CheckAdminStatus ('Milton619');
call ExitGameApplication('Ryan245');
call EditExistingPlayers('Leon236','Password@12','leon.kate@Ut.com', 'Yes', 'Unlocked'); 