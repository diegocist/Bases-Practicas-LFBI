DROP SCHEMA IF EXISTS public CASCADE;
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

COMMENT ON TABLE Empleado IS 'Tabla que contiene la información de los empleados de cada Sucursal.';
COMMENT ON COLUMN Empleado.CURP IS 'CURP del empleado';
COMMENT ON COLUMN Empleado.FechaNacimiento IS 'Fecha de nacimiento del empleado';
COMMENT ON COLUMN Empleado.Nombre IS 'Nombre del empleado';
COMMENT ON COLUMN Empleado.ApellidoPaterno IS 'Apellido Paterno del empleado';
COMMENT ON COLUMN Empleado.ApellidoMaterno IS 'Apellido Materno del empleado';
COMMENT ON COLUMN Empleado.RFC IS 'RFC del empleado';
COMMENT ON COLUMN Empleado.tipoEmpleado IS 'Categoría para identificar al tipo de empleado: Gerente, Tecnico, EncargadoPremios y Cajero (0 a 3)';
COMMENT ON CONSTRAINT Empleado_pkey ON Empleado IS 'Llave primaria de la tabla Empleado';

COMMENT ON CONSTRAINT Empleado_d1 ON Empleado IS 'Restriccion CHECK que valida el formato estandar de 18 caracteres del CURP';
COMMENT ON CONSTRAINT Empleado_d2 ON Empleado IS 'Restriccion CHECK que revisa que el empleado sea mayor de 18 años';
COMMENT ON CONSTRAINT Empleado_d3 ON Empleado IS 'Restriccion CHECK que asegura que el nombre no sea una cadena vacía';
COMMENT ON CONSTRAINT Empleado_d4 ON Empleado IS 'Restriccion CHECK que revisa que el apellido paterno no sea una cadena vacía';
COMMENT ON CONSTRAINT Empleado_d5 ON Empleado IS 'Restriccion CHECK que revisa que el apellido materno no sea una cadena vacía';
COMMENT ON CONSTRAINT Empleado_d6 ON Empleado IS 'Restriccion CHECK que valida el formato de 13 caracteres del RFC';
COMMENT ON CONSTRAINT Empleado_d7 ON Empleado IS 'Restriccion CHECK que valida que el tipo de empleado esté en el rango de 0 a 3';

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

COMMENT ON TABLE Juego IS 'Tabla que contiene los juegos disponibles en las Sucursales.';
COMMENT ON COLUMN Juego.idJuego IS 'Identificador único del juego (es secuencial)';
COMMENT ON COLUMN Juego.Nombre IS 'Nombre del juego';
COMMENT ON COLUMN Juego.Costo IS 'Costo para jugar';
COMMENT ON COLUMN Juego.Categoria IS 'Categoría para identificar al tipo de juego: Disparos, Destreza, Ritmo, Velocidad (0 a 3)';

COMMENT ON CONSTRAINT Juego_pkey ON Juego IS 'Llave primaria de la tabla juego';
COMMENT ON CONSTRAINT Juego_d1 ON Juego IS 'Restriccion CHECK que revisa que el idJuego sea mayor a 0';
COMMENT ON CONSTRAINT Juego_d2 ON Juego IS 'Restriccion CHECK que asegura que el nombre del juego no sea vacío';
COMMENT ON CONSTRAINT Juego_d3 ON Juego IS 'Restriccion CHECK que valida que el costo sea mayor a 0 y múltiplo de 10';
COMMENT ON CONSTRAINT Juego_d4 ON Juego IS 'Restriccion CHECK que revisa que la categoría del juego esté en el intervalo de 0 a 3';

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

-- Comentarios Sucursal
COMMENT ON TABLE Sucursal IS 'Tabla que contiene las sucursales del negocio';

COMMENT ON COLUMN Sucursal.idSucursal IS 'Identificador de la sucursal';
COMMENT ON COLUMN Sucursal.Telefono IS 'Telefono de la sucursal, compuesto por 10 digitos';
COMMENT ON COLUMN Sucursal.Nombre IS 'Nombre de la sucursal';
COMMENT ON COLUMN Sucursal.Colonia IS 'Colonia donde se ubica la sucursal';
COMMENT ON COLUMN Sucursal.Estado IS 'Estado donde se ubica la sucursal';
COMMENT ON COLUMN Sucursal.Calle IS 'Calle donde se ubica la sucursal';
COMMENT ON COLUMN Sucursal.NumExterior IS 'Numero exterior de la sucursal';
COMMENT ON COLUMN Sucursal.NumInterior IS 'Numero interior de la sucursal, acepta NULL';

COMMENT ON CONSTRAINT Sucursal_pkey ON Sucursal IS 'La llave primaria de la tabla Sucursal';
COMMENT ON CONSTRAINT Sucursal_d1 ON Sucursal IS 'Restriccion check que asegura que idSucursal sea mayor a 0';
COMMENT ON CONSTRAINT Sucursal_d2 ON Sucursal IS 'Restriccion check que asegura que Telefono tenga exactamente 10 digitos';
COMMENT ON CONSTRAINT Sucursal_d3 ON Sucursal IS 'Restriccion check que asegura que NumExterior sea mayor a 0';
COMMENT ON CONSTRAINT Sucursal_d4 ON Sucursal IS 'Restriccion check que asegura que NumInterior, cuando no es NULL, sea mayor a 0';


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

