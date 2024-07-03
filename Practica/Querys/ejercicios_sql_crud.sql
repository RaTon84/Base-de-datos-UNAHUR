CREATE TABLE PACIENTE
(ID_PACIENTE INT PRIMARY KEY,
APELLIDO VARCHAR(30) NOT NULL,
NOMBRE VARCHAR(30) NOT NULL,
DOB DATE NOT NULL,
GENERO CHAR(1) NOT NULL,
PESO float NOT NULL,
ALTURA float NOT NULL,
ESTA_VACUNADO CHAR(1) NOT NULL);

INSERT INTO PACIENTE (ID_PACIENTE, APELLIDO, NOMBRE, DOB,
GENERO, PESO, ALTURA, ESTA_VACUNADO)
VALUES
(15223, 'Smith', 'Deniz', '2018/12/31', 'F', 21.4, 29.2, 'Y'),
(15224, 'Agarwal', 'Arjun', '2017/08/29', 'M', 28.1, 34.2, 'Y'),
(15225, 'Adams', 'Poppy', '2015/02/14', 'F', 34.0, 39.2, 'N'),
(15226, 'Johnson', 'Tierra', '2019/08/15', 'F', 14.6, 24.5, 'Y'),
(15227, 'Khouri', 'Mohammed', '2014/03/30', 'M', 41.5, 44.1, 'Y'),
(15228, 'Jones', 'Ben', '2011/04/04', 'M', 70.1, 52.2, 'Y'),
(15229, 'Kowalczyk', 'Alexandra', '2019/08/27', 'F', 15.2, 23.9, 'Y');

select * from paciente;

insert into paciente (id_paciente,apellido,nombre,dob,genero,peso,altura,esta_vacunado)
	values(14100, 'viltez', 'hernan','1984/06/15', 'M', 80.4,40.5, 'Y'),
		(14101, 'viltez', 'javier','1999/06/15', 'M', 89.4,45.5, 'N');


update paciente set esta_vacunado='Y' 
	where genero='F' and dob between '2015/1/1' and '2019/1/1';

alter table paciente alter column genero type varchar(20);
update paciente set genero='Femenino' 
	where id_paciente in (15223, 15225, 15229);

update paciente set peso= peso+2 
	where altura>39;

delete from paciente 
	where nombre like '%am%';


insert into paciente (id_paciente,apellido,nombre,dob,genero,peso,altura,esta_vacunado)
	values(14108, 'viltez', 'hernan','2014/06/15', 'M', 80.4,40.5, 'N');
delete from paciente
	where genero= 'M' 
	and esta_vacunado='N' 
	and dob between '2014/1/1' and '2015/1/1';

delete from paciente;

drop table paciente;