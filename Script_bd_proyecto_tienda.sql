--Cracion de tablas
--Parte Raul

drop table if exists ajuste_inventario;

create table ajuste_inventario (
	id_ajuste int primary key,
	id_inventario int,
	cantidad decimal(10,2),
	tipo_ajuste varchar(30),
	fecha timestamp 
);

drop table if exists inventario;

create table inventario(
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

drop table if exists factura_compra;

create table factura_compra(
	id_factura_compra int primary key,
	fecha timestamp,
	id_proveedor int,
	tipo_documento varchar(30),
	num_factura varchar(30),
	codigo varchar(30),
	es_cerdito_fiscal boolean,
	total decimal(10, 2),
	sub_total decimal(10, 2),
	iva decimal(10, 2),
	esatdo varchar(30)
);

drop table if exists detalle_factura_compra;

create table detalle_factura_compra(
	id_detalle_factura_compra int primary key,
	id_factura_compra int,
	id_producto int,
	cantidad decimal(10, 2),
	precio_unitario decimal(10, 2),
	sub_total decimal(10, 2),
	id_inventario int
);

--Parte Erick
--Parte Stiven

--Llaves foraneas

--Insertar los datos