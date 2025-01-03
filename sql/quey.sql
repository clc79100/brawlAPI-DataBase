#comentarioxd
USE brawlapi;

CREATE TABLE Hipercarga(
    hipercargaID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    imagen VARCHAR(200) NOT NULL,
    PRIMARY KEY(hipercargaID)
);

CREATE TABLE Alcance(
    alcanceID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    PRIMARY KEY(alcanceID)
);

CREATE TABLE Calidad(
    calidadID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    PRIMARY KEY(calidadID)
);

CREATE TABLE Tipo (
    tipoID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    PRIMARY KEY(tipoID)
);

CREATE TABLE Refuerzo (
    refuerzoID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    imagen VARCHAR(200) NOT NULL,
    calidadID INT NOT NULL,
    PRIMARY KEY(refuerzoID),
    CONSTRAINT fk_calidadID_refuerzo FOREIGN KEY(calidadID) REFERENCES Calidad(calidadID)
);

CREATE TABLE Brawler(
    brawlerID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    salud INT NOT NULL,
    daño VARCHAR(20) NOT NULL,
    alcanceID INT NOT NULL,
    calidadID INT NOT NULL,
    tipoID INT NOT NULL,
    hipercargaID INT,
    PRIMARY KEY(brawlerID),
    CONSTRAINT fk_alcanceID FOREIGN KEY(alcanceID) REFERENCES Alcance(alcanceID),
    CONSTRAINT fk_calidadID_brawler FOREIGN KEY(calidadID) REFERENCES Calidad(calidadID),
    CONSTRAINT fk_tipoID FOREIGN KEY(tipoID) REFERENCES Tipo(tipoID),
    CONSTRAINT fk_hipercargaID FOREIGN KEY(hipercargaID) REFERENCES Hipercarga(hipercargaID),
    UNIQUE(hipercargaID)
);

CREATE TABLE Estelar(
    estelarID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    imagen VARCHAR(200) NOT NULL,
    brawlerID INT NOT NULL,
    PRIMARY KEY (estelarID),
    CONSTRAINT fk_brawler_estelar FOREIGN KEY(brawlerID) REFERENCES Brawler(brawlerID)
);

CREATE TABLE Gadget (
    gadgetID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    imagen VARCHAR(200) NOT NULL,
    brawlerID INT NOT NULL,
    PRIMARY KEY(gadgetID),
    CONSTRAINT fk_brawler_gadget FOREIGN KEY(brawlerID) REFERENCES Brawler(brawlerID)
);

CREATE TABLE Super(
    superID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    imagen VARCHAR(200) NOT NULL,
    brawlerID INT NOT NULL,
    PRIMARY KEY(superID),
    CONSTRAINT fk_brawler_super FOREIGN KEY(brawlerID) REFERENCES Brawler(brawlerID)
);


CREATE TABLE StatsExtra(
    statsExtraID INT NOT NULL AUTO_INCREMENT,
    salud INT,
    daño VARCHAR(20) NOT NULL,
    alcanceID INT NOT NULL,
    brawlerID INT NOT NULL,
    PRIMARY KEY(statsExtraID),
    CONSTRAINT fk_alcance_statsExtra FOREIGN KEY(alcanceID) REFERENCES Alcance(alcanceID),
    CONSTRAINT fk_alcance_brawler FOREIGN KEY(brawlerID) REFERENCES Brawler(brawlerID)
);

CREATE TABLE DetalleBrawlerRefuerzo(
    detalleBrawlerRefuerzoID INT NOT NULL AUTO_INCREMENT,
    brawlerID INT NOT NULL,
    refuerzoID INT NOT NULL,
    PRIMARY KEY(detalleBrawlerRefuerzoID),
    CONSTRAINT fk_brawler FOREIGN KEY(brawlerID) REFERENCES Brawler(brawlerID),
    CONSTRAINT fk_refuerzo FOREIGN KEY(refuerzoID) REFERENCES Refuerzo(refuerzoID)
);


SELECT * FROM alcance;
SELECT * FROM calidad;
SELECT * FROM tipo;
SELECT * FROM hipercarga;
SELECT * FROM refuerzo;
SELECT * FROM brawler;
SELECT * FROM gadget;
SELECT * FROM estelar;
SELECT * FROM DetalleBrawlerRefuerzo;

#Todos los brawlers
SELECT 
    B.brawlerID, 
    B.nombre AS Brawler,
    B.salud AS Salud,
    B.daño AS Daño,
    A.nombre AS Alcance,
    C.nombre AS Calidad,
    T.nombre AS "Tipo de Brawler"
FROM Brawler AS B
INNER JOIN Alcance AS A
    ON B.alcanceID = A.alcanceID
INNER JOIN Calidad AS C
    ON B.calidadID = C.calidadID
