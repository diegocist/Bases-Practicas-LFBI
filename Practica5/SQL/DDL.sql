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
 CHECK(RFC ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
 
 -- tipoEmpleado: NOT NULL y dentro del intervalo [0, 3]
 ALTER TABLE Empleado ALTER COLUMN tipoEmpleado 
 SET NOT NULL;
 ALTER TABLE Empleado ADD CONSTRAINT Empleado_d7 
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

CREATE TABLE Cliente(
    idCliente SERIAL4,
    Nombre VARCHAR(50),
    ApellidoPaterno VARCHAR(50),
    ApellidoMaterno VARCHAR(50),
    FechaNacimiento DATE,
    Sexo VARCHAR(10)
);

--Restricciones Cliente
--Dominio

-- idCliente NOT NULL y con valor mayor a 0
ALTER TABLE Cliente ALTER COLUMN idCliente
SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT Cliente_d1
CHECK(idCliente > 0);

-- Nombre NOT NULL y con al menos un elemento
ALTER TABLE Cliente ALTER COLUMN Nombre
SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT Cliente_d2
CHECK(Nombre <> '');

-- ApellidoPaterno NOT NULL y con al menos un elemento
ALTER TABLE Cliente ALTER COLUMN ApellidoPaterno
SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT Cliente_d3
CHECK(ApellidoPaterno <> '');

-- ApellidoMaterno acepta NULL; cuando no es NULL debe tener al menos un elemento
ALTER TABLE Cliente ADD CONSTRAINT Cliente_d4
CHECK(ApellidoMaterno <> '');

-- FechaNacimiento NOT NULL y menor o igual a la fecha actual
ALTER TABLE Cliente ALTER COLUMN FechaNacimiento
SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT Cliente_d5
CHECK(FechaNacimiento <= CURRENT_DATE);

-- Sexo NOT NULL y con un valor predefinido
ALTER TABLE Cliente ALTER COLUMN Sexo
SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT Cliente_d6
CHECK(Sexo IN ('Masculino', 'Femenino', 'No binario'));

--Entidad
-- idCliente como llave primaria
ALTER TABLE Cliente ADD CONSTRAINT Cliente_pkey
PRIMARY KEY (idCliente);


CREATE TABLE Tarjeta(
    idTarjeta SERIAL4,
    Estado VARCHAR(30),
    Saldo FLOAT,
    Puntos INT
);

--Restricciones Tarjeta
--Dominio

-- idTarjeta NOT NULL y con valor mayor a 0
ALTER TABLE Tarjeta ALTER COLUMN idTarjeta
SET NOT NULL;
ALTER TABLE Tarjeta ADD CONSTRAINT Tarjeta_d1
CHECK(idTarjeta > 0);

-- Estado NOT NULL y con un valor predefinido
ALTER TABLE Tarjeta ALTER COLUMN Estado
SET NOT NULL;
ALTER TABLE Tarjeta ADD CONSTRAINT Tarjeta_d2
CHECK(Estado IN ('Activa', 'Bloqueada', 'Cancelada'));

-- Saldo NOT NULL y mayor o igual a 0
ALTER TABLE Tarjeta ALTER COLUMN Saldo
SET NOT NULL;
ALTER TABLE Tarjeta ADD CONSTRAINT Tarjeta_d3
CHECK(Saldo >= 0);

-- Puntos NOT NULL y mayor o igual a 0
ALTER TABLE Tarjeta ALTER COLUMN Puntos
SET NOT NULL;
ALTER TABLE Tarjeta ADD CONSTRAINT Tarjeta_d4
CHECK(Puntos >= 0);

--Entidad
-- idTarjeta como llave primaria
ALTER TABLE Tarjeta ADD CONSTRAINT Tarjeta_pkey
PRIMARY KEY (idTarjeta);


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
    idMaquina SERIAL4,
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

CREATE TABLE Registrar(
    idCliente INT,
    idTarjeta INT
);

--Restricciones Registrar
--Dominio

-- idCliente NOT NULL y con valor mayor a 0
ALTER TABLE Registrar ALTER COLUMN idCliente
SET NOT NULL;
ALTER TABLE Registrar ADD CONSTRAINT Registrar_d1
CHECK(idCliente > 0);

-- idTarjeta NOT NULL y con valor mayor a 0
ALTER TABLE Registrar ALTER COLUMN idTarjeta
SET NOT NULL;
ALTER TABLE Registrar ADD CONSTRAINT Registrar_d2
CHECK(idTarjeta > 0);

-- Entidad
ALTER TABLE Registrar ADD CONSTRAINT Registrar_pkey
PRIMARY KEY (idCliente, idTarjeta);

-- Referencial
-- idCliente
ALTER TABLE Registrar ADD CONSTRAINT Registrar_fkey1
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente);

