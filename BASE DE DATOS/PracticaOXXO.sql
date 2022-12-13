USE master;
GO
IF DB_ID(N'OXXO')IS NOT NULL
DROP DATABASE Oxxo;
GO
CREATE DATABASE OXXO
ON
(NAME = OXXO_dat,
FILENAME= 'C:\PracticaOXXO\OXXO.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME =OXXO_log,
FILENAME = 'C:\PracticaOXXO\OXXO.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE OXXO;
GO
CREATE TABLE Articulo
(
idArticulo INT IDENTITY (1,1),
cantidad VARCHAR(40)NOT NULL,
precio VARCHAR(40)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL,
idEmpleado int not null,
idBodega int not null
);
CREATE TABLE ArticuloEmpleado
(
idArticuloEmpleado INT IDENTITY (1,1),
idArticulo int not null,
idEmpleado int not null,
estatus BIT DEFAULT 1 NOT NULL,
);
GO
GO
CREATE TABLE Bodega
(
idBodega INT IDENTITY (1,1),
paquetes VARCHAR(40)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Caja
(
idCaja INT IDENTITY (1,1),
noCaja VARCHAR(40)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL,
idEmpleado int not null
);
GO
CREATE TABLE Empleado
(
idEmpleado INT IDENTITY (1,1),
nombre VARCHAR(40)NOT NULL,
apellidoP VARCHAR(40)NOT NULL,
apellidoM VARCHAR(40)NOT NULL,
rfc VARCHAR(40)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);



---------------PRIMARY KEY---------
ALTER TABLE Articulo ADD CONSTRAINT PK_Articulo PRIMARY KEY (idArticulo)
ALTER TABLE ArticuloEmpleado ADD CONSTRAINT PK_ArticuloEmpleado PRIMARY KEY (idArticuloEmpleado)
ALTER TABLE Bodega ADD CONSTRAINT PK_Bodega PRIMARY KEY (idBodega)
ALTER TABLE Caja ADD CONSTRAINT PK_Caja PRIMARY KEY (idCaja)
ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado)

-----------------------------------------FOREIGN KEY----------------------------------------
ALTER TABLE Articulo ADD CONSTRAINT fk_ArticuloEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado)
ALTER TABLE Articulo ADD CONSTRAINT fk_ArticuloBodega FOREIGN KEY (idBodega) REFERENCES Bodega (idBodega)
ALTER TABLE ArticuloEmpleado ADD CONSTRAINT fk_ArticuloEmpleadoArticulo FOREIGN KEY (idArticulo) REFERENCES Articulo (idArticulo)
ALTER TABLE ArticuloEmpleado ADD CONSTRAINT fk_ArticuloEmpleadoEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado)
ALTER TABLE Caja ADD CONSTRAINT fk_CajaEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado)


------------------------------------INDEX-------------------
CREATE INDEX IX_Articulo ON Articulo(idArticulo);
GO
CREATE INDEX IX_Bodega ON Bodega(idBodega);
GO
CREATE INDEX IX_Caja ON Caja(idCaja);
GO
CREATE INDEX IX_Empleado ON Empleado(idEmpleado);
GO
CREATE INDEX IX_ArticuloEmpleado ON ArticuloEmpleado(idArticuloEmpleado);


