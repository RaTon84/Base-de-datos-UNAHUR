CREATE TABLE ALMACEN(
Nro INT PRIMARY KEY,
Nombre VARCHAR(20) NOT NULL,
Responsable VARCHAR(50) NOT NULL);

CREATE TABLE ARTICULO(
CodArt INT PRIMARY KEY,
Descripcion VARCHAR (50) NOT NULL,
Precio float);

CREATE TABLE MATERIAL(
CodMat INT PRIMARY KEY, 
Descripcion VARCHAR(100) NOT NULL);

CREATE TABLE CIUDAD(
CodCiudad INT PRIMARY KEY,
Nombre VARCHAR(100) NOT NULL);

CREATE TABLE PROVEEDOR(
CodProv INT PRIMARY KEY,
Nombre VARCHAR(20) NOT NULL,
Domicilio VARCHAR(100),
CodCiudad INT NOT NULL,
FOREIGN KEY (CodCiudad) REFERENCES Ciudad (CodCiudad));

CREATE TABLE CONTIENE(
Cod_Contiene serial PRIMARY KEY,
Nro INT NOT NULL,
CodArt INT NOT NULL,
FOREIGN KEY (Nro) REFERENCES ALMACEN (Nro),
FOREIGN KEY (CodArt) REFERENCES ARTICULO (CodArt));

CREATE TABLE COMPUESTO_POR(
Cod_Composicion serial PRIMARY KEY,
CodArt INT NOT NULL,
CodMat INT NOT NULL,
FOREIGN KEY (CodArt) REFERENCES ARTICULO (CodArt),
FOREIGN KEY (CodMat) REFERENCES MATERIAL (CodMat));

CREATE TABLE PROVISTO_POR(
Cod_Provisto serial PRIMARY KEY,
CodMat INT NOT NULL,
CodProv INT NOT NULL,
FOREIGN KEY (CodMat) REFERENCES MATERIAL (CodMat),
FOREIGN KEY (CodProv) REFERENCES PROVEEDOR (CodProv)); 

INSERT INTO ALMACEN (Nro, Nombre, Responsable)
VALUES (001, 'La Original', 'Alfredo'),
(002, 'Galpon', 'Esteban'),
(003, 'Almacen de Don Juan', 'Juan'),
(004, 'La Tiendita', 'Roberto'); 

INSERT INTO ARTICULO (CodArt, Descripcion, Precio)
VALUES (001, 'Pan', 130.70),
(002, 'Facturas', 300.00),
(003, 'Cheese Cake', 450.87),
(004, 'Pasta Frola', 278.90); 

INSERT INTO MATERIAL (CodMat, Descripcion)
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
(5, 'Glaciar', 'Sarmiento 555', 3),
(6, 'Johnson', 'Potosi 123', 1); 

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

1) Indicar la cantidad de proveedores que comienzan con la
letra L

select count(*) cant_con_L
	from proveedor 
	where nombre like 'L%';

#2) Listar el promedio de precios de los artículos por cada
almacén (nombre)

select al.nombre, avg(ar.precio)
	from almacen al
	join contiene co on al.nro=co.nro
	join articulo ar on co.codart=ar.codart	
	group by al.nro;

3) Listar la descripción de artículos compuestos por al menos 2
materiales

select cp.codart codigo, ar.descripcion articulo
	from articulo ar
	join compuesto_por cp on ar.codart=cp.codart
	group by cp.codart, ar.descripcion
	having count(*)>=2
	order by cp.codart asc;

4) Listar cantidad de materiales que provee cada proveedor y
el código, nombre y domicilio del proveedor.

select pr.codProv, pr.nombre, pr.domicilio, count(*) cant_materiales
	from provisto_por pp
	join proveedor pr on pp.codprov=pr.codprov
	group by pr.codprov
	order by pr.codprov asc;	
	
5) Cuál es el precio máximo de los artículos que estan
compuestos por materiales que proveen los proveedores de la
ciudad de La Plata.
	
select max(ar.precio) precio_maximo
	from articulo ar
	join compuesto_por cp on ar.codart=cp.codart
	join provisto_por pp on cp.codmat=pp.codmat
	join proveedor pr on pp.codprov=pr.codprov
	join ciudad ci on pr.codciudad=ci.codciudad
	where ci.nombre='La Plata';

6) Listar los nombres de aquellos proveedores que no proveen
ningún material

select pr.nombre
from proveedor pr	
where pr.codprov not in 
	(select pp.codprov
	from provisto_por pp);

SELECT P.NOMBRE NOMBRE_PROV
FROM PROVEEDOR P 
LEFT JOIN PROVISTO_POR PP ON P.CodProv= PP.CodProv
WHERE PP.CodMat IS NULL;

Otra forma de hacerlo:
	
SELECT P.NOMBRE NOMBRE_PROV
FROM PROVEEDOR P 
LEFT JOIN PROVISTO_POR PP ON P.CodProv= PP.CodProv
GROUP BY P.CodProv
HAVING COUNT(PP.CodMat) = 0;