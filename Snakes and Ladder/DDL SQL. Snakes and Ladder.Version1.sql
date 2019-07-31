
Drop database if exists SnakesAndLadder;
Create database SnakesAndLadder;
use SnakesAndLadder;

drop procedure if exists SnakesAndLadder_DDL;
DELIMITER //
create procedure SnakesAndLadder_DDL()
Begin 

-- 1) Creating Tables 
-- 1.1 ) Create table for Account__CheckUserLogin
create table Account (
Username varchar (50) PRIMARY KEY UNIQUE NOT NULL,
UserPassword varchar (50) NOT NULL,
Email varchar (50) unique NOT NULL,
HighScore int default 0,
TotalGameWon int default 0,
TotalGamePlayed int default 0,
AccountLoginAttempts int default 0,
AccountStatus enum ('Offline', 'Playing', 'Online') default 'Offline',
LockedStatus enum ('Locked', 'Unlocked') default 'Unlocked',
AdminPermission enum ('Yes', 'No') default 'No',
DateLastActive timestamp default current_timestamp
);


-- 1.2 ) Create table for Game played by the players. 
Create table Game (
GameID int primary key Auto_Increment,
Username varchar (50) not null,
NumberOfPlayer int default 1,
GameWinner varchar (50) default 0,
GameScore int default 0,
NumberOnDice int default 0,
StatusOfGame enum ('Running', 'Playing','Terminated','Finished','Waiting to Start') default 'Running',
DatePlayed datetime not null,
CurrentTurn int default null,
foreign key (Username) references Account (Username) on delete cascade)
ENGINE=INNODB AUTO_INCREMENT=3021;

-- 1.3) Create table to record every game played by each player. I am naming it GamePlayRecord
create table GamePlayRecord (
GameRecordID INT primary key NOT NULL auto_increment,
CountGamesPlayed INT default 1,
CountPlayerScore int default 0,
Username varchar(50) not null,
GameID int not null,
foreign key (Username) references Account (Username) on delete cascade,
foreign key (GameID) references Game (GameID) on delete cascade
);

-- 1.4)  create table for Player which determines the position of the player
Create table Player (
Username varchar(50) unique not null,
ColorOfPlayer enum ('Red', 'Yellow', 'Blue', 'Green', 'None') default 'None',
GameID int not null,
PlayerStartPosition int default 0 check (PlayerStartPosition >= 0 AND PlayerStartPosition < 100),
PlayerEndPosition int default 0 check (PlayerEndPosition >= 0 AND PlayerEndPosition <= 100),
PlayerScore int default null,
CountTurn int (2) default 1,
PlayerTurn enum ('Disable', 'Enable', 'Quit') default 'Enable',
Primary key (Username,ColorOfPlayer,GameID),
foreign key (Username) references Account (Username) on delete cascade,
foreign key (GameID) references Game (GameID) on delete cascade
);

-- 1.5 ) create table for Game play token. This is used to record the movement of the player across each player depending on the color and turn
Create table GamePlayToken (
TokenID INT primary key NOT NULL auto_increment,

LocationNumber int default 0,
GameID int not null,
Username varchar (50),
ColorOfPlayer enum ('Red', 'Yellow', 'Blue', 'Green', 'None') default 'None',
foreign key (Username,ColorOfPlayer,GameID) references Player(Username,ColorOfPlayer,GameID) on update cascade
);

-- 1.6) create table for Snakes and ladder
create table SnakeLadder (
ObstacleID int primary key auto_increment,
ObstacleName varchar (20) not null,
ObstacleStartPosition int not null,
ObstacleEndPosition int not null,
Username varchar(50) default null,
ColorOfPlayer enum ('Red', 'Yellow', 'Blue', 'Green', 'None') default 'None',
GameID int default null,
TokenID int default null,
foreign key (Username,ColorOfPlayer,GameID) references Player(Username,ColorOfPlayer,GameID) on update cascade,
foreign key (TokenID) references GamePlayToken (TokenID) on delete cascade
);


-- 2) ALtering the Table 
-- ALTER TABLE Account
-- ADD CONSTRAINT check_AccountLoginAttempts check ((AccountLoginAttempts >= 0) AND (AccountLoginAttempts <=5 ));

ALTER TABLE Game
ADD CONSTRAINT check_NumberOfPlayer check ((NumberOfPlayer > 0) and (NumberOfPlayer < 4));



END//
DELIMITER ;

call SnakesAndLadder_DDL;