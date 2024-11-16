BEGIN TRANSACTION;
DROP TABLE IF EXISTS "peliculas_generos";
/*****************************************************************************************/
/************************************* Creacion de tablas ********************************/
/* Localidad */
if exists				(
						select	* 
						from	sys.tables t 
						where	t.name= 'LOCALIDAD'
						)
DROP TABLE LOCALIDAD;
CREATE TABLE LOCALIDAD	(
						ID_LOCALIDAD INTEGER IDENTITY(1,1) NOT NULL,
						CODIGO VARCHAR(10) NOT NULL,
						NOMBRE VARCHAR(50) NOT NULL

						CONSTRAINT PK_LOCALIDAD PRIMARY KEY (ID_LOCALIDAD)
						) ON [PRIMARY]
						GO

/* Rol */
if exists				(
						select	* 
						from	sys.tables t 
						where	t.name= 'ROL'
						)
DROP TABLE ROL;
CREATE TABLE ROL	(
						ID_ROL INTEGER IDENTITY(1,1) NOT NULL,
						CODIGO VARCHAR(10) NOT NULL,
						NOMBRE VARCHAR(50) NOT NULL

						CONSTRAINT PK_ROL PRIMARY KEY (ID_ROL)
						) ON [PRIMARY]


/* USUARIO */
if exists			(
						select	* 
						from	sys.tables t 
						where	t.name= 'USUARIO'
						)
DROP TABLE USUARIO;
CREATE TABLE USUARIO	(
						ID_USUARIO INTEGER IDENTITY(1,1) NOT NULL,
						NOMBRE VARCHAR(50) NOT NULL,
						APELLIDO VARCHAR(50) NOT NULL,
						DNI VARCHAR(15) NOT NULL,
						EDAD INTEGER NULL,
						EMAIL VARCHAR(50) NOT NULL,
						DOMICILIO VARCHAR(100) NULL,
						ID_LOCALIDAD INTEGER,
						ID_ROL INTEGER NOT NULL,
						TOKEN VARCHAR(255) NULL,
						

						CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO),
						CONSTRAINT FK_USUARIO_LOCALIDAD FOREIGN KEY (ID_LOCALIDAD) REFERENCES LOCALIDAD (ID_LOCALIDAD),
						CONSTRAINT FK_USUARIO_ROL FOREIGN KEY (ID_ROL) REFERENCES ROL(ID_ROL)
						) ON [PRIMARY]
						GO

/* Marca */
if exists			(
						select	* 
						from	sys.tables t 
						where	t.name= 'MARCA'
						)
DROP TABLE MARCA;
CREATE TABLE MARCA		(
						ID_MARCA INTEGER IDENTITY (1,1) NOT NULL,
						NOMBRE_MARCA VARCHAR(50) NOT NULL,
						
						CONSTRAINT PK_MARCA PRIMARY KEY (ID_MARCA)
						)ON [PRIMARY]
						GO

/* Categoria */
if exists			(
						select	* 
						from	sys.tables t 
						where	t.name= 'CATEGORIA'
						)
DROP TABLE CATEGORIA;
CREATE TABLE CATEGORIA	(
						ID_CATEGORIA INTEGER IDENTITY (1,1) NOT NULL,
						NOMBRE_CATEGORIA VARCHAR(50) NOT NULL,
						
						CONSTRAINT PK_CATEGORIA PRIMARY KEY (ID_CATEGORIA)
						)ON [PRIMARY]
						GO

/* Producto */
if exists			(
						select	* 
						from	sys.tables t 
						where	t.name= 'PRODUCTO'
						)
DROP TABLE PRODUCTO;
CREATE TABLE PRODUCTO	(
						ID_PRODUCTO INTEGER IDENTITY(1,1) NOT NULL,
						NOMBRE VARCHAR(100) NOT NULL,
						ID_CATEGORIA INTEGER NOT NULL,
						PRECIO DECIMAL(10, 2)NOT NULL,
						STOCK INTEGER NOT NULL,
						ID_MARCA INTEGER NOT NULL,

						CONSTRAINT PK_PRODUCTO PRIMARY KEY (ID_PRODUCTO),
						CONSTRAINT FK_PRODUCTO_CATEGORIA FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA (ID_CATEGORIA),
						CONSTRAINT FK_PRODUCTO_MARCA FOREIGN KEY (ID_MARCA) REFERENCES MARCA (ID_MARCA)
						) ON [PRIMARY]
						
						GO