-- idTarjeta
ALTER TABLE Registrar ADD CONSTRAINT Registrar_fkey2
FOREIGN KEY (idTarjeta) REFERENCES Tarjeta(idTarjeta);

CREATE TABLE CorreoCliente(
    idCliente INT,
    Correo VARCHAR(100)
);

--Restricciones CorreoCliente
--Dominio

--Entidad
ALTER TABLE CorreoCliente ADD CONSTRAINT CorreoCliente_pkey
PRIMARY KEY (idCliente, Correo);

--Referencial
ALTER TABLE CorreoCliente ADD CONSTRAINT CorreoCliente_fkey
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente);

CREATE TABLE TelefonoCliente(
    idCliente INT,
    Telefono VARCHAR(10)
);

--Restricciones TelefonoCliente
--Dominio

-- Telefono de 10 digitos
ALTER TABLE TelefonoCliente ADD CONSTRAINT TelefonoCliente_d1
CHECK(Telefono ~ '^[0-9]{10}$');		

--Entidad
ALTER TABLE TelefonoCliente ADD CONSTRAINT TelefonoCliente_pkey
PRIMARY KEY (idCliente, Telefono);

--Referencial
ALTER TABLE TelefonoCliente ADD CONSTRAINT TelefonoCliente_fkey
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente);

CREATE TABLE Recarga(
    idTarjeta INT,
    numRecarga INT,
    idSucursal INT,
    CURP VARCHAR(18),
    Monto DECIMAL(10,2),
    MetodoPago VARCHAR(30),
    Hora TIME,
    Fecha DATE
);

--Restricciones Recarga
--Dominio

-- idTarjeta NOT NULL y con valor mayor a 0
ALTER TABLE Recarga ALTER COLUMN idTarjeta
SET NOT NULL;
ALTER TABLE Recarga ADD CONSTRAINT Recarga_d1
CHECK(idTarjeta > 0);

-- numRecarga NOT NULL y con valor mayor a 0
ALTER TABLE Recarga ALTER COLUMN numRecarga
SET NOT NULL;
ALTER TABLE Recarga ADD CONSTRAINT Recarga_d2
CHECK(numRecarga > 0);

-- idSucursal NOT NULL y con valor mayor a 0
ALTER TABLE Recarga ALTER COLUMN idSucursal
SET NOT NULL;
ALTER TABLE Recarga ADD CONSTRAINT Recarga_d3
CHECK(idSucursal > 0);

-- CURP NOT NULL y con el formato estandar
ALTER TABLE Recarga ALTER COLUMN CURP
SET NOT NULL;
ALTER TABLE Recarga ADD CONSTRAINT Recarga_d4
CHECK(CURP ~ '^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9][0-9]$');

-- Monto NOT NULL y decimal mayor a 0
ALTER TABLE Recarga ALTER COLUMN Monto
SET NOT NULL;
ALTER TABLE Recarga ADD CONSTRAINT Recarga_d5
CHECK(Monto > 0);

-- MetodoPago NOT NULL y con un valor predefinido
ALTER TABLE Recarga ALTER COLUMN MetodoPago
SET NOT NULL;
ALTER TABLE Recarga ADD CONSTRAINT Recarga_d6
CHECK(MetodoPago IN ('Efectivo', 'Crédito', 'Débito', 'Paypal'));

-- Hora NOT NULL
ALTER TABLE Recarga ALTER COLUMN Hora
SET NOT NULL;

-- Fecha NOT NULL y menor o igual a la fecha actual
ALTER TABLE Recarga ALTER COLUMN Fecha
SET NOT NULL;
ALTER TABLE Recarga ADD CONSTRAINT Recarga_d7
CHECK(Fecha <= CURRENT_DATE);

--Entidad
-- (idTarjeta, numRecarga) como llave primaria
ALTER TABLE Recarga ADD CONSTRAINT Recarga_pkey
PRIMARY KEY (idTarjeta, numRecarga);

--Referencial
-- idTarjeta
ALTER TABLE Recarga ADD CONSTRAINT Recarga_fkey1
FOREIGN KEY (idTarjeta) REFERENCES Tarjeta(idTarjeta);

-- idSucursal 
ALTER TABLE Recarga ADD CONSTRAINT Recarga_fkey2
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal);

-- CURP 
ALTER TABLE Recarga ADD CONSTRAINT Recarga_fkey3
FOREIGN KEY (CURP) REFERENCES Cajero(CURP);


CREATE TABLE Canje(
    idCanje SERIAL4,
    idSucursal INT,
    idTarjeta INT,
    CURP VARCHAR(18),
    Hora TIME,
    Fecha DATE
);