-- Comentarios Premio
COMMENT ON TABLE Premio IS 'Tabla que contiene los premios que se pueden canjear con puntos';

COMMENT ON COLUMN Premio.idPremio IS 'Identificador del premio';
COMMENT ON COLUMN Premio.Nombre IS 'Nombre del premio';
COMMENT ON COLUMN Premio.CategoriaEdad IS 'Categoria de edad a la que va dirigido el premio: Infantil, Juvenil, Adulto o Todas';
COMMENT ON COLUMN Premio.ValorAproximado IS 'Valor aproximado del premio';
COMMENT ON COLUMN Premio.CostoPuntos IS 'Cantidad de puntos necesarios para canjear el premio';

COMMENT ON CONSTRAINT Premio_pkey ON Premio IS 'La llave primaria de la tabla Premio';
COMMENT ON CONSTRAINT Premio_d1 ON Premio IS 'Restriccion check que asegura que idPremio sea mayor a 0';
COMMENT ON CONSTRAINT Premio_d2 ON Premio IS 'Restriccion check que asegura que CategoriaEdad sea Infantil, Juvenil, Adulto o Todas';
COMMENT ON CONSTRAINT Premio_d3 ON Premio IS 'Restriccion check que asegura que ValorAproximado sea mayor a 0';
COMMENT ON CONSTRAINT Premio_d4 ON Premio IS 'Restriccion check que asegura que CostoPuntos sea mayor a 0';

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

-- Comentarios Cliente
COMMENT ON TABLE Cliente IS 'Tabla que contiene a los clientes del negocio';

COMMENT ON COLUMN Cliente.idCliente IS 'Identificador del cliente';

COMMENT ON COLUMN Cliente.Nombre IS 'Nombre del cliente';
COMMENT ON COLUMN Cliente.ApellidoPaterno IS 'Apellido paterno del cliente';
COMMENT ON COLUMN Cliente.ApellidoMaterno IS 'Apellido materno del cliente, acepta NULL';
COMMENT ON COLUMN Cliente.FechaNacimiento IS 'Fecha de nacimiento del cliente';
COMMENT ON COLUMN Cliente.Sexo IS 'Sexo del cliente: Masculino, Femenino o No binario';

COMMENT ON CONSTRAINT Cliente_pkey ON Cliente IS 'La llave primaria de la tabla Cliente';
COMMENT ON CONSTRAINT Cliente_d1 ON Cliente IS 'Restriccion check que asegura que idCliente sea mayor a 0';
COMMENT ON CONSTRAINT Cliente_d2 ON Cliente IS 'Restriccion check que asegura que Nombre no sea una cadena vacia';
COMMENT ON CONSTRAINT Cliente_d3 ON Cliente IS 'Restriccion check que asegura que ApellidoPaterno no sea una cadena vacia';
COMMENT ON CONSTRAINT Cliente_d4 ON Cliente IS 'Restriccion check que asegura que ApellidoMaterno, cuando no es NULL, no sea una cadena vacia';
COMMENT ON CONSTRAINT Cliente_d5 ON Cliente IS 'Restriccion check que asegura que FechaNacimiento sea menor o igual a la fecha actual';
COMMENT ON CONSTRAINT Cliente_d6 ON Cliente IS 'Restriccion check que asegura que Sexo sea Masculino, Femenino o No binario';

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


-- Comentarios Tarjeta
COMMENT ON TABLE Tarjeta IS 'Tabla que contiene las tarjetas de los clientes';

COMMENT ON COLUMN Tarjeta.idTarjeta IS 'Identificador de la tarjeta';
COMMENT ON COLUMN Tarjeta.Estado IS 'Estado de la tarjeta: Activa, Bloqueada o Cancelada';
COMMENT ON COLUMN Tarjeta.Saldo IS 'Saldo disponible de la tarjeta';
COMMENT ON COLUMN Tarjeta.Puntos IS 'Puntos acumulados en la tarjeta';

COMMENT ON CONSTRAINT Tarjeta_pkey ON Tarjeta IS 'La llave primaria de la tabla Tarjeta';
COMMENT ON CONSTRAINT Tarjeta_d1 ON Tarjeta IS 'Restriccion check que asegura que idTarjeta sea mayor a 0';
COMMENT ON CONSTRAINT Tarjeta_d2 ON Tarjeta IS 'Restriccion check que asegura que Estado sea Activa, Bloqueada o Cancelada';
COMMENT ON CONSTRAINT Tarjeta_d3 ON Tarjeta IS 'Restriccion check que asegura que Saldo sea mayor o igual a 0';
COMMENT ON CONSTRAINT Tarjeta_d4 ON Tarjeta IS 'Restriccion check que asegura que Puntos sea mayor o igual a 0';



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
FOREIGN KEY(CURP) REFERENCES Empleado(curp) ON DELETE CASCADE ON UPDATE CASCADE;

