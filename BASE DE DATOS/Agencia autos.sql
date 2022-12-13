
USE master;
GO
IF DB_ID(N'AgenciaAutos')IS NOT NULL
DROP DATABASE AgenciaAutos;
GO
CREATE DATABASE AgenciaAutos
ON
(NAME = AgenciaAutos_dat,
FILENAME= 'C:\BaseDatos\AgenciaAutos.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME =AgenciaAutos_log,
FILENAME = 'C:\BaseDatos\AgenciaAutos.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE AgenciaAutos;
GO
CREATE TABLE Cliente
(
idCliente INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Reserva
(
idReserva INT NOT NULL,
idCliente INT NOT NULL,
idAgencia INT NOT NULL,
Fechainicial DATETIME NOT NULL,
Fechafinal DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Coche
(
idCoche INT NOT NULL,
idGaraje INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Garaje
(
idGaraje INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Agencia
(
idAgencia INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE CocheReserva
(
idCocheReserva INT NOT NULL,
idCoche INT NOT NULL,
idReserva INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
--Llaves Primarias
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Reserva ADD CONSTRAINT PK_Reserva PRIMARY KEY (idReserva)
ALTER TABLE Coche ADD CONSTRAINT PK_Coche PRIMARY KEY (idCoche)
ALTER TABLE Garaje ADD CONSTRAINT PK_Garaje PRIMARY KEY (idGaraje)
ALTER TABLE Agencia ADD CONSTRAINT PK_Auto PRIMARY KEY (idAgencia)

ALTER TABLE Coche
ADD CONSTRAINT FK_CocheGaraje
FOREIGN KEY (idGaraje) REFERENCES Garaje(idGaraje);
GO
ALTER TABLE Reserva
ADD CONSTRAINT FK_ReservaCliente
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente);
GO
ALTER TABLE Reserva
ADD CONSTRAINT FK_ReservaAgencia
FOREIGN KEY (idAgencia) REFERENCES Agencia(idAgencia);
GO
ALTER TABLE CocheReserva
ADD CONSTRAINT FK_CocheReservaCoche
FOREIGN KEY (idCoche) REFERENCES Coche(idCoche);
GO
ALTER TABLE CocheReserva
ADD CONSTRAINT FK_CocheReservaReserva
FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva);
GO

CREATE INDEX IX_Cliente ON Cliente(idCliente);
GO
CREATE INDEX IX_Sucursal ON Reserva(idReserva);
GO
CREATE INDEX IX_Turista ON Coche (idCoche);
GO
CREATE INDEX IX_Vuelo ON Garaje(idGaraje);
GO
CREATE INDEX IX_Agencia ON Agencia(idAgencia);
GO