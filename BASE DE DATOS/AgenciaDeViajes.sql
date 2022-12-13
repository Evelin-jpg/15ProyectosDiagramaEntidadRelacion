--SQL
USE master;
GO
IF DB_ID (N'AgenciaViajes') IS NOT NULL
DROP DATABASE AgenciaViajes;
GO
CREATE DATABASE AgenciaViajes 
ON 
(NAME = AgenciaViajes_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AgenciaViajes.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME = AgenciaViajes_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AgenciaViajes.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE AgenciaViajes;
GO
--------------------TABLAS-----------
CREATE TABLE Hotel
(
idHotel int IDENTITY(1,1),
nombre varchar (50) not null,
Numplaza char (10) not null,
telefono char (20) not null,
pais varchar (50) not null,
estado varchar (50) not null,
CodigoPostal varchar (10) not null,
NumHotel char (10) not null,
codigoHotel char (10) not null,
estatus bit default 1 not null,
);

CREATE TABLE Sucursal
(
idSucursal int IDENTITY(1,1),
Numplaza char (6) not null,
telefono char (10) not null,
CodigoPostal varchar (5) not null,
numcasa char (10) not null,
calle varchar (30) not null,
estatus bit default 1 not null,
);

CREATE TABLE Turista
(
idTurista int IDENTITY(1,1),
nombre varchar (50) not null,
apellidoPaterno varchar (50) not null,
apellidoMaterno varchar (50) not null,
telefono char (12) not null,
CodigoPostal varchar (5) not null,
Numcasa char (7) not null,
calle varchar (30) not null,
idVuelo int null,
idSucursal int null,
idHotel int null,
estatus bit default 1 not null,
);
CREATE TABLE Vuelo
(
idVuelo	int IDENTITY(1,1),
Fecha varchar (15) not null,
Hora varchar (50) not null,	
PlazasT	varchar	(50) not null,
paisdestino	varchar	(50) not null,
ciudaddestino varchar (50) not null,
estadodestino varchar (50) not null,
paisorigen varchar (50) not null,
ciudadorigen varchar (50) not null,
estadoorigen varchar (50) not null,
estatus bit default 1 not null,
);
GO
--------------------------------INDEX------------------------------
CREATE INDEX IX_Hotel ON Hotel(idHotel);
GO
CREATE INDEX IX_Sucursal ON Sucursal(idSucursal);
GO
CREATE INDEX IX_Turista ON Turista (idTurista );
GO
CREATE INDEX IX_Vuelo ON Vuelo(idVuelo);
GO
------------------------------LLAVES PRIMARIAS----------------------
ALTER TABLE Hotel ADD CONSTRAINT PK_Hotel PRIMARY KEY (idHotel)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (idSucursal)
ALTER TABLE Turista ADD CONSTRAINT PK_Turista PRIMARY KEY (idTurista)
ALTER TABLE Vuelo ADD CONSTRAINT PK_Vuelo PRIMARY KEY (idVuelo)

-----------------------------LLAVES FORANEAS-----------------------
ALTER TABLE Turista
ADD CONSTRAINT FKTuristaVuelo 
FOREIGN KEY (idVuelo) REFERENCES Vuelo (idVuelo);
GO
ALTER TABLE Turista
ADD CONSTRAINT FKTuristaSucursal 
FOREIGN KEY (idSucursal) REFERENCES Sucursal (idSucursal);
GO
ALTER TABLE Turista
ADD CONSTRAINT FKTuristaHotel 
FOREIGN KEY (idHotel) REFERENCES Hotel (idHotel);
GO