COMMENT ON TABLE CorreoEmpleado IS 'Tabla que almacena los correos electrónicos asociados a cada empleado.';
COMMENT ON COLUMN CorreoEmpleado.CURP IS 'CURP del empleado al que pertenece el correo';
COMMENT ON COLUMN CorreoEmpleado.Correo IS 'Dirección de correo electrónico del empleado';

COMMENT ON CONSTRAINT CorreoEmpleado_pkey ON CorreoEmpleado IS 'Llave primaria compuesta por CURP y Correo';
COMMENT ON CONSTRAINT CorreoEmpleado_fkey ON CorreoEmpleado IS 'Llave foránea que hace referencia al CURP del empleado. Usa borrado y actualización en Cascada';

CREATE TABLE TelefonoEmpleado(
	CURP VARCHAR(18),
	Telefono VARCHAR(10)
);

--Restricciones TelefonoEmpleado
--Dominio
ALTER TABLE TelefonoEmpleado ADD CONSTRAINT TelefonoEmpleado_d1
CHECK(Telefono ~ '^[0-9]{10}$');

--Entidad
ALTER TABLE TelefonoEmpleado ADD CONSTRAINT TelefonoEmpleado_pkey
PRIMARY KEY(CURP, Telefono);

--Referencial
ALTER TABLE TelefonoEmpleado ADD CONSTRAINT TelefonoEmpleado_fkey
FOREIGN KEY(CURP) REFERENCES Empleado(curp) ON DELETE CASCADE ON UPDATE CASCADE;

COMMENT ON TABLE TelefonoEmpleado IS 'Tabla que almacena los números telefono asociados a cada empleado.';
COMMENT ON COLUMN TelefonoEmpleado.CURP IS 'CURP del empleado al que pertenece el teléfono.';
COMMENT ON COLUMN TelefonoEmpleado.Telefono IS 'Número de telefono del empleado.';

COMMENT ON CONSTRAINT TelefonoEmpleado_pkey ON TelefonoEmpleado IS 'Llave primaria compuesta por CURP y Telefono';
COMMENT ON CONSTRAINT TelefonoEmpleado_d1 ON TelefonoEmpleado IS 'Restriccion CHECK que verifica que el teléfono tenga exactamente 10 dígitos.';
COMMENT ON CONSTRAINT TelefonoEmpleado_fkey ON TelefonoEmpleado IS 'Llave foránea que hace referencia al CURP del Empleado. Usa borrado y actualización en cascada';

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
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego) ON DELETE CASCADE ON UPDATE CASCADE;

COMMENT ON TABLE Disparos IS 'Tabla que almacena los juegos de disparos. Es Subtipo de la tabla Juego.';
COMMENT ON COLUMN Disparos.idJuego IS 'Identificador unico del juego. (Secuencial y Heredado)';
COMMENT ON COLUMN Disparos.PuntosPorAcierto IS 'Puntos otorgados por cada acierto';
COMMENT ON CONSTRAINT Disparos_pkey ON Disparos IS 'Llave primaria de Disparos (Heredada de Disparos)';
COMMENT ON CONSTRAINT Disparos_d1 ON Disparos IS 'Restriccion CHECK que verifica que el idJuego sea un entero positivo';
COMMENT ON CONSTRAINT Disparos_d2 ON Disparos IS 'Restriccion CHECK que valida que los puntos por acierto sean iguales a 1';
COMMENT ON CONSTRAINT Disparos_fkey ON Disparos IS 'Llave foránea que hace referencia a Juego. Usa borrado y actualización en cascada';

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
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego) ON DELETE CASCADE ON UPDATE CASCADE;

COMMENT ON TABLE Destreza IS 'Tabla que almacena los juegos de destreza. Es Subtipo de la tabla Juego.';
COMMENT ON COLUMN Destreza.idJuego IS 'Identificador unico del juego. (Secuencial y Heredado)';
COMMENT ON COLUMN Destreza.PuntosPorAcierto IS 'Puntos otorgados por cada acierto';

COMMENT ON CONSTRAINT Destreza_pkey ON Destreza IS 'Llave primaria de Destreza (Heredada de Juego)';
COMMENT ON CONSTRAINT Destreza_d1 ON Destreza IS 'Restriccion CHECK que verifica que el idJuego sea un entero positivo';
COMMENT ON CONSTRAINT Destreza_d2 ON Destreza IS 'Restriccion CHECK que valida que los puntos por acierto sean iguales a 1';
COMMENT ON CONSTRAINT Destreza_fkey ON Destreza IS 'Llave foránea que hace referencia a Juego. Usa borrado y actualización en cascada';

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
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego) ON DELETE CASCADE ON UPDATE CASCADE;

COMMENT ON TABLE Ritmo IS 'Tabla que almacena los juegos de ritmo. Es Subtipo de la tabla Juego.';
COMMENT ON COLUMN Ritmo.idJuego IS 'Identificador unico del juego. (Secuencial y Heredado)';
COMMENT ON COLUMN Ritmo.PuntosTop5 IS 'Puntos otorgados por posicionarse en el Top 5';

