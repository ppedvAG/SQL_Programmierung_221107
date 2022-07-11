--Part Sicht

--statt einer  großen Tabelle viele kleinere tabellen

--statt einer großen Umsatz tabelle viele kleinere. geht auch kw02_2022Umsatz etc... Umsatz_Jan  Umsatz_Feb

create table u2020 (id int identity, jahr int, spx int)
create table u2022 (id int identity, jahr int, spx int)
create table u2021 (id int identity, jahr int, spx int)
create table u2019 (id int identity, jahr int, spx int)


--Client braucht wieder "Umsatz"

create view Umsatz
as
select * from u2022
UNION ALL --keine Suche nach doppelten 
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019

--geht
select * from umsatz


--Plan.. wie geht SQL vor.. und Statistics

set statistics io, time on

select * from umsatz

select * from umsatz where jahr = 2020





--Garantie, dass die Daten immer korrekt in der richtigen Tabelle landen

--zb create table tabelle (id int, spx not null)
ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2020)



	--INS UP DEL

--INS UP DEL geht, aber nur dann wenn: 
--kein identity Wert mehr in den Tabellen
--der PK darf nicht nur aus der ID bestehen  zB ID und Jahr


--ID ohne Identity
-- 1 2 3 4 5 6 7 
--select max(id) +1

--Sequenzen
USE [Northwind]

GO

CREATE SEQUENCE [dbo].[seqID] 
 AS [int]
 START WITH 1
 INCREMENT BY 1

select next value for seqID


---Partitionierung

create table testdaten ( id int)--wo ist die Tabelle-- mdf Datei oder auch Dateigruppe Primary

create table testdaten (id int) ON [PRIMARY] --Pfad zur mdf 

create table testABC (id int) on hot


----Part Funktion  Part Schema  Dateigruppen


--int---------------100----------------------200-----------------
---                1                              2                                       3

--0 bis 100  1
100 bis 200  2
200 bis 300  3
..
create partition function fzahl(int)
as
RANGE LEFT FOR VALUES (100,200) --1 2 3


select $partition.fzahl(117) --2

--jetzt das Part Schema

create partition scheme schZahl
as
partition fzahl to (bis100, bis200, rest)
-------------             1         2           3

drop table parttab

create table partTab ( id int identity, nummer int, spx char(4100)) ON schZahl(nummer)

--1 DS hat schon wieder 8 KB wg 51% Füllgrad

--20000 DS .. 18 Sekunde
set statistics io, time off

--warum sind Schleifen schneller als GO 
--bei GO waren es 20000 Batches mit jeweils einer TX

--in der WHILE 1 Batch aber 20000 TX
--noch besser mit einer TX 

declare @i as int = 1
begin tran
while @i <= 20000
	begin 
			insert into partTab values (@i, 'XY')
			set @i+=1  ---  set @i=+1
	end
commit


--ist das nun besser ?

set statistics io, time on


select * from parttab where id = 117
--20000 Seiten  mit ca 15ms Dauer /CPU
-- Table Scan.. geht alles durch 

select * from parttab where nummer = 117
--Seiten:   100   Dauer: ca 0 


select * from parttab where nummer = 1170


------------100----------------------200------------------------------------5000-----------------------------------
--neue Grenze aber wie
-- Tabelle / partF()  / part (Schema)   / Dgruppen

--    -                x              x                           x

alter partition scheme schZahl next used bis5000

alter partition function fzahl()  split range (5000)--werte werden automatisch sofort verschoben


--kann man eine Grenze entfernen?
--Tabelle, F(),  Schema, Dgruppen
--     -         x       -                -

alter partition function fzahl()  merge range (100)

select * from parttab where nummer = 117


select $partition.fzahl(nummer), min(nummer), max(nummer), count(*) from parttab
group by $partition.fzahl(nummer)


--Kombinierbar