/* Venta */
if exists			(
						select	* 
						from	sys.tables t 
						where	t.name= 'VENTA'
						)
DROP TABLE VENTA;
CREATE TABLE VENTA		(
						ID_VENTA INTEGER IDENTITY(1,1) NOT NULL,
						FECHA_PEDIDO DATE NOT NULL,
						ID_VENDEDOR INTEGER NOT NULL,
						ID_CLIENTE INTEGER NOT NULL,
						FECHA_ENTREGA DATE NULL,

						CONSTRAINT PK_VENTA PRIMARY KEY (ID_VENTA),
						CONSTRAINT FK_VENTA_VENDEDOR FOREIGN KEY (ID_VENDEDOR) REFERENCES USUARIO (ID_USUARIO),
						CONSTRAINT FK_VENTA_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES USUARIO (ID_USUARIO)
						) ON [PRIMARY]
						

/* Pedido */
if exists			(
						select	* 
						from	sys.tables t 
						where	t.name= 'PEDIDO'
						)
DROP TABLE PEDIDO;					
CREATE TABLE PEDIDO		(
						ID_PEDIDO INTEGER IDENTITY(1,1) NOT NULL,
						ID_VENTA INTEGER NOT NULL,
						ID_PRODUCTO INTEGER NOT NULL,
						CANTIDAD INTEGER NOT NULL,

						CONSTRAINT PK_PEDIDO PRIMARY KEY (ID_PEDIDO),
						CONSTRAINT FK_PEDIDO_VENTA FOREIGN KEY (ID_VENTA) REFERENCES VENTA (ID_VENTA),
						CONSTRAINT FK_PEDIDO_PRODUCTO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO)
						) ON [PRIMARY]


/*****************************************************************************************/
/*************************************Inercion de datos **********************************/

/* rol */
INSERT
INTO	ROL (codigo,nombre)
VALUES	('ADM','Administrador'),
		('VEND','Vendedor'),
		('CLI','Cliente');


/* localidad */
INSERT
INTO	LOCALIDAD	(codigo, nombre)
VALUES	('CABA','Ciudad Autonoma de Buenos Aires'),
		('GBA', 'Gran Buenos Aires'),
		('CBA', 'Cordoba- Capital'),
		('SLN', 'San Luis- Capital'),
		('IGU', 'Iguazu');