COMMENT ON CONSTRAINT Ritmo_pkey ON Ritmo IS 'Llave primaria de Ritmo (Heredada de Juego)';
COMMENT ON CONSTRAINT Ritmo_d1 ON Ritmo IS 'Restriccion CHECK que verifica que el idJuego sea mayor a 0';
COMMENT ON CONSTRAINT Ritmo_d2 ON Ritmo IS 'Restriccion CHECK que valida que los puntos otorgados para el del Top 5 sean iguales a 20';
COMMENT ON CONSTRAINT Ritmo_fkey ON Ritmo IS 'Llave foránea que hace referencia a Juego. Usa borrado y actualización en cascada';

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
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego) ON DELETE CASCADE ON UPDATE CASCADE;

COMMENT ON TABLE Velocidad IS 'Tabla que almacena los juegos de velocidad. Es Subtipo de la tabla Juego.';
COMMENT ON COLUMN Velocidad.idJuego IS 'Identificador unico del juego. (Secuencial y Heredado)';
COMMENT ON COLUMN Velocidad.PuntosTop5 IS 'Puntos otorgados por posicionarse en el Top 5';
COMMENT ON CONSTRAINT Velocidad_pkey ON Velocidad IS 'Llave primaria de Velocidad (Heredada de Juego)';
COMMENT ON CONSTRAINT Velocidad_d1 ON Velocidad IS 'Restriccion CHECK que verifica que el idJuego sea mayor a 0';
COMMENT ON CONSTRAINT Velocidad_d2 ON Velocidad IS 'Restriccion CHECK que valida que los puntos otorgados para el Top 5 sean iguales a 20';
COMMENT ON CONSTRAINT Velocidad_fkey ON Velocidad IS 'Llave foránea que hace referencia a Juego. Usa borrado y actualización en cascada';

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

ALTER TABLE Gerente ADD CONSTRAINT Gerente_unique_cedula
UNIQUE (Cedula);
 
--Referencial
-- CURP hace referencia a Empleado(CURP)
ALTER TABLE Gerente ADD CONSTRAINT Gerente_fkey
FOREIGN KEY (CURP) REFERENCES Empleado(CURP)
ON UPDATE CASCADE ON DELETE CASCADE;


-- Comentarios Gerente
COMMENT ON TABLE Gerente IS 'Tabla que contiene a los empleados que son gerentes';

COMMENT ON COLUMN Gerente.CURP IS 'CURP del gerente, identifica al empleado';
COMMENT ON COLUMN Gerente.Cedula IS 'Cedula profesional del gerente, compuesta por 7 u 8 digitos';

COMMENT ON CONSTRAINT Gerente_pkey ON Gerente IS 'La llave primaria de la tabla Gerente';
COMMENT ON CONSTRAINT Gerente_fkey ON Gerente IS 'Llave foranea de CURP hacia Empleado';
COMMENT ON CONSTRAINT Gerente_unique_cedula ON Gerente IS 'Restriccion unique que asegura que no se repita la cedula entre gerentes';
COMMENT ON CONSTRAINT Gerente_d1 ON Gerente IS 'Restriccion check que asegura que CURP tenga el formato estandar';
COMMENT ON CONSTRAINT Gerente_d2 ON Gerente IS 'Restriccion check que asegura que Cedula tenga 7 u 8 digitos';


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
FOREIGN KEY (CURP) REFERENCES Empleado(CURP)
ON UPDATE CASCADE ON DELETE CASCADE;

-- Comentarios Tecnico
COMMENT ON TABLE Tecnico IS 'Tabla que contiene a los empleados que son tecnicos';

COMMENT ON COLUMN Tecnico.CURP IS 'CURP del tecnico, identifica al empleado';
COMMENT ON COLUMN Tecnico.Especialidad IS 'Especialidad del tecnico';

COMMENT ON CONSTRAINT Tecnico_pkey ON Tecnico IS 'La llave primaria de la tabla Tecnico';
COMMENT ON CONSTRAINT Tecnico_fkey ON Tecnico IS 'Llave foranea de CURP hacia Empleado';
COMMENT ON CONSTRAINT Tecnico_d1 ON Tecnico IS 'Restriccion check que asegura que CURP tenga el formato estandar';
 

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
FOREIGN KEY (CURP) REFERENCES Empleado(CURP)
ON UPDATE CASCADE ON DELETE CASCADE;

-- Comentarios Cajero
COMMENT ON TABLE Cajero IS 'Tabla que contiene a los empleados que son cajeros';

COMMENT ON COLUMN Cajero.CURP IS 'CURP del cajero, identifica al empleado';

COMMENT ON CONSTRAINT Cajero_pkey ON Cajero IS 'La llave primaria de la tabla Cajero';
COMMENT ON CONSTRAINT Cajero_fkey ON Cajero IS 'Llave foranea de CURP hacia Empleado';
COMMENT ON CONSTRAINT Cajero_d1 ON Cajero IS 'Restriccion check que asegura que CURP tenga el formato estandar';


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
FOREIGN KEY (CURP) REFERENCES Empleado(CURP)
ON UPDATE CASCADE ON DELETE CASCADE;