--Restricciones Canje
--Dominio

-- idCanje NOT NULL y con valor mayor a 0
ALTER TABLE Canje ALTER COLUMN idCanje
SET NOT NULL;
ALTER TABLE Canje ADD CONSTRAINT Canje_d1
CHECK(idCanje > 0);

-- idSucursal NOT NULL y con valor mayor a 0
ALTER TABLE Canje ALTER COLUMN idSucursal
SET NOT NULL;
ALTER TABLE Canje ADD CONSTRAINT Canje_d2
CHECK(idSucursal > 0);

-- idTarjeta NOT NULL y con valor mayor a 0
ALTER TABLE Canje ALTER COLUMN idTarjeta
SET NOT NULL;
ALTER TABLE Canje ADD CONSTRAINT Canje_d3
CHECK(idTarjeta > 0);

-- CURP NOT NULL y con el formato estandar
ALTER TABLE Canje ALTER COLUMN CURP
SET NOT NULL;
ALTER TABLE Canje ADD CONSTRAINT Canje_d4
CHECK(CURP ~ '^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9][0-9]$');

-- Hora NOT NULL
ALTER TABLE Canje ALTER COLUMN Hora
SET NOT NULL;

-- Fecha NOT NULL y menor o igual a la fecha actual
ALTER TABLE Canje ALTER COLUMN Fecha
SET NOT NULL;
ALTER TABLE Canje ADD CONSTRAINT Canje_d5
CHECK(Fecha <= CURRENT_DATE);

--Entidad
-- idCanje como llave primaria
ALTER TABLE Canje ADD CONSTRAINT Canje_pkey
PRIMARY KEY (idCanje);

--Referencial

-- idSucursal 
ALTER TABLE Canje ADD CONSTRAINT Canje_fkey1
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal);

-- idTarjeta 
ALTER TABLE Canje ADD CONSTRAINT Canje_fkey2
FOREIGN KEY (idTarjeta) REFERENCES Tarjeta(idTarjeta);

-- CURP 
ALTER TABLE Canje ADD CONSTRAINT Canje_fkey3
FOREIGN KEY (CURP) REFERENCES EncargadoPremios(CURP);


CREATE TABLE Incluir(
    idCanje INT,
    idPremio INT,
    Cantidad INT
);

--Restricciones Incluir
--Dominio

-- idCanje NOT NULL y con valor mayor a 0
ALTER TABLE Incluir ALTER COLUMN idCanje
SET NOT NULL;
ALTER TABLE Incluir ADD CONSTRAINT Incluir_d1
CHECK(idCanje > 0);

-- idPremio NOT NULL y con valor mayor a 0
ALTER TABLE Incluir ALTER COLUMN idPremio
SET NOT NULL;
ALTER TABLE Incluir ADD CONSTRAINT Incluir_d2
CHECK(idPremio > 0);

-- Cantidad NOT NULL y con valor mayor a 0
ALTER TABLE Incluir ALTER COLUMN Cantidad
SET NOT NULL;
ALTER TABLE Incluir ADD CONSTRAINT Incluir_d3
CHECK(Cantidad > 0);

--Entidad
ALTER TABLE Incluir ADD CONSTRAINT Incluir_pkey
PRIMARY KEY (idCanje, idPremio);

--Referencial
-- idPremio 
ALTER TABLE Incluir ADD CONSTRAINT Incluir_fkey2
FOREIGN KEY (idPremio) REFERENCES Premio(idPremio);

-- idCanje 
ALTER TABLE Incluir ADD CONSTRAINT Incluir_fkey1
FOREIGN KEY (idCanje) REFERENCES Canje(idCanje);


CREATE TABLE Partida(
    numPartida SERIAL4,
    idMaquina INT,
    idTarjeta INT,
    FechaPartida DATE,
    HoraFin TIME,
    PuntosObtenidos FLOAT,
    Puntaje FLOAT
);

-- Restricciones Partida
-- Dominio

-- numPartida NOT NULL y mayor a 0
ALTER TABLE Partida ALTER COLUMN numPartida
SET NOT NULL;
ALTER TABLE Partida ADD CONSTRAINT Partida_d1 
CHECK(numPartida > 0);

-- idMaquina NOT NULL y mayor a 0
ALTER TABLE Partida ALTER COLUMN idMaquina
SET NOT NULL;
ALTER TABLE Partida ADD CONSTRAINT Partida_d2 
CHECK(idMaquina > 0);

-- idTarjeta NOT NULL y mayor a 0
ALTER TABLE Partida ALTER COLUMN idTarjeta
SET NOT NULL;
ALTER TABLE Partida ADD CONSTRAINT Partida_d3 
CHECK(idTarjeta > 0);

