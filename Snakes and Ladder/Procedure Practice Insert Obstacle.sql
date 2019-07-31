USE SnakesAndLadder;

drop procedure if exists InsertObstacle;
DELIMITER //

CREATE PROCEDURE InsertObstacle
	(pObstacleID int, pObstacleName varchar (20), pUsername varchar (50), 
		pObsacleStartPosition int, pObsacleEndPosition int, pTokenId int, pColorOfPlayer varchar (10), pGameId int)
BEGIN
INSERT INTO SnakeLadder 
(ObstacleID, ObstacleName, ObstacleStartPosition, ObstacleEndPosition, Username, TokenID, ColorOfPlayer, GameID)
values (pObstacleID, pObstacleName, pObsacleStartPosition,pObsacleEndPosition, pUsername, pTokenId,pColorOfPlayer,pGameId);


END //
DELIMITER ;