-- Comentarios EncargadoPremios
COMMENT ON TABLE EncargadoPremios IS 'Tabla que contiene a los empleados que son encargados de premios';

COMMENT ON COLUMN EncargadoPremios.CURP IS 'CURP del encargado de premios, identifica al empleado';

COMMENT ON CONSTRAINT EncargadoPremios_pkey ON EncargadoPremios IS 'La llave primaria de la tabla EncargadoPremios';
COMMENT ON CONSTRAINT EncargadoPremios_fkey ON EncargadoPremios IS 'Llave foranea de CURP hacia Empleado';
COMMENT ON CONSTRAINT EncargadoPremios_d1 ON EncargadoPremios IS 'Restriccion check que asegura que CURP tenga el formato estandar';

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
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
ON UPDATE CASCADE ON DELETE CASCADE;

-- idPremio hace referencia a Premio(idPremio)
ALTER TABLE Almacenamiento ADD CONSTRAINT Almacenamiento_fkey2
FOREIGN KEY (idPremio) REFERENCES Premio(idPremio)
ON UPDATE CASCADE ON DELETE RESTRICT;


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
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- idJuego hace referencia a Juego(idJuego)
ALTER TABLE Maquina ADD CONSTRAINT Maquina_fkey2
FOREIGN KEY (idJuego) REFERENCES Juego(idJuego)
ON UPDATE CASCADE ON DELETE RESTRICT;


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
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
ON UPDATE CASCADE ON DELETE CASCADE;

-- CURP hace referencia a Gerente(CURP)
ALTER TABLE Administrar ADD CONSTRAINT Administrar_fkey2
FOREIGN KEY (CURP) REFERENCES Gerente(CURP)
ON UPDATE CASCADE ON DELETE CASCADE;


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
FOREIGN KEY (idMaquina) REFERENCES Maquina(idMaquina)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- CURP hace referencia a Tecnico(CURP)
ALTER TABLE Reparar ADD CONSTRAINT Reparar_fkey2
FOREIGN KEY (CURP) REFERENCES Tecnico(CURP)
ON UPDATE CASCADE ON DELETE RESTRICT;


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
FOREIGN KEY (CURP) REFERENCES Tecnico(CURP)
ON UPDATE CASCADE ON DELETE CASCADE;

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

-- Referencial
-- idCliente
ALTER TABLE Registrar ADD CONSTRAINT Registrar_fkey1
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
ON UPDATE CASCADE ON DELETE RESTRICT;


-- idTarjeta
ALTER TABLE Registrar ADD CONSTRAINT Registrar_fkey2
FOREIGN KEY (idTarjeta) REFERENCES Tarjeta(idTarjeta)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- Comentarios Registrar
COMMENT ON TABLE Registrar IS 'Tabla que relaciona a los clientes con sus tarjetas';

COMMENT ON COLUMN Registrar.idCliente IS 'Identificador del cliente que registra la tarjeta';
COMMENT ON COLUMN Registrar.idTarjeta IS 'Identificador de la tarjeta registrada';

COMMENT ON CONSTRAINT Registrar_d1 ON Registrar IS 'Restriccion check que asegura que idCliente sea mayor a 0';
COMMENT ON CONSTRAINT Registrar_d2 ON Registrar IS 'Restriccion check que asegura que idTarjeta sea mayor a 0';
COMMENT ON CONSTRAINT Registrar_fkey1 ON Registrar IS 'Llave foranea de idCliente hacia Cliente(idCliente), ON UPDATE CASCADE ON DELETE RESTRICT';
COMMENT ON CONSTRAINT Registrar_fkey2 ON Registrar IS 'Llave foranea de idTarjeta hacia Tarjeta(idTarjeta), ON UPDATE CASCADE ON DELETE RESTRICT';

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
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
ON UPDATE CASCADE ON DELETE CASCADE ;

-- Comentarios CorreoCliente
COMMENT ON TABLE CorreoCliente IS 'Tabla que contiene los correos de los clientes (atributo multivaluado)';

COMMENT ON COLUMN CorreoCliente.idCliente IS 'Identificador del cliente dueno del correo';
COMMENT ON COLUMN CorreoCliente.Correo IS 'Correo electronico del cliente';

COMMENT ON CONSTRAINT CorreoCliente_pkey ON CorreoCliente IS 'La llave primaria compuesta de la tabla CorreoCliente';
COMMENT ON CONSTRAINT CorreoCliente_fkey ON CorreoCliente IS 'Llave foranea de idCliente hacia Cliente(idCliente), ON UPDATE CASCADE ON DELETE CASCADE';

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
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
ON UPDATE CASCADE ON DELETE CASCADE ;

-- Comentarios TelefonoCliente
COMMENT ON TABLE TelefonoCliente IS 'Tabla que contiene los telefonos de los clientes (atributo multivaluado)';

COMMENT ON COLUMN TelefonoCliente.idCliente IS 'Identificador del cliente dueno del telefono';
COMMENT ON COLUMN TelefonoCliente.Telefono IS 'Telefono del cliente, compuesto por 10 digitos';

