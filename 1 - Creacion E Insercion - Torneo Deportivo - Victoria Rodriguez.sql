#############################################################
#############################################################
################# INICIO - CREACION DE DATOS ################
#############################################################
#############################################################


CREATE DATABASE TorneoDeportivoVictoriaRodriguez;

USE TorneoDeportivoVictoriaRodriguez;

CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.arbitro (
	id_arbitro  INT AUTO_INCREMENT UNIQUE,
	nombre_a TEXT NOT NULL,
    apellido_a TEXT(40) NOT NULL,
    dni_a INT(11) NOT NULL,
    años_experiencia INT NOT NULL,
    mail VARCHAR(80) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_partido INT, -- foreign key partido
    PRIMARY KEY (id_arbitro),
    INDEX dni_a (dni_a)
);

CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.autoridad_club (
	id_autoridad	INT	NOT NULL  AUTO_INCREMENT,
	nombre_autoridad_club	TEXT(40) NOT NULL,
	apellido_autoridad_club	TEXT(40) NOT NULL,
    dni_club	INT	NOT NULL,
    PRIMARY KEY (id_autoridad)
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.autoridad_torneo (
	id_autoridad	INT	NOT NULL  AUTO_INCREMENT,
	nombre_autoridad	TEXT(40) NOT NULL,
	apellido_autoridad	TEXT(40) NOT NULL,
    dni	INT	NOT NULL,
	nombre_torneo	VARCHAR(30)	NOT NULL,
	nombre_empresa	TEXT(60)	NOT NULL,
    PRIMARY KEY (id_autoridad)
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.categoria (
	id_cat INT AUTO_INCREMENT,
    categoria INT NOT NULL,
    PRIMARY KEY (id_cat)
    -- foreign key categoria por que voy a realizar busquedas por la categoria de un jugador
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.club(
	id_club INT AUTO_INCREMENT,
    nombre_club VARCHAR(60) NOT NULL,
    id_autoridad_club INT NOT NULL,
    PRIMARY KEY (id_club)
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.condicion_alimentaria (
	id_comidas INT AUTO_INCREMENT,
	nombre_condicion TEXT(25),
    PRIMARY KEY (id_comidas)
);

CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.equipo_f (
	id_equipo_f INT AUTO_INCREMENT,
    categoria INT NOT NULL,
    id_dt INT  NOT NULL,
    partidos_jugados INT NOT NULL DEFAULT(0),
    partidos_a_jugar INT NOT NULL DEFAULT(0),
	sexo char DEFAULT 'F',
    id_club INT  NOT NULL,
    PRIMARY KEY (id_equipo_f),
    INDEX (categoria, id_club)
    -- foreign key categoria y id_equipo y id_club
	, CONSTRAINT fk_id_equipo_f FOREIGN KEY (id_equipo_f) REFERENCES club (id_club) ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.equipo_m (
	id_equipo_m INT AUTO_INCREMENT,
    categoria INT NOT NULL,
    id_dt INT  NOT NULL,
    partidos_jugados INT NOT NULL DEFAULT(0),
    partidos_a_jugar INT NOT NULL DEFAULT(0),
	sexo char DEFAULT 3,
    id_club INT  NOT NULL,
    PRIMARY KEY (id_equipo_M),
    INDEX (categoria, id_club)
    -- foreign key categoria y id_equipo y id_club
	, CONSTRAINT fk_id_equipo_m FOREIGN KEY (id_equipo_m) REFERENCES club (id_club) ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.goleador (
	id_goleador INT AUTO_INCREMENT,
	id_jugador INT,
    categoria INT(4),
    goles INT,
    id_club INT,
    PRIMARY KEY (id_goleador)
    -- fk id_jugador, categoria
    -- indice cantidad_partidos
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.jugador_f (
	id_jugador_f INT AUTO_INCREMENT ,
    nombre_j TEXT(40) NOT NULL,
    apellido_j TEXT(40) NOT NULL,
    dni_j INT(11) NOT NULL ,
    categoria INT(4) NOT NULL,
    numero_camiseta INT(2) NOT NULL,
    camiseta_talle INT NOT NULL,
    pantalon_talle INT NOT NULL,
    partidos_jugados INT NOT NULL,
    goles INT NOT NULL,
	sexo char DEFAULT 'F',
    id_club INT,
    id_comida INT,
    id_posicion INT,
    PRIMARY KEY (id_jugador_f),
    INDEX dni_j (dni_j)
    , CONSTRAINT fk_id_club FOREIGN KEY (id_jugador_f) REFERENCES club (id_club) ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.jugador_m (
	id_jugador_m INT AUTO_INCREMENT ,
    nombre_j TEXT(40) NOT NULL,
    apellido_j TEXT(40) NOT NULL,
    dni_j INT(11) NOT NULL ,
    categoria INT(4) NOT NULL,
    numero_camiseta INT(2) NOT NULL,
    camiseta_talle TEXT(10) NOT NULL,
    pantalon_talle TEXT(10) NOT NULL,
    partidos_jugados INT NOT NULL,
    goles INT NOT NULL,
	sexo char DEFAULT 3,
    id_club INT,
    id_comida INT,
	id_posicion INT,
    PRIMARY KEY (id_jugador_m),
    INDEX dni_j (dni_j)
    , CONSTRAINT fk_id_club_m FOREIGN KEY (id_jugador_m) REFERENCES club (id_club)  ON UPDATE CASCADE

);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.log_goleador (
    id_goleador INT AUTO_INCREMENT,
    id_jugador INT,
	old_id_jugador INT,
    categoria INT(4) NOT NULL,
    goles INT NOT NULL,
    id_club INT NOT NULL,
    PRIMARY KEY (id_goleador)
    -- fk id_jugador, categoria
    -- indice cantidad_partidos
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.log_equipo_goleador (
    id_partido INT AUTO_INCREMENT,
    old_id_id_partido INT,
    categoria INT(4) NOT NULL,
    equipo_visitante_goles INT NOT NULL,
    equipo_local_goles INT NOT NULL,
    PRIMARY KEY (id_partido)

);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.partido_f (
	id_partido INT AUTO_INCREMENT,
    id_arbitro INT NOT NULL,
	fecha_hora DATETIME NOT NULL,
    categoria INT NOT NULL DEFAULT 0, 
    id_equipo_local INT NOT NULL,
    id_equipo_visitante INT NOT NULL,
    equipo_local_goles INT NOT NULL DEFAULT 0,
	equipo_visitante_goles INT NOT NULL DEFAULT 0,
    id_equipo_ganador INT NOT NULL DEFAULT 0,
    id_equipo_perdedor INT NOT NULL DEFAULT 0,
    finalizado_correctamente TINYINT,
    sexo_j CHAR DEFAULT 'F',
    PRIMARY KEY (id_partido)
    -- foreign key id_equipo_local y visitante 
	, CONSTRAINT fk_id_equipo_local_f FOREIGN KEY (id_equipo_local) REFERENCES club (id_club)
);


CREATE TABLE IF NOT EXISTS  TorneoDeportivoVictoriaRodriguez.partido_con_mas_goles (
	id_partido_con_mas_goles INT AUTO_INCREMENT,
	id_partido INT,
    id_arbitro INT NOT NULL,
    categoria INT NOT NULL DEFAULT 0, 
    id_equipo_local INT NOT NULL,
    id_equipo_visitante INT NOT NULL,
    equipo_local_goles INT NOT NULL DEFAULT 0,
	equipo_visitante_goles INT NOT NULL DEFAULT 0,
    id_equipo_ganador INT NOT NULL DEFAULT 0,
    id_equipo_perdedor INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_partido_con_mas_goles)
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.partido_m (
	id_partido INT AUTO_INCREMENT,
    id_arbitro INT NOT NULL,
	fecha_hora DATETIME NOT NULL,
    categoria INT NOT NULL DEFAULT 0, 
    id_equipo_local INT NOT NULL,
    id_equipo_visitante INT NOT NULL,
    equipo_local_goles INT NOT NULL DEFAULT 0,
	equipo_visitante_goles INT NOT NULL DEFAULT 0,
    id_equipo_ganador INT NOT NULL DEFAULT 0,
    id_equipo_perdedor INT NOT NULL DEFAULT 0,
    finalizado_correctamente TINYINT,
    sexo_j CHAR DEFAULT 3,
    PRIMARY KEY (id_partido)
    -- foreign key id_equipo_local y visitante 
	, CONSTRAINT fk_id_equipo_local_m FOREIGN KEY (id_equipo_local) REFERENCES club (id_club)
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.periodista (
	id_periodista INT AUTO_INCREMENT,
	nombre_p	TEXT(40)  NOT NULL,
	apellido_p	TEXT(40)  NOT NULL,
    dni_p	INT(11)	NOT NULL,
	mail_p VARCHAR(80) NOT NULL,
	telefono_p VARCHAR(20) NOT NULL,
	años_experiencia_p INT NOT NULL,
    prensa TEXT(45),
    PRIMARY KEY (id_periodista)
    -- FK PRENSA para ver a cual pertenece
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.posicion (
	id_posicion INT AUTO_INCREMENT UNIQUE,
    nombre_posicion TEXT(18) NOT NULL,
	nombre_posicion_corto TEXT(10) NOT NULL,
    PRIMARY KEY (id_posicion)
);


CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.talle (
	id_talle INT AUTO_INCREMENT,
	talle TEXT(25) NOT NULL,
    talle_por_tamaño TEXT(25) NOT NULL,
    PRIMARY KEY (id_talle)
);



CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.televisacion_prensa (
	id_prensa INT	NOT NULL  AUTO_INCREMENT,
	nro_camaras_disponibles	INT  NOT NULL,
	trae_periodista	TINYINT  NOT NULL,
    id_periodista INT	NOT NULL,
	remuneracion DECIMAL(10, 2)	NOT NULL,
	nombre_empresa	TEXT(60)	NOT NULL,
	mail VARCHAR(80) NOT NULL,
	 telefono VARCHAR(20) NOT NULL,
    oficina_direccion	VARCHAR(60)	NOT NULL,
    PRIMARY KEY (id_prensa)
);

CREATE TABLE IF NOT EXISTS TorneoDeportivoVictoriaRodriguez.televisacion_prensa (
	id_prensa INT	NOT NULL  AUTO_INCREMENT,
	nro_camaras_disponibles	INT  NOT NULL,
	trae_periodista	TINYINT  NOT NULL,
    id_periodista INT	NOT NULL,
	remuneracion DECIMAL(10, 2)	NOT NULL,
	nombre_empresa	TEXT(60)	NOT NULL,
	mail VARCHAR(80) NOT NULL,
	 telefono VARCHAR(20) NOT NULL,
    oficina_direccion	VARCHAR(60)	NOT NULL,
    PRIMARY KEY (id_prensa)
);




# Si en mi computadora no arrojo esta linea, no me permite insertar dato en las tablas que tienen FK
SET FOREIGN_KEY_CHECKS = 0;

#############################################################
#############################################################
################## FIN - CREACION DE DATOS ##################
#############################################################
#############################################################


#############################################################
#############################################################
################ INICIO - INSERCION DE DATOS ################
#############################################################
#############################################################


USE TorneoDeportivoVictoriaRodriguez;

INSERT INTO arbitro (id_arbitro,nombre_a,apellido_a,dni_a,años_experiencia,mail,telefono)
VALUES 
(NULL,'Leonardo','Alvarez',25444666,3,'leonardo_alvarez311@gmail.com','5491133334444'),
(NULL,'Camila','Ortega',77888999,5,'cam51ortega@hotmail.com','5491145677894'),
(NULL,'Azul','Perez',55666222,4,'perezazul988@gmail.com','5491178945612')
;


INSERT INTO autoridad_club (id_autoridad,nombre_autoridad_club,apellido_autoridad_club,dni_club)
VALUES
(NULL, 'Reagen', 'Heazel', 92254832),
(NULL, 'Hilly', 'Hampe', 23002107),
(NULL, 'Korey', 'Wilcott', 22839203),
(NULL, 'Jeromy', 'Pallister', 66661885),
(NULL, 'Nickey', 'Cervantes', 74195718),
(NULL, 'Celine', 'Claxton', 96236665),
(NULL, 'Bald', 'Londing', 48101821),
(NULL, 'Jenifer', 'Willstrop', 85218311),
(NULL, 'Guilbert', 'Summerhayes', 92605610),
(NULL, 'Laurens', 'Hugonnet', 55746162)
;


INSERT INTO autoridad_torneo (id_autoridad,nombre_autoridad,apellido_autoridad,dni,nombre_torneo,nombre_empresa)
VALUES
(NULL,'Ismael','Ruiz',12345678,'FeMeBal','FederacionDeportiva'),
(NULL,'Viviana','Gonzalez',87654321,'FeMeBal','FederacionDeportiva'),
(NULL,'Ileana','Mora',45678954,'FeMeBal','FederacionDeportiva')
;

INSERT INTO club (id_club, nombre_club, id_autoridad_club)
VALUES 
(NULL,'CASLA', 1),
(NULL,'CARP', 2),
(NULL,'CABJ', 3),
(NULL,'SEDALO', 4),
(NULL,'AAAJ', 5),
(NULL,'DORREGO', 6)

;

INSERT INTO categoria (id_cat, categoria)
VALUES 
(NULL,2000),
(NULL,1999),
(NULL,1998),
(NULL,1997),
(NULL,1996),
(NULL,1995)
;

INSERT INTO condicion_alimentaria (id_comidas,nombre_condicion)
VALUES
(NULL,'vegetariano'),
(NULL,'vegano'),
(NULL,'omnivoro'),
(NULL,'diabetico'),
(NULL,'celiaco')
;


INSERT INTO periodista (id_periodista,nombre_p,apellido_p,dni_p,mail_p,telefono_p,años_experiencia_p,prensa)
VALUES
(NULL,'Esteban','Echeverria',45126577,'eche_este@gmail.com','5491111123321',3,0),
(NULL,'Ludmila','Olivero',77888999,'olivero456@gmail.com','5491112344321',5,0),
(NULL,'Micaela','Sans',99542567,'micasans13@gmail.com','54977704777',4,0)
;

INSERT INTO posicion (id_posicion,nombre_posicion,nombre_posicion_corto)
VALUES
(NULL,'central','cen'),
(NULL,'armado_derecho','ar_der'),
(NULL,'armado_izquierdo','ar_izq'),
(NULL,'lateral_derecho','lat_der'),
(NULL,'lateral_izquierdo','lat_izq'),
(NULL,'arquero','arq'),
(NULL,'suplente','sup')
;

INSERT INTO televisacion_prensa (id_prensa,nro_camaras_disponibles,trae_periodista,id_periodista,remuneracion,nombre_empresa,mail,telefono,oficina_direccion)

VALUES
(NULL,20,1,1,40000,'A.S.G Entertainment','asgentertainment@gmail.com','5491145655566','Av. Boedo 450' ),
(NULL,40,0,0,65000,'Servicios TV TODO','tvtodo_contacto@hotmail.com','5491188253201', 'Av Libertador 666'),
(NULL,30,1,2,50000,'Hermanos CUH', 'cuhhnos@gmail.com' ,'5491185213698','Av Gaona 789')
;

INSERT INTO talle(id_talle, talle, talle_por_tamaño)
VALUES 
(NULL, 'S', 'S'),
(NULL, 'XS', 'S'),
(NULL, 'M', 'M'),
(NULL, 'L', 'L'),
(NULL, 'XL', 'L'),
(NULL, '2XL', 'L'),
(NULL, '2XL', 'L')
;



INSERT INTO jugador_f (id_jugador_f,nombre_j,apellido_j,dni_j,categoria,numero_camiseta,camiseta_talle,pantalon_talle,partidos_jugados,goles,sexo,id_club,id_comida, id_posicion)
VALUES

# 1995 - 1
(NULL, 'Antonia', 'Chiosso', 98604,1995, 95, 7, 3, 0, 0, 'F', 1, 1, 1),
(NULL, 'Aleja', 'Hornos', 10512,1995, 86, 5, 5, 0, 0, 'F', 1, 2, 2),
(NULL, 'Holly', 'Ocampo', 97769,1995, 21, 3, 6, 0, 0, 'F', 1, 3, 3),
(NULL, 'Rey', 'Tejerina', 99390,1995, 92, 7, 6, 0, 0, 'F', 1, 4, 4),
(NULL, 'Ana', 'Rosales', 68109,1995, 37, 7, 2, 0, 0, 'F', 1, 5, 5),
(NULL, 'Paula', 'Capone', 49042,1995, 38, 4, 2, 0, 0, 'F', 1, 5, 6),
(NULL, 'Gastona', 'Causa', 36463,1995, 4, 3, 5, 0, 0, 'F', 1, 3, 7),
(NULL, 'Victoria', 'Simonet', 81955,1995, 93, 2, 4, 0, 0, 'F', 1, 3, 7),
(NULL, 'Clara', 'Lopez', 52460,1995, 53, 2, 1, 0, 0, 'F', 1, 1, 7),
(NULL, 'Lourdes', 'Brasseco', 61434,1995, 24, 5, 6, 0, 0, 'F', 1, 3, 7),
(NULL, 'Celina', 'Eandi', 21675,1995, 22, 4, 3, 0, 0, 'F', 1, 4, 7),
(NULL, 'Raquel', 'Garcia', 65211,1995, 59, 3, 1, 0, 0, 'F', 1, 5, 7),
(NULL, 'Viviana', 'Chavez', 46771,1995, 50, 5, 4, 0, 0, 'F', 1, 3, 7),
(NULL, 'Sofia', 'Alvarez', 51826,1995, 84, 4, 2, 0, 0, 'F', 1, 2, 7),
(NULL, 'Eliana', 'Perez', 59146,1995, 37, 1, 6, 0, 0, 'F', 1, 1, 7),
(NULL, 'Ileana', 'Rodriguez', 55752,1995, 89, 6, 7, 0, 0, 'F', 1, 1, 7),

# 1996 - 1
(NULL, 'Valentina', 'Jacoby', 98604,1996, 95, 7, 3, 0, 0, 'F', 1, 1, 1),
(NULL, 'Antonia', 'ALLUE', 10512,1996, 86, 5, 5, 0, 0, 'F', 1, 2, 2),
(NULL, 'Daniela', 'Fiorentino', 97769,1996, 21, 3, 6, 0, 0, 'F', 1, 3, 3),
(NULL, 'Cristina', 'Pinasco', 99390,1996, 92, 7, 6, 0, 0, 'F', 1, 4, 4),
(NULL, 'Ivana', 'Zemborain', 68109,1996, 37, 7, 2, 0, 0, 'F', 1, 5, 5),
(NULL, 'Miriam', 'Molina', 49042,1996, 38, 4, 2, 0, 0, 'F', 1, 5, 6),
(NULL, 'Jazmin', 'Navarro', 36463,1996, 4, 3, 5, 0, 0, 'F', 1, 3, 7),
(NULL, 'Perla', 'Melmik', 81955,1996, 93, 2, 4, 0, 0, 'F', 1, 3, 7),
(NULL, 'Marina', 'Moya', 52460,1996, 53, 2, 1, 0, 0, 'F', 1, 1, 7),
(NULL, 'Martina', 'Giorgi', 61434,1996, 24, 5, 6, 0, 0, 'F', 1, 3, 7),
(NULL, 'Merlina', 'Casini', 21675,1996, 22, 4, 3, 0, 0, 'F', 1, 4, 7),
(NULL, 'Dana', 'Terraza', 65211,1996, 59, 3, 1, 0, 0, 'F', 1, 5, 7),
(NULL, 'Paola', 'Oliva', 46771,1996, 50, 5, 4, 0, 0, 'F', 1, 3, 7),
(NULL, 'Angelica', 'Banzas', 51826,1996, 84, 4, 2, 0, 0, 'F', 1, 2, 7),
(NULL, 'Abril', 'Bazan', 59146,1996, 37, 1, 6, 0, 0, 'F', 1, 1, 7),
(NULL, 'Luna', 'Araujo', 55752,1996, 89, 6, 7, 0, 0, 'F', 1, 1, 7),

# 1997 - 1
(NULL, 'Jeannie', 'Mandrier', 16049, 1997, 38, 1, 1, 0, 1, 'F', 1, 5, 1),
(NULL, 'Fae', 'Caress', 41369, 1997, 6, 7, 3, 0, 1,'F', 1, 5, 2),
(NULL, 'Candice', 'Mellsop', 72672, 1997, 44, 1, 5, 0, 1, 'F',1, 3, 3),
(NULL, 'Erminie', 'Matuskiewicz', 85546, 1997, 16, 1, 5, 4, 0, 'F', 1, 3, 4),
(NULL, 'Elna', 'Labes', 70094, 1997, 67, 3, 4, 0, 0, 'F', 1, 1, 5),
(NULL, 'Deirdre', 'Syne', 95173, 1997, 34, 6, 3, 0, 9, 'F', 1, 3, 6),
(NULL, 'Nanny', 'Ivanyushkin', 85023, 1997, 52, 3, 2, 0, 0, 'F', 1, 4, 7),
(NULL, 'Nevsa', 'Gostick', 31003, 1997, 21, 6, 2, 0, 0, 'F', 1, 5, 7),
(NULL, 'Ede', 'Abba', 74629, 1997, 47, 6, 7, 0, 0, 'F', 1, 3, 7),
(NULL, 'Donielle', 'Sheriff', 78935, 1997, 56, 4, 2, 0, 0, 'F', 1, 2, 7),
(NULL, 'Lanna', 'Croasdale', 63254, 1997, 19, 3, 2, 0, 2, 'F', 1, 1, 7),
(NULL, 'Cynthia', 'Kissack', 10426, 1997, 39, 5, 3, 0, 0, 'F', 1, 1, 7),

# 1998 - 1
(NULL, 'Alyse', 'Bakey', 82247, 1998, 81, 1, 1, 0, 5, 'F', 1, 1, 1),
(NULL, 'Kayla', 'Kiss', 96478, 1998, 1, 5, 1, 0, 0, 'F', 1, 2, 2),
(NULL, 'Danica', 'Carroll', 96891, 1998, 60, 4, 6, 0, 0, 'F', 1, 3, 3),
(NULL, 'Tallie', 'Bayne', 40657, 1998, 42, 3, 5, 0, 0, 'F', 1, 4, 4),
(NULL, 'Nancy', 'Forrestor', 53616, 1998, 34, 5, 4, 0, 7, 'F', 1, 5, 5),
(NULL, 'Tabbatha', 'Cutmere', 20793, 1998, 92, 2, 4, 0, 0, 'F', 1, 5, 6),
(NULL, 'Ebonee', 'Pointing', 94710, 1998, 55, 4, 6, 0, 0, 'F', 1, 3, 7),
(NULL, 'Gabriella', 'Ganing', 28249, 1998, 8, 7, 1, 0, 0, 'F', 1, 3, 7),
(NULL, 'Dulci', 'Skilton', 61318, 1998, 59, 4, 2, 0, 0, 'F', 1, 1, 7),
(NULL, 'Kiri', 'Tavernor', 39033, 1998, 13, 1, 3, 0, 0, 'F', 1, 3, 7),
(NULL, 'Ilse', 'Sculley', 58824, 1998, 61, 2, 3, 0, 0, 'F', 1, 4, 7),
(NULL, 'Engracia', 'Death', 80112, 1998, 82, 6, 3, 0, 0, 'F', 1, 5, 7),
(NULL, 'Margaret', 'Crompton', 77678, 1998, 79, 1, 5, 0, 0, 'F', 1, 3, 7),
(NULL, 'Merissa', 'Beardsdale', 66430, 1998, 32, 5, 5, 0, 0, 'F', 1, 2, 7),
(NULL, 'Sula', 'Gerrie', 94960, 1998, 35, 4, 1, 0, 0, 'F', 1, 1, 7),
(NULL, 'Tonia', 'Girdler', 39385, 1998, 99, 7, 4, 0, 0, 'F', 1, 1, 7),

# 1999 - 1
(NULL, 'Val', 'Pavel', 67412, 1999, 52, 2, 3, 0, 0, 'F', 1, 1, 1),
(NULL, 'Rosalyn', 'Rannells', 52745, 1999, 73, 1, 4, 0, 0, 'F', 1, 2, 2),
(NULL, 'Belinda', 'Britner', 40568, 1999, 65, 2, 7, 0, 0, 'F', 1, 3, 3),
(NULL, 'Marne', 'Schutze', 25654, 1999, 81, 6, 7, 0, 0, 'F', 1, 4, 4),
(NULL, 'Nicholle', 'Bartlam', 26693, 1999, 29, 2, 4, 0, 0, 'F', 1, 5, 5),
(NULL, 'Kaye', 'Enrrico', 58261, 1999, 44, 6, 1, 0, 0, 'F', 1, 5, 6),
(NULL, 'Jacquie', 'Ronca', 10006, 1999, 6, 4, 7, 0, 0, 'F', 1, 3, 7),
(NULL, 'Kali', 'Cringle', 54512, 1999, 17, 3, 5, 0, 0, 'F', 1, 3, 7),
(NULL, 'Barbi', 'Kann', 59431, 1999, 78, 5, 5, 0, 0, 'F', 1, 1, 7),
(NULL, 'Cybill', 'Ramage', 53048, 1999, 17, 1, 3, 0, 0, 'F', 1, 3, 7),
(NULL, 'Joleen', 'Bruinemann', 72039, 1999, 72, 7, 2, 0, 0, 'F', 1, 4, 7),
(NULL, 'Mureil', 'Haskew', 17999, 1999, 65, 3, 4, 0, 0, 'F', 1, 5, 7),
(NULL, 'Kaye', 'Rowley', 71341, 1999, 7, 5, 6, 0, 0, 'F', 1, 3, 7),
(NULL, 'Fayette', 'Pfeffle', 28899, 1999, 98, 5, 1, 0, 0, 'F', 1, 2, 7),
(NULL, 'Alverta', 'Nowakowska', 76310, 1999, 83, 7, 3, 0, 0, 'F', 1, 1, 7),
(NULL, 'Blondelle', 'Tunaclift', 23711, 1999, 96, 3, 3, 0, 0, 'F', 1, 1, 7),

# 2000 - 1
(NULL, 'Robbin', 'Fibbings', 31487, 2000, 58, 2, 5, 0, 0, 'F', 1, 1, 1),
(NULL, 'Clary', 'Hartigan', 43663, 2000, 54, 7, 1, 0, 0, 'F', 1, 2, 2),
(NULL, 'Calley', 'Devanny', 35672, 2000, 83, 3, 7, 0, 0, 'F', 1, 3, 3),
(NULL, 'Nannette', 'Titcumb', 65251, 2000, 96, 2, 2, 0, 0, 'F', 1, 4, 4),
(NULL, 'Alejandrina', 'Shesnan', 75263, 2000, 25, 6, 2, 0, 0, 'F', 1, 5, 5),
(NULL, 'Beckie', 'Itzik', 51191, 2000, 5, 6, 1, 0, 0, 'F', 1, 5, 6),
(NULL, 'Grata', 'Nalder', 39094, 2000, 6, 2, 5, 0, 0, 'F', 1, 3, 7),
(NULL, 'Anna', 'Pirrone', 13212, 2000, 26, 1, 2, 0, 0, 'F', 1,3, 7),
(NULL, 'Petronia', 'Langforth', 82956, 2000, 9, 5, 7, 0, 0, 'F', 1, 1, 7),
(NULL, 'Wanids', 'Bettridge', 15238, 2000, 70, 7, 2, 0, 0, 'F', 1, 3, 7),
(NULL, 'Chloette', 'Gaughey', 53875, 2000, 61, 7, 1, 0, 0, 'F', 1, 4, 7),
(NULL, 'Coral', 'Kydd', 32962, 2000, 72, 6, 4, 0, 0, 'F', 1, 5, 7),
(NULL, 'Ashleigh', 'Girardeau', 86610, 2000, 90, 4, 3, 0, 0, 'F', 1, 3, 7),
(NULL, 'Brittaney', 'Banner', 31696, 2000, 86, 5, 3, 0, 0, 'F', 1, 2, 7),
(NULL, 'Lanette', 'Philimore', 14530, 2000, 66, 1, 6, 0, 0, 'F', 1, 1, 7),
(NULL, 'Marissa', 'Glandfield', 21139, 2000, 71, 6, 1, 0, 0, 'F', 1, 1, 7),

# 1995 - 2
(NULL, 'Deane', 'Ebbin', 68713,1995, 9, 1, 3, 0, 0, 3, 2, 1, 1),
(NULL, 'Katee', 'Calderhead', 98439,1995, 30, 5, 2, 0, 0, 3, 2, 2, 2),
(NULL, 'Cammy', 'Estable', 19971,1995, 19, 6, 7, 0, 0, 'F', 2, 3, 3),
(NULL, 'Briny', 'Coysh', 88329,1995, 67, 7, 7, 0, 0, 'F', 2, 4, 4),
(NULL, 'Romy', 'Couchman', 62131,1995, 33, 5, 5, 0, 0, 3, 2, 5, 5),
(NULL, 'Shelley', 'Lillie', 90522,1995, 16, 6, 1, 0, 0, 3, 2, 5, 6),
(NULL, 'Josie', 'Kohneke', 81749,1995, 41, 1, 4, 0, 0, 3, 2, 3, 7),
(NULL, 'Linnell', 'Gibbieson', 32108,1995, 81, 4, 3, 0, 0, 3, 2, 3, 7),
(NULL, 'Brittaney', 'Axston', 37029,1995, 81, 6, 3, 0, 0, 'F', 2, 1, 7),
(NULL, 'Jacquelin', 'Fray', 68513,1995, 34, 7, 3, 0, 0, 'F', 2, 3, 7),
(NULL, 'Sula', 'Yakuntsov', 85140,1995, 21, 3, 7, 0, 0, 'F', 2, 4, 7),
(NULL, 'Faith', 'Sumnall', 58123,1995, 10, 5, 6, 0, 0, 3, 2, 5, 7),
(NULL, 'Adaline', 'Miroy', 69187,1995, 49, 3, 7, 0, 0, 3, 2, 3, 7),
(NULL, 'Drona', 'Plumbe', 92426,1995, 32, 5, 3, 0, 0, 3, 2, 2, 7),
(NULL, 'Catina', 'Jankowski', 62183,1995, 89, 5, 2, 0, 0, 3, 2, 1, 7),
(NULL, 'Doralynne', 'Elles', 47506,1995, 33, 7, 1, 0, 0, 3, 2, 1, 7),

# 1996 - 2
(NULL, 'Goldie', 'Jouaneton', 85714,1996, 69, 3, 1, 0, 0, 'F', 2, 1, 1),
(NULL, 'Maris', 'Rattery', 15655,1996, 31, 1, 5, 0, 0, 'F', 2, 2, 2),
(NULL, 'Franny', 'Mulleary', 10891,1996, 10, 4, 5, 0, 0, 'F', 2, 3, 3),
(NULL, 'Pearl', 'Fittis', 55044,1996, 38, 2, 4, 0, 0, 'F', 2, 4, 4),
(NULL, 'Marketa', 'Cyseley', 73918,1996, 34, 2, 4, 0, 0, 'F', 2, 5, 5),
(NULL, 'Melesa', 'Vinter', 32163,1996, 93, 7, 3, 0, 0, 'F', 2, 5, 6),
(NULL, 'Kristine', 'Allebone', 43407,1996, 50, 1, 6, 0, 0, 'F', 2, 3, 7),
(NULL, 'Consolata', 'Ovens', 38225,1996, 1, 4, 7, 0, 0, 'F', 2, 3, 7),
(NULL, 'Channa', 'Waterdrinker', 46553,1996, 98, 3, 5, 0, 0, 'F', 2, 1, 7),
(NULL, 'Barbey', 'Isselee', 16354,1996, 8, 6, 6, 0, 0, 'F', 2, 3, 7),
(NULL, 'Dorolisa', 'Batham', 60076,1996, 89, 2, 5, 0, 0, 'F', 2, 4, 7),
(NULL, 'Lynne', 'Axell', 69487,1996, 24, 6, 6, 0, 0, 'F', 2, 5, 7),
(NULL, 'Crista', 'Marshman', 16695,1996, 30, 7, 4, 0, 0, 'F', 2, 3, 7),
(NULL, 'Thomasina', 'Ruffy', 73332,1996, 96, 5, 3, 0, 0, 'F', 2, 2, 7),
(NULL, 'Eddi', 'Featonby', 83009,1996, 6, 1, 1, 0, 0, 'F', 2, 1, 7),
(NULL, 'Garland', 'Warton', 97418,1996, 95, 3, 1, 0, 0, 'F', 2, 1, 7),

# 1997 - 2
(NULL, 'Mechelle', 'Castagnone', 91546,1997, 42, 4, 7, 0, 0, 'F', 2, 1, 1),
(NULL, 'Letizia', 'Boswood', 84852,1997, 7, 4, 4, 0, 0, 'F', 2, 2, 2),
(NULL, 'Ray', 'Bowden', 55409,1997, 92, 2, 7, 0, 0, 'F', 2, 3, 3),
(NULL, 'Kary', 'Czajkowska', 48678,1997, 90, 3, 1, 0, 0, 'F', 2, 4, 4),
(NULL, 'Darbie', 'Stenbridge', 56723,1997, 7, 7, 2, 0, 0, 'F', 2, 5, 5),
(NULL, 'Joannes', 'Fauguel', 76747,1997, 49, 6, 2, 0, 0, 'F', 2, 5, 6),
(NULL, 'Angele', 'Noblet', 93058,1997, 63, 3, 7, 0, 0, 'F', 2, 3, 7),
(NULL, 'Leigh', 'Huddle', 12421,1997, 30, 5, 5, 0, 0, 'F', 2, 3, 7),
(NULL, 'Carlye', 'Pittham', 97245,1997, 61, 3, 7, 0, 0, 'F', 2, 1, 7),
(NULL, 'Celie', 'Newvell', 47850,1997, 83, 5, 5, 0, 0, 'F', 2, 3, 7),
(NULL, 'Ray', 'Gerrels', 77856,1997, 77, 3, 3, 0, 0, 'F', 2, 4, 7),
(NULL, 'Fayette', 'Jakubowsky', 14960,1997, 73, 7, 5, 0, 0, 'F', 2, 5, 7),
(NULL, 'Reyna', 'Colbourne', 53581,1997, 21, 7, 2, 0, 0, 'F', 2, 3, 7),
(NULL, 'Savina', 'Espinosa', 88337,1997, 88, 4, 1, 0, 0, 'F', 2, 2, 7),
(NULL, 'Eydie', 'Goodrum', 22537,1997, 47, 4, 1, 0, 0, 'F', 2, 1, 7),
(NULL, 'Beulah', 'Palk', 94090,1997, 92, 3, 1, 0, 0, 'F', 2, 1, 7),

# 1998 - 2
(NULL, 'Dori', 'Basili', 93280,1998, 40, 4, 7, 0, 0, 'F', 2, 1, 1),
(NULL, 'Nessie', 'Fuzzens', 86418,1998, 23, 5, 5, 0, 0, 'F', 2, 2, 2),
(NULL, 'Rosabel', 'Blastock', 74070,1998, 98, 4, 5, 0, 0, 'F', 2, 3, 3),
(NULL, 'Abra', 'McGarvey', 14375,1998, 81, 4, 6, 0, 0, 'F', 2, 4, 4),
(NULL, 'Bernadene', 'Muat', 45952,1998, 59, 4, 1, 0, 0, 'F', 2, 5, 5),
(NULL, 'Adina', 'Espada', 68441,1998, 37, 7, 6, 0, 0, 'F', 2, 5, 6),
(NULL, 'Christiana', 'Pude', 28484,1998, 8, 4, 1, 0, 0, 'F', 2, 3, 7),
(NULL, 'Marjory', 'Popley', 30962,1998, 88, 3, 3, 0, 0, 'F', 2, 3, 7),
(NULL, 'Dannie', 'Coat', 66397,1998, 92, 2, 3, 0, 0, 'F', 2, 1, 7),
(NULL, 'Nerissa', 'Pougher', 47138,1998, 41, 2, 6, 0, 0, 'F', 2, 3, 7),
(NULL, 'Con', 'Riddiford', 26192,1998, 26, 5, 6, 0, 0, 'F', 2, 4, 7),
(NULL, 'Candace', 'Naper', 75327,1998, 59, 7, 6, 0, 0, 'F', 2, 5, 7),
(NULL, 'Rivi', 'Salmons', 84265,1998, 38, 3, 6, 0, 0, 'F', 2, 3, 7),
(NULL, 'Moyna', 'Puddefoot', 85745,1998, 77, 1, 2, 0, 0, 'F', 2, 2, 7),
(NULL, 'Corie', 'Petrak', 60409,1998, 46, 4, 7, 0, 0, 'F', 2, 1, 7),
(NULL, 'Ondrea', 'Moralee', 69789,1998, 31, 5, 1, 0, 0, 'F', 2, 1, 7),


(NULL, 'Traci', 'Arkil', 89785,1999, 50, 7, 5, 0, 0, 3, 2, 1, 1),
(NULL, 'Nerissa', 'Oxx', 89812,1999, 53, 5, 4, 0, 0, 3, 2, 2, 2),
(NULL, 'Gussie', 'Dubble', 99102,1999, 60, 4, 7, 0, 0, 3, 2, 3, 3),
(NULL, 'Concettina', 'Hulcoop', 40761,1999, 5, 5, 4, 0, 0, 'F', 2, 4, 4),
(NULL, 'Clemence', 'Maulin', 17638,1999, 63, 1, 2, 0, 0, 3, 2, 5, 5),
(NULL, 'Ami', 'Mungham', 87041,1999, 70, 6, 6, 0, 0, 3, 2, 5, 6),
(NULL, 'Zoe', 'McVitie', 57243,1999, 26, 7, 3, 0, 0, 'F', 2, 3, 7),
(NULL, 'Kara', 'Reignould', 45119,1999, 64, 3, 7, 0, 0, 3, 2, 3, 7),
(NULL, 'Faye', 'Gerbi', 64302,1999, 96, 5, 7, 0, 0, 'F', 2, 1, 7),
(NULL, 'Rheta', 'Wanek', 30163,1999, 92, 2, 3, 0, 0, 3, 2, 3, 7),
(NULL, 'Stacy', 'Aylin', 39133,1999, 68, 6, 4, 0, 0, 3, 2, 4, 7),
(NULL, 'Hanny', 'Shillitoe', 36480,1999, 63, 2, 7, 0, 0, 3, 2, 5, 7),
(NULL, 'Lexine', 'Eastam', 42447,1999, 15, 6, 2, 0, 0, 3, 2, 3, 7),
(NULL, 'Pauli', 'Pridding', 56703,1999, 70, 4, 2, 0, 0, 3, 2, 2, 7),
(NULL, 'Basia', 'Trussler', 17405,1999, 51, 6, 1, 0, 0, 'F', 2, 1, 7),
(NULL, 'Hollyanne', 'Fernant', 19326,1999, 87, 1, 6, 0, 0, 'F', 2, 1, 7),

# 1999 - 2
(NULL, 'Vida', 'Quharge', 97302,2000, 12, 7, 2, 0, 0, 'F', 2, 1, 1),
(NULL, 'Hannis', 'Garstang', 92012,2000, 34, 5, 7, 0, 0, 'F', 2, 2, 2),
(NULL, 'Chryste', 'Yankishin', 97277,2000, 61, 1, 6, 0, 0, 'F', 2, 3, 3),
(NULL, 'Jacquette', 'Lubeck', 36901,2000, 96, 4, 5, 0, 0, 'F', 2, 4, 4),
(NULL, 'Shayna', 'Parsonson', 47240,2000, 46, 4, 7, 0, 0, 'F', 2, 5, 5),
(NULL, 'Bobette', 'Pickering', 80257,2000, 5, 7, 4, 0, 0, 'F', 2, 5, 6),
(NULL, 'Blakeley', 'Bagley', 81418,2000, 89, 2, 6, 0, 0, 'F', 2, 3, 7),
(NULL, 'Tonia', 'Bullon', 57660,2000, 90, 1, 4, 0, 0, 'F', 2, 3, 7),
(NULL, 'Evy', 'Lattimore', 89759,2000, 27, 4, 7, 0, 0, 'F', 2, 1, 7),
(NULL, 'Gladi', 'Abberley', 73686,2000, 3, 7, 5, 0, 0, 'F', 2, 3, 7),
(NULL, 'Bibby', 'Laidler', 22894,2000, 52, 4, 6, 0, 0, 'F', 2, 4, 7),
(NULL, 'Blondell', 'Jewes', 70260,2000, 41, 5, 5, 0, 0, 'F', 2, 5, 7),
(NULL, 'Bibby', 'Ubsdale', 31487,2000, 91, 6, 2, 0, 0, 'F', 2, 3, 7),
(NULL, 'Pauly', 'Bourgour', 70440,2000, 56, 7, 2, 0, 0, 'F', 2, 2, 7),
(NULL, 'Larisa', 'Labbey', 65406,2000, 15, 7, 1, 0, 0, 'F', 2, 1, 7),
(NULL, 'Velvet', 'Stanaway', 80119,2000, 69, 2, 3, 0, 0, 'F', 2, 1, 7),

# 1995 - 2
(NULL, 'Malina', 'Shalders', 98604,1995, 95, 7, 3, 0, 0, 'F', 3, 1, 1),
(NULL, 'Faunie', 'Ayliffe', 10512,1995, 86, 5, 5, 0, 0, 'F', 3, 2, 2),
(NULL, 'Rey', 'Kettow', 97769,1995, 21, 3, 6, 0, 0, 'F', 3, 3, 3),
(NULL, 'Holly', 'Yven', 99390,1995, 92, 7, 6, 0, 0, 'F', 3, 4, 4),
(NULL, 'Annemarie', 'Boland', 68109,1995, 37, 7, 2, 0, 0, 'F', 3, 5, 5),
(NULL, 'Muffin', 'Agglio', 49042,1995, 38, 4, 2, 0, 0, 'F', 3, 5, 6),
(NULL, 'Kessiah', 'Berni', 36463,1995, 4, 3, 5, 0, 0, 'F', 3, 3, 7),
(NULL, 'Sally', 'Scorer', 81955,1995, 93, 2, 4, 0, 0, 'F', 3, 3, 7),
(NULL, 'Trula', 'Foulstone', 52460,1995, 53, 2, 1, 0, 0, 'F', 3, 1, 7),
(NULL, 'Rosabelle', 'Kenna', 61434,1995, 24, 5, 6, 0, 0, 'F', 3, 3, 7),
(NULL, 'Marcelia', 'Cotty', 21675,1995, 22, 4, 3, 0, 0, 'F', 3, 4, 7),
(NULL, 'Ronna', 'Finkle', 65211,1995, 59, 3, 1, 0, 0, 'F', 3, 5, 7),
(NULL, 'Carolee', 'Duggon', 46771,1995, 50, 5, 4, 0, 0, 'F', 3, 3, 7),
(NULL, 'Lucilia', 'Denman', 51826,1995, 84, 4, 2, 0, 0, 'F', 3, 2, 7),
(NULL, 'Issie', 'Pudsall', 59146,1995, 37, 1, 6, 0, 0, 'F', 3, 1, 7),
(NULL, 'Carol', 'Gillie', 55752,1995, 89, 6, 7, 0, 0, 'F', 3, 1, 7),

# 1996 - 3
(NULL, 'Karlyn', 'Kearns', 91813,1996, 10, 7, 6, 0, 0, 3, 3, 1, 1),
(NULL, 'Imogene', 'Gowanlock', 92864,1996, 98, 4, 6, 0, 0, 'F', 3, 2, 2),
(NULL, 'Luella', 'Chaves', 60724,1996, 22, 7, 5, 0, 0, 3, 3, 3, 3),
(NULL, 'Lizbeth', 'Corrado', 74688,1996, 87, 3, 4, 0, 0, 3, 3, 4, 4),
(NULL, 'Clementina', 'Jelley', 51103,1996, 47, 1, 1, 0, 0, 3, 3, 5, 5),
(NULL, 'Constancy', 'Hourigan', 89646,1996, 26, 3, 7, 0, 0, 'F', 3, 5, 6),
(NULL, 'Candy', 'Van', 52714, 1996, 84, 5, 1, 0, 0, 'F',3,3, 7),
(NULL, 'Petra', 'Sibray', 51484,1996, 59, 5, 2, 0, 0, 'F', 3, 3, 7),
(NULL, 'Jeanine', 'Heatly', 36360,1996, 48, 2, 5, 0, 0, 'F', 3, 1, 7),
(NULL, 'Haley', 'Thornthwaite', 48517,1996, 2, 1, 4, 0, 0, 3, 3, 3, 7),
(NULL, 'Dotty', 'Caulkett', 39490,1996, 59, 5, 1, 0, 0, 'F', 3, 4, 7),
(NULL, 'Verine', 'Petrak', 83187,1996, 98, 5, 6, 0, 0, 3, 3, 5, 7),
(NULL, 'Raphaela', 'McCay', 49912,1996, 91, 6, 3, 0, 0, 3, 3, 3, 7),
(NULL, 'Abbye', 'Hallgate', 72511,1996, 66, 6, 7, 0, 0, 'F', 3, 2, 7),
(NULL, 'Rafaela', 'Penney', 67744,1996, 51, 4, 4, 0, 0, 'F', 3, 1, 7),
(NULL, 'Cordula', 'Fawdry', 79652,1996, 39, 4, 7, 0, 0, 'F', 3, 1, 7),

# 1997 - 3
(NULL, 'Pierrette', 'Carmen', 97095,1997, 88, 3, 2, 0, 0, 'F', 3, 1, 1),
(NULL, 'Elene', 'Conachie', 14848,1997, 92, 6, 5, 0, 0, 'F', 3, 2, 2),
(NULL, 'Amandi', 'Aspray', 66638,1997, 73, 7, 7, 0, 0, 'F', 3, 3, 3),
(NULL, 'Gae', 'Laidler', 92458,1997, 3, 4, 4, 0, 0, 'F', 3, 4, 4),
(NULL, 'Naoma', 'Kristoffersson', 27626,1997, 93, 7, 2, 0, 0, 'F', 3, 5, 5),
(NULL, 'Concettina', 'Sycamore', 99295,1997, 32, 1, 6, 0, 0, 'F', 3, 5, 6),
(NULL, 'Fey', 'Chisnall', 68217,1997, 16, 6, 2, 0, 0, 'F', 3, 3, 7),
(NULL, 'Walliw', 'Bevar', 11935,1997, 10, 2, 6, 0, 0, 'F', 3, 3, 7),
(NULL, 'Elbertina', 'Brettell', 99900,1997, 53, 4, 5, 0, 0, 'F', 3, 1, 7),
(NULL, 'Jemima', 'Sudron', 76553,1997, 38, 4, 3, 0, 0, 'F', 3, 3, 7),
(NULL, 'Malory', 'Klessmann', 31436,1997, 92, 7, 2, 0, 0, 'F', 3, 4, 7),
(NULL, 'Marja', 'Goodlud', 97366,1997, 77, 6, 3, 0, 0, 'F', 3, 5, 7),
(NULL, 'Rosie', 'Testro', 83304,1997, 44, 1, 2, 0, 0, 'F', 3, 3, 7),
(NULL, 'Arlena', 'Stockney', 32901,1997, 38, 1, 4, 0, 0, 'F', 3, 2, 7),
(NULL, 'Andie', 'Sherwen', 58720,1997, 92, 2, 6, 0, 0, 'F', 3, 1, 7),
(NULL, 'Kamillah', 'Jeanet', 38783,1997, 59, 1, 7, 0, 0, 'F', 3, 1, 7),

# 1998 - 3
(NULL, 'Lynnette', 'Becaris', 50157,1998, 84, 5, 5, 0, 0, 'F', 3, 1, 1),
(NULL, 'Babara', 'Hannan', 92704,1998, 34, 4, 3, 0, 0, 3, 3, 2, 2),
(NULL, 'Barbara', 'Leppington' ,44818, 1998, 12, 4, 4, 0, 0, 3, 3,3, 3),
(NULL, 'Alaine', 'Egdale', 48442,1998, 60, 2, 1, 0, 0, 'F', 3, 4, 4),
(NULL, 'Celinda', 'Dymock', 11290,1998, 60, 3, 6, 0, 0, 3, 3, 5, 5),
(NULL, 'Sabina', 'Sims', 99709,1998, 5, 1, 7, 0, 0, 3, 3, 5, 6),
(NULL, 'Neile', 'Mowle', 34836,1998, 3, 7, 7, 0, 0, 3, 3, 3, 7),
(NULL, 'Lynnette', 'Shyres', 29530,1998, 68, 3, 1, 0, 0, 'F', 3, 3, 7),
(NULL, 'Gertrude', 'Mixer', 10621,1998, 56, 2, 4, 0, 0, 3, 3, 1, 7),
(NULL, 'Mercy', 'Gounot', 27753,1998, 33, 6, 6, 0, 0, 3, 3, 3, 7),
(NULL, 'Grace', 'Biesty', 99308,1998, 2, 7, 7, 0, 0, 'F', 3, 4, 7),
(NULL, 'Kelsey', 'Plumtree', 34693,1998, 40, 3, 2, 0, 0, 'F', 3, 5, 7),
(NULL, 'Charlena', 'Petrasek', 25500,1998, 56, 4, 6, 0, 0, 3, 3, 3, 7),
(NULL, 'Colline', 'Denizet', 77831,1998, 69, 7, 4, 0, 0, 3, 3, 2, 7),
(NULL, 'Netti', 'Collocott', 84883,1998, 71, 3, 4, 0, 0, 'F', 3, 1, 7),
(NULL, 'Theodora', 'Bickerton', 34373,1998, 29, 3, 3, 0, 0, 'F', 3, 1, 7),

# 1999 - 3
(NULL, 'Ilyse', 'Shann', 96040,1999, 50, 1, 7, 0, 0, 'F', 3, 1, 1),
(NULL, 'Noell', 'Leades', 86874,1999, 83, 5, 4, 0, 0, 'F', 3, 2, 2),
(NULL, 'Holly', 'Garfitt', 87235,1999, 31, 7, 7, 0, 0, 'F', 3, 3, 3),
(NULL, 'Kippy', 'Suttling', 26473,1999, 46, 6, 3, 0, 0, 'F', 3, 4, 4),
(NULL, 'Debbi', 'Haggleton', 35181,1999, 22, 4, 3, 0, 0, 'F', 3, 5, 5),
(NULL, 'Francisca', 'Ferries', 29196,1999, 3, 3, 2, 0, 0, 'F', 3, 5, 6),
(NULL, 'Guenna', 'Raftery', 62029,1999, 68, 2, 4, 0, 0, 'F', 3, 3, 7),
(NULL, 'Leoine', 'Surgood', 36149,1999, 74, 7, 1, 0, 0, 'F', 3, 3, 7),
(NULL, 'Tamara', 'Chitter', 91332,1999, 51, 2, 5, 0, 0, 'F', 3, 1, 7),
(NULL, 'Teresa', 'Keedwell', 10100,1999, 66, 2, 7, 0, 0, 'F', 3, 0, 7),
(NULL, 'Cinda', 'Freddi', 24159,1999, 6, 2, 6, 0, 0, 'F', 3, 4, 7),
(NULL, 'Zsa',  'Marle' , 48119, 1999, 24, 7, 6, 0, 0, 'F', 3,5, 7),
(NULL, 'Luise', 'Claricoates', 74769,1999, 24, 3, 6, 0, 0, 'F', 3, 3, 7),
(NULL, 'Moll', 'Simchenko', 17974,1999, 38, 6, 2, 0, 0, 'F', 3, 2, 7),
(NULL, 'Jobi', 'Quarry', 13229,1999, 73, 2, 7, 0, 0, 'F', 3, 1, 7),
(NULL, 'Appolonia', 'Grinin', 10634,1999, 6, 7, 5, 0, 0, 'F', 3, 1, 7),

# 2000 - 3
(NULL, 'Georgianne', 'Lodwig', 85420,2000, 34, 1, 5, 0, 0, 'F', 3, 1, 1),
(NULL, 'Libbey', 'Madine', 51831,2000, 73, 5, 2, 0, 0, 'F', 3, 2, 2),
(NULL, 'Delcine', 'Sullivan', 78984,2000, 48, 5, 4, 0, 0, 'F', 3, 3, 3),
(NULL, 'Petunia', 'Warrillow', 28105,2000, 6, 3, 6, 0, 0, 'F', 3, 4, 4),
(NULL, 'Kira', 'Bigley', 52518,2000, 51, 4, 1, 0, 0, 'F', 3, 5, 5),
(NULL, 'Brita', 'Gridon', 89529,2000, 59, 3, 7, 0, 0, 'F', 3, 5, 6),
(NULL, 'Ynes', 'Hoodspeth', 91203,2000, 11, 2, 3, 0, 0, 'F', 3, 3, 7),
(NULL, 'Prissie', 'Hallewell', 73685,2000, 68, 5, 3, 0, 0, 'F', 3, 3, 7),
(NULL, 'Mariann', 'Southall', 41144,2000, 30, 6, 5, 0, 0, 'F', 3, 1, 7),
(NULL, 'Sukey', 'Barge', 13034,2000, 15, 4, 1, 0, 0, 'F', 3, 3, 7),
(NULL, 'Zita', 'Hudghton', 90234,2000, 44, 4, 2, 0, 0, 'F', 3, 4, 7),
(NULL, 'Lara', 'Trussell', 22601,2000, 19, 2, 7, 0, 0, 'F', 3, 5, 7),
(NULL, 'Esme', 'Perton', 94490,2000, 63, 4, 1, 0, 0, 'F', 3, 3, 7),
(NULL, 'Aveline', 'Acres', 26855,2000, 6, 5, 5, 0, 0, 'F', 3, 2, 7),
(NULL, 'Cortney', 'Gissop', 19532,2000, 13, 7, 7, 0, 0, 'F', 3, 1, 7),
(NULL, 'Joete', 'Wedgbrow', 46562,2000, 65, 6, 6, 0, 0, 'F', 3, 1, 7),

# 1995 - 4
(NULL, 'Nerty', 'Franses', 70353,1995, 41, 5, 1, 0, 0, 'F', 4, 1, 1),
(NULL, 'Ami', 'Montfort', 94742,1995, 65, 6, 2, 0, 0, 'F', 4, 2, 2),
(NULL, 'Shawn', 'Ketley', 55666,1995, 54, 6, 4, 0, 0, 'F', 4, 3, 3),
(NULL, 'Saba', 'Aird', 13537,1995, 100, 7, 7, 0, 0, 'F', 4, 4, 4),
(NULL, 'Willa', 'Kinker', 33985,1995, 50, 4, 3, 0, 0, 'F', 4, 5, 5),
(NULL, 'Gillie', 'Makepeace', 47500,1995, 1, 6, 7, 0, 0, 'F', 4, 5, 6),
(NULL, 'Ediva', 'Darko', 19997,1995, 92, 6, 5, 0, 0, 'F', 4, 3, 7),
(NULL, 'Tommi', 'Kerbey', 98846,1995, 70, 2, 6, 0, 0, 'F', 4, 3, 7),
(NULL, 'Christina', 'Cockcroft', 73215,1995, 1, 2, 2, 0, 0, 'F', 4, 1, 7),
(NULL, 'Channa', 'Jory', 57837,1995, 84, 5, 3, 0, 0, 'F', 4, 3, 7),
(NULL, 'Gnni', 'Ortega' , 21341, 1995, 96, 2, 2, 0, 0, 'F', 4,4, 7),
(NULL, 'Monah', 'Eastway', 76047,1995, 59, 5, 1, 0, 0, 'F', 4, 5, 7),
(NULL, 'Heidi', 'Tabor', 38442,1995, 5, 6, 3, 0, 0, 'F', 4, 3, 7),
(NULL, 'Morganica', 'Antoni', 23571,1995, 94, 4, 4, 0, 0, 'F', 4, 2, 7),
(NULL, 'Bird', 'Klimpke', 60818,1995, 17, 5, 6, 0, 0, 'F', 4, 1, 7),
(NULL, 'Tabbie', 'Stanmer', 33468,1995, 86, 5, 7, 0, 0, 'F', 4, 1, 7),

# 1996 - 4
(NULL, 'Hedi', 'Molian', 17267,1996, 71, 2, 3, 0, 0, 'F', 4, 1, 1),
(NULL, 'Martie', 'Kubal', 87657,1996, 2, 2, 7, 0, 0, 'F', 4, 2, 2),
(NULL, 'Amandi', 'Tremayne', 11426,1996, 61, 1, 6, 0, 0, 'F', 4, 3, 3),
(NULL, 'Elianore', 'Gathercole', 76440,1996, 43, 1, 4, 0, 0, 'F', 4, 4, 4),
(NULL, 'Margette', 'Winridge', 71228,1996, 75, 6, 1, 0, 0, 'F', 4, 5, 5),
(NULL, 'Zelda', 'Davley', 73262,1996, 71, 4, 6, 0, 0, 'F', 4, 5, 6),
(NULL, 'Poppy', 'Keave', 65382,1996, 1, 2, 2, 0, 0, 'F', 4, 3, 7),
(NULL, 'Eleen', 'Hapke', 54090,1996, 11, 5, 7, 0, 0, 'F', 4, 3, 7),
(NULL, 'Sabine', 'Hallad', 19522,1996, 21, 2, 6, 0, 0, 'F', 4, 1, 7),
(NULL, 'Fidelia', 'Maxwale', 64101,1996, 55, 4, 3, 0, 0, 'F', 4, 3, 7),
(NULL, 'Corinne', 'Dodge', 48606,1996, 75, 1, 1, 0, 0, 'F', 4, 4, 7),
(NULL, 'Adel', 'Wallwork', 29379,1996, 15, 1, 3, 0, 0, 'F', 4, 5, 7),
(NULL, 'Hedvige', 'Tarbard', 94108,1996, 70, 1, 1, 0, 0, 'F', 4, 3, 7),
(NULL, 'Dannye', 'Siggee', 26871,1996, 94, 5, 6, 0, 0, 'F', 4, 2, 7),
(NULL, 'Sheelagh', 'Olivella', 48186,1996, 63, 7, 5, 0, 0, 'F', 4, 1, 7),
(NULL, 'Bernice', 'Favey', 73339,1996, 78, 2, 4, 0, 0, 'F', 4, 1, 7),

# 1997 - 4
(NULL, 'Sonja', 'Cordelet', 93962,1997, 44, 1, 6, 0, 0, 'F', 4, 1, 1),
(NULL, 'Dode', 'Purcell', 72761,1997, 33, 7, 1, 0, 0, 'F', 4, 2, 2),
(NULL, 'Leisha', 'Waddoups', 12940,1997, 76, 6, 7, 0, 0, 'F', 4, 3, 3),
(NULL, 'Annemarie', 'Jennrich', 44320,1997, 54, 3, 3, 0, 0, 'F', 4, 4, 4),
(NULL, 'Klarrisa', 'Sawyer', 12105,1997, 78, 1, 1, 0, 0, 'F', 4, 5, 5),
(NULL, 'Lottie', 'Grzegorek', 35632,1997, 59, 2, 3, 0, 0, 'F', 4, 5, 6),
(NULL, 'Margy', 'Stone', 14298, 1997, 41, 1, 7, 0, 0, 'F', 4,3, 7),
(NULL, 'Fayina', 'McGowing', 24393,1997, 5, 1, 2, 0, 0, 'F', 4, 3, 7),
(NULL, 'Deidre', 'Meaders', 30453,1997, 61, 2, 7, 0, 0, 'F', 4, 1, 7),
(NULL, 'Lonnie', 'Dow', 53152,1997, 13, 4, 3, 0, 0, 'F', 4, 3, 7),
(NULL, 'Fancy', 'McKintosh', 91856,1997, 28, 6, 7, 0, 0, 'F', 4, 4, 7),
(NULL, 'George', 'Dowty', 73434,1997, 70, 3, 4, 0, 0, 'F', 4, 5, 7),
(NULL, 'Benny', 'Faithfull', 53383,1997, 73, 4, 1, 0, 0, 'F', 4, 3, 7),
(NULL, 'Roberta', 'Benjamin', 68758,1997, 57, 2, 5, 0, 0, 'F', 4, 2, 7),
(NULL, 'Brandais', 'Allmann', 98976,1997, 100, 7, 3, 0, 0, 'F', 4, 1, 7),
(NULL, 'Nanci', 'Kullmann', 13670,1997, 97, 2, 7, 0, 0, 'F', 4, 1, 7),

# 1998 - 4
(NULL, 'Thalia', 'Kid', 91109,1998, 82, 4, 6, 0, 0, 'F', 4, 1, 1),
(NULL, 'Dorella', 'Rawe', 50092,1998, 75, 4, 7, 0, 0, 'F', 4, 2, 2),
(NULL, 'Coralyn', 'Wiltsher', 28511,1998, 23, 3, 3, 0, 0, 'F', 4, 3, 3),
(NULL, 'Lorie', 'Kohnert', 99885,1998, 32, 6, 5, 0, 0, 'F', 4, 4, 4),
(NULL, 'Siusan', 'Malbon', 47820,1998, 40, 5, 7, 0, 0, 'F', 4, 5, 5),
(NULL, 'Rachelle', 'Georgeou', 44746,1998, 68, 1, 5, 0, 0, 'F', 4, 5, 6),
(NULL, 'Corella', 'Surgeoner', 85005,1998, 17, 6, 1, 0, 0, 'F', 4, 3, 7),
(NULL, 'Lonee', 'Sketch', 48813,1998, 24, 4, 5, 0, 0, 'F', 4, 3, 7),
(NULL, 'Melisse', 'Ellershaw', 88565,1998, 83, 7, 1, 0, 0, 'F', 4, 1, 7),
(NULL, 'Loralyn', 'Brewster', 76411,1998, 71, 5, 6, 0, 0, 'F', 4, 3, 7),
(NULL, 'Aline', 'Crocroft', 44022,1998, 36, 1, 1, 0, 0, 'F', 4, 4, 7),
(NULL, 'Shayna', 'Callister', 21688,1998, 6, 3, 4, 0, 0, 'F', 4, 5, 7),
(NULL, 'Jaclin', 'Lowles', 84533,1998, 19, 2, 2, 0, 0, 'F', 4, 3, 7),
(NULL, 'Pegeen', 'Scaysbrook', 89478,1998, 51, 2, 2, 0, 0, 'F', 4, 2, 7),
(NULL, 'Karlen', 'Morley', 79805,1998, 65, 1, 3, 0, 0, 'F', 4, 1, 7),
(NULL, 'Codee', 'Lewknor', 82332,1998, 15, 6, 5, 0, 0, 'F', 4, 1, 7),

# 1999 - 4
(NULL, 'Kizzee', 'Dickman', 16924,1999, 65, 6, 3, 0, 0, 'F', 4, 1, 1),
(NULL, 'Nelle', 'Fearnley', 47162,1999, 47, 6, 1, 0, 0, 'F', 4, 2, 2),
(NULL, 'Anna',  'Shanklin', 75350, 1999, 47, 4, 2, 0, 0, 'F', 4,3, 3),
(NULL, 'Catharina', 'Raper', 64088,1999, 2, 7, 3, 0, 0, 'F', 4, 4, 4),
(NULL, 'Lettie', 'Lombardo', 22330,1999, 92, 6, 7, 0, 0, 'F', 4, 5, 5),
(NULL, 'Millisent', 'Woodyear', 39537,1999, 85, 7, 3, 0, 0, 'F', 4, 5, 6),
(NULL, 'Dee', 'Euels', 84713,1999, 40, 3, 4, 0, 0, 'F', 4, 3, 7),
(NULL, 'Corrine', 'Grimmer', 32195,1999, 37, 5, 7, 0, 0, 'F', 4, 3, 7),
(NULL, 'Lurette', 'Francescuccio', 17364, 1999, 94, 5, 1, 0, 0, 'F', 4,1, 7),
(NULL, 'Dannie', 'Keniwell', 93766,1999, 92, 7, 4, 0, 0, 'F', 4, 3, 7),
(NULL, 'Renie', 'Montier', 43827,1999, 17, 3, 3, 0, 0, 'F', 4, 4, 7),
(NULL, 'Dalia', 'Howie', 74909,1999, 47, 6, 3, 0, 0, 'F', 4, 5, 7),
(NULL, 'Dulcie', 'Symonds', 55246,1999, 42, 4, 5, 0, 0, 'F', 4, 3, 7),
(NULL, 'Bellina', 'Drabble', 75331,1999, 92, 1, 2, 0, 0, 'F', 4, 2, 7),
(NULL, 'Zenia', 'Blackie', 59209,1999, 60, 2, 1, 0, 0, 'F', 4, 1, 7),
(NULL, 'Josefina', 'Struis', 10438,1999, 64, 7, 2, 0, 0, 'F', 4, 1, 7),

# 2000 - 4
(NULL, 'Leila', 'Izzatt', 19360,2000, 47, 6, 7, 0, 0, 'F', 4, 1, 1),
(NULL, 'Rosamund', 'Beenham', 33195,2000, 48, 7, 1, 0, 0, 'F', 4, 2, 2),
(NULL, 'Evaleen', 'Mawson', 65514,2000, 87, 7, 6, 0, 0, 'F', 4, 3, 3),
(NULL, 'Deedee', 'Gentric', 67002,2000, 50, 1, 1, 0, 0, 'F', 4, 4, 4),
(NULL, 'Scarlett', 'Huntington', 69120,2000, 39, 2, 7, 0, 0, 'F', 4, 5, 5),
(NULL, 'Kalinda', 'Kisting', 85189,2000, 14, 4, 5, 0, 0, 'F', 4, 5, 6),
(NULL, 'Candi', 'Whellans', 85977,2000, 60, 3, 2, 0, 0, 'F', 4, 3, 7),
(NULL, 'Karyl', 'Gilbeart', 51349,2000, 80, 6, 5, 0, 0, 'F', 4, 3, 7),
(NULL, 'Madelena', 'Frew', 91613,2000, 62, 4, 6, 0, 0, 'F', 4, 1, 7),
(NULL, 'Florri', 'Crampsey', 98170,2000, 99, 2, 7, 0, 0, 'F', 4, 3, 7),
(NULL, 'Charmion', 'Fulleylove', 61300,2000, 63, 1, 2, 0, 0, 'F', 4, 4, 7),
(NULL, 'Sunny', 'Barnfather', 65754,2000, 9, 5, 4, 0, 0, 'F', 4, 5, 7),
(NULL, 'Livy', 'Murrison', 17998,2000, 21, 3, 6, 0, 0, 'F', 4, 3, 7),
(NULL, 'Lura', 'Gott', 94485,2000, 62, 5, 5, 0, 0, 'F', 4, 2, 7),
(NULL, 'Angel', 'Maffioni', 78884,2000, 23, 7, 1, 0, 0, 'F', 4, 1, 7),
(NULL, 'Ashlee', 'Shinefield', 86046,2000, 82, 3, 7, 0, 0, 'F', 4, 1, 7),

# 1995 - 5
(NULL, 'Nicol', 'Duesbury', 83771,1995, 5, 4, 7, 0, 0, 'F', 5, 1, 1),
(NULL, 'Cecilla', 'Hens', 11471,1995, 21, 7, 7, 0, 0, 'F', 5, 2, 2),
(NULL, 'Aubine', 'Laight', 98606,1995, 33, 6, 5, 0, 0, 'F', 5, 3, 3),
(NULL, 'Daveta', 'Gaughey' , 67335, 1995, 10, 7, 1, 0, 0, 'F', 5, 4, 4),
(NULL, 'Naomi', 'Landy', 80324,1995, 88, 5, 2, 0, 0, 'F', 5, 5, 5),
(NULL, 'Melessa', 'Deeson', 30245,1995, 38, 7, 2, 0, 0, 'F', 5, 5, 6),
(NULL, 'Ingaberg', 'Sporton', 69368,1995, 44, 7, 6, 0, 0, 'F', 5, 3, 7),
(NULL, 'Dael', 'Arnault', 69022,1995, 7, 4, 3, 0, 0, 'F', 5, 3, 7),
(NULL, 'Gilbertina', 'Brignell', 20130,1995, 59, 5, 5, 0, 0, 'F', 5, 1, 7),
(NULL, 'Orelle', 'Knath', 50914,1995, 88, 2, 3, 0, 0, 'F', 5, 3, 7),
(NULL, 'Zsa',  'Childe', 93775, 1995, 44, 5, 7, 0, 0, 'F', 5,4, 7),
(NULL, 'Linn', 'Broyd', 33060,1995, 87, 1, 2, 0, 0, 'F', 5, 5, 7),
(NULL, 'Domeniga', 'Hollyar', 94826,1995, 57, 1, 1, 0, 0, 'F', 5, 3, 7),
(NULL, 'Lana', 'Spinks', 76859,1995, 32, 1, 4, 0, 0, 'F', 5, 2, 7),
(NULL, 'Ramonda', 'Folland', 96839,1995, 7, 7, 7, 0, 0, 'F', 5, 1, 7),
(NULL, 'Rita', 'Lumly', 60668,1995, 78, 3, 1, 0, 0, 'F', 5, 1, 7),

# 1996 - 5
(NULL, 'Debor', 'Walworth', 42884,1996, 92, 7, 3, 0, 0, 'F', 5, 1, 1),
(NULL, 'Flossy', 'Kenrat', 36224,1996, 70, 1, 4, 0, 0, 'F', 5, 2, 2),
(NULL, 'Tiffie', 'Noonan', 43758,1996, 26, 1, 5, 0, 0, 'F', 5, 3, 3),
(NULL, 'Gwenore', 'Eyam', 61245,1996, 24, 2, 1, 0, 0, 'F', 5, 4, 4),
(NULL, 'Bunni', 'Gherardesci', 38330,1996, 19, 5, 1, 0, 0, 'F', 5, 5, 5),
(NULL, 'Andreana', 'Squibbs', 93816,1996, 45, 6, 1, 0, 0, 'F', 5, 5, 6),
(NULL, 'Bobbette', 'Boswell', 89110,1996, 65, 5, 5, 0, 0, 'F', 5, 3, 7),
(NULL, 'Roanne', 'Glavias', 57167,1996, 18, 3, 2, 0, 0, 'F', 5, 3, 7),
(NULL, 'Grethel', 'Stubley', 37172,1996, 72, 4, 2, 0, 0, 'F', 5, 1, 7),
(NULL, 'Selinda', 'Treagust', 47734,1996, 45, 6, 1, 0, 0, 'F', 5, 3, 7),
(NULL, 'Mercedes', 'Gianiello', 61407,1996, 18, 3, 5, 0, 0, 'F', 5, 4, 7),
(NULL, 'Rey', 'Flecknoe', 98912,1996, 55, 5, 7, 0, 0, 'F', 5, 5, 7),
(NULL, 'Iolande', 'Tarbox', 97944,1996, 91, 5, 4, 0, 0, 'F', 5, 3, 7),
(NULL, 'Shoshana', 'Trimnell', 34663,1996, 69, 5, 3, 0, 0, 'F', 5, 2, 7),
(NULL, 'Esmaria', 'Colloby', 57508,1996, 27, 4, 2, 0, 0, 'F', 5, 1, 7),
(NULL, 'Alison', 'Dalinder', 22176,1996, 82, 1, 2, 0, 0, 'F', 5, 1, 7),


(NULL, 'Kore', 'Sugarman', 57167,1997, 72, 3, 5, 0, 0, 'F', 5, 1, 1),
(NULL, 'Joey', 'Lefley', 59667,1997, 96, 5, 7, 0, 0, 'F', 5, 2, 2),
(NULL, 'Joeann', 'Yankeev', 19089,1997, 30, 4, 5, 0, 0, 'F', 5, 3, 3),
(NULL, 'Madelina', 'Batten', 85671,1997, 54, 2, 4, 0, 0, 'F', 5, 4, 4),
(NULL, 'Zora', 'Chaters', 99684,1997, 88, 3, 3, 0, 0, 'F', 5, 5, 5),
(NULL, 'Sandra', 'Petracco', 83702,1997, 70, 7, 5, 0, 0, 'F', 5, 5, 6),
(NULL, 'Lela', 'Moore', 61320,1997, 19, 1, 7, 0, 0, 'F', 5, 3, 7),
(NULL, 'Berthe', 'Fleckno', 18085,1997, 78, 2, 1, 0, 0, 'F', 5, 3, 7),
(NULL, 'Bella', 'Pellew', 75921,1997, 70, 5, 1, 0, 0, 'F', 5, 1, 7),
(NULL, 'Ariel', 'Borer', 26919,1997, 38, 6, 3, 0, 0, 'F', 5, 3, 7),
(NULL, 'Salli', 'Danzig', 47326,1997, 94, 2, 4, 0, 0, 'F', 5, 4, 7),
(NULL, 'Evangelina', 'Bootland', 33514, 1997, 51, 1, 1, 0, 0, 'F', 5, 5, 7),
(NULL, 'Zora', 'Henrique', 55759, 1997, 57, 6, 1, 0, 0, 'F', 5, 3, 7),
(NULL, 'Sibbie', 'Negus', 84742, 1997, 60, 2, 7, 0, 0, 'F', 5, 2, 7),
(NULL, 'Pepi', 'McCafferty', 59212, 1997, 39, 4, 3, 0, 0, 'F', 5, 1, 7),
(NULL, 'Ann', 'Mains', 81187, 1997, 28, 4, 4, 0, 0, 'F', 5, 1, 7),

# 1996 - 5
(NULL, 'Bliss', 'Collinge', 74192,1998, 98, 5, 6, 0, 0, 'F', 5, 1, 1),
(NULL, 'Debbie', 'Carl', 30015,1998, 73, 4, 5, 0, 0, 'F', 5, 2, 2),
(NULL, 'Georgine', 'Plunkett', 91376,1998, 89, 7, 1, 0, 0, 'F', 5, 3, 3),
(NULL, 'Elsy', 'Giacobbo', 48477,1998, 50, 6, 5, 0, 0, 'F', 5, 4, 4),
(NULL, 'Katusha', 'Watling', 69709,1998, 83, 1, 5, 0, 0, 'F', 5, 5, 5),
(NULL, 'Krystyna', 'Kestle', 11701,1998, 9, 7, 1, 0, 0, 'F', 5, 5, 6),
(NULL, 'Chantalle', 'Gannan', 67737,1998, 76, 7, 7, 0, 0, 'F', 5, 3, 7),
(NULL, 'Andriette', 'Veeler', 34795,1998, 36, 7, 7, 0, 0, 'F', 5, 3, 7),
(NULL, 'Dahlia', 'Quennell', 13650,1998, 91, 1, 3, 0, 0, 'F', 5, 1, 7),
(NULL, 'Ingrid', 'Quickenden', 50945,1998, 23, 5, 1, 0, 0, 'F', 5, 3, 7),
(NULL, 'Annelise', 'Franceschielli', 32266,1998, 23, 6, 6, 0, 0, 'F', 5, 4, 7),
(NULL, 'Maxine', 'Scohier', 17130,1998, 89, 3, 6, 0, 0, 'F', 5, 5, 7),
(NULL, 'Perrine', 'Murton', 77880,1998, 55, 1, 7, 0, 0, 'F', 5, 3, 7),
(NULL, 'Clareta', 'Conisbee', 26440,1998, 29, 7, 3, 0, 0, 'F', 5, 2, 7),
(NULL, 'Guinna', 'Vertey', 92953,1998, 100, 1, 6, 0, 0, 'F', 5, 1, 7),
(NULL, 'Theressa', 'Elmar', 22017,1998, 36, 3, 7, 0, 0, 'F', 5, 1, 7)
;



INSERT INTO jugador_m (id_jugador_m,nombre_j,apellido_j,dni_j,categoria,numero_camiseta,camiseta_talle,pantalon_talle,partidos_jugados,goles,sexo,id_club,id_comida, id_posicion)
VALUES
(NULL, 'Jakie','Foat', 18044, 1995, 89, 5, 6, 0, 0,3, 1,5, 1),
(NULL, 'Winny','Elsley', 17672, 1995, 30, 6, 1, 0, 0,3, 1,3, 2),
(NULL, 'Boote','Gyford', 99567, 1995, 64, 1, 5, 0, 0,3, 1,3, 3),
(NULL, 'Wallache','Almond', 29805, 1995, 49, 4, 2, 0, 0,3, 1,1, 4),
(NULL, 'Adler','Grovier', 80638, 1995, 45, 1, 7, 0, 0,3, 1,1, 5),
(NULL, 'Nye','Clowser', 47684, 1995, 12, 1, 2, 0, 0,3, 1,1, 6),
(NULL, 'Malvin','Genn', 55245, 1995, 5, 4, 3, 0, 0,3, 1,2, 7),
(NULL, 'Odey','Mattusov', 18826, 1995, 92, 2, 7, 0, 0,3, 1,2, 7),
(NULL, 'Natale','Rider', 14726, 1995, 11, 2, 3, 0, 0,3, 1,2, 7),
(NULL, 'Lindon','Lethlay', 67563, 1995, 64, 4, 5, 0, 0,3, 1,2, 7),
(NULL, 'Garvin','Boundy', 40747, 1995, 61, 5, 2, 0, 0,3, 1,4, 7),
(NULL, 'Ruperto','Franseco', 36166, 1995, 94, 3, 4, 0, 0,3, 1,4, 7),
(NULL, 'Ody','Ronaldson', 35212, 1995, 73, 5, 6, 0, 0,3, 1,4, 7),
(NULL, 'Hayden','Mollene', 39592, 1995, 56, 3, 5, 0, 0,3, 1,4, 7),
(NULL, 'Axel','Woltering', 86527, 1995, 17, 2, 5, 0, 0,3, 1,4, 7),
(NULL, 'Mal','Spini', 78428, 1995, 80, 3, 1, 0, 0,3, 1,5, 7),


(NULL, 'Kenyon','Halversen', 75516, 1996, 67, 6, 7, 0, 0,3, 1,5, 1),
(NULL, 'Bentley','Terbrugge', 53486, 1996, 27, 4, 3, 0, 0,3, 1,5, 2),
(NULL, 'Lief','Braley', 96582, 1996, 68, 2, 3, 0, 0,3, 1,1, 3),
(NULL, 'Kalle','Dowsett', 85020, 1996, 88, 2, 4, 0, 0,3, 1,1, 4),
(NULL, 'Cirilo','Makinson', 41852, 1996, 27, 2, 4, 0, 0,3, 1,2, 5),
(NULL, 'Aleksandr','Palley', 42640, 1996, 67, 3, 6, 0, 0,3, 1,2, 6),
(NULL, 'Tris','Callaway', 34185, 1996, 47, 7, 6, 0, 0,3, 1,3, 7),
(NULL, 'Emmanuel','Laidler', 46892, 1996, 35, 1, 3, 0, 0,3, 1,3, 7),
(NULL, 'Conway','Fulcher', 19374, 1996, 30, 3, 1, 0, 0,3, 1,3, 7),
(NULL, 'Granville','Crawford', 49756, 1996, 63, 3, 2, 0, 0,3, 1,3, 7),
(NULL, 'Keelby','Sallier', 53418, 1996, 54, 3, 6, 0, 0,3, 1,1, 7),
(NULL, 'Sullivan','Teideman', 42203, 1996, 42, 7, 5, 0, 0,3, 1,1, 7),
(NULL, 'Ivan','Ryall', 94398, 1996, 68, 5, 5, 0, 0,3, 1,1, 7),
(NULL, 'Rolfe','Hackforth', 17133, 1996, 52, 7, 4, 0, 0,3, 1,3, 7),
(NULL, 'Gerek','Serris', 62746, 1996, 21, 4, 2, 0, 0,3, 1,3, 7),
(NULL, 'Goddard','Bunce', 73612, 1996, 72, 6, 4, 0, 0,3, 1,3, 7),


(NULL, 'Constantine','Gelder', 58847, 1997, 61, 5, 7, 0, 0,3, 1,3, 1),
(NULL, 'Meier','Bearcock', 48885, 1997, 79, 2, 7, 0, 0,3, 1,3, 2),
(NULL, 'Cornie','Isgate', 62748, 1997, 45, 3, 1, 0, 0,3, 1,3, 3),
(NULL, 'Clarke','Clausson', 61321, 1997, 42, 2, 4, 0, 0,3, 1,3, 4),
(NULL, 'Eldridge','Sackey', 88422, 1997, 77, 2, 4, 0, 0,3, 1,3, 5),
(NULL, 'Patric','Drejer', 28313, 1997, 70, 3, 1, 0, 0,3, 1,3, 6),
(NULL, 'Farris','McRuvie', 40259, 1997, 2, 7, 4, 0, 0,3, 1,3, 7),
(NULL, 'Jessie','Vurley', 49919, 1997, 33, 2, 6, 0, 0,3, 1,3, 7),
(NULL, 'Ahmad','Millson', 60158, 1997, 26, 5, 3, 0, 0,3, 1,3, 7),
(NULL, 'Vern','Guinnane', 69145, 1997, 21, 3, 3, 0, 0,3, 1,3, 7),
(NULL, 'Palm','Cowin', 56171, 1997, 31, 7, 2, 0, 0,3, 1,3, 7),
(NULL, 'Natale','Sweett', 19341, 1997, 81, 7, 6, 0, 0,3, 1,3, 7),
(NULL, 'Claudio','Menico', 62432, 1997, 37, 3, 3, 0, 0,3, 1,3, 7),
(NULL, 'Orren','Salliere', 50232, 1997, 53, 5, 7, 0, 0,3, 1,3, 7),
(NULL, 'Carly','Whitelock', 78103, 1997, 96, 1, 1, 0, 0,3, 1,3, 7),
(NULL, 'Bond','Towey', 98274, 1997, 96, 1, 4, 0,0, 3,1,3, 7),


(NULL, 'Hervey','Sawer', 22467, 1998, 66, 2, 2, 0, 0,3, 1,3, 1),
(NULL, 'Marlowe','Sigsworth', 96353, 1998, 58, 1, 6, 0, 0,3, 1,3, 2),
(NULL, 'Teador','Bootland', 34161, 1998, 9, 2, 3, 0, 0,3, 1,3, 3),
(NULL, 'Morris','Skoggins', 55290, 1998, 93, 1, 5, 0, 0,3, 1,3, 4),
(NULL, 'Thane','Style', 67637, 1998, 9, 1, 4, 0, 0,3, 1,3, 5),
(NULL, 'Bogart','Boram', 57603, 1998, 7, 7, 7, 0, 0,3, 1,3, 6),
(NULL, 'Carce','Franchioni', 94604, 1998, 56, 5, 5, 0, 0,3, 1,3, 7),
(NULL, 'Archibaldo','Barthelmes', 93415, 1998, 58, 2, 4, 0, 0,3, 1,1, 7),
(NULL, 'Lind','Barley', 40932, 1998, 87, 4, 7, 0, 0,3, 1,1, 7),
(NULL, 'Thomas','Kemet', 82656, 1998, 30, 7, 7, 0, 0,3, 1,1, 7),
(NULL, 'Ephrayim','Orteau', 24912, 1998, 67, 7, 3, 0, 0,3, 1,2, 7),
(NULL, 'Alfonso','Frankel', 40997, 1998, 85, 5, 7, 0, 0,3, 1,2, 7),
(NULL, 'Justino','Madgin', 78375, 1998, 19, 7, 1, 0, 0,3, 1,2, 7),
(NULL, 'Papageno','Durnford', 77192, 1998, 7, 1, 5, 0, 0,3, 1,2, 7),
(NULL, 'Laurence','Buttress', 30726, 1998, 22, 3, 7, 0, 0,3, 1,2, 7),
(NULL, 'Ezekiel','Nisius', 35421, 1998, 72, 5, 3, 0, 0,3, 1,3, 7),


(NULL, 'Giffie','Shinton', 71774, 1999, 28, 6, 3, 0, 0,3, 1,4, 1),
(NULL, 'Sax','Coots', 72647, 1999, 63, 7, 7, 0, 0,3, 1,4, 2),
(NULL, 'Gabriel','Wagenen', 80644, 1999, 38, 5, 1, 0, 0,3, 1,4, 3),
(NULL, 'Nicolai','Scatchar', 63966, 1999, 11, 2, 1, 0, 0,3, 1,4, 4),
(NULL, 'Xymenes','Shawyers', 81932, 1999, 62, 1, 2, 0, 0,3, 1,5, 5),
(NULL, 'Arty','Swanwick', 80599, 1999, 96, 1, 4, 0, 0,3, 1,5, 6),
(NULL, 'Emanuel','Flicker', 21932, 1999, 37, 5, 4, 0, 0,3, 1,5, 7),
(NULL, 'Nichole','Gorrie', 18942, 1999, 48, 5, 2, 0, 0,3, 1,5, 7),
(NULL, 'Rutherford','Aphale', 75052, 1999, 65, 3, 1, 0, 0,3, 1,5, 7),
(NULL, 'Hillard','Baversor', 85189, 1999, 86, 4, 3, 0, 0,3, 1,1, 7),
(NULL, 'Kahlil','Maccrie', 13005, 1999, 16, 6, 4, 0, 0,3, 1,1, 7),
(NULL, 'Christy','Deeks', 38405, 1999, 11, 7, 4, 0, 0,3, 1,1, 7),
(NULL, 'Solly','Phorsby', 83964, 1999, 7, 1, 3, 0, 0,3, 1,1, 7),
(NULL, 'Moe','Escolme', 61134, 1999, 65, 5, 2, 0, 0,3, 1,3, 7),
(NULL, 'Giorgi','Fendt', 92414, 1999, 94, 4, 7, 0, 0,3, 1,3, 7),
(NULL, 'Delano','Morot', 92125, 1999, 46, 7, 7, 0, 0,3, 1,3, 7),


(NULL, 'Garik','Bowlands', 10903, 2000, 18, 3, 1, 0, 0,3, 1,3, 1),
(NULL, 'Delbert','Harridge', 56390, 2000, 58, 4, 7, 0, 0,3, 1,3, 2),
(NULL, 'Vernon','Vezey', 44735, 2000, 49, 2, 6, 0, 0,3, 1,3, 3),
(NULL, 'Flin','Ibbott', 26481, 2000, 95, 7, 6, 0, 0,3, 1,3, 4),
(NULL, 'Darin','Cadamy', 80336, 2000, 19, 2, 1, 0, 0,3, 1,3, 5),
(NULL, 'Brion','Dunkerton', 10367, 2000, 23, 2, 1, 0, 0,3, 1,3, 6),
(NULL, 'Izak','Pasterfield', 72119, 2000, 87, 7, 3, 0, 0,3, 1,3, 7),
(NULL, 'Henri','Mussilli', 11939, 2000, 64, 5, 2, 0, 0,3, 1,3, 7),
(NULL, 'Vincents','Hedgecock', 10110, 2000, 9, 7, 4, 0, 0,3, 1,3, 7),
(NULL, 'Gaspar','Emtage', 63132, 2000, 100, 7, 1, 0, 0,3, 1,1, 7),
(NULL, 'Peyter','Kiln', 27960, 2000, 58, 5, 5, 0, 0,3, 1,1, 7),
(NULL, 'Ellswerth','Mussotti', 63698, 2000, 8, 4, 5, 0, 0,3, 1,3, 7),
(NULL, 'Tristan','Petrovsky', 21108, 2000, 87, 3, 2, 0, 0,3, 1,3, 7),
(NULL, 'Chick','Budgey', 21793, 2000, 87, 5, 6, 0, 0,3, 1,3, 7),
(NULL, 'Isaiah','Teodoro', 18461, 2000, 2, 7, 3, 0, 0,3, 1,3, 7),
(NULL, 'Onfroi','Phetteplace', 21881, 2000, 22, 5, 6, 0, 0,3, 1,3, 7),


(NULL, 'Luke','Lebrun', 66089, 1995, 2, 1, 6, 0, 0,3, 2,3, 1),
(NULL, 'Donal','Manklow', 90745, 1995, 36, 3, 5, 0, 0,3, 2,3, 2),
(NULL, 'Leigh','Salisbury', 16575, 1995, 92, 1, 1, 0, 0,3, 2,3, 3),
(NULL, 'Emanuele','Breckon', 39335, 1995, 55, 2, 7, 0, 0,3, 2,3, 4),
(NULL, 'Lucian','Wickstead', 21759, 1995, 22, 7, 7, 0, 0,3, 2,3, 5),
(NULL, 'Freddy','Dust', 70439, 1995, 48, 2, 2, 0, 0,3, 2,3, 6),
(NULL, 'Jaime','Spaunton', 40002, 1995, 26, 2, 1, 0, 0,3, 2,3, 7),
(NULL, 'Solly','Purver', 81394, 1995, 98, 2, 2, 0, 0,3, 2,3, 7),
(NULL, 'Raddy','Magarrell', 22317, 1995, 60, 3, 3, 0, 0,3, 2,3, 7),
(NULL, 'Normy','Vuyst', 85321, 1995, 39, 1, 4, 0,0,3, 2,3, 7),
(NULL, 'Frasquito','Lowers', 61450, 1995, 7, 7, 4, 0, 0,3, 2,3, 7),
(NULL, 'Cazzie','Skryne', 11537, 1995, 85, 3, 6, 0, 0,3, 2,3, 7),
(NULL, 'Jephthah','Pye', 73012, 1995, 92, 5, 3, 0, 0,3, 2,3, 7),
(NULL, 'Derwin','McGuinley', 98001, 1995, 8, 2, 2, 0, 0,3, 2,3, 7),
(NULL, 'Irwin','Looney', 54470, 1995, 78, 3, 2, 0, 0,3, 2,3, 7),
(NULL, 'Erick','Iddons', 56413, 1995, 85, 7, 4, 0, 0,3, 2,3, 7),


(NULL, 'Zollie','Woodham', 55160, 1996, 74, 3, 7, 0, 0,3, 2,3, 1),
(NULL, 'Trenton','Petric', 62901, 1996, 30, 5, 5, 0, 0,3, 2,3, 2),
(NULL, 'Rem','Shepley', 16280, 1996, 38, 6, 5, 0, 0,3, 2,3, 3),
(NULL, 'Obediah','Hulle', 43455, 1996, 94, 4, 7, 0, 0,3, 2,5, 4),
(NULL, 'Tamas','Lamy', 19049, 1996, 20, 4, 3, 0, 0,3, 2,5, 5),
(NULL, 'Ward','Heggs', 84078, 1996, 33, 3, 3, 0, 0,3, 2,5, 6),
(NULL, 'Wildon','King', 44438, 1996, 54, 3, 3, 0, 0,3, 2,5, 7),
(NULL, 'Killian','Bellward', 57545, 1996, 45, 3, 5, 0, 0,3, 2,5, 7),
(NULL, 'Ferd','Maffini', 52382, 1996, 4, 3, 5, 0, 0,3, 2,5, 7),
(NULL, 'Hilary','Rottgers', 42859, 1996, 80, 1, 6, 0, 0,3, 2,5, 7),
(NULL, 'Edward','Summerhayes', 77811, 1996, 4, 2, 5, 0, 0,3, 2,5, 7),
(NULL, 'Artemas','Featherstonhalgh', 70684, 1996, 18, 3, 7, 0, 0,3, 2,1, 7),
(NULL, 'Conn','Maffeo', 15925, 1996, 42, 1, 5, 0, 0,3, 2,1, 7),
(NULL, 'Jamil','Livett', 88219, 1996, 84, 1, 2, 0, 0,3, 2,1, 7),
(NULL, 'Parnell','Rother', 46766, 1996, 26, 4, 7, 0, 0,3, 2,1, 7),
(NULL, 'Adrian','Matusov', 80757, 1996, 79, 5, 1, 0, 0,3, 2,1, 7),


(NULL, 'Aron','Berndt', 52096, 1997, 58, 7, 7, 0, 0,3, 2,1, 1),
(NULL, 'Garey','Hackworthy', 25093, 1997, 99, 3, 7, 0, 0,3, 2,2, 2),
(NULL, 'Wald','Saben', 88891, 1997, 66, 2, 1, 0, 0,3, 2,2, 3),
(NULL, 'Fairfax','Crosswaite', 83782, 1997, 69, 2, 3, 0, 0,3, 2,2, 4),
(NULL, 'Portie','Duckitt', 65227, 1997, 59, 4, 2, 0, 0,3, 2,2, 5),
(NULL, 'Edik','Gleave', 47474, 1997, 68, 4, 5, 0, 0,3, 2,2, 6),
(NULL, 'Damon','Mathouse', 71882, 1997, 15, 3, 6, 0, 0,3, 2,2, 7),
(NULL, 'Christophorus','Galbraeth', 42150, 1997, 76, 1, 6, 0, 0,3, 2,2, 7),
(NULL, 'Gannon','Bulloch', 53632, 1997, 22, 4, 1, 0, 0,3, 2,4, 7),
(NULL, 'Tally','Boule', 80739, 1997, 6, 7, 3, 0, 0,3, 2,4, 7),
(NULL, 'Reilly','Hestrop', 56571, 1997, 79, 1, 4, 0, 0,3, 2,4, 7),
(NULL, 'Jehu','Kalinovich', 95542, 1997, 94, 2, 6, 0, 0,3, 2,4, 7),
(NULL, 'Urson','McTavish', 84876, 1997, 26, 3, 1, 0, 0,3, 2,1, 7),
(NULL, 'Pippo','Bromidge', 33348, 1997, 59, 5, 5, 0, 0,3, 2,1, 7),
(NULL, 'Carr','Alp', 44050, 1997, 25, 5, 3, 0, 0,3, 2,1, 7),
(NULL, 'Padriac','Westhoff', 58753, 1997, 74, 1, 1, 0, 0,3, 2,3, 7),


(NULL, 'Iain','Dye', 46979, 1998, 75, 2, 2, 0, 0,3, 2,3, 1),
(NULL, 'Darbee','Hardwich', 88649, 1998, 22, 2, 6, 0, 0,3, 2,3, 2),
(NULL, 'Fran','Broxup', 14541, 1998, 35, 7, 7, 0, 0,3, 2,3, 3),
(NULL, 'Gibby','Forst', 60057, 1998, 98, 2, 4, 0, 0,3, 2,3, 4),
(NULL, 'Abdul','Eason', 52693, 1998, 83, 2, 7, 0, 0,3, 2,3, 5),
(NULL, 'Tyson','Vigars', 70457, 1998, 40, 3, 1, 0, 0,3, 2,3, 6),
(NULL, 'Rowen','McInility', 31232, 1998, 50, 5, 7, 0, 0,3, 2,3, 7),
(NULL, 'Brewer','Corsor', 50379, 1998, 40, 3, 3, 0, 0,3, 2,3, 7),
(NULL, 'Eziechiele','Imlock', 88930, 1998, 69, 2, 7, 0, 0,3, 2,3, 7),
(NULL, 'Rowland','Mariel', 49854, 1998, 8, 1, 5, 0, 0,3, 2,3, 7),
(NULL, 'Derward','Cornewell', 37851, 1998, 90, 6, 1, 0, 0,3, 2,3, 7),
(NULL, 'Kris','Denness', 15011, 1998, 49, 5, 5, 0, 0,3, 2,3, 7),
(NULL, 'Vincenz','Pariso', 75378, 1998, 89, 5, 6, 0, 0,3, 2,3, 7),
(NULL, 'Baily','Hatzar', 87160, 1998, 17, 6, 1, 0, 0,3, 2,3, 7),
(NULL, 'Luce','Claiden', 18908, 1998, 8, 7, 1, 0, 0,3, 2,3, 7),


(NULL, 'Royce','Aizlewood', 25177, 1998, 82, 3, 1, 0, 0,3, 2,3, 1),
(NULL, 'Alfred','Sommersett', 61530, 1999, 84, 5, 4, 0, 0,3, 2,3, 2),
(NULL, 'Hillary','Ply', 91451, 1999, 90, 3, 2, 0, 0,3, 2,3, 3),
(NULL, 'Burlie','Emeny', 27973, 1999, 78, 2, 2, 0, 0,3, 2,3, 4),
(NULL, 'Neale','Tolliday', 62259, 1999, 35, 5, 7, 0, 0,3, 2,3, 5),
(NULL, 'Noak','Roskeilly', 65141, 1999, 29, 5, 1, 0, 0,3, 2,3, 6),
(NULL, 'Ruperto','Weall', 62997, 1999, 30, 2, 5, 0, 0,3, 2,3, 7),
(NULL, 'Finley','Woolf', 87013, 1999, 9, 7, 1, 0, 0,3, 2,3, 7),
(NULL, 'Francois','Schusterl', 27203, 1999, 97, 3, 5, 0, 0,3, 2,3, 7),
(NULL, 'Salomon','Gutridge', 60339, 1999, 47, 5, 2, 0, 0,3, 2,3, 7),
(NULL, 'Reid','Bille', 69027, 1999, 11, 7, 3, 0, 0,3, 2,3, 7),
(NULL, 'Jock','Leverentz', 74669, 1999, 65, 6, 5, 0, 0,3, 2,3, 7),
(NULL, 'Skyler','Verbeke', 89648, 1999, 44, 1, 2, 0, 0,3, 2,3, 7),
(NULL, 'Maynard','Heamus', 40612, 1999, 19, 7, 2, 0, 0,3, 2,3, 7),
(NULL, 'Leonerd','Taysbil', 71824, 1999, 94, 5, 1, 0, 0,3, 2,3, 7),
(NULL, 'Jens','Mossbee', 26793, 1999, 83, 2, 6, 0, 0,3, 2,3, 7),
(NULL, 'Brian','Gerrelts', 91348, 1999, 10, 3, 7, 0, 0,3, 2,3, 7),


(NULL, 'Rich','Thomasson', 71946, 2000, 31, 4, 6, 0, 0,3, 2,3, 1),
(NULL, 'Filmore','Clarkin', 84985, 2000, 64, 4, 3, 0, 0,3, 2,3, 2),
(NULL, 'Glenn','Siaspinski', 10114, 2000, 68, 5, 2, 0, 0,3, 2,3, 3),
(NULL, 'Teodoor','Androletti', 53375, 2000, 70, 1, 3, 0, 0,3, 2,3, 4),
(NULL, 'Adolf','Suffe', 55969, 2000, 77, 1, 4, 0, 0,3, 2,3, 5),
(NULL, 'Reese','Boyles', 37838, 2000, 40, 5, 2, 0, 0,3, 2,3, 6),
(NULL, 'Harrison','Edland', 83305, 2000, 52, 2, 6, 0, 0,3, 2,3, 7),
(NULL, 'Hammad','Gross', 33210, 2000, 81, 5, 2, 0, 0,3, 2,3, 7),
(NULL, 'Aldon','Dalbey', 77671, 2000, 19, 3, 1, 0, 0,3, 2,3, 7),
(NULL, 'Damon','Eagger', 82499, 2000, 90, 6, 7, 0, 0,3, 2,3, 7),
(NULL, 'Jaimie','Scraggs', 32376, 2000, 41, 5, 3, 0, 0,3, 2,3, 7),
(NULL, 'Chaddy','Drewitt', 56657, 2000, 64, 2, 5, 0, 0,3, 2,3, 7),
(NULL, 'Konstantin','Charlotte', 30063, 2000, 8, 5, 5, 0, 0,3, 2,3, 7),
(NULL, 'Ephraim','Spehr', 71779, 2000, 69, 7, 1, 0, 0,3, 2,3, 7),
(NULL, 'Ulberto','Blackborne', 83445, 2000, 96, 3, 5, 0, 0,3, 2,3, 7),
(NULL, 'Weider','Scullion', 61475, 2000, 49, 4, 1, 0, 0,3, 2,3, 7),


(NULL, 'Cornie','Johnson', 17490, 1995, 35, 7, 6, 0, 0,3, 3,3, 1),
(NULL, 'Ely','Tumioto', 50180, 1995, 61, 6, 1, 0, 0,3, 3,3, 2),
(NULL, 'Felic','Timony', 30846,1995, 41, 3, 3,0,0, 3,3,3, 3),
(NULL, 'Humfried','Ridges', 85434, 1995, 97, 4, 3, 0, 0,3, 3,3, 4),
(NULL, 'Stevie','Bridgen', 60982, 1995, 65, 6, 7, 0, 0,3, 3,1, 5),
(NULL, 'Iosep','Kenforth', 54435, 1995, 39, 5, 7, 0, 0,3, 3,1, 6),
(NULL, 'Shelby','Boughtwood', 69770, 1995, 33, 4, 6, 0, 0,3, 3,1, 7),
(NULL, 'Major','MacComiskey', 49342, 1995, 28, 1, 3, 0, 0,3, 3,5, 7),
(NULL, 'Bron','Agius', 19091, 1995, 53, 4, 4, 0, 0,3, 3,5, 7),
(NULL, 'Shalom','Norfolk', 10690, 1995, 55, 2, 6, 0, 0,3, 3,4, 7),
(NULL, 'Ripley', 'Nowlan', 74187,1995, 54, 2, 5,0,0, 3,3,4, 7),
(NULL, 'Phip','Crolla', 80105, 1995, 42, 5, 1, 0, 0,3, 3,5, 7),
(NULL, 'Saxe','Hastwall', 80078, 1995, 70, 6, 1, 0, 0,3, 3,5, 7),
(NULL, 'Kip','Doumerque', 66440, 1995, 38, 5, 2, 0, 0,3, 3,5, 7),
(NULL, 'Emelen','Blazic', 99092, 1995, 75, 6, 2, 0, 0,3, 3,1, 7),
(NULL, 'Holmes','Bohl', 60483, 1995, 54, 2, 4, 0, 0,3, 3,1, 7),


(NULL, 'Massimiliano','Dunphy', 93185, 1996, 86, 6, 2, 0, 0,3, 3,1, 1),
(NULL, 'Tobie','Ballham', 97988, 1996, 49, 3, 1, 0, 0,3, 3,3, 2),
(NULL, 'Baldwin','Morstatt', 97936, 1996, 72, 6, 2, 0, 0,3, 3,3, 3),
(NULL, 'Giraldo','Hawton', 51833, 1996, 98, 6, 3, 0, 0,3, 3,3, 4),
(NULL, 'Tobias','Edmonstone', 33550, 1996, 64, 5, 1, 0, 0,3, 3,3, 5),
(NULL, 'Carlyle','Radleigh', 64259, 1996, 29, 1, 3, 0, 0,3, 3,3, 6),
(NULL, 'Shanan','Raynham', 95983, 1996, 56, 7, 6, 0, 0,3, 3,1, 7),
(NULL, 'Willey','Goggan', 61554, 1996, 87, 5, 7, 0, 0,3, 3,1, 7),
(NULL, 'Diarmid','Dewi', 33082, 1996, 10, 1, 5, 0, 0,3, 3,1, 7),
(NULL, 'Delmor','Rowbotham', 71670, 1996, 9, 3, 7, 0, 0,3, 3,1, 7),
(NULL, 'Cullin','Vanyutin', 83894, 1996, 84, 7, 6, 0, 0,3, 3,2, 7),
(NULL, 'Sidney','Marquis', 65274, 1996,38, 2, 6, 0,0,3, 3,2, 7),
(NULL, 'Dalt','MacEvilly', 84877, 1996, 88, 3, 5, 0, 0,3, 3,2, 7),
(NULL, 'Valentin','Martinello', 50200, 1996, 6, 3, 6, 0, 0,3, 3,2, 7),
(NULL, 'Bev','Dreelan', 70147, 1996, 71, 4, 3, 0, 0,3, 3,5, 7),
(NULL, 'Daryle','Frossell', 96170, 1996, 21, 6, 6, 0, 0,3, 3,5, 7),


(NULL, 'Granger','Dooley', 18798, 1997, 66, 4, 2, 0, 0,3, 3,5, 1),
(NULL, 'Drew','Feilden', 98599, 1997, 82, 4, 7, 0, 0,3, 3,5, 2),
(NULL, 'Drew','Pulley', 25577, 1997, 20, 1, 7, 0, 0,3, 3,4, 3),
(NULL, 'Cosimo','Moffet', 10990, 1997, 31, 5, 4, 0, 0,3, 3,4, 4),
(NULL, 'Scott','Prandoni', 98517, 1997, 88, 2, 4, 0, 0,3, 3,4, 5),
(NULL, 'Dannie','McGinny', 52537, 1997, 14, 1, 5, 0, 0,3, 3,3, 6),
(NULL, 'Bernarr','Waylen', 62846, 1997, 32, 1, 6, 0, 0,3, 3,3, 7),
(NULL, 'Reed','Edgett', 97113, 1997, 2, 4, 7, 0, 0,3, 3,3, 7),
(NULL, 'Burlie','Bullus', 80527, 1997, 46, 5, 7, 0, 0,3, 3,3, 7),
(NULL, 'Cecilius','Ketcher', 48159, 1997, 36, 1, 7, 0, 0,3, 3,3, 7),
(NULL, 'Rudie','Renton', 78438, 1997, 6, 5, 4, 0, 0,3, 3,1, 7),
(NULL, 'Mozes','Gauchier', 29830, 1997, 5, 3, 7, 0, 0,3, 3,1, 7),
(NULL, 'Jeremiah','Jimpson', 35009, 1997, 68, 1, 3, 0, 0,3, 3,1, 7),
(NULL, 'Jacky','Llewhellin', 44474, 1997, 95, 3, 3, 0, 0,3, 3,1, 7),
(NULL, 'Shelden','Ellins', 41289, 1997, 8, 7, 6, 0, 0,3, 3,1, 7),
(NULL, 'Delano','Leagham', 81932,1997, 35, 1, 1,0,0, 3,3,1, 7),


(NULL, 'Vasily','Treuge', 53061, 1998, 45, 1, 1, 0, 0,3, 3,3, 1),
(NULL, 'Rogerio','Garlett', 52877, 1998, 16, 2, 1, 0, 0,3, 3,3, 2),
(NULL, 'Arni','Beardsworth', 91176, 1998, 59, 1, 7, 0, 0,3, 3,3, 3),
(NULL, 'Caesar','Kielty', 31878, 1998, 95, 6, 4, 0, 0,3, 3,3, 4),
(NULL, 'Javier','Monte' , 41304, 1998,20, 5, 2, 0,0,3, 3,2, 5),
(NULL, 'Hansiain','Gerrietz', 77132, 1998, 65, 1, 6, 0, 0,3, 3,2, 6),
(NULL, 'Teddy','Fountain', 27646, 1998, 34, 6, 3, 0, 0,3, 3,2, 7),
(NULL, 'Bond','Message', 83212, 1998, 98, 4, 2, 0, 0,3, 3,2, 7),
(NULL, 'Gerardo','Birley', 88407, 1998, 63, 3, 2, 0, 0,3, 3,2, 7),
(NULL, 'Kyle','Hamelyn', 98773, 1998, 1, 7, 3, 0, 0,3, 3,2, 7),
(NULL, 'Antoine','Caldeyroux', 69978, 1998, 89, 5, 2, 0, 0,3, 3,2, 7),
(NULL, 'Duncan','Dilleway', 73016, 1998, 50, 2, 2, 0, 0,3, 3,2, 7),
(NULL, 'Windham','Tanner', 89842, 1998, 2, 6, 6, 0, 0,3, 3,2, 7),
(NULL, 'Geoffrey','Simonassi', 95553, 1998, 82, 2, 1, 0, 0,3, 3,3, 7),
(NULL, 'Zedekiah','Decourt', 38641, 1998, 37, 2, 1, 0, 0,3, 3,3, 7),
(NULL, 'Chevalier','Herrero', 69896, 1998, 85, 5, 3, 0, 0,3, 3,3, 7),


(NULL, 'Olivero','Bentham3', 53673, 1999, 92, 4, 2, 0, 0,3, 3,3, 1),
(NULL, 'Fabian','Fennell', 23190, 1999, 70, 2, 4, 0, 0,3, 3,3, 2),
(NULL, 'Brent','Eyre', 51390, 1999, 7, 1, 4, 0, 0,3, 3,5, 3),
(NULL, 'Ephraim','Gobeau', 62929, 1999, 25, 1, 5, 0, 0,3, 3,5, 4),
(NULL, 'Tedie','Limon', 33252, 1999, 83, 6, 2, 0, 0,3, 3,5, 5),
(NULL, 'Dion','Grieswood', 11088, 1999, 28, 6, 1, 0, 0,3, 3,5, 6),
(NULL, 'Gerald','Bolitho', 93379, 1999, 78, 7, 4, 0, 0,3, 3,5, 7),
(NULL, 'Hobey','Overy', 70384, 1999, 43, 3, 3, 0, 0,3, 3,4, 7),
(NULL, 'Chauncey','Maliphant', 53694, 1999, 64, 6, 7, 0, 0,3, 3,4, 7),
(NULL, 'Dino','Rodgerson', 43103, 1999, 90, 2, 7, 0, 0,3, 3,4, 7),
(NULL, 'Antin','Barefoot', 96550, 1999, 85, 1, 5, 0, 0,3, 3,4, 7),
(NULL, 'Jorge','Sentinella', 29443, 1999, 90, 2, 2, 0, 0,3, 3,3, 7),
(NULL, 'Vachel','Crielly', 90119, 1999, 10, 7, 4, 0, 0,3, 3,3, 7),
(NULL, 'Christoper','Itzkovwitch', 17743, 1999, 56, 2, 5, 0, 0,3, 3,3, 7),
(NULL, 'Rosco','Burry', 51733, 1999, 73, 5, 3, 0, 0,3, 3,3, 7),
(NULL, 'Barrie','Revett', 87668, 1999, 35, 5, 2, 0, 0,3, 3,3, 7),


(NULL, 'Marsh','Sopp', 26790, 2000, 52, 7, 6, 0, 0,3, 3,1, 1),
(NULL, 'Verne','Shout', 72839, 2000, 87, 6, 1, 0, 0,3, 3,1, 2),
(NULL, 'Fraze','Bartoszewicz', 35778, 2000, 48, 3, 1, 0, 0,3, 3,1, 3),
(NULL, 'Wilden','Fivey', 88665, 2000, 34, 1, 2, 0, 0,3, 3,1, 4),
(NULL, 'Hyman','Rown', 40103, 2000, 36, 7, 5, 0, 0,3, 3,1, 5),
(NULL, 'Frasco','Grimbleby', 82109, 2000, 53, 2, 7, 0, 0,3, 3,1, 6),
(NULL, 'Aron','Simonutti', 59987, 2000, 11, 7, 1, 0, 0,3, 3,2, 7),
(NULL, 'Sigismond','Mitroshinov', 43890, 2000, 58, 4, 7, 0, 0,3, 3,2, 7),
(NULL, 'Izaak','Juliff', 76299, 2000, 38, 5, 5, 0, 0,3, 3,2, 7),
(NULL, 'Mar','Harce', 82628, 2000, 17, 6, 7, 0, 0,3, 3,2, 7),
(NULL, 'Ring','Stalley', 73279, 2000, 68, 7, 7, 0, 0,3, 3,2, 7),
(NULL, 'Roderich','Clifford', 84673, 2000, 95, 3, 6, 0, 0,3, 3,2, 7),
(NULL, 'Jedd','Dymidowicz', 92731, 2000, 95, 3, 1, 0, 0,3, 3,3, 7),
(NULL, 'Alonso','Tett', 32819, 2000, 42, 2, 2, 0, 0,3, 3,3, 7),
(NULL, 'Emmy','Emmatt', 17082, 2000, 5, 4, 6, 0, 0,3, 3,3, 7),
(NULL, 'Devy','Pease', 44167, 2000, 67, 4, 4, 0, 0,3, 3,3, 7),


(NULL, 'Ara','Linney', 52470, 1995, 36, 7, 4, 0, 0,3,4,3, 1),
(NULL, 'Darius','McQuirter',43677,1995,10,7,4,0,0,3,4,3, 2),
(NULL, 'Andy','Edghinn',58929,1995,93,1,3,0,0,3,4,3, 3),
(NULL, 'Abran','Traske',31751,1995,83,7,7,0,0,3,4,3, 4),
(NULL, 'Johnnie','Scorah',50751,1995,28,3,1,0,0,3,4,3, 5),
(NULL, 'Renaldo','Fidilis',84728,1995,39,3,7,0,0,3,4,3, 6),
(NULL, 'Cullin','Stenyng',14299,1995,98,1,7,0,0,3,4,3, 7),
(NULL, 'Frederick','Gillino',49583,1995,24,3,7,0,0,3,4,3, 7),
(NULL, 'Darryl','Bessant',48063,1995,8,1,4,0,0,3,4,3, 7),
(NULL, 'Uriel','Dettmar',56583,1995,1,4,4,0,0,3,4,3, 7),
(NULL, 'Bev','Masi',33180,1995,6,1,2,0,0,3,4,3, 7),
(NULL, 'Mike','Fitton',86208,1995,24,3,4,0,0,3,4,3, 7),
(NULL, 'Towney','Fant',65502,1995,6,1,4,0,0,3,4,3, 7),
(NULL, 'Temple','Lauderdale',97471,1995,78,7,5,0,0,3,4,3, 7),
(NULL, 'Axel','Roote',33326,1995,10,5,7,0,0,3,4,3, 7),
(NULL, 'Gherardo','Staining',59377,1995,88,3,3,0,0,3,4,3, 7),


(NULL, 'Robinet','Sugars',75640,1996,60,7,4,0,0,3,4,3, 1),
(NULL, 'Teodor','Arnholz',75202,1996,61,2,5,0,0,3,4,3, 2),
(NULL, 'Jerald','Duxbarry',87324,1996,2,5,4,0,0,3,4,3, 3),
(NULL, 'Arty','Braunston',51734,1996,48,1,2,0,0,3,4,3, 4),
(NULL, 'Lothaire','Knox',45684,1996,22,3,5,0,0,3,4,3, 5),
(NULL, 'Reinwald','Sighart',53834,1996,16,7,1,0,0,3,4,3, 6),
(NULL, 'Jerry','Maydwell',92225,1996,86,4,1,0,0,3,4,3, 7),
(NULL, 'Cornie','Houlton',51964,1996,13,6,6,0,0,3,4,1, 7),
(NULL, 'Trefor','McCafferky',42171,1996,30,5,4,0,0,3,4,1, 7),
(NULL, 'Elihu','Dandie',72021,1996,22,1,1,0,0,3,4,1, 7),
(NULL, 'Vassily','Kikke',33975,1996,6,7,7,0,0,3,4,1, 7),
(NULL, 'Lorry','Ginnally',34296,1996,55,7,6,0,0,3,4,1, 7),
(NULL, 'Isidro','Dahlbom',60600,1996,50,6,5,0,0,3,4,1, 7),
(NULL, 'Matthaeus','Raisher',63523,1996,75,1,3,0,0,3,4,1, 7),
(NULL, 'Flin','Callam',18115,1996,20,1,4,0,0,3,4,1, 7),
(NULL, 'Renaud','Jacobbe',17632,1996,91,7,1,0,0,3,4,1, 7),


(NULL, 'Arni','Jerrim',51183,1997,17,1,2,0,0,3,4,1, 1),
(NULL, 'Garik','Beelby',81419,1997,5,3,1,0,0,3,4,1, 2),
(NULL, 'Woody','Hedley',24856,1997,73,7,3,0,0,3,4,5, 3),
(NULL, 'Mord','Elsom',68060,1997,63,1,5,0,0,3,4,5, 4),
(NULL, 'Cliff','Jacquemy',61510,1997,62,6,7,0,0,3,4,5, 5),
(NULL, 'Ramsay','Geal',78505,1997,37,2,2,0,0,3,4,5, 6),
(NULL, 'Aymer','Cominello',64429,1997,64,7,3,0,0,3,4,5, 7),
(NULL, 'Lin','Antonopoulos',31205,1997,100,5,1,0,0,3,4,5, 7),
(NULL, 'Robbert','Copp',15279,1997,73,3,4,0,0,3,4,5, 7),
(NULL, 'Reese','MacConnel',63043,1997,100,6,7,0,0,3,4,5, 7),
(NULL, 'Benson','Whickman',76416,1997,32,2,3,0,0,3,4,5, 7),
(NULL, 'Parry','Lavies',54652,1997,28,3,7,0,0,3,4,5, 7),
(NULL, 'Scarface','Ryle',74050,1997,97,7,2,0,0,3,4,5, 7),
(NULL, 'Kingsley','Stirton',69984,1997,25,6,3,0,0,3,4,5, 7),
(NULL, 'Bondie','Sleicht',56690,1997,58,3,6,0,0,3,4,5, 7),
(NULL, 'Dex','Tumbelty',79581,1997,15,7,3,0,0,3,4,5, 7),


(NULL, 'Grange','Westmarland',15035,1998,76,5,3,0,0,3,4,5, 1),
(NULL, 'Clayborne','Lauridsen',20466,1998,68,3,3,0,0,3,4,5, 2),
(NULL, 'Ezequiel','Sivill',92797,1998,4,7,5,0,0,3,4,5, 3),
(NULL, 'Harlan','Buske',12630,1998,31,4,6,0,0,3,4,4, 4),
(NULL, 'Ellswerth','Simnel',83005,1998,93,6,7,0,0,3,4,4, 5),
(NULL, 'West','Adamides',29088,1998,65,6,7,0,0,3,4,4, 6),
(NULL, 'Edsel','Melloy',63168,1998,42,5,1,0,0,3,4,4, 7),
(NULL, 'Tirrell','Madrell',20078,1998,12,4,5,0,0,3,4,4, 7),
(NULL, 'Eldredge','Matejovsky',59903,1998,20,3,1,0,0,3,4,4, 7),
(NULL, 'Bondy','Whooley',84527,1998,42,1,6,0,0,3,4,4, 7),
(NULL, 'Sonny','Dalton',42253,1998,16,4,3,0,0,3,4,4, 7),
(NULL, 'Allen','Gillogley',74034,1998,33,5,6,0,0,3,4,4, 7),
(NULL, 'Heall','Dewen',21984,1998,63,2,1,0,0,3,4,4, 7),
(NULL, 'Clem','Andrejs',60912,1998,46,5,4,0,0,3,4,3, 7),
(NULL, 'Julian','Strangwood',76264,1998,32,7,2,0,0,3,4,3, 7),
(NULL, 'Jeremiah','Chillistone',78206,1998,65,1,1,0,0,3,4,3, 7),


(NULL, 'Lalo','Fonzo',22523,1999,86,4,7,0,0,3,4,3, 1),
(NULL, 'Etienne','Nurden',71153,1999,99,5,4,0,0,3,4,3, 2),
(NULL, 'Kris','Fawke',84491,1999,59,7,6,0,0,3,4,3, 3),
(NULL, 'Ed','Trousdale',62257,1999,93,6,1,0,0,3,4,3, 4),
(NULL, 'Sigismond','Yeo',77531,1999,38,5,2,0,0,3,4,3, 5),
(NULL, 'Brendin','Carvill',13122,1999,64,6,2,0,0,3,4,3, 6),
(NULL, 'Darryl','Gilbard',98407,1999,41,1,4,0,0,3,4,2, 7),
(NULL, 'Aldis','Winser',18785,1999,24,4,3,0,0,3,4,2, 7),
(NULL, 'Harper','Happer',15138,1999,91,4,7,0,0,3,4,2, 7),
(NULL, 'Roley','Jinkins',49384,1999,56,1,3,0,0,3,4,2, 7),
(NULL, 'Denver','Duddy',15974,1999,24,1,7,0,0,3,4,2, 7),
(NULL, 'Chrisse','Southern',22855,1999,24,7,7,0,0,3,4,2, 7),
(NULL, 'Antonino','Oxford',28391,1999,18,3,2,0,0,3,4,2, 7),
(NULL, 'Nicholas','Teare',24777,1999,38,6,5,0,0,3,4,2, 7),
(NULL, 'Frans','Furphy',46641,1999,38,5,6,0,0,3,4,2, 7),
(NULL, 'Boycey','Escala',63877,1999,65,7,1,0,0,3,4,2, 7),


(NULL, 'Abel','Dyshart',59313,2000,33,1,6,0,0,3,4,2, 1),
(NULL, 'Town','Mixture',27626,2000,52,5,6,0,0,3,4,2, 2),
(NULL, 'Stanfield','Cawse',65691,2000,38,3,5,0,0,3,4,2, 3),
(NULL, 'Barnie','Fawthrop',19523,2000,54,6,1,0,0,3,4,2,4),
(NULL, 'Bard','Buckbee',38501,2000,24,5,7,0,0,3,4,2, 5),
(NULL, 'Olivero','McReidy',84623,2000,49,6,6,0,0,3,4,2, 6),
(NULL, 'Fredrick','Youthead',73922,2000,11,7,2,0,0,3,4,2, 7),
(NULL, 'Muhammad','Mobius',77752,2000,45,4,5,0,0,3,4,2, 7),
(NULL, 'Geno','Parkhouse',24573,2000,55,2,2,0,0,3,4,2, 7),
(NULL, 'Monroe','MacCole',93411,2000,41,2,5,0,0,3,4,1, 7),
(NULL, 'Marcello','Trethowan',24982,2000,34,3,3,0,0,3,4,1, 7),
(NULL, 'Berkie','Gaspero',42481,2000,51,7,7,0,0,3,4,1, 7),
(NULL, 'Garret','Osbourne',41486,2000,71,4,2,0,0,3,4,1, 7),
(NULL, 'Kienan','Bock',64867,2000,66,3,5,0,0,3,4,1, 7),
(NULL, 'Niall','Grennan',94125,2000,55,6,2,0,0,3,4,1, 7),
(NULL, 'Hugibert','Slocombe',14198,2000,28,3,6,0,0,3,4,5, 7),


(NULL, 'Vlad','Redmain',77732,1995,91,6,5,0,0,3,5,5, 1),
(NULL, 'Nev','Corck',86583,1995,22,7,2,0,0,3,5,5, 2),
(NULL, 'Onfroi','Devlin',89335,1995,100,4,5,0,0,3,5,5, 3),
(NULL, 'Olly','Hanes',53638,1995,6,6,2,0,0,3,5,5, 4),
(NULL, 'Axe','Lohden',37002,1995,53,2,4,0,0,3,5,5, 5),
(NULL, 'Kingston','Gellan',56655,1995,24,6,7,0,0,3,5,5, 6),
(NULL, 'Ramon','Neary',27209,1995,47,5,1,0,0,3,5,4, 7),
(NULL, 'Tiler','Willas',61273,1995,8,1,2,0,0,3,5,4, 7),
(NULL, 'Bart','French',53072,1995,15,7,1,0,0,3,5,4, 7),
(NULL, 'Ermanno','Grayland',38940,1995,6,3,6,0,0,3,5,4, 7),
(NULL, 'Morgun','Stringfellow',55796,1995,18,5,6,0,0,3,5,4, 7),
(NULL, 'Alix','Reichhardt',15504,1995,78,4,2,0,0,3,5,4, 7),
(NULL, 'Adair','Heskins',10661,1995,39,5,7,0,0,3,5,4, 7),
(NULL, 'Willdon','Hiers',42960,1995,5,3,7,0,0,3,5,4, 7),
(NULL, 'Keene','Rubenovic',28616,1995,2,2,6,0,0,3,5,3, 7),
(NULL, 'Dev','Eatherton',58018,1995,61,6,4,0,0,3,5,3, 7),


(NULL, 'Ellery','Grimbleby',78187,1996,79,3,5,0,0,3,5,3, 1),
(NULL, 'Neel','Soppit',44002,1996,54,1,2,0,0,3,5,3, 2),
(NULL, 'Brett','Caccavella',73633,1996,1,6,1,0,0,3,5,3, 3),
(NULL, 'Bennie','McMillian',10537,1996,34,2,6,0,0,3,5,3, 4),
(NULL, 'Addie','Fairburne',30115,1996,24,5,4,0,0,3,5,3, 5),
(NULL, 'Clayson','Sedgman',93389,1996,41,4,6,0,0,3,5,3, 6),
(NULL, 'Ad','Grand',24204,1996,9,6,2,0,0,3,5,3, 7),
(NULL, 'Cyrillus','Humfrey',28291,1996,36,1,4,0,0,3,5,3, 7),
(NULL, 'Tripp','Inseal',79566,1996,71,5,5,0,0,3,5,3, 7),
(NULL, 'Kennie','Huffer',92382,1996,47,6,7,0,0,3,5,3, 7),
(NULL, 'Rowland','Fairbourn',28704,1996,75,4,2,0,0,3,5,3, 7),
(NULL, 'Lorne','Bassil',52612,1996,30,5,7,0,0,3,5,3, 7),
(NULL, 'Seymour','Croce',50574,1996,57,7,5,0,0,3,5,3, 7),
(NULL, 'Napoleon','Dilrew',85037,1996,60,6,5,0,0,3,5,3, 7),
(NULL, 'Cecilius','Rustidge',34381,1996,47,1,1,0,0,3,5,3, 7),
(NULL, 'Ralf','Ashwin',42246,1996,52,1,6,0,0,3,5,3, 7),


(NULL, 'Alberto','Perez',32302,1997,33,2,3,0,0,3,5,3, 1),
(NULL, 'Ramon','Baldessari',73780,1997,6,4,7,0,0,3,5,3, 2),
(NULL, 'Jose','Gont',40346,1997,20,4,7,0,0,3,5,3, 3),
(NULL, 'Angel','Barbosa',46834,1997,19,6,3,0,0,3,5,3, 4),
(NULL, 'Luis','Rodriguez',70278,1997,40,6,3,0,0,3,5,3, 5),
(NULL, 'Pablo','Casasola',12712,1997,56,6,2,0,0,3,5,3, 6),
(NULL, 'Enrique','Rodriguez',37328,1997,73,4,6,0,0,3,5,3, 7),
(NULL, 'Matias','Santilan',90701,1997,50,4,5,0,0,3,5,3, 7),
(NULL, 'Mathias','Zamora',86570,1997,52,1,5,0,0,3,5,3, 7),
(NULL, 'Hernan','Zuzulich',42058,1997,49,4,4,0,0,3,5,3, 7),
(NULL, 'Gonzalo','Zuviria',30270,1997,49,7,6,0,0,3,5,3, 7),
(NULL, 'Santiago','Spector',37090,1997,91,4,3,0,0,3,5,3, 7),
(NULL, 'Roberto','Romero',31489,1997,80,4,4,0,0,3,5,3, 7),
(NULL, 'Martin','Rosales',42288,1997,4,5,4,0,0,3,5,3, 7),
(NULL, 'Tomas','Garcia',56474,1997,90,1,5,0,0,3,5,3, 7),
(NULL, 'Facundo','Cosin',88645,1997,44,1,7,0,0,3,5,3, 7),


(NULL, 'Inigo','Pardoe',32302,1998,33,2,3,0,0,3,5,3, 1),
(NULL, 'Roger','Stranaghan',73780,1998,6,4,7,0,0,3,5,3, 2),
(NULL, 'Ange','Zumbusch',40346,1998,20,4,7,0,0,3,5,3, 3),
(NULL, 'Phip','Duckering',46834,1998,19,6,3,0,0,3,5,3, 4),
(NULL, 'Putnem','Cook',70278,1998,40,6,3,0,0,3,5,3, 5),
(NULL, 'Lothaire','Perche',12712,1998,56,6,2,0,0,3,5,3, 6),
(NULL, 'Kellby','Allkins',37328,1998,73,4,6,0,0,3,5,3, 7),
(NULL, 'Heinrick','Goodhew',90701,1998,50,4,5,0,0,3,5,3, 7),
(NULL, 'Krispin','Heppenspall',86570,1998,52,1,5,0,0,3,5,3, 7),
(NULL, 'Ezra','Godding',42058,1998,49,4,4,0,0,3,5,5, 7),
(NULL, 'Ruy','Golden',30270,1998,49,7,6,0,0,3,5,5, 7),
(NULL, 'Humbert','McVee',37090,1998,91,4,3,0,0,3,5,5, 7),
(NULL, 'Ludvig','Telfer',31489,1998,80,4,4,0,0,3,5,5, 7),
(NULL, 'Sheppard','Seman',42288,1998,4,5,4,0,0,3,5,4, 7),
(NULL, 'Cale','McKernon',56474,1998,90,1,5,0,0,3,5,4, 7),
(NULL, 'Pren','Hanshaw',88645,1998,44,1,7,0,0,3,5,4, 7),


(NULL, 'Noam','Ledster',45942,1999,29,6,7,0,0,3,5,4, 0),
(NULL, 'Egbert','Picopp',86307,1999,80,3,1,0,0,3,5,3, 0),
(NULL, 'Drake','Hambrick',39580,1999,88,7,1,0,0,3,5,3, 0),
(NULL, 'Benton','Sibson',80266,1999,11,3,6,0,0,3,5,3, 0),
(NULL, 'Gasper','Troillet',27308,1999,62,1,7,0,0,3,5,3, 0),
(NULL, 'Emile','Rusbridge',97508,1999,60,2,6,0,0,3,5,1, 0),
(NULL, 'Finlay','Carratt',36573,1999,83,6,5,0,0,3,5,1, 0),
(NULL, 'Ernst','Woodcraft',40677,1999,94,6,6,0,0,3,5,1, 0),
(NULL, 'Ferris','Mignot',11533,1999,97,1,6,0,0,3,5,1, 0),
(NULL, 'Jose','Charman',26249,1999,21,5,7,0,0,3,5,1, 0),
(NULL, 'Randi','Crevy',33167,1999,64,2,4,0,0,3,5,2, 0),
(NULL, 'Ozzy','Bridgestock',18684,1999,36,5,1,0,0,3,5,2, 0),
(NULL, 'Rodrick','Learoid',80480,1999,43,6,7,0,0,3,5,2, 0),
(NULL, 'Eugen','Sotheron',16734,1999,96,2,2,0,0,3,5,2, 0),
(NULL, 'Gardy','Perryman',49524,1999,60,4,4,0,0,3,5,3, 0),
(NULL, 'Xymenes','James',39909,1999,95,3,7,0,0,3,5,3, 0),


(NULL, 'Matteo','McAw',14183,2000,58,3,7,0,0,3,5,3, 0),
(NULL, 'Jarred','Doughill',85307,2000,40,2,4,0,0,3,5,3, 0),
(NULL, 'Fabien','Work',61762,2000,65,3,1,0,0,3,5,3, 0),
(NULL, 'Ari','Aberdeen',15686,2000,12,3,4,0,0,3,5,1, 0),
(NULL, 'Lyle','Bernaert',43022,2000,72,5,2,0,0,3,5,1, 0),
(NULL, 'Micheal','Cardenoso',19123,2000,40,7,4,0,0,3,5,1, 0),
(NULL, 'Chilton','Radbond',20820,2000,25,3,7,0,0,3,5,1, 0),
(NULL, 'Thoma','Crankhorn',62712,2000,57,5,3,0,0,3,5,1, 0),
(NULL, 'Zared','Giblin',34453,2000,36,1,6,0,0,3,5,2, 0),
(NULL, 'Niko','Carling',98607,2000,58,4,5,0,0,3,5,2, 0),
(NULL, 'Falito','Theobald',92193,2000,85,1,2,0,0,3,5,2, 0),
(NULL, 'Ferguson','Dougharty',52392,2000,30,5,5,0,0,3,5,2, 0),
(NULL, 'Ulric','Payler',94474,2000,12,5,3,0,0,3,5,2, 0),
(NULL, 'Gran','Benham',62232,2000,28,6,6,0,0,3,5,2, 0),
(NULL, 'Talbert','Reany',13474,2000,91,5,6,0,0,3,5,5, 0),
(NULL, 'Kile','Borman',37673,2000,90,2,7,0,0,3,5,0, 0)
;

INSERT INTO partido_f (id_partido, id_arbitro, fecha_hora, categoria, id_equipo_local, id_equipo_visitante)
VALUES
# Fecha 1 - 1995
  (NULL, 3, '2023-07-01 11:21:12', 1995, 1, 7),
  (NULL, 3, '2023-07-01 21:25:33', 1995, 13, 19),
  (NULL, 1, '2023-07-01 01:32:59', 1995, 25, 31),
# Fecha 2 - 1995
  (NULL, 3, '2023-07-01 11:33:12', 1995, 19, 1),
  (NULL, 2, '2023-07-01 17:32:30', 1995, 31, 13),
  (NULL, 1, '2023-07-01 03:32:47', 1995, 7, 25),
# Fecha 3 - 1995
  (NULL, 3, '2024-07-01 10:43:32', 1995, 1, 31),
  (NULL, 1, '2023-07-01 01:58:00', 1995, 13, 7),
  (NULL, 2, '2024-07-01 05:56:29', 1995, 25, 19),
# Fecha 1 - 1996
   (NULL, 3, '2023-06-18 03:35:10', 1996, 2, 8),
   (NULL, 2, '2024-01-28 11:49:06', 1996, 14, 20),
   (NULL, 2, '2023-10-28 12:53:09', 1996, 26, 32),
# Fecha 2 - 1996
   (NULL, 1, '2024-04-13 06:48:39', 1996, 20, 2),
   (NULL, 2, '2024-01-08 14:20:30', 1996, 8, 26),
   (NULL, 2, '2024-03-12 00:25:02', 1996, 32, 14),
# Fecha 3 - 1996
   (NULL, 2, '2023-04-12 03:01:35', 1996, 14, 8),
   (NULL, 1, '2024-05-31 17:54:43', 1996, 2, 32),
   (NULL, 2, '2023-08-08 02:35:26', 1996, 26, 20),
# Fecha 1 - 1997
   (NULL, 2, '2023-04-05 12:50:05', 1997, 3, 9),
   (NULL, 2, '2023-06-23 18:57:46', 1997, 15, 21),
   (NULL, 1, '2024-04-20 03:34:44', 1997, 27, 33),
# Fecha 2 - 1997
   (NULL, 1, '2023-05-16 22:00:52', 1997, 21, 3),
   (NULL, 3, '2024-06-25 11:54:05', 1997, 9, 27),
   (NULL, 3, '2023-08-28 12:46:00', 1997, 33, 15),
# Fecha 3 - 1997
   (NULL, 3, '2023-10-27 20:57:40', 1997, 15, 9),
   (NULL, 3, '2024-02-19 20:16:01', 1997, 3, 33),
   (NULL, 1, '2024-02-12 21:35:00', 1997, 27, 21),
# Fecha 1 - 1998
   (NULL, 3, '2023-03-25 14:24:17', 1998, 4, 10),
   (NULL, 2, '2023-05-28 12:40:33', 1998, 16, 22),
   (NULL, 3, '2024-07-23 22:37:15', 1998, 28, 34),
# Fecha 2 - 1998
   (NULL, 3, '2023-03-25 14:24:17', 1998, 22, 4),
   (NULL, 2, '2023-05-28 12:40:33', 1998, 10, 28),
   (NULL, 3, '2024-07-23 22:37:15', 1998, 34, 16),
# Fecha 3 - 1998
   (NULL, 3, '2023-03-25 14:24:17', 1998, 16, 10),
   (NULL, 2, '2023-05-28 12:40:33', 1998, 4, 34),
   (NULL, 3, '2024-07-23 22:37:15', 1998, 28, 22),
# Fecha 1 - 1999
   (NULL, 3, '2023-03-25 14:24:17', 1999, 5, 11),
   (NULL, 2, '2023-05-28 12:40:33', 1999, 17, 23),
   (NULL, 3, '2024-07-23 22:37:15', 1999, 29, 35),
# Fecha 2 - 1999
   (NULL, 3, '2023-03-25 14:24:17', 1999, 23, 5),
   (NULL, 2, '2023-05-28 12:40:33', 1999, 11, 29),
   (NULL, 3, '2024-07-23 22:37:15', 1999, 35, 17),
# Fecha 3 - 1999
   (NULL, 3, '2023-03-25 14:24:17', 1999, 17, 11),
   (NULL, 2, '2023-05-28 12:40:33', 1999, 5, 35),
   (NULL, 3, '2024-07-23 22:37:15', 1999, 29, 23)
;



INSERT INTO partido_m  (id_partido, id_arbitro, fecha_hora, categoria, id_equipo_local, id_equipo_visitante)
VALUES
  (NULL, 3, '2023-07-01 11:21:12', 1995, 1, 25),
  (NULL, 3, '2023-07-03 21:25:33', 1995, 7, 19),
  (NULL, 1, '2023-03-29 01:32:59', 1995, 13, 7),
  (NULL, 3, '2023-06-04 11:33:12', 1995, 19, 13),
  (NULL, 2, '2023-11-01 17:32:30', 1995, 25, 1),
  (NULL, 1, '2023-09-09 03:32:47', 1996, 2, 26),
  (NULL, 3, '2024-03-31 10:43:32', 1996, 8, 20),
  (NULL, 1, '2023-10-09 01:58:00', 1996, 14, 8),
  (NULL, 2, '2024-04-02 05:56:29', 1996, 20, 14),
  (NULL, 3, '2023-06-18 03:35:10', 1996, 26, 2),
  (NULL, 2, '2024-01-28 11:49:06', 1997, 3, 27),
  (NULL, 2, '2023-10-28 12:53:09', 1997, 9, 21),
  (NULL, 1, '2024-04-13 06:48:39', 1997, 15, 15),
  (NULL, 2, '2024-01-08 14:20:30', 1997, 21, 9),
  (NULL, 2, '2024-03-12 00:25:02', 1997, 27, 3),
  (NULL, 2, '2023-04-12 03:01:35', 1998, 4, 28),
  (NULL, 1, '2024-05-31 17:54:43', 1998, 10, 22),
  (NULL, 2, '2023-08-08 02:35:26', 1998, 16, 10),
  (NULL, 2, '2023-04-05 12:50:05', 1998, 22, 16),
  (NULL, 2, '2023-06-23 18:57:46', 1998, 28, 4),
  (NULL, 1, '2024-04-20 03:34:44', 1999, 5, 29),
  (NULL, 1, '2023-05-16 22:00:52', 1999, 11, 23),
  (NULL, 3, '2024-06-25 11:54:05', 1999, 17, 11),
  (NULL, 3, '2023-08-28 12:46:00', 1999, 23, 17),
  (NULL, 3, '2023-10-27 20:57:40', 1999, 29, 5),
  (NULL, 3, '2024-02-19 20:16:01', 2000, 6, 30),
  (NULL, 1, '2024-02-12 21:35:00', 2000, 12, 24),
  (NULL, 3, '2023-03-25 14:24:17', 2000, 18, 12),
  (NULL, 2, '2023-05-28 12:40:33', 2000, 24, 18),
  (NULL, 3, '2024-07-23 22:37:15', 2000, 30, 6)
  
;

 INSERT INTO equipo_f (id_equipo_f, categoria, id_dt, partidos_jugados, partidos_a_jugar, sexo, id_club)
 VALUES
 # 1995 - 1
(NULL, 1995, 9, 0, 20, 'F', 1),
 # 1996 - 1
(NULL, 1996, 6, 0, 20, 'F', 1),
# 1997 - 1
(NULL, 1997, 6, 0, 20, 'F', 1),
# 1998 - 1
(NULL, 1998, 6, 0, 20, 'F', 1),
# 1999 - 1
(NULL, 1999, 6, 0, 20, 'F', 1),
# 2000 - 1
(NULL, 2000, 6, 0, 20, 'F', 1),
# 1995 - 2
(NULL, 1995, 9, 0, 20, 'F', 2),
# 1996 - 2
(NULL, 1996, 6, 0, 20, 'F', 2),
# 1997 - 2
(NULL, 1997, 6, 0, 20, 'F', 2),
# 1998 - 2
(NULL, 1998, 6, 0, 20, 'F', 2),
# 1999 - 2
(NULL, 1999, 6, 0, 20, 'F', 2),
# 2000 - 2
(NULL, 2000, 6, 0, 20, 'F', 2),
# 1995 - 3
(NULL, 1995, 9, 0, 20, 'F', 3),
# 1996 - 3
(NULL, 1996, 6, 0, 20, 'F', 3),
# 1997 - 3
(NULL, 1997, 6, 0, 20, 'F', 3),
# 1998 - 3
(NULL, 1998, 6, 0, 20, 'F', 3),
# 1999 - 3
(NULL, 1999, 6, 0, 20, 'F', 3),
# 2000 - 3
(NULL, 2000, 6, 0, 20, 'F', 3),
# 1995 - 4
(NULL, 1995, 9, 0, 20, 'F', 4),
# 1996 - 4
(NULL, 1996, 6, 0, 20, 'F', 4),
# 1997 - 4
(NULL, 1997, 6, 0, 20, 'F', 4),
# 1998 - 4
(NULL, 1998, 6, 0, 20, 'F', 4),
# 1999 - 4
(NULL, 1999, 6, 0, 20, 'F', 4),
# 2000 - 4
(NULL, 2000, 6, 0, 20, 'F', 4),
# 1995 - 5
(NULL, 1995, 9, 0, 20, 'F', 5),
# 1996 - 5
(NULL, 1996, 6, 0, 20, 'F', 5),
# 1997 - 5
(NULL, 1997, 6, 0, 20, 'F', 5),
# 1998 - 5
(NULL, 1998, 6, 0, 20, 'F', 5),
# 1999 - 5
(NULL, 1999, 6, 0, 20, 'F', 5),
# 2000 - 5
(NULL, 2000, 6, 0, 20, 'F', 5),
# 1995 - 6
(NULL, 1995, 9, 0, 20, 'F', 6),
# 1996 - 6
(NULL, 1996, 6, 0, 20, 'F', 6),
# 1997 - 6
(NULL, 1997, 6, 0, 20, 'F', 6),
# 1998 - 6
(NULL, 1998, 6, 0, 20, 'F', 6),
# 1999 - 6
(NULL, 1999, 6, 0, 20, 'F', 6),
# 2000 - 6
(NULL, 2000, 6, 0, 20, 'F', 6)
;
;

INSERT INTO equipo_m (id_equipo_m, categoria, id_dt, partidos_jugados, partidos_a_jugar, sexo, id_club)
VALUES
# 1995 - 1
(NULL, 1995, 9, 0, 20, 3, 1),
# 1996 - 1
(NULL, 1996, 6, 0, 20, 3, 1),
# 1997 - 1
(NULL, 1997, 6, 0, 20, 3, 1),
# 1998 - 1
(NULL, 1998, 6, 0, 20, 3, 1),
# 1999 - 1
(NULL, 1999, 6, 0, 20, 3, 1),
# 2000 - 1
(NULL, 2000, 6, 0, 20, 3, 1),
# 1995 - 2
(NULL, 1995, 9, 0, 20, 3, 2),
# 1996 - 2
(NULL, 1996, 6, 0, 20, 3, 2),
# 1997 - 2
(NULL, 1997, 6, 0, 20, 3, 2),
# 1998 - 2
(NULL, 1998, 6, 0, 20, 3, 2),
# 1999 - 2
(NULL, 1999, 6, 0, 20, 3, 2),
# 2000 - 2
(NULL, 2000, 6, 0, 20, 3, 2),
# 1995 - 3
(NULL, 1995, 9, 0, 20, 3, 3),
# 1996 - 3
(NULL, 1996, 6, 0, 20, 3, 3),
# 1997 - 3
(NULL, 1997, 6, 0, 20, 3, 3),
# 1998 - 3
(NULL, 1998, 6, 0, 20, 3, 3),
# 1999 - 3
(NULL, 1999, 6, 0, 20, 3, 3),
# 2000 - 3
(NULL, 2000, 6, 0, 20, 3, 3),
# 1995 - 4
(NULL, 1995, 9, 0, 20, 3, 4),
# 1996 - 4
(NULL, 1996, 6, 0, 20, 3, 4),
# 1997 - 4
(NULL, 1997, 6, 0, 20, 3, 4),
# 1998 - 4
(NULL, 1998, 6, 0, 20, 3, 4),
# 1999 - 4
(NULL, 1999, 6, 0, 20, 3, 4),
# 2000 - 4
(NULL, 2000, 6, 0, 20, 3, 4),
# 1995 - 5
(NULL, 1995, 9, 0, 20, 3, 5),
# 1996 - 5
(NULL, 1996, 6, 0, 20, 3, 5),
# 1997 - 5
(NULL, 1997, 6, 0, 20, 3, 5),
# 1998 - 5
(NULL, 1998, 6, 0, 20, 3, 5),
# 1999 - 5
(NULL, 1999, 6, 0, 20, 3, 5),
# 2000 - 5
(NULL, 2000, 6, 0, 20, 3, 5)
;

UPDATE torneodeportivovictoriarodriguez.jugador_f SET goles = '2' WHERE (id_jugador_f = '2');
UPDATE torneodeportivovictoriarodriguez.jugador_f SET goles = '6' WHERE (id_jugador_f = '4');
UPDATE torneodeportivovictoriarodriguez.jugador_f SET goles = '7' WHERE (id_jugador_f = '95');
UPDATE torneodeportivovictoriarodriguez.jugador_f SET goles = '9' WHERE (id_jugador_f = '99');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '7');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '16');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '19');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '17');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '23');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '47');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '60');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '57');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '55');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '59');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '72');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '69');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '67');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '75');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '86');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '11' WHERE (`id_jugador_f` = '84');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '82');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '80');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '97');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '101');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '107');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '110');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '9' WHERE (`id_jugador_f` = '111');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '15' WHERE (`id_jugador_f` = '114');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '1' WHERE (`id_jugador_f` = '123');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '121');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '126');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '132');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '134');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '135');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '138');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '140');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '147');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '150');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '161');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '154');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '157');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '144');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '165');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '168');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '170');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '173');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '1' WHERE (`id_jugador_f` = '178');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '180');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '183');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '185');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '187');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '191');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '194');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '15' WHERE (`id_jugador_f` = '197');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '11' WHERE (`id_jugador_f` = '199');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '204');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '9' WHERE (`id_jugador_f` = '206');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '208');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '210');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '212');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '217');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '220');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '222');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '224');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '237');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '232');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '234');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '412');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '415');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '428');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '423');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '9' WHERE (`id_jugador_f` = '424');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '431');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '436');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '441');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '438');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '9' WHERE (`id_jugador_f` = '443');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '401');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '397');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '399');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '389');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '385');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '1' WHERE (`id_jugador_f` = '378');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '376');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '373');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '371');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '365');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '9' WHERE (`id_jugador_f` = '362');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '2' WHERE (`id_jugador_f` = '359');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '353');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '351');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '349');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '9' WHERE (`id_jugador_f` = '345');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '339');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '7' WHERE (`id_jugador_f` = '333');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '335');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '3' WHERE (`id_jugador_f` = '322');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '4' WHERE (`id_jugador_f` = '318');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '11' WHERE (`id_jugador_f` = '319');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '5' WHERE (`id_jugador_f` = '308');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '6' WHERE (`id_jugador_f` = '310');
UPDATE `torneodeportivovictoriarodriguez`.`jugador_f` SET `goles` = '8' WHERE (`id_jugador_f` = '311');

UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '13', `equipo_visitante_goles` = '9', `id_equipo_ganador` = '1', `id_equipo_perdedor` = '25' WHERE (`id_partido` = '1');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '8', `equipo_visitante_goles` = '5', `id_equipo_ganador` = '7', `id_equipo_perdedor` = '19' WHERE (`id_partido` = '2');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '7', `equipo_visitante_goles` = '17', `id_equipo_ganador` = '7', `id_equipo_perdedor` = '13' WHERE (`id_partido` = '3');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '3', `equipo_visitante_goles` = '15', `id_equipo_ganador` = '19', `id_equipo_perdedor` = '13' WHERE (`id_partido` = '4');


UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `finalizado_correctamente` = '1' WHERE (`id_partido` = '1');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `finalizado_correctamente` = '1' WHERE (`id_partido` = '2');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `finalizado_correctamente` = '1' WHERE (`id_partido` = '3');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `finalizado_correctamente` = '1' WHERE (`id_partido` = '4');

#1995
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `id_equipo_perdedor` = '7' WHERE (`id_partido` = '1');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '6', `equipo_visitante_goles` = '15', `id_equipo_ganador` = '19', `id_equipo_perdedor` = '13' WHERE (`id_partido` = '2');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '17', `equipo_visitante_goles` = '18', `id_equipo_ganador` = '31', `id_equipo_perdedor` = '25' WHERE (`id_partido` = '3');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '6', `equipo_visitante_goles` = '9', `id_equipo_ganador` = '1', `id_equipo_perdedor` = '19' WHERE (`id_partido` = '4');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '20', `equipo_visitante_goles` = '24', `id_equipo_ganador` = '31', `id_equipo_perdedor` = '13' WHERE (`id_partido` = '5');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '9', `equipo_visitante_goles` = '10', `id_equipo_ganador` = '25', `id_equipo_perdedor` = '7' WHERE (`id_partido` = '6');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '17', `equipo_visitante_goles` = '16', `id_equipo_ganador` = '1', `id_equipo_perdedor` = '31' WHERE (`id_partido` = '7');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '8', `equipo_visitante_goles` = '11', `id_equipo_ganador` = '7', `id_equipo_perdedor` = '13' WHERE (`id_partido` = '8');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '21', `equipo_visitante_goles` = '25', `id_equipo_ganador` = '19', `id_equipo_perdedor` = '25' WHERE (`id_partido` = '9');

