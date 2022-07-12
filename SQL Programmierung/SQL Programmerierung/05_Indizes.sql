--INDIZES

/*

CLUSTERED
= Tabelle in sortierter Form
nur 1 mal
ist gut, wenn Bereiche abgefragt werden, aber auch bei einzlenen Treffern
CL IX ist oft pure Verschwendung als PK

PK möchte nur eines .. eindeutigkeit ereichen

NON CLUSTERD
eine Kopie der Daten in sortierter Reihenfolge
ca 1000 IX pro Tabelle
ist gut , wenn rel wenig rauskommt

--zuerst den CL IX auf Spalten festlegen, die häufig nach Bereichen durchsucht werden

*/

--wg PK als GR IX keine gute Bereichsabfrage mehr
select * from best --Cl scan


eindeutiger IX
die IX Spalten dürfen nur einmal vorkommen

zusammengesetzter IX
besteht im ganzen Baum aus den Spalten mit denen der IX gemacht wurde
max 16 Spalten
max 4 Spalten 

gefilterter IX
nicht alle Daten sind im IX enthalten

IX mit eingeschlossenen Spalten   
legt die SELECT Spalten am Ende des Baum an, belasten die Suche nicht ca 1023 Spalten verwendbar


part. IX

ind Sichten

abdeckender IX
der ideale IX: kein Lookup, kein SCAN


select * from customers

--Tool
realer hypothetischer IX

--
Columnstore IX


set statistics io, time on
-------------------------------INDIZES -----------------------------
--TABLE SCAN
select * from ku where id = 10 --60000 Seiten   200/50

select id from ku where id = 10

--zuerst Spalte für CL IX aussuchen: Orderdate
select id from ku where id = 10 -- NIX_ID eindeutig

--jetzt: IX SEEK  3 Seiten 0/4 ms

select id, freight from ku where id = 10 --IX Seek mit Lookuo   0/2 ms 


select id, freight from ku where id < 100 --IX Seek mit Lookup (99%)  ..103 Seiten  072 ms


select id, freight from ku where id < 13000 -- ab ca 1,x %Wechsle zu Table SCAN


--besser, wenn Lookup weg--in den IX Spalte des SELECT mit reinnehmen
--NIX_ID_FR

select id, freight from ku where id < 900000 --immer noch Seek


select sp1, s2, sp3, sp4 from tab where sp3 = 10
--      SELECT                                          WHERE
--    unterste Ebene                                                      IX BAUM


--NIX_ID_incl_FR
select id, freight from ku where id < 900000

--GR IX ? nö wg orderdate
-- NGR_EI_FR_incl_CYCIUPQU
select country, city, sum(unitprice*quantity) from ku
	where freight < 1 and employeeid = 2
group by country, city

--eigtl 2 IX , aber SQL schlägt nix mehr vor
select country, city, sum(unitprice*quantity) from ku
	where freight < 1 or employeeid = 2
group by country, city


--NIX_CY_PD_INCL_CI_FR_ WELT
--NIX_CY_PD_INCL_CI_FR_ USA --null vorteil

select city , freight from ku 
where country = 'USA' and productid =10

--falls Landfilter ok wäre.. eigtl für jedes Kand evtl

---Idee :Partitionieruing


create partition function fland (varchar(50))
as range left fr values ('Ägypten','ALbanien'''


select country, count(*) from ku --8207 --it = 141 ms, verstrichene Zeit = 148 ms.
group by country

create or alter view vdemo with schemabinding
as
select country, count_big(*) as Anzahl from dbo.ku --8207 --it = 141 ms, verstrichene Zeit = 148 ms.
group by country

select * from vdemo--schnell 2 Seiten 0 ms

--aber.. 


select * into ku2 from ku
select * into ku3 from ku

--HEAP


select top 3 * from ku2
--Abfrage : best Spalten , AGG , where 

select country, sum(unitprice*quantity) from ku2
where country = 'USA'
group by country --Seiten 764  16ms

--Clumnstore IX
select country, sum(unitprice*quantity) from ku3
where country = 'USA'
group by country --Seiten 764  16ms


--Tabelle KU2:  410MB
--Tabelle KU3: 3,5 MB  !!

--geht dch nur, wenn Kompression
.--zusätzlich Archivkompression: 3,0



select country, sum(unitprice*quantity) from ku2
where employeeid =2
group by country --Seiten 764  16ms

select country, sum(unitprice*quantity) from ku3
where employeeid =2
group by country --Seiten 764  16ms



--IX Rebuild  > 30%
--IX Reorg     >10% < 30%
--< 10% --> nix

--200 MB HEAP
--1 GR + 2 NGR --  363 MB

REBUILD: 
OFFLINE     ONLINE
mit     oder  ohne     tempdb
größter Aufwand: ONLINE + tempdb   --> 1100MB
min. Aufwand:   860MB

--Optimierungsprobleme
--SQL Sever macht zuerst das AND
--Setze klammern !
select country, sum(freight) from ku
where  (city = 'Paris' or productid = 4) and employeeid = 2 


select country, sum(freight) from ku
where  (city = 'Paris' or (productid = 4) and employeeid = 2 )


--Reihenfolge  spielt zunächst keine Rolle
select country, sum(freight) from ku
where  country = 'USA' and City = 'New York'
--aber im IX schon.. die selektivere zuerst.. die, die weniger DAtenzeilen auspuckt




--JOIN: LEFT RIGHT INNER CROSS FULL


--LOOP JOIN HASH  MERGE



select * from customers --cl ix sortiert
select * from orders


select * from customers c inner join orders o on c.CustomerID=o.CustomerID


Loop Join


select * from customers c inner merge join orders o on c.CustomerID=o.CustomerID

select * from customers c inner loop join orders o on c.CustomerID=o.CustomerID

select * from customers c inner hash join orders o on c.CustomerID=o.CustomerID






select country as Land, sum(freight) as SummeFracht  from ku k
where country = 'USA'
group by country having 
order by country

select country as Land, sum(freight) as Summe, k.City  from ku k
where employeeid = 9
group by country, city having sum(freight) > 100
order by Land





