COMMENT ON CONSTRAINT TelefonoCliente_d1 ON TelefonoCliente IS 'Restriccion check que asegura que Telefono tenga exactamente 10 digitos';
COMMENT ON CONSTRAINT TelefonoCliente_pkey ON TelefonoCliente IS 'La llave primaria compuesta de la tabla TelefonoCliente';
COMMENT ON CONSTRAINT TelefonoCliente_fkey ON TelefonoCliente IS 'Llave foranea de idCliente hacia Cliente(idCliente), ON UPDATE CASCADE ON DELETE CASCADE';

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
FOREIGN KEY (idTarjeta) REFERENCES Tarjeta(idTarjeta)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- idSucursal 
ALTER TABLE Recarga ADD CONSTRAINT Recarga_fkey2
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- CURP 
ALTER TABLE Recarga ADD CONSTRAINT Recarga_fkey3
FOREIGN KEY (CURP) REFERENCES Cajero(CURP)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- Comentarios Recarga
COMMENT ON TABLE Recarga IS 'Tabla que contiene las recargas de saldo hechas a las tarjetas';

COMMENT ON COLUMN Recarga.idTarjeta IS 'Identificador de la tarjeta recargada';
COMMENT ON COLUMN Recarga.numRecarga IS 'Numero de recarga dentro de la tarjeta';
COMMENT ON COLUMN Recarga.idSucursal IS 'Identificador de la sucursal donde se hizo la recarga';
COMMENT ON COLUMN Recarga.CURP IS 'CURP del cajero que realizo la recarga';
COMMENT ON COLUMN Recarga.Monto IS 'Monto recargado';
COMMENT ON COLUMN Recarga.MetodoPago IS 'Metodo de pago: Efectivo, Credito, Debito o Paypal';
COMMENT ON COLUMN Recarga.Hora IS 'Hora de la recarga';
COMMENT ON COLUMN Recarga.Fecha IS 'Fecha de la recarga';

COMMENT ON CONSTRAINT Recarga_d1 ON Recarga IS 'Restriccion check que asegura que idTarjeta sea mayor a 0';
COMMENT ON CONSTRAINT Recarga_d2 ON Recarga IS 'Restriccion check que asegura que numRecarga sea mayor a 0';
COMMENT ON CONSTRAINT Recarga_d3 ON Recarga IS 'Restriccion check que asegura que idSucursal sea mayor a 0';
COMMENT ON CONSTRAINT Recarga_d4 ON Recarga IS 'Restriccion check que asegura que CURP tenga el formato estandar';
COMMENT ON CONSTRAINT Recarga_d5 ON Recarga IS 'Restriccion check que asegura que Monto sea mayor a 0';
COMMENT ON CONSTRAINT Recarga_d6 ON Recarga IS 'Restriccion check que asegura que MetodoPago sea Efectivo, Credito, Debito o Paypal';
COMMENT ON CONSTRAINT Recarga_d7 ON Recarga IS 'Restriccion check que asegura que Fecha sea menor o igual a la fecha actual';
COMMENT ON CONSTRAINT Recarga_pkey ON Recarga IS 'La llave primaria compuesta de la tabla Recarga';
COMMENT ON CONSTRAINT Recarga_fkey1 ON Recarga IS 'Llave foranea de idTarjeta hacia Tarjeta(idTarjeta), ON UPDATE CASCADE ON DELETE RESTRICT';
COMMENT ON CONSTRAINT Recarga_fkey2 ON Recarga IS 'Llave foranea de idSucursal hacia Sucursal(idSucursal), ON UPDATE CASCADE ON DELETE RESTRICT';
COMMENT ON CONSTRAINT Recarga_fkey3 ON Recarga IS 'Llave foranea de CURP hacia Cajero(CURP),  ON UPDATE CASCADE ON DELETE RESTRICT';

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
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- idTarjeta 
ALTER TABLE Canje ADD CONSTRAINT Canje_fkey2
FOREIGN KEY (idTarjeta) REFERENCES Tarjeta(idTarjeta)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- CURP 
ALTER TABLE Canje ADD CONSTRAINT Canje_fkey3
FOREIGN KEY (CURP) REFERENCES EncargadoPremios(CURP)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- Comentarios Canje
COMMENT ON TABLE Canje IS 'Tabla que contiene los canjes de premios hechos con las tarjetas';

COMMENT ON COLUMN Canje.idCanje IS 'Identificador del canje';
COMMENT ON COLUMN Canje.idSucursal IS 'Identificador de la sucursal donde se hizo el canje';
COMMENT ON COLUMN Canje.idTarjeta IS 'Identificador de la tarjeta usada en el canje';
COMMENT ON COLUMN Canje.CURP IS 'CURP del encargado de premios que realizo el canje';
COMMENT ON COLUMN Canje.Hora IS 'Hora del canje';
COMMENT ON COLUMN Canje.Fecha IS 'Fecha del canje';

