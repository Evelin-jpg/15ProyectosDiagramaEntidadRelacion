Create DataBase GestionDeTrabajoDeFinDeCarrera
use master;
go
If DB_ID (N'GestionDeTrabajoDeFinDeCarrera') is not Null
Drop DataBase GestionDeTrabajoDeFinDeCarrera;
go
Create DataBase GestionDeTrabajoDeFinDeCarrera
ON
(Name =GestionDeTrabajoDeFinDeCarrera_dat,
	FileName ='C:\BaseDatos\GestionDeTrabajoDeFinDeCarrera.mdf',
	size=10,
	Maxsize = 50,
	Filegrowth =5)
Log On
( Name = GestionDeTrabajoDeFinDeCarrera_log,
	FileName = 'C:\BaseDatos\GestionDeTrabajoDeFinDeCarrera.ldf',
	Size = 5MB,
	MaxSize =25MB,
	Filegrowth = 5MB);
GO
Use GestionDeTrabajoDeFinDeCarrera;
Create Table ALUMNO
(
	IdAlumno int Not null,
	IdTFC int Not null,
	IdGrupo int Not null,
	NumeroMatricula int Not null,
	Nombre varchar(50) Not null,
	ApellidoPaterno varchar (50) Not null,
	ApellidoMaterno varchar (50) Not null,
	RFC varchar (50) Not null,
	FechaGrupo varchar (50) Not null,
	Estatus bit Default 1 Not null
);
go
Create Table GRUPO
(
	IdGrupo int Not null,
	NumeroGrupo int Not null,
	NumeroComponentes int Not null,
	Estatus bit Default 1 Not null
);
go
Create Table PROFESOR
(
	IdProfesor int Not null,
	IdTFC int Not null,
	Nombre varchar Not null,
	ApellidoPaterno varchar Not null,
	ApellidoMaterno varchar Not null,
	RFC varchar Not null,
	NumeroExterior int Not null,
	NumeroInterior varchar Not null,
	Calle varchar Not null,
	Municipio varchar Not null,
	CP varchar Not null,
	Estatus bit Default 1 Not null
);
go
Create Table TFC
(
	IdTFC int Not Null,
	NumeroOrden int Not null,
	NombreTema varchar Not null,
	FechaComienzo varchar Not null,
	Estatus bit Default 1 Not null
);
go
Create Table TRIBUNAL
(
	IdTribunal int Not null,
	IdTFC int Not null,
	NumeroTribunal int Not null,
	LugarExamen varchar Not null,
	FechaDefine datetime Not null,
	NumeroComponetes int Not null,
	Estatus bit Default 1 Not null
);

--Llaves primarias 
Alter Table ALUMNO add conStraint PK_ALUMNO primary key (IdAlumno)
Alter Table GRUPO add constraint PK_GRUPO primary key (IdGrupo)
Alter Table PROFESOR add constraint PK_PROFESOR primary key (IdProfesor)
Alter Table TFC add constraint PK_TFC primary key (IdTFC)
Alter Table TRIBUNAL add constraint PK_TRIBUANAL primary key(IdTribunal)

--Llaves Foraneas 
Alter Table ALUMNO add constraint FK_AlumnoTFC foreign key (IdAlumno)References
TFC(IdTFC)
Alter Table ALUMNO add constraint FK_AlumnoGrupo foreign key (IdAlumno)References
GRUPO (IdGrupo)
Alter Table ALUMNO add constraint FK_AlumnoProfesor foreign key (IdAlumno) References
PROFESOR(IdProfesor)
Alter Table PROFESOR add constraint FK_ProfesorTFC foreign key (IdProfesor)References
TFC(IdTFC)
Alter Table TRIBUNAL add constraint FK_TribunalTFC foreign key (IdTribunal)References
TFC(IdTFC)
Alter Table TRIBUNAL add constraint FK_TribunalProfesor foreign key (IdTribunal)References
PROFESOR(IdProfesor)
--Indice 
Create Index IX_Alumno on ALUMNO (IdAlumno)
Create Index IX_Grupo on GRUPO (IdGrupo)
Create Index IX_Profesor on PROFESOR (IdProfesor)
Create Index IX_TFC on TFC (IdTFC)
Create Index IX_Tribunal on TRIBUNAL (IdTribunal)
