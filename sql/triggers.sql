USE brawlapi

DELIMITER $$
CREATE TRIGGER tr_defaultRefuerzo
AFTER INSERT ON Brawler
FOR EACH ROW
BEGIN
    DECLARE newID INT;
    SET newID = NEW.brawlerID;

    INSERT INTO DetalleBrawlerRefuerzo(brawlerID, refuerzoID) VALUES
    (newID,1),(newID,2),(newID,3),(newID,4),(newID,5),(newID,6);
END;
DELIMITER ;

SELECT * FROM DetalleBrawlerRefuerzo;

DELIMITER $$
CREATE TRIGGER tr_brawler_refuerzo_duplicados
BEFORE INSERT ON DetalleBrawlerRefuerzo
FOR EACH ROW
BEGIN
    IF (
        SELECT COUNT(*) FROM DetalleBrawlerRefuerzo 
        WHERE brawlerID = NEW.brawlerID AND refuerzoID = NEW.refuerzoID
        ) > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Refuerzo duplicado en brawler';
    END IF;
END;
DELIMITER ;

SELECT * FROM DetalleBrawlerRefuerzo;


DELETE FROM brawler WHERE brawlerID = 4;
SELECT * FROM alcance;
SHOW TRIGGERS;
SELECT COUNT(*) FROM DetalleBrawlerRefuerzo 
        WHERE brawlerID = 1 AND refuerzoID = 88