COMMENT ON CONSTRAINT Canje_pkey ON Canje IS 'La llave primaria de la tabla Canje';
COMMENT ON CONSTRAINT Canje_d1 ON Canje IS 'Restriccion check que asegura que idCanje sea mayor a 0';
COMMENT ON CONSTRAINT Canje_d2 ON Canje IS 'Restriccion check que asegura que idSucursal sea mayor a 0';
COMMENT ON CONSTRAINT Canje_d3 ON Canje IS 'Restriccion check que asegura que idTarjeta sea mayor a 0';
COMMENT ON CONSTRAINT Canje_d4 ON Canje IS 'Restriccion check que asegura que CURP tenga el formato estandar';
COMMENT ON CONSTRAINT Canje_d5 ON Canje IS 'Restriccion check que asegura que Fecha sea menor o igual a la fecha actual';
COMMENT ON CONSTRAINT Canje_fkey1 ON Canje IS 'Llave foranea de idSucursal hacia Sucursal, ON UPDATE CASCADE ON DELETE RESTRICT';
COMMENT ON CONSTRAINT Canje_fkey2 ON Canje IS 'Llave foranea de idTarjeta hacia Tarjeta, ON UPDATE CASCADE ON DELETE RESTRICT';
COMMENT ON CONSTRAINT Canje_fkey3 ON Canje IS 'Llave foranea de CURP hacia EncargadoPremios, ON UPDATE CASCADE ON DELETE RESTRICT';

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
ALTER TABLE Incluir ADD CONSTRAINT Incluir_unique
UNIQUE (idCanje, idPremio);

--Referencial
-- idPremio 
ALTER TABLE Incluir ADD CONSTRAINT Incluir_fkey2
FOREIGN KEY (idPremio) REFERENCES Premio(idPremio)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- idCanje 
ALTER TABLE Incluir ADD CONSTRAINT Incluir_fkey1
FOREIGN KEY (idCanje) REFERENCES Canje(idCanje)
 ON UPDATE CASCADE ON DELETE CASCADE;


-- Comentarios Incluir
COMMENT ON TABLE Incluir IS 'Tabla que contiene los premios incluidos en cada canje';

COMMENT ON COLUMN Incluir.idCanje IS 'Identificador del canje';
COMMENT ON COLUMN Incluir.idPremio IS 'Identificador del premio incluido';
COMMENT ON COLUMN Incluir.Cantidad IS 'Cantidad del premio incluida en el canje';

COMMENT ON CONSTRAINT Incluir_d1 ON Incluir IS 'Restriccion check que asegura que idCanje sea mayor a 0';
COMMENT ON CONSTRAINT Incluir_d2 ON Incluir IS 'Restriccion check que asegura que idPremio sea mayor a 0';
COMMENT ON CONSTRAINT Incluir_d3 ON Incluir IS 'Restriccion check que asegura que Cantidad sea mayor a 0';
COMMENT ON CONSTRAINT Incluir_unique ON Incluir IS 'Restriccion unique que asegura que la combinacion (idCanje, idPremio) no se repita';
COMMENT ON CONSTRAINT Incluir_fkey1 ON Incluir IS 'Llave foranea de idCanje hacia Canje(idCanje), ON UPDATE CASCADE ON DELETE CASCADE';
COMMENT ON CONSTRAINT Incluir_fkey2 ON Incluir IS 'Llave foranea de idPremio hacia Premio(idPremio), ON UPDATE CASCADE ON DELETE RESTRICT';


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
FOREIGN KEY (idMaquina) REFERENCES Maquina(idMaquina) ON DELETE RESTRICT ON UPDATE CASCADE;


-- idTarjeta hace referencia a Tarjeta(idTarjeta)
ALTER TABLE Partida ADD CONSTRAINT Partida_fkey2 
FOREIGN KEY (idTarjeta) REFERENCES Tarjeta(idTarjeta) ON DELETE RESTRICT ON UPDATE CASCADE;

COMMENT ON TABLE Partida IS 'Tabla que almacena los registros de partidas jugadas en las máquinas.';
COMMENT ON COLUMN Partida.numPartida IS 'Identificador de la partida (Es secuencial)';
COMMENT ON COLUMN Partida.idMaquina IS 'Identificador de la máquina en la que se jugó la partida';
COMMENT ON COLUMN Partida.idTarjeta IS 'Identificador de la tarjeta utilizada para jugar';
COMMENT ON COLUMN Partida.FechaPartida IS 'Fecha en que se llevó a cabo la partida';
COMMENT ON COLUMN Partida.HoraFin IS 'Hora en que finalizó la partida';
COMMENT ON COLUMN Partida.PuntosObtenidos IS 'Cantidad de puntos acumulados en la partida';
COMMENT ON COLUMN Partida.Puntaje IS 'Puntaje final registrado en la partida';