#1996
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '17', `equipo_visitante_goles` = '19', `id_equipo_ganador` = '8', `id_equipo_perdedor` = '2' WHERE (`id_partido` = '10');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '4', `equipo_visitante_goles` = '21', `id_equipo_ganador` = '20', `id_equipo_perdedor` = '14' WHERE (`id_partido` = '11');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '15', `equipo_visitante_goles` = '12', `id_equipo_ganador` = '26', `id_equipo_perdedor` = '32' WHERE (`id_partido` = '12');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '7', `equipo_visitante_goles` = '8', `id_equipo_ganador` = '20', `id_equipo_perdedor` = '2' WHERE (`id_partido` = '13');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '13', `equipo_visitante_goles` = '9', `id_equipo_ganador` = '8', `id_equipo_perdedor` = '26' WHERE (`id_partido` = '14');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '14', `equipo_visitante_goles` = '22', `id_equipo_ganador` = '14', `id_equipo_perdedor` = '32' WHERE (`id_partido` = '15');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '25', `equipo_visitante_goles` = '16', `id_equipo_ganador` = '14', `id_equipo_perdedor` = '8' WHERE (`id_partido` = '16');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '13', `equipo_visitante_goles` = '16', `id_equipo_ganador` = '32', `id_equipo_perdedor` = '2' WHERE (`id_partido` = '17');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '11', `equipo_visitante_goles` = '10', `id_equipo_ganador` = '26', `id_equipo_perdedor` = '20' WHERE (`id_partido` = '18');

