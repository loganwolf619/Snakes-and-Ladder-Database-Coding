Drop database if exists SnakesAndLadder;
Create database SnakesAndLadder;
use SnakesAndLadder;

create table tblAccount (
Username varchar (50) PRIMARY KEY UNIQUE,
Password varchar (50),
Email varchar (50) unique,
HighScore int default 0,
AccountLoginAttempts int default 0, 
AdminStatus enum ('LoggedOut', 'LoggedIn', 'Playing', 'Locked') default 'LoggedOut',
AdminPermissions enum ('Yes', 'No') default 'No'
);