COMMENT ON CONSTRAINT Partida_pkey ON Partida IS 'Llave primaria compuesta por numPartida e idMaquina';
COMMENT ON CONSTRAINT Partida_d1 ON Partida IS 'Restriccion CHECK que revisa que el numPartida sea mayor a 0';
COMMENT ON CONSTRAINT Partida_d2 ON Partida IS 'Restriccion CHECK que revisa que el idMaquina sea mayor a 0';
COMMENT ON CONSTRAINT Partida_d3 ON Partida IS 'Restriccion CHECK que revisa que el idTarjeta sea mayor a 0';
COMMENT ON CONSTRAINT Partida_d4 ON Partida IS 'Restriccion CHECK que valida que la fecha de la partida no sea posterior a la fecha actual';
COMMENT ON CONSTRAINT Partida_d5 ON Partida IS 'Restriccion CHECK que valida que los puntos obtenidos sean mayores o iguales a 0';
COMMENT ON CONSTRAINT Partida_d6 ON Partida IS 'Restriccion CHECK que valida que el puntaje sea mayor o igual a 0';
COMMENT ON CONSTRAINT Partida_fkey1 ON Partida IS 'Llave foránea que hace referencia a Maquina. Usa borrado en RESTRICT y actualización en cascada';
COMMENT ON CONSTRAINT Partida_fkey2 ON Partida IS 'Llave foránea que hace referencia a Tarjeta. Usa borrado en RESTRICT y actualización en cascada';

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

-- Correcciones: llave primaria compuesta por: idSucursal, Dia, HoraApertura, HoraCierre.
ALTER TABLE DiaApertura DROP CONSTRAINT DiaApertura_pkey;

ALTER TABLE DiaApertura ADD CONSTRAINT DiaApertura_pkey 
PRIMARY KEY (idSucursal, Dia, HoraApertura, HoraCierre);

-- Referencial
-- idSucursal hace referencia a Sucursal(idSucursal)
ALTER TABLE DiaApertura ADD CONSTRAINT DiaApertura_fkey1 
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE ON UPDATE CASCADE;

COMMENT ON TABLE DiaApertura IS 'Tabla que almacena los días y horarios de apertura de cada sucursal.';
COMMENT ON COLUMN DiaApertura.idSucursal IS 'Identificador de la sucursal';
COMMENT ON COLUMN DiaApertura.Dia IS 'Abreviación del día de la semana de servicio';
COMMENT ON COLUMN DiaApertura.HoraApertura IS 'Hora en la que abre la sucursal';
COMMENT ON COLUMN DiaApertura.HoraCierre IS 'Hora en la que cierra la sucursal';
COMMENT ON CONSTRAINT DiaApertura_pkey ON DiaApertura IS 'Llave primaria compuesta por idSucursal, Dia, HoraApertura y HoraCierre';
COMMENT ON CONSTRAINT DiaApertura_d1 ON DiaApertura IS 'Restriccion CHECK que valida que la hora de cierre sea posterior a la hora de apertura';
COMMENT ON CONSTRAINT DiaApertura_fkey1 ON DiaApertura IS 'Llave foránea que hace referencia a Sucursal. Usa borrado y actualización en cascada';

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

-- Correcciones: No usar llave primaria, pero usar UNIQUE, para que las tuplas no se repitan.
ALTER TABLE Trabajar DROP CONSTRAINT Trabajar_pkey;

ALTER TABLE Trabajar ADD CONSTRAINT Trabajar_u1 UNIQUE (idSucursal, CURP);

-- Referencial
ALTER TABLE Trabajar ADD CONSTRAINT Trabajar_fkey1 
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Trabajar ADD CONSTRAINT Trabajar_fkey2 
FOREIGN KEY (CURP) REFERENCES Empleado(CURP) ON DELETE RESTRICT ON UPDATE CASCADE;


COMMENT ON TABLE Trabajar IS 'Tabla que almacena la relación entre empleados y sucursales.';
COMMENT ON COLUMN Trabajar.idSucursal IS 'Identificador de la sucursal donde labora el empleado';
COMMENT ON COLUMN Trabajar.CURP IS 'CURP del empleado';
COMMENT ON COLUMN Trabajar.FechaContratacion IS 'Fecha de contratación del empleado';
COMMENT ON COLUMN Trabajar.Salario IS 'Salario del empleado';
COMMENT ON COLUMN Trabajar.HoraInicio IS 'Hora de inicio de la jornada del empleado';
COMMENT ON COLUMN Trabajar.HoraFin IS 'Hora de fin de la jornada del empleado';

COMMENT ON CONSTRAINT Trabajar_u1 ON Trabajar IS 'Restriccion UNIQUE que asegura la unicidad de la combinación idSucursal y CURP';
COMMENT ON CONSTRAINT Trabajar_d1 ON Trabajar IS 'Restriccion CHECK que valida que el salario sea mayor a 0';
COMMENT ON CONSTRAINT Trabajar_d2 ON Trabajar IS 'Restriccion CHECK que valida que la hora de fin sea posterior a la hora de inicio';
COMMENT ON CONSTRAINT Trabajar_fkey1 ON Trabajar IS 'Llave foránea que hace referencia a Sucursal. Usa borrado en RESTRICT y actualización en cascada';
COMMENT ON CONSTRAINT Trabajar_fkey2 ON Trabajar IS 'Llave foránea que hace referencia a Empleado. Usa borrado en RESTRICT y actualización en cascada';

