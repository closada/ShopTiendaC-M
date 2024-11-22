USE [master]
GO
/****** Object:  Database [SHOPTIENDAC&M]    Script Date: 08/11/2024 19:04:29 ******/
CREATE DATABASE [SHOPTIENDAC&M]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VENTAS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SHOPTIENDAC&M.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VENTAS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SHOPTIENDAC&M_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SHOPTIENDAC&M] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SHOPTIENDAC&M].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SHOPTIENDAC&M] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET ARITHABORT OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET  MULTI_USER 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SHOPTIENDAC&M] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SHOPTIENDAC&M] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SHOPTIENDAC&M] SET QUERY_STORE = ON
GO
ALTER DATABASE [SHOPTIENDAC&M] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SHOPTIENDAC&M]
GO
/****** Object:  User [tluduena]    Script Date: 08/11/2024 19:04:29 ******/
CREATE USER [tluduena] FOR LOGIN [tluduena] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [profesor]    Script Date: 08/11/2024 19:04:29 ******/
CREATE USER [profesor] FOR LOGIN [profesor] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [macosta]    Script Date: 08/11/2024 19:04:29 ******/
CREATE USER [macosta] FOR LOGIN [macosta] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [consultuser]    Script Date: 08/11/2024 19:04:29 ******/
CREATE USER [consultuser] FOR LOGIN [consult] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [closada]    Script Date: 08/11/2024 19:04:29 ******/
CREATE USER [closada] FOR LOGIN [closada] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Administ]    Script Date: 08/11/2024 19:04:29 ******/
CREATE USER [Administ] FOR LOGIN [administ] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [Consultor]    Script Date: 08/11/2024 19:04:29 ******/
CREATE ROLE [Consultor]
GO
/****** Object:  DatabaseRole [Administrador]    Script Date: 08/11/2024 19:04:29 ******/
CREATE ROLE [Administrador]
GO
ALTER ROLE [Administrador] ADD MEMBER [tluduena]
GO
ALTER ROLE [Administrador] ADD MEMBER [profesor]
GO
ALTER ROLE [Administrador] ADD MEMBER [macosta]
GO
ALTER ROLE [Consultor] ADD MEMBER [consultuser]
GO
ALTER ROLE [Administrador] ADD MEMBER [closada]
GO
ALTER ROLE [Administrador] ADD MEMBER [Administ]
GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE](
	[ID_CLIENTE] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
	[APELLIDO] [varchar](50) NOT NULL,
	[DNI] [varchar](15) NOT NULL,
	[EDAD] [int] NULL,
	[DOMICILIO] [varchar](100) NULL,
	[ID_LOCALIDAD] [int] NULL,
 CONSTRAINT [PK_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[ID_CLIENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[ID_PRODUCTO] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NOT NULL,
	[ID_CATEGORIA] [int] NOT NULL,
	[PRECIO] [decimal](10, 2) NOT NULL,
	[STOCK] [int] NOT NULL,
	[ID_MARCA] [int] NOT NULL,
 CONSTRAINT [PK_PRODUCTO] PRIMARY KEY CLUSTERED 
(
	[ID_PRODUCTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VENTA]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VENTA](
	[ID_VENTA] [int] IDENTITY(1,1) NOT NULL,
	[FECHA_PEDIDO] [date] NOT NULL,
	[ID_CLIENTE] [int] NOT NULL,
	[FECHA_ENTREGA] [date] NULL,
 CONSTRAINT [PK_VENTA] PRIMARY KEY CLUSTERED 
(
	[ID_VENTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PEDIDO]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PEDIDO](
	[ID_PEDIDO] [int] IDENTITY(1,1) NOT NULL,
	[ID_VENTA] [int] NOT NULL,
	[ID_PRODUCTO] [int] NOT NULL,
	[CANTIDAD] [int] NOT NULL,
 CONSTRAINT [PK_PEDIDO] PRIMARY KEY CLUSTERED 
(
	[ID_PEDIDO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_ENTREGAS_PENDIENTES]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ventas que aún tienen su entrega pendiente */
create view [dbo].[VW_ENTREGAS_PENDIENTES] as
select	max(c.nombre) + ' ' + max(c.apellido)			as nombre_cliente,
		max(c.dni)										as dni_cliente,
		sum(p.cantidad)									as cantidad_total,
		STRING_AGG(pr.nombre, ', ')						as nombre_producto,
		max(v.fecha_pedido)								as fecha_compra,
		DATEDIFF(DAY, max(v.fecha_pedido), getdate())	as dias_demora
from	venta v
		inner join pedido p		on v.id_venta = p.id_venta
		inner join producto pr	on p.id_producto = pr.id_producto
		inner join cliente c	on v.id_cliente = c.id_cliente
where	v.fecha_entrega is null
group by v.id_venta;
GO
/****** Object:  Table [dbo].[MARCA]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARCA](
	[ID_MARCA] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_MARCA] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MARCA] PRIMARY KEY CLUSTERED 
(
	[ID_MARCA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_PROD_MAS_VENDIDO]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* TOP producto más vendido */
create view [dbo].[VW_PROD_MAS_VENDIDO] as
select	top 1 
		pr.nombre										as nombre_producto,
		max(m.nombre_marca)								as marca_producto,
		sum(p.cantidad)									as cantidad
from	venta v
		inner join pedido p		on v.id_venta = p.id_venta
		inner join producto pr	on p.id_producto = pr.id_producto
		inner join marca m		on pr.id_marca = m.id_marca
group by pr.id_producto, pr.nombre
order by sum(p.cantidad) desc;
GO
/****** Object:  Table [dbo].[LOCALIDAD]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOCALIDAD](
	[ID_LOCALIDAD] [int] IDENTITY(1,1) NOT NULL,
	[CODIGO] [varchar](10) NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
 CONSTRAINT [PK_LOCALIDAD] PRIMARY KEY CLUSTERED 
(
	[ID_LOCALIDAD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_CLIENTES_PREMIUM]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* TOP 3 clientes que compraron más productos */
create view [dbo].[VW_CLIENTES_PREMIUM] as
select	c2.apellido + ', ' + c2.nombre			as nombre_cliente,
		c2.dni									as dni,
		c2.edad									as edad,
		c2.domicilio							as direccion,
		l.nombre + ' (' + l.codigo + ')'		as localidad,
		cli.cantidad
from	(
		select	c.id_cliente,
				sum(p.cantidad)									as cantidad,
				rank() over (order by sum(p.cantidad) desc)		as ranking
		from	venta v
				inner join cliente c	on v.id_cliente = c.id_cliente
				inner join pedido p		on v.id_venta = p.id_venta
		group by c.id_cliente
		) cli
		inner join cliente c2	on cli.id_cliente = c2.id_cliente
		inner join localidad l	on c2.id_localidad = l.id_localidad
where	cli.ranking <= 3;
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA](
	[ID_CATEGORIA] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_CATEGORIA] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CATEGORIA] PRIMARY KEY CLUSTERED 
(
	[ID_CATEGORIA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_CAT_MAS_VENDIDA]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Categoria que tiene más productos vendidos */
create view [dbo].[VW_CAT_MAS_VENDIDA] as
select	top 1
		c.nombre_categoria		as nombre_categoria,
		sum(p.cantidad)			as cantidad_ventas
from	venta v
		inner join pedido p		on v.id_venta = p.id_venta
		inner join producto pr	on p.id_producto = pr.id_producto
		inner join categoria c	on pr.id_categoria = c.id_categoria
group by c.id_categoria, c.nombre_categoria
order by sum(p.cantidad) desc;
GO
/****** Object:  View [dbo].[VW_ENTREGAS_DEMORADAS]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ventas que su entrega demoró mas de 10 días */
create view [dbo].[VW_ENTREGAS_DEMORADAS] as
select	c.dni													as documento_cliente,
		max(c.apellido) + ', ' + max(c.nombre)					as cliente,
		max(l.nombre) + ' (' + max(l.codigo) + ')'				as localidad,
		max(v.fecha_pedido)										as fecha_compra,
		max(v.fecha_entrega)									as fecha_entrega,
		datediff(day,max(fecha_pedido),max(fecha_entrega))		as dias_demora,
		sum(p.cantidad)											as cantidad_total_productos,
		STRING_AGG(pr.nombre, ', ')								as nombre_productos
from	venta v
		inner join cliente c	on v.id_cliente = c.id_cliente
		inner join pedido p		on v.id_venta = p.id_venta
		inner join producto pr	on p.id_producto = pr.id_producto
		inner join localidad l	on c.id_localidad = l.id_localidad
where	v.fecha_entrega is not null
  and	datediff(day,fecha_pedido,fecha_entrega) > 10
group by v.id_venta, c.id_cliente, c.dni;
GO
/****** Object:  View [dbo].[VW_VENTAS_LOCALIDAD]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* creacion de ventas de localidades */
create view [dbo].[VW_VENTAS_LOCALIDAD] as
select	count (distinct venta.id_venta) as cantidad_ventas,
		localidad.nombre
from	venta
		inner join cliente on venta.id_cliente = cliente.id_cliente
		inner join localidad on localidad.id_localidad = cliente.id_localidad
group by localidad.nombre;
GO
/****** Object:  Table [dbo].[AUDIT_PRODUCTO]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AUDIT_PRODUCTO](
	[AUDITORIA_ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_PRODUCTO] [int] NOT NULL,
	[ACCION] [varchar](50) NOT NULL,
	[FECHA] [datetime] NOT NULL,
	[COMENTARIOS] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AUDITORIA_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AUDIT_VENTA]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AUDIT_VENTA](
	[AUDITORIA_ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_VENTA] [int] NOT NULL,
	[ACCION] [varchar](50) NOT NULL,
	[FECHA] [datetime] NOT NULL,
	[COMENTARIOS] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AUDITORIA_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_CLIENTE]    Script Date: 08/11/2024 19:04:29 ******/
CREATE NONCLUSTERED INDEX [IDX_CLIENTE] ON [dbo].[CLIENTE]
(
	[ID_CLIENTE] ASC,
	[DNI] ASC,
	[NOMBRE] ASC,
	[APELLIDO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_PRODUCTO]    Script Date: 08/11/2024 19:04:29 ******/
CREATE NONCLUSTERED INDEX [IDX_PRODUCTO] ON [dbo].[PRODUCTO]
(
	[ID_PRODUCTO] ASC,
	[NOMBRE] ASC,
	[ID_CATEGORIA] ASC,
	[ID_MARCA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CLIENTE]  WITH CHECK ADD  CONSTRAINT [FK_CLIENTE_LOCALIDAD] FOREIGN KEY([ID_LOCALIDAD])
REFERENCES [dbo].[LOCALIDAD] ([ID_LOCALIDAD])
GO
ALTER TABLE [dbo].[CLIENTE] CHECK CONSTRAINT [FK_CLIENTE_LOCALIDAD]
GO
ALTER TABLE [dbo].[PEDIDO]  WITH CHECK ADD  CONSTRAINT [FK_PEDIDO_PRODUCTO] FOREIGN KEY([ID_PRODUCTO])
REFERENCES [dbo].[PRODUCTO] ([ID_PRODUCTO])
GO
ALTER TABLE [dbo].[PEDIDO] CHECK CONSTRAINT [FK_PEDIDO_PRODUCTO]
GO
ALTER TABLE [dbo].[PEDIDO]  WITH CHECK ADD  CONSTRAINT [FK_PEDIDO_VENTA] FOREIGN KEY([ID_VENTA])
REFERENCES [dbo].[VENTA] ([ID_VENTA])
GO
ALTER TABLE [dbo].[PEDIDO] CHECK CONSTRAINT [FK_PEDIDO_VENTA]
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTO_CATEGORIA] FOREIGN KEY([ID_CATEGORIA])
REFERENCES [dbo].[CATEGORIA] ([ID_CATEGORIA])
GO
ALTER TABLE [dbo].[PRODUCTO] CHECK CONSTRAINT [FK_PRODUCTO_CATEGORIA]
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTO_MARCA] FOREIGN KEY([ID_MARCA])
REFERENCES [dbo].[MARCA] ([ID_MARCA])
GO
ALTER TABLE [dbo].[PRODUCTO] CHECK CONSTRAINT [FK_PRODUCTO_MARCA]
GO
ALTER TABLE [dbo].[VENTA]  WITH CHECK ADD  CONSTRAINT [FK_VENTA_CLIENTE] FOREIGN KEY([ID_CLIENTE])
REFERENCES [dbo].[CLIENTE] ([ID_CLIENTE])
GO
ALTER TABLE [dbo].[VENTA] CHECK CONSTRAINT [FK_VENTA_CLIENTE]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREAR_CLIENTE]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************************/
/* CREAR SPs */
CREATE PROCEDURE [dbo].[SP_CREAR_CLIENTE](
									@nombre varchar(50), 
									@apellido varchar(50), 
									@dni varchar(15), 
									@edad int,
									@domicilio varchar(100), 
									@cod_localidad varchar(10)
								)
AS
BEGIN
	/* valido algunos campos */
	IF @edad < 18 Or @edad > 99
	BEGIN
		PRINT 'Edad invalida'
		return -1
	END
	/* inserto el campo */
	INSERT
	INTO	CLIENTE (nombre,apellido,dni,edad, domicilio, id_localidad)
	SELECT	@nombre			as nombre,
			@apellido		as apellido,
			@dni			as dni,
			@edad			as edad,
			@domicilio		as domicilio,
			l.id_localidad	as id_localidad
	FROM	localidad l
	where	l.codigo = @cod_localidad
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTAR_VENTA]    Script Date: 08/11/2024 19:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERTAR_VENTA]	(
									/* PARAMETROS DEL CLIENTE */
									@nombre varchar(50), 
									@apellido varchar(50), 
									@dni varchar(15), 
									@edad int,
									@domicilio varchar(100), 
									@cod_localidad varchar(10),

									/* PARAMETROS DEL PEDIDO*/
									@id_producto int,
									@cantidad int,

									/* PARAMETROS DE LA VENTA */
									@fecha_pedido date
									)
AS
BEGIN
	DECLARE @IdCliente INT=-1;
	DECLARE @IdVenta INT=-1;
	DECLARE @Stock INT=-1;

	/* Valido que cantidad sea > 1 y dentro del stock posible */
	SELECT @Stock = STOCK FROM PRODUCTO WHERE ID_PRODUCTO = @id_producto;
	PRINT 'STOCK DEL PRODUCTO: ' + cast(@Stock as varchar(50))

	IF @cantidad < 1 Or (@cantidad > @stock)
	BEGIN
		PRINT 'Cantidad invalida para insertar el pedido'
		RETURN -1
	END

	/* 1 VER SI EXISTE CLIENTE Y SI NO, CREARLO */
	SELECT @IdCliente = ID_CLIENTE FROM CLIENTE WHERE DNI = @dni;

	IF @IdCliente = -1
	BEGIN
		PRINT 'Se crea el cliente nuevo'
		EXEC SP_CREAR_CLIENTE @nombre, @apellido, @dni, @edad, @domicilio, @cod_localidad
	END

	SELECT @IdCliente = ID_CLIENTE FROM CLIENTE WHERE DNI = @dni;
	PRINT 'ID DEL CLIENTE: ' + cast(@IdCliente as varchar(50))
	
	/* 2 INSERTAR VENTA */
	INSERT
	INTO	VENTA (fecha_pedido, id_cliente)
	VALUES	(@fecha_pedido, @IdCliente);

	SELECT @IdVenta = ID_VENTA FROM VENTA WHERE fecha_pedido = @fecha_pedido and id_cliente = @IdCliente;
	PRINT 'ID VENTA CREADO: ' + cast(@IdVenta as varchar(50))
		
	/* 3 INSERTAR PEDIDO */
	INSERT
	INTO	PEDIDO	(id_venta, id_producto, cantidad)
	VALUES			(@IdVenta, @id_producto, @cantidad)
	
	/* MODIFICAR CANTIDAD DE STOCK EN LA TABLA PRODUCTO */
	UPDATE	PRODUCTO
	SET		STOCK = (@Stock - @cantidad)
	WHERE	id_producto = @id_producto;
END
GO
USE [master]
GO
ALTER DATABASE [SHOPTIENDAC&M] SET  READ_WRITE 
GO