INSERT INTO USUARIO (nombre, apellido, dni, edad, email, domicilio, id_localidad, id_rol, token)
VALUES
    ('Laura', 'Torres', '56789012', 28, 'laura.torres@email.com', 'Calle Luna 111', 1, 3, NULL),  -- Rol Cliente
    ('Carlos', 'Ramírez', '67890123', 32, 'carlos.ramirez@email.com', 'Calle Estrella 222', 2, 2, NULL),
    ('Sofía', 'Hernández', '78901234', 27, 'sofia.hernandez@email.com', 'Avenida del Mar 333', 3, 2, NULL),
    ('Andrés', 'Fernández', '89012345', 45, 'andres.fernandez@email.com', 'Calle del Río 444', 4, 1, NULL),
    ('Lucía', 'Castillo', '90123456', 31, 'lucia.castillo@email.com', 'Calle Verde 555', 5, 3, NULL),  -- Rol Cliente
    ('Javier', 'Moreno', '01234567', 38, 'javier.moreno@email.com', 'Calle del Cielo 666', 1, 1, NULL),
    ('Camila', 'Salas', '12345678', 29, 'camila.salas@email.com', 'Calle de la Luna 777', 2, 3, NULL),  -- Rol Cliente
    ('Diego', 'Rojas', '23456789', 34, 'diego.rojas@email.com', 'Avenida del Sol 888', 3, 1, NULL),
    ('Valentina', 'Cruz', '34567890', 24, 'valentina.cruz@email.com', 'Calle de la Paz 999', 4, 3, NULL),  -- Rol Cliente
    ('Fernando', 'Vázquez', '45678901', 50, 'fernando.vazquez@email.com', 'Calle de la Esperanza 1010', 5, 1, NULL),
    ('Natalia', 'Díaz', '56789013', 26, 'natalia.diaz@email.com', 'Calle de la Alegría 1111', 1, 3, NULL),  -- Rol Cliente
    ('Esteban', 'Castro', '67890124', 36, 'esteban.castro@email.com', 'Calle del Viento 1212', 2, 2, NULL),
    ('Clara', 'González', '78901235', 23, 'clara.gonzalez@email.com', 'Avenida de la Libertad 1313', 3, 3, NULL),  -- Rol Cliente
    ('Ricardo', 'Paredes', '89012346', 41, 'ricardo.paredes@email.com', 'Calle del Futuro 1414', 4, 2, NULL),
    ('Isabella', 'Maldonado', '90123457', 33, 'isabella.maldonado@email.com', 'Calle de la Unidad 1515', 5, 1, NULL),
    ('Luisana', 'Pinto', '01234568', 30, 'luisana.pinto@email.com', 'Calle del Águila 1616', 1, 3, NULL),  -- Rol Cliente
    ('Gustavo', 'Benitez', '12345679', 39, 'gustavo.benitez@email.com', 'Calle del Tigre 1717', 2, 1, NULL),
    ('Patricia', 'Cano', '23456780', 29, 'patricia.cano@email.com', 'Avenida del Fuego 1818', 3, 3, NULL),  -- Rol Cliente
    ('Victor', 'Acosta', '34567891', 42, 'victor.acosta@email.com', 'Calle del Eco 1919', 4, 1, NULL),
    ('Tania', 'Ceballos', '45678902', 25, 'tania.ceballos@email.com', 'Calle del Bosque 2020', 5, 2, NULL),
    ('Alberto', 'Moya', '56789014', 37, 'alberto.moya@email.com', 'Calle de la Montaña 2121', 1, 1, NULL),
    ('Cecilia', 'Mora', '67890125', 28, 'cecilia.mora@email.com', 'Calle del Agua 2222', 2, 2, NULL),
    ('Martín', 'Reyes', '78901236', 34, 'martin.reyes@email.com', 'Avenida de la Vida 2323', 3, 1, NULL),
    ('Gloria', 'Figueroa', '89012347', 49, 'gloria.figueroa@email.com', 'Calle del Árbol 2424', 4, 2, NULL),
    ('Fernando', 'Salazar', '90123458', 26, 'fernando.salazar@email.com', 'Calle de la Eternidad 2525', 5, 3, NULL),  -- Rol Cliente
    ('Mariano', 'Galindo', '01234569', 30, 'mariano.galindo@email.com', 'Calle del Silencio 2626', 1, 2, NULL),
    ('Sandra', 'Núñez', '12345680', 32, 'sandra.nunez@email.com', 'Calle del Destino 2727', 2, 3, NULL),  -- Rol Cliente
    ('Alina', 'Pérez', '23456781', 24, 'alina.perez@email.com', 'Avenida de los Ángeles 2828', 3, 1, NULL),
    ('Nicolás', 'Sotelo', '34567892', 40, 'nicolas.sotelo@email.com', 'Calle del Corazón 2929', 4, 3, NULL),  -- Rol Cliente
    ('Evelyn', 'Ríos', '45678903', 35, 'evelyn.rios@email.com', 'Calle del Deseo 3030', 5, 2, NULL),
    ('Samuel', 'Duarte', '56789015', 38, 'samuel.duarte@email.com', 'Calle del Canto 3131', 1, 1, NULL),
    ('Mariana', 'Cordero', '67890126', 27, 'mariana.cordero@email.com', 'Calle del Viaje 3232', 2, 3, NULL),  -- Rol Cliente
    ('Ricardo', 'Torres', '78901237', 33, 'ricardo.torres@email.com', 'Calle del Recuerdo 3333', 3, 2, NULL),
    ('Carolina', 'Alvarado', '89012348', 45, 'carolina.alvarado@email.com', 'Calle del Horizonte 3434', 4, 1, NULL),
    ('Ezequiel', 'Bravo', '90123459', 30, 'ezequiel.bravo@email.com', 'Calle de la Luz 3535', 5, 3, NULL),  -- Rol Cliente
    ('Selene', 'Valdés', '01234570', 29, 'selene.valdes@email.com', 'Calle de la Fuerza 3636', 1, 2, NULL),
    ('Gabriel', 'López', '12345681', 36, 'gabriel.lopez@email.com', 'Avenida del Amor 3737', 2, 1, NULL),
    ('Silvana', 'Mendoza', '23456782', 22, 'silvana.mendoza@email.com', 'Calle del Poder 3838', 3, 3, NULL),  -- Rol Cliente
    ('Héctor', 'Aguirre', '34567893', 41, 'hector.aguirre@email.com', 'Calle del Cambio 3939', 4, 1, NULL),
    ('Fabiola', 'Quintero', '45678904', 25, 'fabiola.quintero@email.com', 'Calle del Triunfo 4040', 5, 2, NULL);



