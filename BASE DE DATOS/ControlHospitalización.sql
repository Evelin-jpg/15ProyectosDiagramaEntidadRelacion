--SQL
USE master;
GO
IF DB_ID (N'ControlHospitalizacion') IS NOT NULL
DROP DATABASE ControlHospitalizacion;
GO
CREATE DATABASE ControlHospitalizacion 
ON 
(NAME = ControlHospitalizacion_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ControlHospitalizacion.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME = ControlHospitalizacion_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ControlHospitalizacion.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE ControlHospitalizacion;
GO
---------------------TABLAS------------------
CREATE TABLE Cama
(
idCama int IDENTITY(1,1),
numero char (10) not null,
idPlanta int null,
estatus bit default 1 not null,
);
CREATE TABLE Diagnostico
(
idDiagnostico int IDENTITY(1,1),
codigo char (10) not null,
descripcion varchar (50) not null,
estatus bit default 1 not null,
);
CREATE TABLE Medico
(
idMedico int IDENTITY (1,1),
nombre varchar (50) not null,
apellidoPaterno varchar (50) not null,
apellidoMaterno varchar (50) not null,
numficha varchar (30) not null,
estatus bit default 1 not null,
);
CREATE TABLE Paciente
(
idPaciente int IDENTITY (1,1),
NSS char (30) not null,
RFC char (30) not null,
fechaNacimiento varchar (20) not null, 
nombre varchar (50) not null,
apellidoPaterno varchar (50) not null,
apellidoMaterno varchar (50) not null,
estatus bit default 1 not null,
);
CREATE TABLE Pase
(
idPase int IDENTITY (1,1),
numero varchar (30) not null,
horaInicio datetime not null,
horaFinal datetime not null,
idPaciente int null,
estatus bit default 1 not null,
);
CREATE TABLE Planta
(
idPlanta int IDENTITY (1,1),
numero varchar (30) not null,
nombre varchar (50) not null,
numdeCamas varchar (10) not null,
estatus bit default 1 not null,
);
CREATE TABLE DiagnosticoMedico
(
idDiagnosticoMedico int IDENTITY (1,1),
idDiagnostico int null,
idMedico int null,
estatus bit default 1 not null,
);
CREATE TABLE PacienteDiagnostico
(
idPacienteDiagnostico int IDENTITY (1,1),
idPaciente int null,
idDiagnostico int null,
fecha datetime not null,
estatus bit default 1 not null,
);
CREATE TABLE PacienteMedico
(
idPacienteMedico int IDENTITY (1,1),
idPaciente int null,
idMedico int null,
fecha datetime not null,
estatus bit default 1 not null,
);
CREATE TABLE PacienteCama
(
idPacienteCama int IDENTITY (1,1),
idPaciente int null,
idCama int null,
fecha datetime not null,
estatus bit default 1 not null,
);
GO
------------------------LLAVES PRIMARIAS-----------
ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY(idUsuario)
ALTER TABLE Cama ADD CONSTRAINT PK_Cama PRIMARY KEY(idCama)
ALTER TABLE Diagnostico ADD CONSTRAINT PK_Diagnostico PRIMARY KEY(idDiagnostico)
ALTER TABLE Medico ADD CONSTRAINT PK_Medico PRIMARY KEY (idMedico)
ALTER TABLE Paciente ADD CONSTRAINT PK_Paciente PRIMARY KEY (idPaciente)
ALTER TABLE Pase ADD CONSTRAINT PK_Pase PRIMARY KEY (idPase)
ALTER TABLE Planta ADD CONSTRAINT PK_Planta PRIMARY KEY (idPlanta)
------------------------------LLAVES FORANEAS-------------------
ALTER TABLE DiagnosticoMedico
ADD CONSTRAINT FK_DiagnosticoMedicoDiagnostico
FOREIGN KEY (idDiagnostico) REFERENCES Diagnostico(idDiagnostico);
GO
ALTER TABLE DiagnosticoMedico
ADD CONSTRAINT FK_DiagnosticoMedicoMedico
FOREIGN KEY (idMedico) REFERENCES Medico(idMedico);
GO
ALTER TABLE PacienteDiagnostico
ADD CONSTRAINT FK_PacienteDiagnosticoPaciente
FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente);
GO
ALTER TABLE PacienteDiagnostico
ADD CONSTRAINT FK_PacienteDiagnosticoDiagnostico
FOREIGN KEY (idDiagnostico) REFERENCES Diagnostico(idDiagnostico);
GO
ALTER TABLE PacienteMedico
ADD CONSTRAINT FK_PacienteMedicoPaciente
FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente);
GO
ALTER TABLE PacienteMedico
ADD CONSTRAINT FK_PacienteMedicoMedico
FOREIGN KEY (idMedico) REFERENCES Medico(idMedico);
GO
ALTER TABLE PacienteCama
ADD CONSTRAINT FK_PacienteCamaPaciente
FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente);
GO
ALTER TABLE PacienteCama
ADD CONSTRAINT FK_PacienteCamaCama
FOREIGN KEY (idCama) REFERENCES Cama(idCama);
GO