DROP SCHEMA IF EXISTS  public CASCADE;
CREATE SCHEMA public;

-------------TABLAS CON LLAVES PRIMARIAS-----------------

CREATE TABLE Empleado(
	CURP VARCHAR(18),
	FechaNacimiento DATE,
	Nombre VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	RFC VARCHAR(13),
	tipoEmpleado INT
);

 --Restricciones Empleado
 
--Dominio
 
 -- CURP: NOT NULL Y con longitud igual a 18
 ALTER TABLE Empleado ALTER COLUMN CURP 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d1 
 CHECK(CHAR_LENGTH(curp)=18);
 
 -- FechaNacimiento: NOT NULL y al menos 18 años menor a la fecha actual
 ALTER TABLE Empleado ALTER COLUMN FechaNacimiento 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d2 
 CHECK(FechaNacimiento <= CURRENT_DATE - INTERVAL '18 years');
 
 -- Nombre: NOT NULL y con al menos un elemento
 ALTER TABLE Empleado ALTER COLUMN Nombre 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d3
 CHECK(nombre <> '');
 
 -- ApellidoPaterno: NOT NULL y con al menos un elemento
 ALTER TABLE Empleado ALTER COLUMN ApellidoPaterno 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d4
 CHECK(ApellidoPaterno <> '');
 
 -- ApellidoMaterno: NOT NULL y con al menos un elemento
 ALTER TABLE Empleado ALTER COLUMN ApellidoMaterno 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d5 
 CHECK(ApellidoMaterno <> '');
 
 -- RFC: NOT NULL, con longitud 13 y al menos un elemento.
 ALTER TABLE Empleado ALTER COLUMN RFC 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d6 
 CHECK(RFC <> '');
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d7 
 CHECK(CHAR_LENGTH(RFC)=13);
 
 -- tipoEmpleado: NOT NULL y dentro del intervalo [0, 3]
 ALTER TABLE Empleado ALTER COLUMN tipoEmpleado 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d8 
 CHECK(tipoEmpleado >= 0 AND tipoEmpleado <= 3);

--Entidad
-- CURP como llave primaria
ALTER TABLE Empleado ADD CONSTRAINT Empleado_pkey
PRIMARY KEY (CURP);


CREATE TABLE Juego(
	idJuego SERIAL4,
	Nombre VARCHAR(50),
	Costo INT,
	Categoria INT
);

--Restricciones Juego
--Dominio

-- idJuego NOT NULL y con valor mayor a 0
ALTER TABLE Juego ALTER COLUMN idJuego 
SET NOT NULL;
ALTER TABLE Juego ADD CONSTRAINT Juego_d1 
CHECK(idJuego > 0);

-- Nombre NOT NULL y con al menos un elemento
ALTER TABLE Juego ALTER COLUMN Nombre 
SET NOT NULL;
ALTER TABLE Juego ADD CONSTRAINT Juego_d2 
 CHECK(Nombre <> '');

-- Costo NOT NULL, mayor a cero y multiplo de 10
ALTER TABLE Juego ALTER COLUMN Costo 
SET NOT NULL;
ALTER TABLE Juego ADD CONSTRAINT Juego_d3 
CHECK(Costo > 0 AND Costo % 10 = 0);

-- Categoria NOT NULL y en el intervalo de 0 y 3
ALTER TABLE Juego ALTER COLUMN Categoria 
SET NOT NULL;
ALTER TABLE Juego ADD CONSTRAINT Juego_d4
CHECK(Categoria >= 0 AND Categoria <= 3);

--Entidad
ALTER TABLE Juego ADD CONSTRAINT Juego_pkey
PRIMARY KEY (idJuego);


---------------TABLAS CON LLAVES COMPUESTAS, FORÁNEAS Y HERENCIAS)----------
CREATE TABLE CorreoEmpleado(
	CURP VARCHAR(18),
	Correo VARCHAR(100)
);

-- Restricciones CorreoEmpleado
-- Entidad
ALTER TABLE CorreoEmpleado ADD CONSTRAINT CorreoEmpleado_pkey
PRIMARY KEY(CURP, Correo);

--Referencial
ALTER TABLE CorreoEmpleado ADD CONSTRAINT CorreoEmpleado_fkey
FOREIGN KEY(CURP) REFERENCES Empleado(curp);