/* categoria*/
INSERT 
INTO	categoria (nombre_categoria)
VALUES	('Computadoras'),
		('Teléfonos'),
		('Tablets'),
		('Audio'),
		('Wearables'),
		('Monitores'),
		('Periféricos'),
		('Cámaras'),
		('Almacenamiento');

/*marca*/
INSERT 
INTO	marca (nombre_marca)
VALUES	('HP'),
		('Samsung'),
		('Apple'),
		('Sony'),
		('Garmin'),
		('Dell'),
		('Logitech'),
		('Razer'),
		('Canon'),
		('Seagate'),
		('Lenovo'),
		('Xiaomi'),
		('Bose'),
		('ASUS'),
		('Corsair'),
		('Nikon'),
		('Acer'),
		('OnePlus'),
		('Microsoft'),
		('Fitbit'),
		('LG'),
		('HyperX'),
		('GoPro'),
		('Western Digital'),
		('Google'),
		('JBL'),
		('Mobvoi'),
		('BenQ'),
		('Fujifilm'),
		('Crucial'),
		('Oppo'),
		('Huawei'),
		('Sennheiser'),
		('Amazfit'),
		('AOC'),
		('SteelSeries'),
		('Panasonic'),
		('Toshiba');

/* producto */
INSERT 
INTO	producto (nombre, id_categoria, precio, stock, id_marca)
VALUES	('Laptop HP Pavilion', 1, 749.99, 20, 1),
		('Smartphone Samsung Galaxy S21', 2, 999.99, 50, 2),
		('Tablet Apple iPad Air', 3, 599.99, 30, 3),
		('Auriculares Sony WH-1000XM4', 4, 349.99, 15, 4),
		('Reloj Inteligente Garmin', 5, 249.99, 25, 5),
		('Monitor Dell UltraSharp', 6, 449.99, 10, 6),
		('Teclado Mecánico Logitech', 7, 129.99, 35, 7),
		('Mouse Inalámbrico Razer', 7, 79.99, 40, 8),
		('Cámara Canon EOS M50', 8, 649.99, 12, 9),
		('Disco Duro Externo Seagate', 9, 89.99, 60, 10),
		('Laptop Lenovo ThinkPad', 1, 849.99, 15, 11),
		('Smartphone Xiaomi Mi 11', 2, 749.99, 45, 12),
		('Tablet Samsung Galaxy Tab S7', 3, 499.99, 20, 2),
		('Auriculares Bose QuietComfort', 4, 299.99, 18, 13),
		('Reloj Inteligente Apple Watch', 5, 399.99, 30, 3),
		('Monitor ASUS ROG', 6, 699.99, 8, 14),
		('Teclado Gaming Corsair', 7, 149.99, 28, 15),
		('Mouse Logitech G502', 7, 89.99, 55, 7),
		('Cámara Nikon D3500', 8, 499.99, 10, 16),
		('Disco Duro SSD Samsung', 9, 129.99, 40, 2),
		('Laptop Acer Aspire', 1, 599.99, 25, 17),
		('Smartphone OnePlus 9', 2, 699.99, 35, 18),
		('Tablet Microsoft Surface Pro', 3, 899.99, 10, 19),
		('Auriculares Apple AirPods Pro', 4, 249.99, 50, 3),
		('Reloj Inteligente Fitbit Versa', 5, 199.99, 27, 20),
		('Monitor LG UltraFine', 6, 499.99, 12, 21),
		('Teclado Ergonomico Microsoft', 7, 99.99, 22, 19),
		('Mouse Gaming HyperX', 7, 69.99, 45, 22),
		('Cámara GoPro HERO9', 8, 399.99, 15, 23),
		('Disco Duro Externo WD My Passport', 9, 79.99, 55, 24),
		('Laptop ASUS ZenBook', 1, 1099.99, 8, 14),
		('Smartphone Google Pixel 5', 2, 699.99, 20, 25),
		('Tablet Lenovo Tab P11', 3, 349.99, 30, 11),
		('Auriculares JBL Club One', 4, 349.99, 10, 26),
		('Reloj Inteligente TicWatch Pro', 5, 249.99, 20, 27),
		('Monitor BenQ PD3200U', 6, 599.99, 5, 28),
		('Teclado Logitech K780', 7, 79.99, 25, 7),
		('Mouse Razer DeathAdder', 7, 59.99, 40, 8),
		('Cámara Fujifilm X-T30', 8, 899.99, 10, 29),
		('Disco Duro SSD Crucial', 9, 99.99, 50, 30),
		('Laptop Dell Inspiron', 1, 649.99, 18, 6),
		('Smartphone Oppo Find X3', 2, 799.99, 30, 31),
		('Tablet Huawei MatePad', 3, 399.99, 15, 32),
		('Auriculares Sennheiser Momentum', 4, 299.99, 12, 33),
		('Reloj Inteligente Amazfit GTS', 5, 149.99, 30, 34),
		('Monitor AOC Q27G2', 6, 399.99, 20, 35),
		('Teclado Logitech G Pro', 7, 129.99, 28, 7),
		('Mouse SteelSeries Rival', 7, 79.99, 45, 36),
		('Cámara Panasonic Lumix G7', 8, 499.99, 15, 37),
		('Disco Duro Externo Toshiba', 9, 89.99, 35, 38);


