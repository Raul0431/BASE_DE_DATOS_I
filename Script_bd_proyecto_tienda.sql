--Cracion de tablas
--Parte Raul

DROP TABLE IF EXISTS ajuste_inventario;

CREATE TABLE ajuste_inventario (
	id_ajuste int primary key,
	id_inventario int,
	cantidad decimal(10,2),
	tipo_ajuste varchar(30),
	fecha timestamp 
);

DROP TABLE IF EXISTS inventario;

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

DROP TABLE IF EXISTS factura_compra;

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

DROP TABLE IF EXISTS detalle_factura_compra;

CREATE TABLE detalle_factura_compra(
	id_detalle_factura_compra int primary key,
	id_factura_compra int,
	id_producto int,
	cantidad decimal(10, 2),
	precio_unitario decimal(10, 2),
	sub_total decimal(10, 2),
	id_inventario int
);

--Parte Erick
DROP TABLE IF EXISTS detalle_venta;

CREATE TABLE detalle_venta(
	id_detalle_venta int primary key,
	id_venta int,
	id_producto int,
	cantidad int,
	sub_total decimal(10,2),
	id_inventario int
);

DROP TABLE IF EXISTS proveedor;

CREATE TABLE proveedor(
	id_proveedor int primary key,
	nombre varchar(150),
	telefono varchar(15),
	correo varchar(150),
	direccion varchar(200),
	nit varchar(20),
	nrc varchar(20),
	giro varchar(20)
);

DROP TABLE IF EXISTS categoria;

CREATE TABLE categoria(
	id_categoria int primary key,
	nombre_categoria varchar(100),
	descripcion varchar(200)
);

--Parte Stiven
DROP TABLE IF EXISTS cliente;

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

DROP TABLE IF EXISTS venta;

CREATE TABLE  venta(
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

DROP TABLE IF EXISTS empleado;

CREATE TABLE empleado(
	id_empleado int primary key,
	nombre varchar(100),
	apellido varchar(100),
	cargo varchar(50),
	salario decimal(10,2),
	fecha_contratacion timestamp
);

DROP TABLE IF EXISTS producto;
	
CREATE TABLE producto(
	id_producto int primary key,
	nombre_producto varchar(150),
	descripcion varchar(200),
	id_categoria int,
	stock_minimo decimal(10, 2)
);


--Llaves foraneas
--raul
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
--Erick

ALTER TABLE detalle_venta
ADD CONSTRAINT fk_detalle_venta_venta
FOREIGN KEY (id_venta) REFERENCES venta(id_venta);

ALTER TABLE detalle_venta
ADD CONSTRAINT fk_detalle_venta_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE detalle_venta
ADD CONSTRAINT fk_detalle_venta_inventario
FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario);

--Stiven

-- Venta -> Cliente
ALTER TABLE venta
ADD CONSTRAINT fk_venta_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

-- Venta -> Empleado
ALTER TABLE venta
ADD CONSTRAINT fk_venta_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

--Insertar los datos
