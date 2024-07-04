create table marca
	(idmarca serial primary key,
	descripcion varchar(100) not null);
drop table vehiculo;
create table vehiculo
	(patente varchar primary key,
	color varchar(50) not null,
	anio int not null,
	capacidad int not null,
	puertas int not null,
	idmarca int not null,
	foreign key (idmarca) references marca(idmarca));

create table localidad
	(idlocalidad serial primary key,
	descripcion varchar(100));
drop table cliente
create table cliente
	(legajo int primary key,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	telefono int8 not null,
	idlocalidad int not null,
	foreign key (idlocalidad) references localidad(idlocalidad));
drop table alquiler;
create table alquiler
	(id serial primary key,
	patente varchar not null,
	legcliente int not null,
	fechaalquiler date not null,
	importe float not null,
	cantdias int not null,
	foreign key (patente) references vehiculo(patente),
	foreign key (legcliente) references cliente(legajo));

INSERT INTO LOCALIDAD (Descripcion)
VALUES ('Ramos Mejia'), ('Laferrere'), ('San Justo'), ('Haedo');

INSERT INTO Cliente (Legajo, Nombre, Apellido, Telefono, idLocalidad)
VALUES (1, 'Juan', 'Pepe', 1530111222339, 1),
(2, 'Santiago', 'Molinos', 1530222333448, 1),
(3, 'Ricardo', 'Marolio', 1530333444557, 2),
(4, 'Roberto', 'Ledesma', 1530444555666, 3),
(5, 'Alberto', 'Johnson', 1530555666775, 4);

INSERT INTO Marca (Descripcion)
VALUES ('Nissan'),
('Renault'),
('Ford'),
('Volkswagen'),
('Fiat');

INSERT INTO Vehiculo(Patente, Color, Anio, Capacidad, Puertas, IdMarca)
VALUES ('AAA111', 'Azul', 2021, 2, 3, 1),
('AAA112', 'Rojo', 2010, 10, 5, 2),
('AAA113', 'Violeta', 2022, 11, 3, 3),
('AAA114', 'Naranja', 1990, 5, 5, 1),
('AAA115', 'Verde', 1994, 6, 3, 4),
('AAA116', 'Azul', 2020, 11, 2, 2),
('AAA117', 'Blanco', 1998, 9, 3, 5),
('FFF555', 'Negro' , 2019, 4, 5, 1);

INSERT INTO Alquiler(Patente, legCliente, FechaAlquiler, Importe, CantDias)
VALUES ('AAA111', 1, '2020-01-01', 300.00, 5),
('AAA111', 2, '2020-02-01', 700.00, 6),
('AAA112', 1, '2020-03-01', 100.00, 1),
('AAA111', 3, '2020-03-01', 3000.00, 15),
('AAA112', 3, '2020-03-01', 200.00, 2),
('AAA113', 3, '2021-10-01', 1000.00, 6),
('AAA115', 1, '2021-07-01', 15000.00, 31),
('FFF555', 3, '2022-01-31', 500.00, 9),
('AAA114', 5, '2020-02-20', 4000.00, 8);

2. Obtener los datos de todos los vehículos, ordenados por marca (descripción) y patente

select m.descripcion, v.patente
	from vehiculo v
	join marca m on v.idmarca=m.idmarca
	order by m.descripcion asc, v.patente asc;

3. Para cada marca, informar la cantidad de vehículos total y máxima capacidad,
únicamente para aquellos vehículos con más de 4 puertas.

select m.descripcion, count(*), max(v.capacidad)
	from marca m
	join vehiculo v on m.idmarca=v.idmarca
	where v.puertas>4
	group by m.idmarca

4. Informar: Legajo, Nombre y apellido del cliente, patente, color del auto, fecha de
alquiler, importe, impuestos (15% del importe del alquiler), de todos los alquileres
registrados en el mes de febrero de 2020.
	
select al.legCliente,cl.nombre,cl.apellido,al.patente,ve.color,al.fechaalquiler,al.importe, al.importe*0.15 impuestos
	from cliente cl 
	join alquiler al on cl.legajo=al.legcliente
	join vehiculo ve on ve.patente=al.patente
	where al.fechaalquiler between '2020/2/1' and '2020/2/29'

5. Generar el script para agregar el siguiente Auto: ABC234, Rojo, 2021, 5, 4, 5.

insert into vehiculo values('ABC234', 'Rojo', '2021', 5,4,4) 

6. Escribir la sentencia para modificar el color del auto FFF555 ya que el mismo es gris.

update vehiculo 
	set color='gris' 
	where patente='FFF555'
	
7. Detallar la patente de todos los autos que tienen la máxima capacidad

select ve.patente, ve.capacidad
	from vehiculo ve
	where ve.capacidad 
	in (select max(capacidad)
		from vehiculo) 

8. Mostrar los datos de los clientes que han alquilado algún vehículo de Marca Nissan pero
nunca han alquilado un Ford.
select * from alquiler
select * from vehiculo
select * from marca
	
select cl.nombre
	from cliente cl
	join alquiler al on cl.legajo=al.legcliente
	join vehiculo ve on al.patente=ve.patente
	join marca ma on ve.idmarca=ma.idmarca
	where ma.descripcion='Nissan' and ma.descripcion!='Ford'
	
9. Listar la patente, importe total de alquiler, cantidad de alquiler por auto, únicamente para
los vehículos que hayan sido alquilados más de una vez.


	
10. Informar los datos de los clientes que han alquilado más de una vez en la agencia en el
último trimestre (enero, febrero y marzo 2020)






	