CREATE DATABASE ConsecionariaAutos;
USE master;
GO
IF DB_ID(N'AgenciaAutos')IS NOT NULL
DROP DATABASE ConsecionariaAutos;
GO
CREATE DATABASE ConsecionariaAutos
ON
(NAME = ConsecionariaAutos_dat,
FILENAME= 'C:\BaseDatos\ConsecionariaAutos.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME =ConsecionariaAutos_log,
FILENAME = 'C:\BaseDatos\ConsecionariaAutos.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE ConsecionariaAutos;
GO
CREATE TABLE Cliente
(
idCliente INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
numero INT NOT NULL,
direccion VARCHAR (50) NOT NULL,
rfc VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Opcion
(
idOpcion INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
descripcion VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Usado
(
idUsado INT NOT NULL,
idCliente INT NOT NULL,
Marca VARCHAR (50) NOT NULL,
Matricula VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Vendedor
(
idVendedor INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
direccion VARCHAR (50) NOT NULL,
rfc VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE vehiculo
(
idVehiculo INT NOT NULL,
Precio	int NOT NULL,
marca VARCHAR (50) NOT NULL,
Modelo VARCHAR (50) NOT NULL,
Cilindros INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Venta
(
idVenta INT NOT NULL,
idVendedor INT NOT NULL,
idVehiculo INT NOT NULL,
idCliente INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE VehiculoOpcion
(
idVehiculoOpcion INT NOT NULL,
idVehiculo INT NOT NULL,
idOpcion INT NOT NULL,
Precio INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE VentaOpcion
(
idVentaOpcion INT NOT NULL,
idVenta INT NOT NULL,
idOpcion INT NOT NULL,
Precio INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);

ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Opcion ADD CONSTRAINT PK_Opcion PRIMARY KEY (idOpcion)
ALTER TABLE Vendedor ADD CONSTRAINT PK_Vendedor PRIMARY KEY (idVendedor)
ALTER TABLE Vehiculo ADD CONSTRAINT PK_Vehiculo PRIMARY KEY (idVehiculo)
ALTER TABLE Venta ADD CONSTRAINT PK_Auto PRIMARY KEY (idVenta)

ALTER TABLE Usado
ADD CONSTRAINT FK_UsadoCliente
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente);
GO
ALTER TABLE Venta
ADD CONSTRAINT FK_VentaCliente
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente);
GO
ALTER TABLE Venta
ADD CONSTRAINT FK_VentaVendedor
FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor);
GO
ALTER TABLE Venta
ADD CONSTRAINT FK_VentaVehiculo
FOREIGN KEY (idVehiculo) REFERENCES Vehiculo(idVehiculo);
GO
ALTER TABLE VehiculoOpcion
ADD CONSTRAINT FK_VehiculoOpcionVehiculo
FOREIGN KEY (idVehiculo) REFERENCES Vehiculo(idVehiculo);
GO
ALTER TABLE VehiculoOpcion
ADD CONSTRAINT FK_VehiculoOpcionOpcion
FOREIGN KEY (idOpcion) REFERENCES Opcion(idOpcion);
GO
ALTER TABLE VentaOpcion
ADD CONSTRAINT FK_VentaOpcionVenta
FOREIGN KEY (idVenta) REFERENCES Venta(idVenta);
GO
ALTER TABLE VentaOpcion
ADD CONSTRAINT FK_VentaOpcionOpcion
FOREIGN KEY (idOpcion) REFERENCES Opcion(idOpcion);
GO

CREATE INDEX IX_Cliente ON Cliente(idCliente);
GO
CREATE INDEX IX_Opcion ON Opcion(idOpcion);
GO
CREATE INDEX IX_Vendedor ON Vendedor(idVendedor);
GO
CREATE INDEX IX_Vehiculo ON Vehiculo(idVehiculo);
GO
CREATE INDEX IX_Venta ON Venta(idVenta);
GO