INSERT INTO venta (fecha_pedido, id_vendedor, id_cliente, fecha_entrega)
VALUES 
    ('2024-01-15', 2, 1, '2024-01-20'),
    ('2024-02-10', 3, 13, NULL),  -- Reemplazado por 13
    ('2024-03-25', 12, 5, '2024-03-30'),
    ('2024-04-14', 22, 9, '2024-04-19'),  -- Reemplazado por 9
    ('2024-05-05', 3, 9, NULL),  -- Reemplazado por 9
    ('2024-06-17', 12, 1, '2024-06-22'),
    ('2024-07-21', 22, 35, '2024-07-26'),  -- Reemplazado por 35
    ('2024-08-03', 2, 32, NULL),  -- Reemplazado por 32
    ('2024-09-19', 22, 38, '2024-09-24'),
    ('2024-09-11', 2, 1, NULL),
    ('2024-05-30', 12, 5, '2024-12-05'),
    ('2024-01-07', 2, 13, '2024-12-12'),  -- Reemplazado por 13
    ('2024-01-24', 3, 35, NULL),  -- Reemplazado por 35
    ('2024-02-02', 12, 5, '2024-02-07'),
    ('2024-03-10', 22, 38, NULL),
    ('2024-04-22', 2, 9, '2024-04-27'),  -- Reemplazado por 9
    ('2024-05-15', 3, 7, NULL),  -- Reemplazado por 7
    ('2024-06-09', 12, 38, '2024-06-14'),
    ('2024-07-28', 22, 7, '2024-08-02'),  -- Reemplazado por 7
    ('2024-08-19', 2, 32, NULL),  -- Reemplazado por 32
    ('2024-09-06', 22, 35, '2024-09-11'),  -- Reemplazado por 35
    ('2024-03-15', 3, 9, '2024-10-20'),  -- Reemplazado por 9
    ('2024-02-27', 2, 7, NULL),  -- Reemplazado por 7
    ('2024-07-13', 12, 32, '2024-12-18'),  -- Reemplazado por 32
    ('2024-01-05', 22, 38, NULL),
    ('2024-02-22', 2, 7, '2024-02-27'),  -- Reemplazado por 7
    ('2024-03-30', 3, 13, NULL),  -- Reemplazado por 13
    ('2024-04-09', 12, 32, '2024-04-14'),  -- Reemplazado por 32
    ('2024-05-25', 22, 35, NULL),  -- Reemplazado por 35
    ('2024-06-12', 2, 35, '2024-06-17'),  -- Reemplazado por 35
    ('2024-07-14', 3, 9, '2024-07-19'),  -- Reemplazado por 9
    ('2024-08-28', 12, 7, NULL),  -- Reemplazado por 7
    ('2024-09-07', 2, 32, '2024-09-12'),  -- Reemplazado por 32
    ('2024-02-19', 22, 13, '2024-10-24'),  -- Reemplazado por 13
    ('2024-01-11', 3, 9, NULL),  -- Reemplazado por 9
    ('2024-01-15', 2, 32, '2024-01-20'),  -- Reemplazado por 32
    ('2024-02-10', 12, 7, NULL),  -- Reemplazado por 7
    ('2024-03-25', 22, 9, '2024-03-30'),  -- Reemplazado por 9
    ('2024-04-14', 2, 13, '2024-04-19'),  -- Reemplazado por 13
    ('2024-05-01', 3, 38, '2024-05-05'),
    ('2024-06-02', 22, 7, '2024-06-07'),  -- Reemplazado por 7
    ('2024-07-10', 2, 32, '2024-07-12'),  -- Reemplazado por 32
    ('2024-08-05', 3, 35, '2024-08-10'),  -- Reemplazado por 35
    ('2024-09-12', 12, 9, '2024-09-15'),  -- Reemplazado por 9
    ('2024-10-04', 2, 7, NULL),  -- Reemplazado por 7
    ('2024-11-01', 3, 35, '2024-11-05'),  -- Reemplazado por 35
    ('2024-12-07', 12, 38, '2024-12-10'),
    ('2024-01-25', 22, 9, '2024-02-01'),  -- Reemplazado por 9
    ('2024-02-20', 2, 13, '2024-02-25'),  -- Reemplazado por 13
    ('2024-03-15', 3, 38, '2024-03-20'),
    ('2024-04-01', 12, 7, '2024-04-05'),  -- Reemplazado por 7
    ('2024-05-10', 22, 32, '2024-05-15'),  -- Reemplazado por 32
    ('2024-06-07', 2, 9, NULL),  -- Reemplazado por 9
    ('2024-07-20', 3, 35, '2024-07-22'),  -- Reemplazado por 35
    ('2024-08-15', 12, 35, '2024-08-18'),  -- Reemplazado por 35
    ('2024-09-01', 2, 7, '2024-09-05'),  -- Reemplazado por 7
    ('2024-10-10', 3, 32, '2024-10-13'),  -- Reemplazado por 32
    ('2024-11-03', 12, 13, '2024-11-06'),  -- Reemplazado por 13
    ('2024-12-01', 2, 35, '2024-12-03'),  -- Reemplazado por 35
    ('2024-01-30', 3, 32, '2024-02-03'),  -- Reemplazado por 32
    ('2024-02-25', 12, 7, '2024-03-01'),  -- Reemplazado por 7
    ('2024-03-05', 2, 35, NULL),  -- Reemplazado por 35
    ('2024-04-18', 3, 32, '2024-04-22'),  -- Reemplazado por 32
    ('2024-05-15', 12, 9, '2024-05-20');




