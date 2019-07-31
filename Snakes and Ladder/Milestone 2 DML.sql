USE SnakesAndLadder;

-- Procedure to run Create (Insert), Read (Select), Update, and Delete DDM

drop procedure if exists SnakesAndLadder_CRUD_DDM;

DELIMITER //
create procedure SnakesAndLadder_CRUD_DDM()
Begin 


-- 1.1 ) Account table__
INSERT INTO Account 
(Username,UserPassword,Email, AccountLoginAttempts,AccountStatus, LockedStatus, AdminPermission, DateLastActive) 
VALUES 
("M","M","ashkar.milton@gmail.com","1","Online","Unlocked", "Yes","2019-05-22"),
("Daniel452","Password@2","7ebed7@gmail.com","2","Offline","Unlocked","Yes", "2019-05-22"),
("Ross78K","Password@3","ursus.non@fringillamilacinia.net", "5","Offline","Locked","Yes","2019-05-20"),
("Miles87T","Password@4","onec@dolordapibus.ca","4","Online","Unlocked","No","2019-05-21"),
("Bryan902","Password@5","aoreet.posuere.enim@nectempusscelerisque.net","2","Offline","Unlocked","No", "2019-05-21"),
("Ryan245","Password@6","endrerit.consectetuer@molestiesodales.net", "1","Online","Unlocked","No","2019-05-21"),
("Kiamon32","Password@7","landit.Nam@nisimagna.com","5", "Offline","Locked","Yes","2019-05-19"),
("Russel32","Password@8","rat.in.consectetuer@nisi.com","1","Online","Unlocked","No","2019-05-20"),
("Bryan2","Password@9","bryan.ansi@gmail.com","2","Online","Unlocked","No","2019-05-20"),
("Yiron901","Password@10","pede@Ut.com","1","Online","Unlocked","No","2019-05-21"),
("Fienza781","Password@11","frienza@Ut.com","1","Online","Unlocked","Yes","2019-05-21"),
("Leon236","Password@12","leon.kate@Ut.com","5","Offline","Locked","No","2019-05-21"),
("Panther6","Password@13","panther.mike@Ut.com","5","Offline","Locked","No","2019-05-21"),
("Loanther62","Password@14","paat@Ut.com","4","Online","Unlocked","No","2019-05-21"),
("Lanther6123","Password@15","kyle.mike@Ut.com","3","Online","Unlocked","No","2019-05-21"),
("Kanther6125","Password@16","jinxz.mike@Ut.com","1","Online","Unlocked","No","2019-05-21"),
("Banther6126","Password@17","kisse.mike@Ut.com","1","Online","Unlocked","No","2019-05-21"),
("Kane","Kane","kane.kane@gmail.com","1","Online","Unlocked","No","2019-05-21");


-- 1.2 )Game table__
INSERT INTO Game 
(GameID,Username,NumberOfPlayer,GameWinner,GameScore,StatusOfGame, DatePlayed)
VALUES 
(3021,"M","1",0,0,"Running","2019-05-22 07:36:44"),
(3022,"Daniel452","1",0,0,"Finished","2019-05-22 05:08:56"),
(3023,"Russel32","1",0,0,"Finished","2019-05-21 05:02:04"),
(3024,"Miles87T","1",0,0,"Running","2019-05-21 22:14:31"),
(3025,"Yiron901","1",0,0,"Terminated","2019-05-22 19:43:56"),
(3026,"Fienza781","1",0,0,"Running","2019-05-22 07:36:44"),
(3027,"Kanther6125","1",0,0,"Terminated","2019-05-22 07:36:44"),
(3028,"Banther6126","1",0,0,"Terminated","2019-05-22 07:36:44");

-- 1.3 )GamePlayRcord Table__
INSERT INTO GamePlayRecord
(GameRecordID,CountGamesPlayed,CountPlayerScore,Username,GameID)
VALUES
        (1,1,100,"M",3021),
        (2,1,0,"Yiron901",3025),
        (3,1,0,"Miles87T",3024),
        (4,1,100,"Daniel452",3022),
        (5,1,0,"Russel32",3023),
        (6,1,0,"Fienza781",3026),
        (7,1,0,"Kanther6125",3027),
        (8,1,0,"Banther6126",3028);


-- 1.4)Player Table__
INSERT INTO Player
(Username, GameID, PlayerStartPosition,PlayerEndPosition,PlayerScore, ColorOfPlayer)
VALUES
     
('M', 3021, 1, 1, 100, 'Red'),
('Daniel452', 3022, 1, 1,98, 'Red'),
('Russel32',  3023, 1, 1, 76, 'Red'),
('Miles87T', 3024, 1, 1,70, 'Red'),
('Yiron901',3025, 1, 1,12, 'Blue'),
('Fienza781', 3026, 1, 1,9, 'Red'),
('Kanther6125', 3027, 1, 1,9, 'Red'),
('Banther6126', 3028, 1, 1,9, 'Blue');   

-- 1.5 )GamePlayToken Table __
INSERT INTO GamePlayToken 
(GameID,Username, ColorOfPlayer) 
VALUES 
        (3021,"M", 'Red'),
        (3022,"Daniel452",'Red'),
        (3023,"Russel32",'Red'),
        (3024,"Miles87T",'Red'),
        (3025,"Yiron901", 'Blue'),
        (3026,"Fienza781", 'Red'),
        (3027,"Kanther6125",'Red'),
        (3028,"Banther6126", 'Blue');

-- 1.6) SnakeLadder Table__
INSERT INTO SnakeLadder
(ObstacleID, ObstacleName, ObstacleStartPosition, ObstacleEndPosition)
VALUES 
(1, "Snakes", "45", "5"),
(2, "Snakes", "23", "17"),
(3, "Snakes", "54", "33"),
(4, "Snakes", "67", "23"),
(5, "Snakes", "90", "50"),
(6, "Snakes", "99", "24"),
(7, "Ladder", "8", "29"),
(8, "Ladder", "22", 32),
(9, "Ladder", "65", "97"),
(10, "Ladder", "72", "93"),
(11, "Ladder", "54", "68"),
(12, "Snakes", "74", "68"),
(13, "Ladder", "24", "68");



END //
DELIMITER ;

call SnakesAndLadder_CRUD_DDM();