# 1997 
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '13', `equipo_visitante_goles` = '18', `id_equipo_ganador` = '9', `id_equipo_perdedor` = '3' WHERE (`id_partido` = '19');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '6', `equipo_visitante_goles` = '19', `id_equipo_ganador` = '21', `id_equipo_perdedor` = '15' WHERE (`id_partido` = '20');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '17', `equipo_visitante_goles` = '13', `id_equipo_ganador` = '27', `id_equipo_perdedor` = '33' WHERE (`id_partido` = '21');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '5', `equipo_visitante_goles` = '9', `id_equipo_ganador` = '21', `id_equipo_perdedor` = '3' WHERE (`id_partido` = '22');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '15', `equipo_visitante_goles` = '10', `id_equipo_ganador` = '9', `id_equipo_perdedor` = '27' WHERE (`id_partido` = '23');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '15', `equipo_visitante_goles` = '20', `id_equipo_ganador` = '15', `id_equipo_perdedor` = '33' WHERE (`id_partido` = '24');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '25', `equipo_visitante_goles` = '18', `id_equipo_ganador` = '15', `id_equipo_perdedor` = '9' WHERE (`id_partido` = '25');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '13', `equipo_visitante_goles` = '16', `id_equipo_ganador` = '33', `id_equipo_perdedor` = '3' WHERE (`id_partido` = '26');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '11', `equipo_visitante_goles` = '10', `id_equipo_ganador` = '27', `id_equipo_perdedor` = '21' WHERE (`id_partido` = '27');

