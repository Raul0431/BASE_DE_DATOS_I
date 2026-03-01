--Eliminacion de tablas antes de crearlas
DROP TABLE IF EXISTS detalle_venta;
DROP TABLE IF EXISTS detalle_factura_compra;
DROP TABLE IF EXISTS ajuste_inventario;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS factura_compra;
DROP TABLE IF EXISTS inventario;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS categoria;

--Cracion de tablas

CREATE TABLE ajuste_inventario (
	id_ajuste int primary key,
	id_inventario int,
	cantidad decimal(10,2),
	tipo_ajuste varchar(30),
	fecha timestamp 
);

CREATE TABLE inventario(
	id_inventario int primary key,
	id_proveedor int,
	id_producto int,
	precio_venta decimal(10,2),
	stock decimal(10,2),
	fecha_entrada timestamp,
	fecha_salida timestamp,
	fecha_vencimiento timestamp,
	ubicacion varchar(30)
);

CREATE TABLE factura_compra(
	id_factura_compra int primary key,
	fecha timestamp,
	id_proveedor int,
	tipo_documento varchar(30),
	num_factura varchar(30),
	codigo varchar(30),
	es_credito_fiscal boolean,
	total decimal(10, 2),
	sub_total decimal(10, 2),
	iva decimal(10, 2),
	estado varchar(30)
);

CREATE TABLE detalle_factura_compra(
	id_detalle_factura_compra int primary key,
	id_factura_compra int,
	id_producto int,
	cantidad decimal(10, 2),
	precio_unitario decimal(10, 2),
	sub_total decimal(10, 2),
	id_inventario int
);

CREATE TABLE detalle_venta(
	id_detalle_venta int primary key,
	id_venta int,
	id_producto int,
	cantidad int,
	sub_total decimal(10,2),
	id_inventario int
);

CREATE TABLE proveedor(
	id_proveedor int primary key,
	nombre varchar(150),
	telefono varchar(15),
	correo varchar(150),
	direccion varchar(200),
	nit varchar(20),
	nrc varchar(20),
	giro varchar(150)
);

CREATE TABLE categoria(
	id_categoria int primary key,
	nombre_categoria varchar(100),
	descripcion varchar(200)
);

CREATE TABLE cliente(
	id_cliente int primary key,
	nombre varchar(100),
	apellido varchar(100),
	telefono varchar(15),
	correo varchar(150),
	direccion varchar(200),
	nit varchar(20),
	nrc varchar(20),
	giro varchar(150),
	direccion_fiscal varchar(200)
);

CREATE TABLE venta(
	id_venta int primary key,
	fecha timestamp,
	id_cliente int,
	id_empleado int,
	tipo_documento varchar(30),
	num_factura varchar(30),
	codigo varchar(30),
	sub_total decimal(10,2),
	iva decimal(10,2),
	total decimal(10,2),
	condicion_pago varchar(15),
	plazo_dias int,
	saldo decimal(10,2),
	fecha_vencimiento timestamp
);

CREATE TABLE empleado(
	id_empleado int primary key,
	nombre varchar(100),
	apellido varchar(100),
	cargo varchar(50),
	salario decimal(10,2),
	fecha_contratacion timestamp
);
	
CREATE TABLE producto(
	id_producto int primary key,
	nombre_producto varchar(150),
	descripcion varchar(200),
	id_categoria int,
	stock_minimo decimal(10, 2)
);


--Llaves foraneas
ALTER TABLE ajuste_inventario 
ADD CONSTRAINT fk_ajuste_inventario_inv 
FOREIGN KEY (id_inventario) 
REFERENCES inventario(id_inventario);

ALTER TABLE inventario 
ADD CONSTRAINT fk_inventario_proveedor 
FOREIGN KEY (id_proveedor) 
REFERENCES proveedor(id_proveedor);

ALTER TABLE inventario 
ADD CONSTRAINT fk_inventario_producto 
FOREIGN KEY (id_producto) 
REFERENCES producto(id_producto);

ALTER TABLE factura_compra  
ADD CONSTRAINT fk_factura_compra_proveedor 
FOREIGN KEY (id_proveedor)
REFERENCES proveedor(id_proveedor);

ALTER TABLE detalle_factura_compra   
ADD CONSTRAINT fk_detalle_factura_compra_factura 
FOREIGN KEY (id_factura_compra) 
REFERENCES factura_compra(id_factura_compra);

ALTER TABLE detalle_factura_compra   
ADD CONSTRAINT fk_detalle_factura_compra_inv 
FOREIGN KEY (id_inventario) 
REFERENCES inventario(id_inventario);

ALTER TABLE detalle_venta
ADD CONSTRAINT fk_detalle_venta_venta
FOREIGN KEY (id_venta) REFERENCES venta(id_venta);

ALTER TABLE detalle_venta
ADD CONSTRAINT fk_detalle_venta_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE detalle_venta
ADD CONSTRAINT fk_detalle_venta_inventario
FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario);