-- FechaPartida NOT NULL y menor o igual a la fecha actual
ALTER TABLE Partida ALTER COLUMN FechaPartida
SET NOT NULL;
ALTER TABLE Partida ADD CONSTRAINT Partida_d4 
CHECK(FechaPartida <= CURRENT_DATE);

-- HoraFin NOT NULL
ALTER TABLE Partida ALTER COLUMN HoraFin 
SET NOT NULL;

-- PuntosObtenidos NOT NULL y mayor o igual a 0
ALTER TABLE Partida ALTER COLUMN PuntosObtenidos
SET NOT NULL;
ALTER TABLE Partida ADD CONSTRAINT Partida_d5
CHECK(PuntosObtenidos >= 0);

-- Puntaje NOT NULL y mayor o igual a 0
ALTER TABLE Partida ALTER COLUMN Puntaje SET NOT NULL;
ALTER TABLE Partida ADD CONSTRAINT Partida_d6
CHECK(Puntaje >= 0);

-- Entidad
-- Llave primaria compuesta (numPartida, idMaquina)
ALTER TABLE Partida ADD CONSTRAINT Partida_pkey 
PRIMARY KEY (numPartida, idMaquina);

-- Referencial
-- idMaquina hace referencia a Maquina(idMaquina)
ALTER TABLE Partida ADD CONSTRAINT Partida_fkey1 
FOREIGN KEY (idMaquina) REFERENCES Maquina(idMaquina);

-- idTarjeta hace referencia a Tarjeta(idTarjeta)
ALTER TABLE Partida ADD CONSTRAINT Partida_fkey2 
FOREIGN KEY (idTarjeta) REFERENCES Tarjeta(idTarjeta);


CREATE TABLE DiaApertura(
    idSucursal INT,
    Dia VARCHAR(2),
    HoraApertura TIME,
    HoraCierre TIME
);

-- Restricciones DiaApertura
-- Dominio

-- idSucursal NOT NULL
ALTER TABLE DiaApertura ALTER COLUMN idSucursal
SET NOT NULL;

-- Dia NOT NULL
ALTER TABLE DiaApertura ALTER COLUMN Dia
SET NOT NULL;

-- HoraApertura NOT NULL
ALTER TABLE DiaApertura ALTER COLUMN HoraApertura
SET NOT NULL;

-- HoraCierre NOT NULL
ALTER TABLE DiaApertura ALTER COLUMN HoraCierre
SET NOT NULL;

-- Restricción especial de horario
ALTER TABLE DiaApertura ADD CONSTRAINT DiaApertura_d1 
CHECK(HoraCierre > HoraApertura);

-- Entidad
-- Llave primaria compuesta (idSucursal, Dia)
ALTER TABLE DiaApertura ADD CONSTRAINT DiaApertura_pkey 
PRIMARY KEY (idSucursal, Dia);

-- Referencial
-- idSucursal hace referencia a Sucursal(idSucursal)
ALTER TABLE DiaApertura ADD CONSTRAINT DiaApertura_fkey1 
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal);


CREATE TABLE Trabajar(
    idSucursal INT,
    CURP VARCHAR(18),
    FechaContratacion DATE,
    Salario FLOAT,
    HoraInicio TIME,
    HoraFin TIME
);

-- Restricciones Trabajar
-- Dominio
ALTER TABLE Trabajar ALTER COLUMN idSucursal
SET NOT NULL;
ALTER TABLE Trabajar ALTER COLUMN CURP
SET NOT NULL;
ALTER TABLE Trabajar ALTER COLUMN FechaContratacion
SET NOT NULL;

-- Salario NOT NULL y mayor a 0
ALTER TABLE Trabajar ALTER COLUMN Salario
SET NOT NULL;
ALTER TABLE Trabajar ADD CONSTRAINT Trabajar_d1
CHECK(Salario > 0);

ALTER TABLE Trabajar ALTER COLUMN HoraInicio
SET NOT NULL;
ALTER TABLE Trabajar ALTER COLUMN HoraFin
SET NOT NULL;

-- Restricción lógica: La hora de fin debe ser después de la hora de inicio
ALTER TABLE Trabajar ADD CONSTRAINT Trabajar_d2
CHECK(HoraFin > HoraInicio);

-- Entidad
-- Llave primaria compuesta
ALTER TABLE Trabajar ADD CONSTRAINT Trabajar_pkey 
PRIMARY KEY (idSucursal, CURP);

-- Referencial
ALTER TABLE Trabajar ADD CONSTRAINT Trabajar_fkey1 
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal);

ALTER TABLE Trabajar ADD CONSTRAINT Trabajar_fkey2 
FOREIGN KEY (CURP) REFERENCES Empleado(CURP);