# 1998
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '13', `equipo_visitante_goles` = '18', `id_equipo_ganador` = '9', `id_equipo_perdedor` = '3' WHERE (`id_partido` = '19');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '6', `equipo_visitante_goles` = '19', `id_equipo_ganador` = '21', `id_equipo_perdedor` = '15' WHERE (`id_partido` = '20');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '17', `equipo_visitante_goles` = '13', `id_equipo_ganador` = '27', `id_equipo_perdedor` = '33' WHERE (`id_partido` = '21');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '5', `equipo_visitante_goles` = '9', `id_equipo_ganador` = '21', `id_equipo_perdedor` = '3' WHERE (`id_partido` = '22');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '15', `equipo_visitante_goles` = '10', `id_equipo_ganador` = '9', `id_equipo_perdedor` = '27' WHERE (`id_partido` = '23');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '15', `equipo_visitante_goles` = '20', `id_equipo_ganador` = '15', `id_equipo_perdedor` = '33' WHERE (`id_partido` = '24');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '25', `equipo_visitante_goles` = '18', `id_equipo_ganador` = '15', `id_equipo_perdedor` = '9' WHERE (`id_partido` = '25');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '13', `equipo_visitante_goles` = '16', `id_equipo_ganador` = '33', `id_equipo_perdedor` = '3' WHERE (`id_partido` = '26');
UPDATE `torneodeportivovictoriarodriguez`.`partido_f` SET `equipo_local_goles` = '11', `equipo_visitante_goles` = '10', `id_equipo_ganador` = '27', `id_equipo_perdedor` = '21' WHERE (`id_partido` = '27');



#############################################################
################# FIN - INSERCION DE DATOS  #################
#############################################################