CREATE TABLE TelefonoEmpleado(
	CURP VARCHAR(18),
	Telefono VARCHAR(10)
);

--Restricciones TelefonoEmpleado
--Entidad
ALTER TABLE TelefonoEmpleado ADD CONSTRAINT TelefonoEmpleado_pkey
PRIMARY KEY(CURP, Telefono);

--Referencial
ALTER TABLE TelefonoEmpleado ADD CONSTRAINT TelefonoEmpleado_fkey
FOREIGN KEY(CURP) REFERENCES Empleado(curp);


CREATE TABLE Disparos(
	idJuego INT,
	PuntosPorAcierto INT
);

--Restricciones Disparos
--Dominio
-- idJuego NOT NULL y mayor a 0
ALTER TABLE Disparos ALTER COLUMN idJuego 
SET NOT NULL;
ALTER TABLE Disparos ADD CONSTRAINT Disparos_d1 
CHECK(idJuego > 0);

-- PuntosPorAcierto NOT NULL y igual a 1
ALTER TABLE Disparos ALTER COLUMN PuntosPorAcierto 
SET NOT NULL;
ALTER TABLE Disparos ADD CONSTRAINT Disparos_d2 
CHECK(PuntosPorAcierto = 1);

--Entidad
ALTER TABLE Disparos ADD CONSTRAINT Disparos_pkey
PRIMARY KEY (idJuego);

--Referencial
ALTER TABLE Disparos ADD CONSTRAINT Disparos_fkey
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego);


CREATE TABLE Destreza(
	idJuego INT,
	PuntosPorAcierto INT
);

--Restricciones Destreza
--Dominio
--idJuego NOT NULL y mayor a 0
ALTER TABLE Destreza ALTER COLUMN idJuego 
SET NOT NULL;
ALTER TABLE Destreza ADD CONSTRAINT Destreza_d1 
CHECK(idJuego > 0);

--PuntosPorAcierto NOT NULL y igual a 1
ALTER TABLE Destreza ALTER COLUMN PuntosPorAcierto 
SET NOT NULL;
ALTER TABLE Destreza ADD CONSTRAINT Destreza_d2 
CHECK(PuntosPorAcierto = 1);

--Entidad
ALTER TABLE Destreza ADD CONSTRAINT Destreza_pkey
PRIMARY KEY (idJuego);

--Referencial
ALTER TABLE Destreza ADD CONSTRAINT Destreza_fkey
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego);


CREATE TABLE Ritmo(
	idJuego INT,
	PuntosTop5 INT
);

--Restricciones Ritmo
--Dominio
--idJuego NOT NULL y mayor a 0
ALTER TABLE Ritmo ALTER COLUMN idJuego 
SET NOT NULL;
ALTER TABLE Ritmo ADD CONSTRAINT Ritmo_d1 
CHECK(idJuego > 0);

--PuntosTop5 NOT NULL y igual a 20
ALTER TABLE Ritmo ALTER COLUMN PuntosTop5 
SET NOT NULL;
ALTER TABLE Ritmo ADD CONSTRAINT Ritmo_d2 
CHECK(PuntosTop5 = 20);

--Entidad
ALTER TABLE Ritmo ADD CONSTRAINT Ritmo_pkey
PRIMARY KEY (idJuego);

--Referencial
ALTER TABLE Ritmo ADD CONSTRAINT Ritmo_fkey
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego);


CREATE TABLE Velocidad(
	idJuego INT,
	PuntosTop5 INT
);

--Restricciones Velocidad
--Dominio
--idJuego NOT NULL y mayor a 0
ALTER TABLE Velocidad ALTER COLUMN idJuego 
SET NOT NULL;
ALTER TABLE Velocidad ADD CONSTRAINT Velocidad_d1 
CHECK(idJuego > 0);

--PuntosTop5 NOT NULL y igual a 20
ALTER TABLE Velocidad ALTER COLUMN PuntosTop5 
SET NOT NULL;
ALTER TABLE Velocidad ADD CONSTRAINT Velocidad_d2 
CHECK(PuntosTop5 = 20);

--Entidad
ALTER TABLE Velocidad ADD CONSTRAINT Velocidad_pkey
PRIMARY KEY (idJuego);

--Referencial
ALTER TABLE Velocidad ADD CONSTRAINT Velocidad_fkey
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego);

