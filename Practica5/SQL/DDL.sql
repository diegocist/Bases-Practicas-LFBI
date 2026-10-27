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
 
 -- CURP NOT NULL y con el formato estandar
 ALTER TABLE Empleado ALTER COLUMN CURP 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d1 
 CHECK(CURP ~ '^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9][0-9]$');
  	
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


CREATE TABLE Sucursal(
	idSucursal SERIAL4,
	Telefono VARCHAR(10),
	Nombre VARCHAR(50),
	Colonia VARCHAR(50),
	Estado VARCHAR(50),
	Calle VARCHAR(50),
	NumExterior INT,
	NumInterior INT
);


--Restricciones Sucursal
--Dominio

-- idSucursal NOT NULL y valor mayor a 0
ALTER TABLE Sucursal ALTER COLUMN idSucursal
SET NOT NULL;
ALTER TABLE Sucursal ADD CONSTRAINT Sucursal_d1
CHECK(idSucursal > 0);
 
-- Telefono NOT NULL y compuesto por 10 digitos
ALTER TABLE Sucursal ALTER COLUMN Telefono
SET NOT NULL;
ALTER TABLE Sucursal ADD CONSTRAINT Sucursal_d2
CHECK(Telefono ~ '^[0-9]{10}$');
 
-- Nombre NOT NULL (hasta 50 caracteres)
ALTER TABLE Sucursal ALTER COLUMN Nombre
SET NOT NULL;
 
-- Colonia NOT NULL (hasta 50 caracteres)
ALTER TABLE Sucursal ALTER COLUMN Colonia
SET NOT NULL;
 
-- Estado NOT NULL (hasta 50 caracteres)
ALTER TABLE Sucursal ALTER COLUMN Estado
SET NOT NULL;
 
-- Calle NOT NULL (hasta 50 caracteres)
ALTER TABLE Sucursal ALTER COLUMN Calle
SET NOT NULL;
 
-- NumExterior NOT NULL y con valor mayor a 0
ALTER TABLE Sucursal ALTER COLUMN NumExterior
SET NOT NULL;
ALTER TABLE Sucursal ADD CONSTRAINT Sucursal_d3
CHECK(NumExterior > 0);
 
-- NumInterior acepta NULL; cuando no es NULL debe de ser mayor a 0
ALTER TABLE Sucursal ADD CONSTRAINT Sucursal_d4
CHECK(NumInterior > 0);
 
--Entidad
-- idSucursal como llave primaria
ALTER TABLE Sucursal ADD CONSTRAINT Sucursal_pkey
PRIMARY KEY (idSucursal);


CREATE TABLE Premio(
	idPremio SERIAL4,
	Nombre VARCHAR(100),
	CategoriaEdad VARCHAR(50),
	ValorAproximado DECIMAL(10,2),
	CostoPuntos INT
);
 
--Restricciones Premio
--Dominio
 
-- idPremio NOT NULL y con valor mayor a 0
ALTER TABLE Premio ALTER COLUMN idPremio
SET NOT NULL;
ALTER TABLE Premio ADD CONSTRAINT Premio_d1
CHECK(idPremio > 0);
 
-- Nombre NOT NULL (hasta 100 caracteres)
ALTER TABLE Premio ALTER COLUMN Nombre
SET NOT NULL;
 
-- CategoriaEdad NOT NULL y con un valor predefinido
ALTER TABLE Premio ALTER COLUMN CategoriaEdad
SET NOT NULL;
ALTER TABLE Premio ADD CONSTRAINT Premio_d2
CHECK(CategoriaEdad IN ('Infantil', 'Juvenil', 'Adulto', 'Todas'));
 
-- ValorAproximado NOT NULL y decimal mayor a 0
ALTER TABLE Premio ALTER COLUMN ValorAproximado
SET NOT NULL;
ALTER TABLE Premio ADD CONSTRAINT Premio_d3
CHECK(ValorAproximado > 0);
 
-- CostoPuntos NOT NULL y con valor mayor a 0
ALTER TABLE Premio ALTER COLUMN CostoPuntos
SET NOT NULL;
ALTER TABLE Premio ADD CONSTRAINT Premio_d4
CHECK(CostoPuntos > 0);
 
--Entidad
-- idPremio como llave primaria
ALTER TABLE Premio ADD CONSTRAINT Premio_pkey
PRIMARY KEY (idPremio);


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


CREATE TABLE Gerente(
	CURP VARCHAR(18),
	Cedula VARCHAR(20)
);
 
--Restricciones Gerente
--Dominio
 
-- CURP NOT NULL y con el formato estandar
ALTER TABLE Gerente ALTER COLUMN CURP
SET NOT NULL;
ALTER TABLE Gerente ADD CONSTRAINT Gerente_d1
CHECK(CURP ~ '^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9][0-9]$');
 
