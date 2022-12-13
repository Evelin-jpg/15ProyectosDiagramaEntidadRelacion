--SQL
USE master;
GO
IF DB_ID(N'Carretera')IS NOT NULL
DROP DATABASE Carretera;
GO
CREATE DATABASE Carretera;
ON
NAME = Carretera_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Carreteras.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5 )
LOG ON 
NAME = Carretera_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Carretera.ldf'
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5 );
GO
USE Carretera
GO
CREATE TABLE Carretera
(
idCarretera INT NOT NULL,
Nombre VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Tramo
(
idTramo INT NOT NULL,
idCarretera INT NOT NULL,
Tramo INT NOT NULL,
Descripción VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL,
);
GO
CREATE TABLE Municipio
(
idMunicipio INT NOT NULL,
Nombre VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE MunicipioTramo
(
idMunicipioTramo INT NOT NULL,
idMunicipio INT NOT NULL,
idTramo INT NOT NULL,
kmEntrada INT NOT NULL,
kmSalida INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);

--Llaves Primarias
ALTER TABLE Carretera ADD CONSTRAINT PK_Carretera PRIMARY KEY (idCarretera)
ALTER TABLE Tramo ADD CONSTRAINT PK_Tramo PRIMARY KEY (idTramo)
ALTER TABLE Municipio ADD CONSTRAINT PK_Compania PRIMARY KEY (idMunicipio)

--Llaves Foraneas
ALTER TABLE Tramo ADD CONSTRAINT FK_TramoCarretera FOREIGN KEY (idCarretera) REFERENCES Carretera(idCarretera)
ALTER TABLE MunicipioTramo ADD CONSTRAINT FK_MunicipioTramoMunicipio FOREIGN KEY (idMunicipio) REFERENCES Municipio(idMunicipio)
ALTER TABLE MunicipioTramo ADD CONSTRAINT FK_MunicipioTramoTramo FOREIGN KEY (idTramo) REFERENCES Tramo(idTramo)
--Indice
CREATE INDEX IX_Carretera ON Carretera(idCarretera)
CREATE INDEX IX_Municipio ON Municipio(idMunicipio)
CREATE INDEX IX_Tramo ON Cuerpo(idTramo)