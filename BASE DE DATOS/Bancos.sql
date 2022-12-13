--SQL
USE master;
GO
IF DB_ID (N'Bancos') IS NOT NULL
DROP DATABASE Bancos;
GO
CREATE DATABASE Bancos 
ON 
(NAME = Bancos_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Bancos.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME = Bancos_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Bancos.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE Bancos;
GO
-----------------TABLAS---------------
CREATE TABLE Cliente
(
idCliente int IDENTITY(1,1),
nombre varchar (50) not null,
apellidoPaterno varchar (50) not null,
apellidoMaterno varchar (50) not null,
direccion varchar (50) not null,
curp char (20) not null,
estatus bit default 1 not null
);
CREATE TABLE ClienteCuentaPrivilegio
(
idClienteCuentaPrivilegio int IDENTITY(1,1),
nombre varchar (50) not null,
descripcion varchar (50) not null,
fecha datetime not null,
idPrivilegio int null,
idCuenta int null,
idCliente int null,
estatus bit default 1 not null
);
CREATE TABLE Cuenta
(
idCuenta int IDENTITY(1,1),
nombre varchar (50) not null,
numero varchar (25) not null,
codigo char (15) not null,
fecha datetime not null,
idSucursal int null,
estatus bit default 1 not null,
);
CREATE TABLE Domiciliacion
(
idDomiciliacion int IDENTITY(1,1),
nombre varchar (50) not null,
descripcion varchar (50) not null,
fecha datetime not null,
estatus bit default 1 not null
);
CREATE TABLE Prestamo
(
idPrestamo int IDENTITY(1,1),
nombre varchar (50) not null,
descripcion varchar (50) not null,
fecha datetime not null,
idCliente int null,
estatus bit default 1 not null
);
CREATE TABLE Privilegio
(
idPrivilegio int IDENTITY(1,1),
nombre varchar (50) not null,
descripcion varchar (50) not null,
fecha datetime not null,
estatus bit default 1 not null
);
CREATE TABLE Sucursal
(
idSucursal int IDENTITY(1,1),
nombre varchar (50) not null,
direccion varchar (50) not null,
codigo char (15) not null,
estatus bit default 1 not null,
idUsuarioCrea int null,
fechaCrea datetime null,
idUsuarioModifica int default null,
fechaModifica datetime default null
CONSTRAINT PK_Sucursal PRIMARY KEY(idSucursal)
);
CREATE TABLE CuentaDomiciliacion
(
idCuentaDomiciliacion int IDENTITY(1,1),
idCuenta int null,
idDomiciliacion int null,
estatus bit default 1 not null
);
CREATE TABLE ClienteCuenta
(
idClienteCuenta int IDENTITY(1,1),
idCliente int null,
idCuenta int null,
estatus bit default 1 not null
);
--------------------------------INDEX------------------------------
CREATE INDEX IX_Cliente ON Cliente(idCliente);
GO
CREATE INDEX IX_ClienteCuentaPrivilegio ON ClienteCuentaPrivilegio(idClienteCuentaPrivilegio);
GO
CREATE INDEX IX_Cuenta ON Cuenta(idCuenta);
GO
CREATE INDEX IX_Domiciliacion ON Domiciliacion(idDomiciliacion);
GO
CREATE INDEX IX_Prestamo ON Prestamo(idPrestamo);
GO
CREATE INDEX IX_Privilegio ON Privilegio(idPrivilegio);
GO
CREATE INDEX IX_Sucursal  ON Sucursal (idSucursal );
GO
CREATE INDEX IX_CuentaDomiciliacion ON CuentaDomiciliacion(idCuentaDomiciliacion);
GO
CREATE INDEX IX_ClienteCuenta ON ClienteCuenta(idClienteCuenta);
GO
--------------------------LLAVES PRIMARIAS--------------------------

ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(idCliente)
ALTER TABLE ClienteCuentaPrivilegio ADD CONSTRAINT PK_ClienteCuentaPrivilegio PRIMARY KEY(idClienteCuentaPrivilegio)
ALTER TABLE Cuenta ADD CONSTRAINT PK_Cuenta PRIMARY KEY(idCuenta)
ALTER TABLE Domiciliacion ADD CONSTRAINT PK_Domiciliacion PRIMARY KEY(idDomiciliacion)
ALTER TABLE Prestamo ADD CONSTRAINT PK_Prestamo PRIMARY KEY(idPrestamo)
ALTER TABLE Privilegio ADD CONSTRAINT PK_Privilegio PRIMARY KEY(idPrivilegio)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY(idSucursal)
ALTER TABLE CuentaDomiciliacion ADD CONSTRAINT PK_CuentaDomiciliacion PRIMARY KEY(idCuentaDomiciliacion)
ALTER TABLE ClienteCuenta ADD CONSTRAINT PK_ClienteCuenta PRIMARY KEY(idClienteCuenta)

------------------LLAVES FORANEAS-----------------------------------

ALTER TABLE Cliente
ADD CONSTRAINT FK_ClienteUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Cliente
ADD CONSTRAINT FK_ClienteUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE ClienteCuentaPrivilegio 
ADD CONSTRAINT FK_ClienteCuentaPrivilegioPrivilegio
FOREIGN KEY (idPrivilegio) REFERENCES Privilegio (idPrivilegio)
GO
ALTER TABLE ClienteCuentaPrivilegio
ADD CONSTRAINT FK_ClienteCuentaPrivilegioCuenta
FOREIGN KEY (idCuenta) REFERENCES Cuenta(idCuenta)
GO
ALTER TABLE ClienteCuentaPrivilegio
ADD CONSTRAINT FK_ClienteCuentaPrivilegioCliente
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
GO
ALTER TABLE Cuenta
ADD CONSTRAINT FK_CuentaSucursal
FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
GO
ALTER TABLE Cuenta
ADD CONSTRAINT FK_CuentaUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Cuenta
ADD CONSTRAINT FK_CuentaUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Domiciliacion
ADD CONSTRAINT FK_DomiciliacionUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Domiciliacion
ADD CONSTRAINT FK_DomiciliacionUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Prestamo
ADD CONSTRAINT FK_PrestamoCliente
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
GO
ALTER TABLE Prestamo
ADD CONSTRAINT FK_PrestamoUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Prestamo
ADD CONSTRAINT FK_PrestamoUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Privilegio
ADD CONSTRAINT FK_PrivilegioUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Privilegio
ADD CONSTRAINT FK_PrivilegioUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Sucursal
ADD CONSTRAINT FK_SucursalUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE Sucursal
ADD CONSTRAINT FK_SucursalUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE CuentaDomiciliacion
ADD CONSTRAINT FK_CuentaDomiciliacionCuenta
FOREIGN KEY (idCuenta) REFERENCES Cuenta(idCuenta)
GO
ALTER TABLE CuentaDomiciliacion
ADD CONSTRAINT FK_CuentaDomiciliacionDomiciliacion
FOREIGN KEY (idDomiciliacion) REFERENCES Domiciliacion(idDomiciliacion)
GO
ALTER TABLE CuentaDomiciliacion
ADD CONSTRAINT FK_CuentaDomiciliacionUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE CuentaDomiciliacion
ADD CONSTRAINT FK_CuentaDomiciliacionUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE ClienteCuenta
ADD CONSTRAINT FK_ClienteCuentaCliente
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
GO
ALTER TABLE ClienteCuenta
ADD CONSTRAINT FK_ClienteCuentaCuenta
FOREIGN KEY (idCuenta) REFERENCES Cuenta(idCuenta)
GO
ALTER TABLE ClienteCuenta
ADD CONSTRAINT FK_ClienteCuentaUsuarioCrea 
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(idUsuario)
GO
ALTER TABLE ClienteCuenta
ADD CONSTRAINT FK_ClienteCuentaUsuarioModifica 
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(idUsuario)
GO