-- Cedula NOT NULL y compuesta por 7 u 8 numeros
ALTER TABLE Gerente ALTER COLUMN Cedula
SET NOT NULL;
ALTER TABLE Gerente ADD CONSTRAINT Gerente_d2
CHECK(Cedula ~ '^[0-9]{7,8}$');
 
--Entidad
-- CURP como llave primaria
ALTER TABLE Gerente ADD CONSTRAINT Gerente_pkey
PRIMARY KEY (CURP);
 
--Referencial
-- CURP hace referencia a Empleado(CURP)
ALTER TABLE Gerente ADD CONSTRAINT Gerente_fkey
FOREIGN KEY (CURP) REFERENCES Empleado(CURP);


CREATE TABLE Tecnico(
	CURP VARCHAR(18),
	Especialidad VARCHAR(100)
);
 
--Restricciones Tecnico
--Dominio
 
-- CURP NOT NULL y con el formato estandar
ALTER TABLE Tecnico ALTER COLUMN CURP
SET NOT NULL;
ALTER TABLE Tecnico ADD CONSTRAINT Tecnico_d1
CHECK(CURP ~ '^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9][0-9]$');
 
-- Especialidad NOT NULL (hasta 100 caracteres)
ALTER TABLE Tecnico ALTER COLUMN Especialidad
SET NOT NULL;
 
--Entidad
-- CURP como llave primaria
ALTER TABLE Tecnico ADD CONSTRAINT Tecnico_pkey
PRIMARY KEY (CURP);
 
--Referencial
-- CURP hace referencia a Empleado(CURP)
ALTER TABLE Tecnico ADD CONSTRAINT Tecnico_fkey
FOREIGN KEY (CURP) REFERENCES Empleado(CURP);
 

CREATE TABLE Cajero(
	CURP VARCHAR(18)
);
 
--Restricciones Cajero
--Dominio
 
-- CURP NOT NULL y con el formato estandar
ALTER TABLE Cajero ALTER COLUMN CURP
SET NOT NULL;
ALTER TABLE Cajero ADD CONSTRAINT Cajero_d1
CHECK(CURP ~ '^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9][0-9]$');
 
--Entidad
-- CURP como llave primaria
ALTER TABLE Cajero ADD CONSTRAINT Cajero_pkey
PRIMARY KEY (CURP);
 
--Referencial
-- CURP hace referencia a Empleado(CURP)
ALTER TABLE Cajero ADD CONSTRAINT Cajero_fkey
FOREIGN KEY (CURP) REFERENCES Empleado(CURP);


CREATE TABLE EncargadoPremios(
	CURP VARCHAR(18)
);
 
--Restricciones EncargadoPremios
--Dominio
 
-- CURP NOT NULL y con el formato estandar
ALTER TABLE EncargadoPremios ALTER COLUMN CURP
SET NOT NULL;
ALTER TABLE EncargadoPremios ADD CONSTRAINT EncargadoPremios_d1
CHECK(CURP ~ '^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9][0-9]$');
 
--Entidad
-- CURP como llave primaria
ALTER TABLE EncargadoPremios ADD CONSTRAINT EncargadoPremios_pkey
PRIMARY KEY (CURP);
 
--Referencial
-- CURP hace referencia a Empleado(CURP)
ALTER TABLE EncargadoPremios ADD CONSTRAINT EncargadoPremios_fkey
FOREIGN KEY (CURP) REFERENCES Empleado(CURP);

CREATE TABLE Almacenamiento(
    idSucursal INT,
    idPremio INT,
    FechaRotacion DATE,
    CantidadRecibida INT
);

-- Restricciones Almacenamiento
-- Dominio

-- idSucursal NOT NULL
ALTER TABLE Almacenamiento ALTER COLUMN idSucursal
SET NOT NULL;

-- idPremio NOT NULL
ALTER TABLE Almacenamiento ALTER COLUMN idPremio
SET NOT NULL;

-- FechaRotacion NOT NULL
ALTER TABLE Almacenamiento ALTER COLUMN FechaRotacion
SET NOT NULL;

-- CantidadRecibida NOT NULL y mayor o igual a 0
ALTER TABLE Almacenamiento ALTER COLUMN CantidadRecibida
SET NOT NULL;
ALTER TABLE Almacenamiento ADD CONSTRAINT Almacenamiento_d1
CHECK(CantidadRecibida >= 0);

-- Referencial
-- idSucursal hace referencia a Sucursal(idSucursal)
ALTER TABLE Almacenamiento ADD CONSTRAINT Almacenamiento_fkey1
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal);

-- idPremio hace referencia a Premio(idPremio)
ALTER TABLE Almacenamiento ADD CONSTRAINT Almacenamiento_fkey2
FOREIGN KEY (idPremio) REFERENCES Premio(idPremio);


CREATE TABLE Maquina(
    idMaquina INT,
    idSucursal INT,
    idJuego INT,
    EstadoMaquina VARCHAR(20)
);

-- Restricciones Maquina
-- Dominio

