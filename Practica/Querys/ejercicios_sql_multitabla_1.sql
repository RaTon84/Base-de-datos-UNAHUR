create table almacen
	(nro integer primary key,
	responsable varchar(50) not null);
create table articulo
	(codArt int primary key,
	descripcion varchar(50) not null,
	precio float);
create table material
	(codMat int primary key,
	descripcion VARCHAR(50) not null);

create table ciudad
	(codCiudad int primary key,
	nombre varchar(30), not null);

create table proveedor
	(codProv int primary key,
	nombre varchar(30) not null,
	domicilio varchar(50) not null,
	codCiudad int not null,
	constraint FK_codCiudad
	foreign key (codCiudad) 
	references ciudad(codCiudad));

create table contiene
	(cod_contiene serial primary key ,
	nro int not null,
	codArt int not null,
	foreign key (nro)references almacen(nro),
	foreign key (codArt)references articulo(codArt));
drop table contiene;

create table compuesto_por
	(cod_composicion serial primary key,
	codArt int not null,
	codMat int not null,
	foreign key(codArt) references articulo(codArt),
	foreign key(codMat) references material(codMat));
drop table compuesto_por;

create table provisto_por
	(cod_provisto serial primary key,
	codMat int not null,
	codProv int not null,
	constraint FK_material foreign key(codMat) references material(codMat),
	constraint FK_proveedor foreign key(codProv) references proveedor(codprov));
drop table provisto_por;

INSERT INTO ALMACEN (Nro, Responsable) 
VALUES (001, 'Alfredo'), 
(002, 'Esteban'), 
(003, 'Juan'), 
(004, 'Roberto'); 
INSERT INTO ARTICULO (CodArt, Descripcion, Precio) 
VALUES (001, 'Pan', 130.70), 
(002, 'Facturas', 300.00), 
(003, 'Cheese Cake', 450.87), 
(004, 'Pasta Frola', 278.90); 
INSERT INTO MATERIAL (CodMat,  Descripcion) 
VALUES (001, 'Aceite'), 
(002, 'Harina'), 
(003, 'Levadura'), 
(004, 'Huevo'), 
(005, 'Azucar'), 
(006, 'Sal'), 
(007, 'Agua'); 
INSERT INTO CIUDAD(CodCiudad, Nombre) 
VALUES (1, 'La Plata'), 
(2, 'Capital Federal'), 
(3, 'Ramos Mejia'), 
(4, 'La Matanza'); 
INSERT INTO PROVEEDOR (CodProv, Nombre, Domicilio, 
CodCiudad) 
VALUES(1, 'Arcor', 'Ayacucho 1234', 1), 
(2, 'Molinos', 'Yatay 456', 4), 
(3, 'Ledesma', 'Mario Bravo 987', 1), 
(4, 'Marolio', 'Potosi 098', 2), 
(5, 'Glaciar', 'Sarmiento 555', 3); 
INSERT INTO CONTIENE (Nro, CodArt) 
VALUES (001, 001), 
(001, 002), 
(001, 003), 
(001, 004), 
(002, 003), 
(002, 004), 
(003, 001), 
(004, 002); 
INSERT INTO COMPUESTO_POR (CodArt, CodMat) 
VALUES(001, 001), 
(001, 002), 
(001, 003), 
(002, 002), 
(002, 005), 
(002, 007), 
(003, 001), 
(003, 002), 
(003, 006), 
(004, 007); 
INSERT INTO PROVISTO_POR(CodMat, CodProv) 
VALUES (001, 1), 
(002, 3), 
(003, 5), 
(004, 4), 
(005, 2), 
(006, 2), 
(007, 5); 

1) Listar nombre de todos los proveedores y de su ciudad
select p.nombre proveedor, c.nombre ciudad
	from proveedor p
	join ciudad c on p.codciudad=c.codciudad;

2)Listar los nombres de los proveedores de la ciudad de La Plata
select p.nombre
	from proveedor p
	join ciudad c on p.codciudad=c.codciudad
	where c.nombre='La Plata';

3) Listar los números de almacenes que almacenan el 
	artículo de descripción que empiece con P	 
select distinct c.nro numero_de_almacen
	from contiene c 
	join articulo a on c.codArt = a.codArt
	where a.descripcion like 'P%'
	order by c.nro;
	
4) Listar los números de almacenes y su responsable que 
almacenan el artículo de descripción que empiece con P	 
select distinct a.nro numero_almacen, a.responsable
	from almacen a
	join contiene c on a.nro=c.nro
	join articulo ar on c.codart=ar.codart
	where ar.descripcion like 'P%';	

5) Listar los materiales (código y descripción) 	 
provistos por proveedores de la ciudad de Ramos Mejia
select m.codmat, m.descripcion
	from material m
	join provisto_por pp on m.codmat=pp.codmat
	join proveedor p on pp.codprov=p.codprov
	join ciudad c on c.codciudad=p.codciudad
	where c.nombre='Ramos Mejia';

6) Listar los nombres de los proveedores que proveen materiales  
para artículos ubicados en almacenes que Roberto tiene a su cargo 
select pr.nombre
	from proveedor pr
	join provisto_por pp on pr.codprov=pp.codprov
	join material m on pp.codmat=m.codmat
	join compuesto_por c on m.codmat=c.codmat
	join articulo a on c.codart=a.codart
	join contiene co on a.codart=co.codart
	join almacen al on co.nro=al.nro
	where al.responsable='Roberto';