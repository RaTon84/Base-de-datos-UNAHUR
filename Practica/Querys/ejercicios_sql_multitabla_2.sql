create table proveedor
	(id_proveedor serial primary key,
	nombre varchar(100) not null,
	cuit bigint not null,
	ciudad varchar(100));

create table producto
	(id_producto serial primary key,
	descripcion varchar(100) not null,
	estado varchar(100) not null,
	id_proveedor int not null,
	foreign key (id_proveedor) references proveedor(id_proveedor));

create table cliente
	(id_cliente serial primary key,
	nombre varchar(100) not null);

create table vendedor
	(id_empleado serial primary key,
	nombre varchar(100) not null,
	apellido varchar(100) not null,
	dni int not null,
	ciudad varchar(100));

create table venta
	(nro_factura serial primary key,
	id_cliente int not null,
	fecha date not null,
	id_vendedor int not null,
	foreign key (id_cliente) references cliente(id_cliente),
	foreign key (id_vendedor) references vendedor(id_empleado));

create table detalle_venta
	(nro_detalle serial primary key,
	nro_factura int not null,
	id_producto int not null,
	cantidad int not null,
	precio_unitario float not null,
	foreign key (nro_factura) references venta(nro_factura),
	foreign key (id_producto) references producto(id_producto));

INSERT INTO PROVEEDOR (NOMBRE, CUIT, CIUDAD) 
VALUES ('ARCOR', '30111222339', 'San Luis'), 
('Molinos', '30222333448', 'Cordoba'), 
('Marolio', '30333444557', 'San Luis'), 
('Ledesma', '30444555666', 'Capital Federal'), 
('Johnson', '30555666775', 'Ramos Mejia'); 
select * from proveedor;

INSERT INTO PRODUCTO(DESCRIPCION, ESTADO, ID_PROVEEDOR) 
VALUES ('Harina', 'En Stock', 2), 
('Arroz', 'En Stock', 1), 
('Jabon liquido', 'Sin Stock', 5), 
('Azucar', 'En Stock', 4), 
('Aceite', 'Sin Stock', 3); 
select * from producto;

INSERT INTO CLIENTE (NOMBRE) 
VALUES ('Juan Carlos Altamirano'), 
('Pepe Silla'), 
('Esteban Quito'), 
('Laura Noveas'), 
('Alejandra Hola'); 

INSERT INTO VENDEDOR (NOMBRE, APELLIDO, DNI, CIUDAD) 
VALUES ('Ambar', 'Paredes', 33444555, 'San Pedro'), 
('Federico', 'Medina', 34555666, 'Mar del Plata'), 
('Gaston', 'Salvatierra', 35666777, 'Buenos Aires'), 
('Florencia', 'Luque', 36777888, 'Bariloche'), 
('Leandro', 'Fido', 37888999, 'San Luis'); 

INSERT INTO VENTA(ID_CLIENTE, FECHA, ID_VENDEDOR) 
VALUES (1, '1998-05-01', 3), 
(4, '2015-02-24', 5), 
(2, '2020-03-31', 5), 
(3, '2020-04-12', 2), 
(4, '2021-10-02', 1), 
(5, '2021-11-06', 1), 
(3, '2022-02-16', 4), 
(5, '2022-03-07', 1), 
(1, '2022-03-15', 2), 
(5, '1998-05-15', 5); 

INSERT INTO DETALLE_VENTA (NRO_FACTURA, ID_PRODUCTO, 
CANTIDAD, PRECIO_UNITARIO) 
VALUES(1,  1, 4, 100.80), 
(2, 2, 8, 80.50), 
(3, 4, 10, 200.35), 
(4, 3, 23, 89.99), 
(5, 3, 54, 154.87), 
(6, 2, 19, 321.56), 
(7, 2, 11, 452.84), 
(8, 4, 5, 163.12), 
(9, 4, 3, 56.77), 
(10, 2, 15, 199.66); 
delete from detalle_venta;

1.	Listar los productos que tiene la empresa, 
	donde el proveedor que los provee es de la ciudad de San Luis, 
	ordenado por nombre de la ciudad de mayor a menor. 

select distinct p.descripcion productos_de_san_luis
	from producto p
	join proveedor pr on p.id_proveedor=pr.id_proveedor
	where pr.ciudad='San Luis'
	order by p.descripcion desc;

2.	Listar la descripción de productos en estado 'En Stock' 
	que tiene la empresa y que los mismos no hayan sido vendidos 
	nunca a fin de hacer un análisis de porque no tienen salida. 
	
select * from detalle_venta;
select * from producto;
update producto set estado='En Stock'
	where id_producto=5
	
select p.descripcion productos_sin_salida
	from producto p
	left join detalle_venta dv on p.id_producto=dv.id_producto
	where p.estado='En Stock' and dv.cantidad is null;

3.	Listar los productos que nunca fueron vendidos durante los meses de Marzo. 
	Mayo. Octubre y diciembre de los años 2020 y 2021. 

select p.descripcion sin_ventas2020_2022
	from producto p
	left join detalle_venta dv on p.id_producto=dv.id_producto
	where dv.cantidad is null ;


///////////////////////////////////////

4.	Listar unidades que fueron vendidas de cada producto (descripción) 
	y que vendedor las llevo a cabo en la ciudad de Mar del Plata. 

select p.descripcion producto, sum(dv.cantidad) unidades_vendidas
	from detalle_venta dv
	join producto p on dv.id_producto=p.id_producto
	join venta v on v.nro_factura=dv.nro_factura
	join vendedor ve on ve.id_empleado=v.id_vendedor
	where ve.ciudad='Mar del Plata'
	group by p.descripcion;
	
5.	Listar el nombre de cada vendedor y las ventas realizadas en el año 2015, 
	ordenados por apellido y nombre de cada vendedor. 

select v.apellido apellido, v.nombre nombre, sum(venta)
	
6.	Listar los clientes y las ventas realizadas de los productos 001 y 007 
	llevadas a cabo en el mes de Mayo de 1998. 

select cl.nombre, count(ventas) 
	
7.	Listar las ventas realizadas en el mes de Marzo de 2022, detallando quien 
	fue el vendedor y los clientes involucrados en cada operación. 