-- idMaquina NOT NULL y mayor a 0
ALTER TABLE Maquina ALTER COLUMN idMaquina
SET NOT NULL;
ALTER TABLE Maquina ADD CONSTRAINT Maquina_d1
CHECK(idMaquina > 0);

-- idSucursal NOT NULL
ALTER TABLE Maquina ALTER COLUMN idSucursal
SET NOT NULL;

-- idJuego NOT NULL
ALTER TABLE Maquina ALTER COLUMN idJuego
SET NOT NULL;

-- EstadoMaquina NOT NULL, no vacío y dentro de los valores permitidos
ALTER TABLE Maquina ALTER COLUMN EstadoMaquina
SET NOT NULL;
ALTER TABLE Maquina ADD CONSTRAINT Maquina_d2
CHECK(EstadoMaquina IN ('activo', 'fuera de servicio', 'mantenimiento'));

-- Entidad
-- idMaquina como llave primaria
ALTER TABLE Maquina ADD CONSTRAINT Maquina_pkey
PRIMARY KEY (idMaquina);

-- Referencial
-- idSucursal hace referencia a Sucursal(idSucursal)
ALTER TABLE Maquina ADD CONSTRAINT Maquina_fkey1
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal);

-- idJuego hace referencia a Juego(idJuego)
ALTER TABLE Maquina ADD CONSTRAINT Maquina_fkey2
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego);


CREATE TABLE Administrar(
    idSucursal INT,
    CURP VARCHAR(18)
);

-- Restricciones Administrar
-- Dominio

-- idSucursal NOT NULL
ALTER TABLE Administrar ALTER COLUMN idSucursal
SET NOT NULL;

-- CURP NOT NULL
ALTER TABLE Administrar ALTER COLUMN CURP
SET NOT NULL;

-- Referencial
-- idSucursal hace referencia a Sucursal(idSucursal)
ALTER TABLE Administrar ADD CONSTRAINT Administrar_fkey1
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal);

-- CURP hace referencia a Gerente(CURP)
ALTER TABLE Administrar ADD CONSTRAINT Administrar_fkey2
FOREIGN KEY (CURP) REFERENCES Gerente(CURP);


CREATE TABLE Reparar(
    idMaquina INT,
    CURP VARCHAR(18),
    Tipo VARCHAR(50),
    Problema VARCHAR(1000),
    Fecha DATE
);

-- Restricciones Reparar
-- Dominio

-- idMaquina NOT NULL
ALTER TABLE Reparar ALTER COLUMN idMaquina
SET NOT NULL;

-- CURP NOT NULL
ALTER TABLE Reparar ALTER COLUMN CURP
SET NOT NULL;

-- Tipo NOT NULL y no vacío
ALTER TABLE Reparar ALTER COLUMN Tipo
SET NOT NULL;
ALTER TABLE Reparar ADD CONSTRAINT Reparar_d1
CHECK(Tipo <> '');

-- Problema NOT NULL y no vacío
ALTER TABLE Reparar ALTER COLUMN Problema
SET NOT NULL;
ALTER TABLE Reparar ADD CONSTRAINT Reparar_d2
CHECK(Problema <> '');

-- Fecha NOT NULL
ALTER TABLE Reparar ALTER COLUMN Fecha
SET NOT NULL;

-- Referencial
-- idMaquina hace referencia a Maquina(idMaquina)
ALTER TABLE Reparar ADD CONSTRAINT Reparar_fkey1
FOREIGN KEY (idMaquina) REFERENCES Maquina(idMaquina);

-- CURP hace referencia a Tecnico(CURP)
ALTER TABLE Reparar ADD CONSTRAINT Reparar_fkey2
FOREIGN KEY (CURP) REFERENCES Tecnico(CURP);


CREATE TABLE Certificacion(
    CURP VARCHAR(18),
    TituloCertificacion VARCHAR(100)
);

-- Restricciones Certificacion
-- Dominio

-- CURP NOT NULL y con formato estándar
ALTER TABLE Certificacion ALTER COLUMN CURP
SET NOT NULL;
ALTER TABLE Certificacion ADD CONSTRAINT Certificacion_d1
CHECK(CURP ~ '^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9][0-9]$');

-- TituloCertificacion NOT NULL y no vacío
ALTER TABLE Certificacion ALTER COLUMN TituloCertificacion
SET NOT NULL;
ALTER TABLE Certificacion ADD CONSTRAINT Certificacion_d2
CHECK(TituloCertificacion <> '');

-- Entidad
-- CURP y TituloCertificacion como llave primaria compuesta
ALTER TABLE Certificacion ADD CONSTRAINT Certificacion_pkey
PRIMARY KEY (CURP, TituloCertificacion);

-- Referencial
-- CURP hace referencia a Tecnico(CURP)
ALTER TABLE Certificacion ADD CONSTRAINT Certificacion_fkey1
FOREIGN KEY (CURP) REFERENCES Tecnico(CURP);