/* pedido */
INSERT 
INTO	pedido (id_venta, id_producto, cantidad)
VALUES	(35, 18, 3),
		(5, 10, 2),
		(3, 25, 4),
		(7, 5, 1),
		(1, 15, 3),
		(6, 40, 5),
		(2, 22, 2),
		(9, 12, 4),
		(8, 8, 1),
		(10, 45, 3),
		(4, 30, 2),
		(7, 2, 5),
		(3, 35, 4),
		(5, 19, 1),
		(1, 25, 3),
		(6, 7, 2),
		(8, 44, 5),
		(2, 16, 4),
		(9, 10, 3),
		(10, 27, 2),
		(4, 50, 1),
		(7, 3, 5),
		(3, 13, 2),
		(5, 42, 3),
		(1, 17, 4),
		(6, 33, 1),
		(2, 9, 2),
		(9, 48, 4),
		(8, 6, 3),
		(4, 11, 2),
		(10, 26, 5),
		(5, 22, 1),
		(3, 49, 4),
		(7, 14, 2),
		(1, 37, 3),
		(2, 1, 3),    
		(2, 3, 5),    
		(4, 4, 2),    
		(4, 5, 8),    
		(10, 6, 4),   
		(10, 8, 6),   
		(15, 7, 10),  
		(15, 9, 1),   
		(18, 2, 15),  
		(18, 10, 12), 
		(21, 11, 4),  
		(21, 12, 20), 
		(10, 5, 3),   
		(4, 2, 7),
		(11, 3, 2),
		(12, 8, 1),
		(13, 5, 3),
		(14, 25, 2),
		(15, 30, 4),
		(16, 9, 1),
		(17, 17, 2),
		(18, 45, 3),
		(19, 12, 5),
		(20, 40, 1),
		(21, 28, 2),
		(22, 14, 3),
		(23, 9, 4),
		(24, 22, 5),
		(25, 31, 2),
		(26, 19, 3),
		(27, 11, 1),
		(28, 50, 4),
		(29, 32, 2),
		(30, 21, 3),
		(31, 37, 4),
		(32, 13, 2),
		(33, 8, 1),
		(34, 29, 5);  

COMMIT;
