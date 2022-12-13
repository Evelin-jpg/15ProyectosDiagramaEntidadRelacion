use master;
go 
If DB_ID (N'AgenciaDeViajesII') is not Null
Drop database AgenciaDeViajesII;
GO
Create database AgenciaDeViajesII
on
(
	Name = AgenciaViajesII_dat,
	FileName= 'C:\BaseDatos\AgenciaDeViajesII.mdf',
	Size = 10,
	MaxSize = 50,
	FileGrowth = 5
)
Log on
(
	Name = AgenciaDeViajesII_log,
	FileName = 'C:\BaseDatos\AgenciaDeViajesII.ldf',
	Size = 5MB,
	MaxSize = 25MB,
	FileGrowth = 5MB
);
go
use AgenciaViajesII;
go
Create Table CLIENTE 
(
	IdCliente int Not null,
	Nombre varchar (50) Not null,
	ApellidoPaterno varchar(50) Not null,
	ApellidoMaterno varchar (50) Not null,
	Telefono varchar (15) Not null,
	estatus bit default 1 Not null,
);
Create Table HOTEL
(
	IdHotel int Not null,
	Nombre varchar Not null,
	CodigoPostal varchar Not null,
	Calle varchar Not null,
	Colonia varchar Not null,
	Estatus bit default 1 Not null
);
Create Table PUNTORUTA
(
	IdPuntoRuta int Not null,
	descripcion varchar Not null,
	tipo varchar Not null,
	estatus bit default 1 Not null,
);
Create Table TOUR 
(
	IdTour int Not null,
	Fecha datetime Not null,
	Finalidad varchar Not null,
	Costo int not null,
	Estatus bit default 1 Not null
);
Create Table TIPOPUNTORUTA 
(
	IdTipoPuntoRuta int Not null,
	Nombre varchar Not null,
	Descripcion varchar Not null,
	Estatus bit default 1 Not null
);
Create Table TIPOTOUR
(
	IdTipoTour int Not null,
	Nombre varchar Not null,
	Descripcion varchar Not null,
	Estatus bit default 1 Not null
);
Create Table ClienteTour 
(
	IdClienteTour int Not null,
	IdCliente int Not null,
	IdTour int Not null,
	FechaTour datetime Not null,
	Estatus bit default 1 Not null
); 
Create Table ClienteHotel
(
	IdClienteHotel int Not null,
	IdCliente int Not null,
	IdHotel int Not null,
	FechaHospedaje datetime Not null,
	Estatus bit default 1 Not null
);
Create Table PuntoRutaTour
(
	IdPuntoRutaTour int Not null,
	IdPuntoRuta int Not null,
	IdTour int Not null,
	estatus bit default 1 Not null
);
--Llaves Primarias 
	Alter Table CLIENTE add constraint PK_CLIENTE primary key (IdCliente)
	Alter Table HOTEL add constraint PK_HOTEL primary key (IdHotel)
	Alter Table PUNTORUTA add constraint PK_PuntoRuta primary key (IdPuntoRuta)
	Alter Table TOUR add constraint PK_Tour primary key (IdTour)
	Alter Table TIPOPUNTORUTA add constraint PK_TipoPuntoRuta primary key (IdTipoPuntoRuta)
	Alter Table TIPOTOUR add constraint PK_TipoTour primary key(IdTipoTour)
	Alter Table CLIENTETOUR add constraint PK_ClienteTour primary key(IdClienteTour)
	Alter Table CLIENTEHOTEL add constraint PK_ClienteHotel primary key(IdClienteHotel)
	Alter Table PUNTORUTATOUR add constraint PK_PuntoRutaTour primary key(IdPuntoRutaTour)

	--Llaves foraneas 
		Alter Table HOTEL add constraint FK_HOTELTIPOPUNTORUTA foreign key (IdHotel)References
		TIPOPUNTORUTA(IdTipoPuntoRuta)
		Alter Table PUNTORUTA add constraint FK_PUNTORUTATIPOPUNTORUTA foreign key (IdPuntoRuta)References
		TIPOPUNTORUTA(IdTipoPuntoRuta)
		Alter Table TOUR add constraint FK_TOURTIPOTOUR foreign key(IdTour)References
		TIPOTOUR (idTipoTour)
		Alter Table ClienteHotel add constraint FK_CLIENTEHOTELCLIENTE foreign key (IdClienteHotel)References
		CLIENTE (IdCliente)
		Alter Table ClienteHotel add constraint FK_CLIENTEHOTELHOTEL foreign key (IdClienteHotel)References
		HOTEL (IdHotel)
		Alter Table ClienteTour add constraint FK_ClienteTourCliente foreign key(IdClienteTour)References
		Cliente (IdCliente)
		Alter Table ClienteTour add constraint FK_ClienteTourTour foreign key(IdClienteTour)References
		Tour (IdTour)
		Alter Table PuntoRutaTour add constraint FK_PuntoRutaTourTour foreign key (IdPuntoRutaTour)References
		Tour(IdTour)
		Alter Table PuntoRutaTour add constraint FK_PuntoRutaTourPuntoRuta foreign key (IdPuntoRutaTour)References
		PuntoRuta(IdPuntoRuta)

--Indices 
Create Index IX_Cliente on CLIENTE(IdCliente)
Create Index IX_Hotel on HOTEL(IdHotel)
Create Index IX_PUNTORUTA on PUNTORUTA(IdPuntoRuta)
Create Index IX_TOUR on TOUR(IdTour)
Create Index IX_TIPOPUNTORUTA ON TIPOPUNTORUTA(IdTipoPuntoRuta)
Create Index IX_TIPOTOUR on TIPOTOUR (IdTipoTour)
Create Index IX_CLIENTETOUR on CLIENTETOUR (IdClienteTour)
Create Index IX_CLIENTEHOTEL on CLIENTEHOTEL(IdClienteHotel)
Create Index IX_PUNTORUTATOUR on PUNTORUTATOUR (IdPuntoRutaTour)

