USE brawlapi;

INSERT INTO Calidad (nombre) VALUES 
('Especial'),
('Superespecial'),
('Épico'),
('Mítico'),
('Legendario'),
('Brawler Inicial');

INSERT INTO Alcance (nombre) VALUES 
('Corto'),
('Medio'),
('Largo'),
('Muy Largo');

INSERT INTO Tipo (nombre) VALUES 
('Control'),
('Tanque'),
('Asesino'),
('Destructor'),
('Apoyo'),
('Tiro de Élite'),
('Artilleria');

INSERT INTO Refuerzo (nombre, imagen, calidadID) VALUES
('Velocidad', 'https://example.com/velocidad.png', 2),
('Visión', 'https://example.com/vision.png', 2),
('Salud', 'https://example.com/salud.png', 2),
('Escudo', 'https://example.com/escudo.png', 2),
('Daño', 'https://example.com/dano.png', 2),
('Carga de Gadget', 'https://example.com/carga_gadget.png', 2);

INSERT INTO hipercarga (nombre, descripcion, imagen) VALUES
('TEMPORADA DE FLORACIÓN', 'La Granda punzante actúa sobre un área un 20% mayor.', 'https://www.asset.com');


INSERT INTO Brawler(nombre, salud, daño, alcanceID, calidadID, tipoID, hipercargaID)
VALUES
('SPIKE', 5600, '1080', 3, 5, 4, 1),
('KIT', 6000, '2000', 1, 5, 5, NULL),
('R-T', 5070, '910', 4, 4, 4, NULL);

#INSERT INTO DetalleBrawlerRefuerzo(brawlerID, refuerzoID) VALUES
#(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),
#(2,1),(2,2),(2,3),(2,4),(2,5),(2,6);

INSERT INTO StatsExtra (salud, daño, alcanceID, brawlerID) VALUES
(NULL, '3200', 3,2);
(NULL, '1612', 1,3)

INSERT INTO Gadget (nombre, imagen, brawlerID) VALUES 
('Lluvia de Espinas', 'https://example.com/gadget1.png',1),('Vida Vegetal','https://example.com/gadget2.png',1),
('Caja de Cartón', 'https://example.com/gadget3.png',2),('Hamburgesa con Queso', 'https://example.com/gadget4.png',2),
('Sin Cobertura','https://example.com/gadget5.png',3),('Cuentas Atrás','https://example.com/gadget6.png',3);

INSERT INTO Estelar(nombre, imagen, brawlerID) VALUES
('Fertilizante', 'https://example.com/estelar1.png',1),('Curvatura','https://example.com/estelar2.png',1),
('Sed de Poder', 'https://example.com/estelar3.png',2),('Apego Excesivo', 'https://example.com/estelar4.png',2),
('Álgebra','https://example.com/estelar5.png',3),('Grabación','https://example.com/estelar6.png',3);

INSERT INTO Super (nombre, descripcion, imagen, brawlerID)
VALUES
('Granada Punzante', 'Spike lanza una granada espinanda que ralentiza y daña a los enemigos que se encuentran dentro de su área de explosión.',
'https://example.com/super1.png',1),

('A Caballito', 'Salta y se sube a las espaldas de otro brawler. Cura a los aliados e inflige daño a los enemigos con el paso del tiempo.',
'https://example.com/super2.png',2),

('El Escondite Inglés', 'R-T se divide en dos. Sus piernas se quedan atrás, y sus dos mitades consiguen un poderoso ataque a corta distancia que marca a los enemigos. R-T se mueve más rápido.',
'https://example.com/super3.png',3)

('Onda de Radar', 'R-T se teletransporta a sus piernas y vuelve a estar entero. Recupera 1000 puntos de vida.', 
'https://example.com/super4.png',3);
