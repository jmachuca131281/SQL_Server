USE [master]
GO
/****** Object:  Database [BASEADACURSO]    Script Date: 21/06/2019 16:42:34 ******/
CREATE DATABASE [BASEADACURSO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BASEADACURSO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\BASEADACURSO.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BASEADACURSO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\BASEADACURSO_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BASEADACURSO] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BASEADACURSO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BASEADACURSO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BASEADACURSO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BASEADACURSO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BASEADACURSO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BASEADACURSO] SET ARITHABORT OFF 
GO
ALTER DATABASE [BASEADACURSO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BASEADACURSO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BASEADACURSO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BASEADACURSO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BASEADACURSO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BASEADACURSO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BASEADACURSO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BASEADACURSO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BASEADACURSO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BASEADACURSO] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BASEADACURSO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BASEADACURSO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BASEADACURSO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BASEADACURSO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BASEADACURSO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BASEADACURSO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BASEADACURSO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BASEADACURSO] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BASEADACURSO] SET  MULTI_USER 
GO
ALTER DATABASE [BASEADACURSO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BASEADACURSO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BASEADACURSO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BASEADACURSO] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BASEADACURSO] SET DELAYED_DURABILITY = DISABLED 
GO
USE [BASEADACURSO]
GO
/****** Object:  Table [dbo].[USUARIO2]    Script Date: 21/06/2019 16:42:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USUARIO2](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombres_y_Apellidos] [varchar](50) NULL,
	[Login] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[Icono] [image] NULL,
	[Nombre_de_icono] [varchar](max) NULL,
	[Correo] [varchar](max) NULL,
	[Rol] [varchar](max) NULL,
 CONSTRAINT [PK_USUARIO2] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[buscar_usuario]    Script Date: 21/06/2019 16:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[buscar_usuario]
@letra varchar(50)
as
select  idUsuario,Nombres_y_Apellidos AS Nombres,Login,Password
,Icono ,Nombre_de_icono ,Correo ,rol  FROM USUARIO2

where Nombres_y_Apellidos + Login      LIKE '%'+ @letra +'%'
GO
/****** Object:  StoredProcedure [dbo].[editar_usuario]    Script Date: 21/06/2019 16:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[editar_usuario]
@idUsuario int,
@nombres varchar(50) ,
@Login varchar(50),
@Password VARCHAR(50),
@Icono image,
@Nombre_de_icono varchar(max),
@Correo varchar(max),
@Rol varchar(max)
as
if exists (select Login,idUsuario  FROM USUARIO2 where (Login=@Login and idUsuario <>@idUsuario )  or (Nombres_y_Apellidos =@nombres and idUsuario <>@idUsuario ))
raiserror('YA EXISTE UN USUARIO CON ESE LOGIN O CON ESE ICONO, POR FAVOR INGRESE DE NUEVO',16,1 )

ELSE

update USUARIO2 set Nombres_y_Apellidos=@nombres ,Password =@Password , Icono=@Icono ,Nombre_de_icono =@Nombre_de_icono
 ,Correo =@Correo , Rol=@rol , Login =@Login
 where idUsuario=@idUsuario 

GO
/****** Object:  StoredProcedure [dbo].[eliminar_usuario]    Script Date: 21/06/2019 16:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[eliminar_usuario]
@idusuario int,
@login varchar(50)
as
if exists(select login from USUARIO2 where @login ='admin')
raiserror('El Usuario *Admin* es Inborrable, si se borraria Eliminarias el Acceso al Sistema de porvida, Accion Denegada', 16,1)
else
delete from USUARIO2 where idUsuario =@idusuario and Login <>'admin'
GO
/****** Object:  StoredProcedure [dbo].[insertar_usuario]    Script Date: 21/06/2019 16:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[insertar_usuario]
@nombres varchar(50) ,
@Login varchar(50),
@Password VARCHAR(50),
@Icono image,
@Nombre_de_icono varchar(max),
@Correo varchar(max),
@Rol varchar(max)
as
if exists (select Login FROM USUARIO2 where Login=@Login and Nombre_de_icono=@Nombre_de_icono)
raiserror('YA EXISTE UN USUARIO CON ESE LOGIN O CON ESE ICONO, POR FAVOR INGRESE DE NUEVO',16,1 )
ELSE

insert into USUARIO2 
values(@nombres,@Login,@Password,@Icono,@Nombre_de_icono,@Correo,@Rol )

GO
/****** Object:  StoredProcedure [dbo].[mostrar_usuario]    Script Date: 21/06/2019 16:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[mostrar_usuario]
as
select  idUsuario,Nombres_y_Apellidos AS Nombres,Login,Password
,Icono ,Nombre_de_icono ,Correo ,rol  FROM USUARIO2
GO
USE [master]
GO
ALTER DATABASE [BASEADACURSO] SET  READ_WRITE 
GO
