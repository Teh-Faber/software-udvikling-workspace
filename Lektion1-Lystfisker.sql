SHOW DATABASES;
CREATE DATABASE Lektion1_Lystfisker;
USE Lektion1_Lystfisker;

SHOW TABLES;
create table fisk (
  fisk_id int not null,
  navn char(25) not null,
  max_laengde_cm int not null,
  primary key (fisk_id)
); 

create table plads (
  plads_id int not null,
  navn char(25) not null,
  afstand_fra_hjem_km int not null,
  primary key(plads_id)
);

create table redskab(
  redskab_id int not null,
  navn char(25) not null,
  vaegt_gram int not null,
  primary key (redskab_id)
);

create table fisketur(
  fisketur_id int not null,
  dato date not null,
  plads_id int not null,
  primary key (fisketur_id),
  foreign key (plads_id) references plads(plads_id)
);

create table fangst(
  fangst_id int not null,
  tid time not null,
  laengde_cm int not null,
  fisk_id int not null,
  fisketur_id int not null,
  redskab_id int not null, 
  primary key (fangst_id),
  foreign key (fisk_id) references fisk(fisk_id),
  foreign key (fisketur_id) references fisketur(fisketur_id),
  foreign key (redskab_id) references redskab(redskab_id)	
);

insert into fisk values
 (1,'Hornfisk',90),
 (2,'Torsk',120),
 (3,'Skrubbe',50),
 (4,'Makrel',45),
 (5,'Laks',120);
 
insert into plads values
 (1,'Knudshoved',31),
 (2,'Vresen',45),
 (3,'Fyns Hoved',48),
 (4,'Gabet',24),
 (5,'Kajbjerg',34);

insert into redskab values
 (1,'Rødt blink',25),
 (2,'Grøn flue',5),
 (3,'Forfang',55),
 (4,'Blankt blink',35),
 (5,'Gult blink',28);

insert into fisketur values
 (1,'2018-10-18',4),
 (2,'2019-11-23',2),
 (3,'2019-06-12',3),
 (4,'2019-12-11',1),
 (5,'2020-01-02',1),
 (6,'2014-10-14',5);

insert into fangst values
 (1,'12:17:00',48,4,5,1),
 (2,'15:38:00',35,3,4,3),
 (3,'19:30:00',50,2,3,5), 
 (4,'09:28:00',41,1,2,4),
 (5,'07:12:00',43,5,1,2),
 (6,'05:48:00',55,1,3,2),
 (7,'09:56:00',62,2,6,4);


-- Q1: Vis navnene på samtlige fisk i stigende alfabetisk orden.
SELECT fisk.navn 
FROM fisk 
ORDER BY navn;

-- Q2: Vis navnet på fangstpladser, hvor der er fisket i oktober måned. 
SELECT plads.navn 
FROM plads, fisketur 
WHERE plads.plads_id = fisketur.plads_id AND 
	MONTH(fisketur.dato) = 10;

-- Q3: Vis datoer på samtlige fisketure og navnet på fangstpladsen.
SELECT plads.navn, fisketur.dato 
FROM plads, fisketur 
WHERE plads.plads_id = fisketur.plads_id;
 
-- Q4: Vis navne på de redskaber, der er fisket med ved Kajbjerg.
SELECT redskab.navn 
FROM redskab, fangst, fisketur, plads 
WHERE redskab.redskab_id = fangst.redskab_id AND 
	fangst.fisketur_id = fisketur.fisketur_id AND 
	fisketur.plads_id = plads.plads_id AND 
    plads.navn = 'Kajbjerg';