ALTER TABLE venta
ADD CONSTRAINT fk_venta_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE venta
ADD CONSTRAINT fk_venta_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE producto
ADD CONSTRAINT fk_producto_id_categoria
FOREIGN KEY (id_categoria)
REFERENCES categoria(id_categoria);

--Insertar los datos

--INSERTAR CATALOGOS PRINCIPALES (No dependen de otras tablas)

INSERT INTO categoria (id_categoria, nombre_categoria, descripcion) VALUES
(1, 'Computación', 'Laptops, computadoras de escritorio y servidores'),
(2, 'Periféricos', 'Teclados, mouses, monitores y accesorios');

-- Proveedores
INSERT INTO proveedor (id_proveedor, nombre, telefono, correo, direccion, nit, nrc, giro) VALUES
(1, 'Tech Distribuidora SA de CV', '2222-0000', 'ventas@techdist.com.sv', 'San Salvador', '0614-010190-101-1', '123456-7', 'Venta de equipo informático'),
(2, 'Importaciones Globales', '2233-1111', 'contacto@imglobal.sv', 'Santa Tecla', '0614-020285-102-2', '765432-1', 'Importación de tecnología');

-- Clientes
INSERT INTO cliente (id_cliente, nombre, apellido, telefono, correo, direccion, nit, nrc, giro, direccion_fiscal) VALUES
(1, 'Juan', 'Pérez', '7777-8888', 'juan.perez@gmail.com', 'Colonia Escalón', '0614-150595-101-5', NULL, 'Consumidor Final', 'Misma'),
(2, 'Empresa Innovadora SA', '', '2500-3000', 'compras@innovadora.sv', 'Antiguo Cuscatlán', '0614-101010-103-3', '112233-4', 'Desarrollo de Software', 'Edificio Centro, San Salvador');

-- Empleados
INSERT INTO empleado (id_empleado, nombre, apellido, cargo, salario, fecha_contratacion) VALUES
(1, 'Carlos', 'López', 'Vendedor', 450.00, '2025-01-15 08:00:00'),
(2, 'Ana', 'Martínez', 'Gerente de Tienda', 850.00, '2024-06-01 08:00:00');

--INSERTAR PRODUCTOS E INVENTARIO (Dependen de los catalogos)

-- Productos (Dependen de Categoria)
INSERT INTO producto (id_producto, nombre_producto, descripcion, id_categoria, stock_minimo) VALUES
(1, 'Laptop Dell Inspiron 15', 'Laptop 15 pulgadas, 8GB RAM, 256GB SSD', 1, 5.00),
(2, 'Mouse Inalámbrico Logitech', 'Mouse óptico USB', 2, 10.00);

-- Inventario (Depende de Proveedor y Producto)
INSERT INTO inventario (id_inventario, id_proveedor, id_producto, precio_venta, stock, fecha_entrada, fecha_salida, fecha_vencimiento, ubicacion) VALUES
(1, 1, 1, 650.00, 15.00, '2026-02-01 10:00:00', NULL, NULL, 'Bodega A - Estante 1'),
(2, 2, 2, 25.00, 50.00, '2026-02-15 14:30:00', NULL, NULL, 'Vitrina Principal');

-- Ajustes de Inventario (Depende de Inventario)
INSERT INTO ajuste_inventario (id_ajuste, id_inventario, cantidad, tipo_ajuste, fecha) VALUES
(1, 2, -2.00, 'Pérdida/Dañado', '2026-02-28 09:00:00');

--INSERTAR TRANSACCIONES (Compras y Ventas)

-- Factura de Compra (Depende de Proveedor)
INSERT INTO factura_compra (id_factura_compra, fecha, id_proveedor, tipo_documento, num_factura, codigo, es_credito_fiscal, total, sub_total, iva, estado) VALUES
(1, '2026-02-01 09:30:00', 1, 'Crédito Fiscal', 'CCF-00150', 'COMP-001', true, 5650.00, 5000.00, 650.00, 'Pagada');

-- Detalle Factura Compra (Depende de Factura, Producto, Inventario)
INSERT INTO detalle_factura_compra (id_detalle_factura_compra, id_factura_compra, id_producto, cantidad, precio_unitario, sub_total, id_inventario) VALUES
(1, 1, 1, 10.00, 500.00, 5000.00, 1);

-- Venta (Depende de Cliente y Empleado)
INSERT INTO venta (id_venta, fecha, id_cliente, id_empleado, tipo_documento, num_factura, codigo, sub_total, iva, total, condicion_pago, plazo_dias, saldo, fecha_vencimiento) VALUES
(1, '2026-03-01 11:15:00', 1, 1, 'Factura Consumidor Final', 'FCF-0001', 'VEN-001', 575.22, 74.78, 650.00, 'Contado', 0, 0.00, '2026-03-01 11:15:00');

-- Detalle Venta (Depende de Venta, Producto, Inventario)
INSERT INTO detalle_venta (id_detalle_venta, id_venta, id_producto, cantidad, sub_total, id_inventario) VALUES
(1, 1, 1, 1, 650.00, 1);