INNER JOIN Tipo AS T
    ON B.tipoID = T.tipoID;

#Todos los brawlers(hipercarga nulo)
SELECT 
    B.brawlerID, 
    B.nombre AS Brawler,
    A.nombre AS Alcance,
    C.nombre AS Calidad,
    T.nombre AS "Tipo de Brawler",
    H.nombre AS Hipercarga
FROM Brawler AS B
INNER JOIN Alcance AS A
    ON B.alcanceID = A.alcanceID
INNER JOIN Calidad AS C
    ON B.calidadID = C.calidadID
INNER JOIN Tipo AS T
    ON B.tipoID = T.tipoID
LEFT JOIN Hipercarga AS H
    ON B.hipercargaID = H.hipercargaID;

#Refuerzo con GroupConcat
SELECT 
    B.nombre AS Brawler,
    GROUP_CONCAT(R.nombre SEPARATOR ', ') AS Refuerzo
FROM Brawler AS B
INNER JOIN DetalleBrawlerRefuerzo AS D_BR
    ON D_BR.brawlerID = B.brawlerID
INNER JOIN Refuerzo AS R
    ON R.refuerzoID = D_BR.refuerzoID
GROUP BY B.brawlerID;

#Refuezo sin groupConcat
SELECT 
    B.nombre AS Brawler,
    R.nombre AS Refuerzo
FROM Brawler AS B
INNER JOIN DetalleBrawlerRefuerzo AS D_BR
    ON D_BR.brawlerID = B.brawlerID
INNER JOIN Refuerzo AS R
    ON R.refuerzoID = D_BR.refuerzoID;


#Vista de refuerzo con inner join con brawler
CREATE VIEW vw_Refuerzo_Brawler AS
    SELECT
        R.refuerzoID,
        R.nombre AS refuerzo,
        R.imagen,
        C.nombre AS calidad,
        B.brawlerID
    FROM Refuerzo AS R
    INNER JOIN Calidad AS C
        ON C.calidadID = R.calidadID
    INNER JOIN DetalleBrawlerRefuerzo AS D_BR
        ON R.refuerzoID = D_BR.refuerzoID
    INNER JOIN Brawler AS B
        ON B.brawlerID = D_BR.brawlerID
    ORDER BY R.refuerzoID;

DROP VIEW vw_refuerzo_brawler;
SELECT * FROM vw_refuerzo_brawler WHERE brawlerID = 1;

#Vista de brawler con inner join de datos básicas(Sin hipercarga)
CREATE VIEW vw_Brawler AS
    SELECT 
        B.brawlerID, 
        B.nombre AS brawler,
        B.salud,
        B.daño,
        A.nombre AS alcance,
        C.nombre AS calidad,
        T.nombre AS tipo
    FROM Brawler AS B
    INNER JOIN Alcance AS A
        ON B.alcanceID = A.alcanceID
    INNER JOIN Calidad AS C
        ON B.calidadID = C.calidadID
    INNER JOIN Tipo AS T
        ON B.tipoID = T.tipoID;

SELECT * FROM vw_brawler;
#DROP VIEW vw_brawler;

#Vista 

#Procedimiento almacenado de todos los datos de un brawler
DELIMITER $$
CREATE PROCEDURE GetBrawler(IN idToSearch INT)
BEGIN
    SELECT * FROM vw_Brawler WHERE vw_Brawler.brawlerID = idToSearch;

    SELECT
        G.gadgetID,
        G.nombre AS gadget,
        G.imagen
    FROM Gadget AS G
    WHERE G.BrawlerID = idToSearch;

    SELECT 
        E.estelarId,
        E.nombre AS estelar,
        E.imagen
    FROM Estelar AS E
    WHERE E.BrawlerId = idToSearch;

    SELECT
        refuerzoID,
        refuerzo,
        imagen,
        calidad
    FROM vw_refuerzo_brawler
    WHERE brawlerID = idToSearch;

    SELECT
        S.superID,
        S.nombre AS super,
        S.descripcion,
        S.imagen
    FROM Super AS S
    WHERE S.brawlerID = idToSearch;

    SELECT
        H.nombre AS hipercarga,
        H.descripcion,
        H.imagen
    FROM Hipercarga AS H
    INNER JOIN brawler AS B
        ON H.hipercargaID = B.hipercargaID
    WHERE B.brawlerID = idToSearch;

    SELECT
        SE.statsExtraID,
        SE.salud,
        SE.daño,
        A.nombre AS alcance
    FROM statsExtra AS SE
    INNER JOIN alcance AS A
        ON A.alcanceID = SE.alcanceID
    WHERE SE.brawlerID = idToSearch;
END
DELIMITER ;
DROP PROCEDURE IF EXISTS GetBrawler;
CALL GetBrawler(2);


