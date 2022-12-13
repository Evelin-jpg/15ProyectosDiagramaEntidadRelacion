--SQL
USE master;
GO
IF DB_ID (N'ServicioMilitar') IS NOT NULL
	DROP DATABASE ServicioMilitar;

GO
CREATE DATABASE ServicioMilitar
ON
( NAME = ServicioMilitar_dat,
    FILENAME = 'C:\samples\ServicioMilitar.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ServicioMilitar_log,
    FILENAME = 'C:\samples\ServicioMilitar.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
CREATE TABLE Compania
(
	idCompania INT NOT NULL,
	actividad VARCHAR(50) NOT NULL, 
	estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Cuartel
(
idCuartel INT NOT NULL,
codigo VARCHAR(50)NOT NULL,
direccion VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL,
);
GO
CREATE TABLE Cuerpo
(
idCuerpo INT NOT NULL,
denominacion VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL,
);
GO
CREATE TABLE Servicio
(
idServicio INT NOT NULL,
codigo VARCHAR(10)NOT NULL,
descripcion VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE CompañiaCuartel
(
idCompañiaCuartel INT NOT NULL,
idCompañia INT NOT NULL,
idCuartel INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
CREATE TABLE SoldadoServicio
(
idSoldadoServicio INT NOT NULL,
idServicio INT NOT NULL,
idSoldado INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);	

--Llaves Primarias 
ALTER TABLE Compania ADD CONSTRAINT PK_Compania PRIMARY KEY (idCompañia)
ALTER TABLE Cuartel ADD CONSTRAINT PK_Compania PRIMARY KEY (idCuartel)
ALTER TABLE Cuerpo ADD CONSTRAINT PK_Compania PRIMARY KEY (idCuerpo)
ALTER TABLE Servicio ADD CONSTRAINT PK_Compania PRIMARY KEY (idServicio)

--Llaves Foraneas
--Soldado
ALTER TABLE Soldado ADD CONSTRAINT FK_SoldadoCompania FOREIGN KEY (idCompania) REFERENCES Compania(idCompania)
ALTER TABLE Soldado ADD CONSTRAINT FK_SoldadoCuartel FOREIGN KEY (idCuartel) REFERENCES Cuartel(idCuartel)
ALTER TABLE Soldado ADD CONSTRAINT FK_SoldadoCuerpo FOREIGN KEY (idCuerpo) REFERENCES Cuerpo(idCuerpo)
--CompaniaCuartel
ALTER TABLE CompaniaCuartel ADD CONSTRAINT FK_CompaniaCuartelCompania FOREIGN KEY (idCompania) REFERENCES compania(idCompania)
ALTER TABLE SoldadoCompania ADD CONSTRAINT FK_CompaniaCuartelCompania FOREIGN KEY (iSoldado) REFERENCES compania(idSoldado)
--ServicioSoldado
ALTER TABLE ServicioSoldado ADD CONSTRAINT FKServicioSoldadoServicio FOREIGN KEY (idServicioSoldadoServicio) REFERENCES compania(idServicio)
ALTER TABLE ServicioSoldado ADD CONSTRAINT FK_ServicioSoldadoServicio FOREIGN KEY (idServicioSoldadoSericio) REFERENCES compania(idSoldado)
--Indice
CREATE INDEX IX_Compania ON Compania(idCompania)
CREATE INDEX IX_Cuartel ON Cuartel(idCuartel)
CREATE INDEX IX_Cuerpo ON Cuerpo(idCuerpo)
CREATE INDEX IX_Servicio ON Servicio(idServicio)
