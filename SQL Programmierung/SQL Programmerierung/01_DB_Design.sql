--DB Design

/* Stichworte

Normalform   --mehr Joins
1 NF atomar  jede Zelle nur ein Wert ;-)
2. NF  Primärschlüssel auf jeder Tabelle
3. NF keine Abhängigkeiten bei den Spalten ausserhalb des PK



Redundanz  (Datawarehouse).. schnell

Generalisierung zentrale Ablage gemeinsamer Merkmale (PLZ Ort



Northwind

--gibts denn ein Feld mit varchar?
-- in einigen Fälle brauuchen wir doppeltten Speicherplatz umsonst
--Customerid nChar
--Datumsfelder
-- muss ich tats. auf ms wissen, wann es gekauft wurde
--Birthdate


Daten werden 1:1 in RAM geschoben
*/
select customerid, country from customers


Datentyp

Otto
varchar(50).....  4   'Otto'
nvarchar(50)..  4*2 = 8  'otto'
char(50)...		50    'otto                                  '
		8000
nchar(50)...      50*2=100  'otto                          '
text() .. gar nicht mehr nehmen.. seit SQL 2005 depricated
max Länge ist 2 GB


Primärschlüssel
Aufgabe:  Beziehung   1:N
Muss: der Wert muss eindeutig sein


Beziehung
Garantie für ref Integrität

*/


--logische Design

create table txy (id int identity, spx char(4100))

insert into txy
select 'xy'
GO 20000   --21 Sekunden

--Wie groß ist die Tabelle?   ..ca 80MB---warum ist dieses Ding aber 160MB groß

--Physikalische DB Design   -- Verbessern des DB Designs

--Optimierung: ideale Datentypen: nicht zu groß nicht klein
--Wie hoch war der Umsatz in Q1 2022 in DE
--Abfrage Customers--> Orders --> Order Details
--               1 MIO              2 MIO          4 MIO  -->  7 MIO

--wird redundanz gezielt verwendet  (Joins sparen) wirds schneller
--Redundanzpflege:  Trigger (aber langsam),
-- alles auch Logik in Prozedur.. Rechte auf Tabelle verweigern

select * from ausleihkopf where datepart(qq,leihdatum ) = 1 

--sobald eine F() um eine Spalte in der Where Bedingung lilegt ist es die schlechteste variante
--> Table Scan



create table txyz (id int identity, spx char(4100), spy char(4100))



--kamm man Seitenverschleiss messen

dbcc showcontig() --ganze DB
dbcc showcontig('txy')
--- Gescannte Seiten.............................: 20000
- --Mittlere Seitendichte (voll).....................: 50.79%


--- Gescannte Seiten.............................: 200000
- --Mittlere Seitendichte (voll).....................: 80.79%



--IO (Seiten) -->RAM
					  --> CPU

--kann man die Seiten bei Abfragen messen

set statistics io, time on --off
--IO = Anzahl der Seiten
--Dauer = Gesmate Dauer in ms
--CPU - CPU Zeit in ms
--nur messen wenn notwendig
--SQL Server-Analyse- und Kompilierzeit:  wie lange braucht der SQL Server um den besten Weg zu den Daten zu finden

select * from customers


--kann man fststellen, warum etwas langsam war.. 
select * from sys.dm_os_wait_stats

--     Suspended               RUNNABLE 
----|-----------------------|--------| RUNNING
--  0                                  50          70#

--Gesamte Zeit minus Siganlzeit = Wartezeit auf Ressource

--kann man erausfinden, welche Tabelle sehr häufig abgefragt werden
select db_name(database_id), object_name(object_id),* from sys.dm_db_index_usage_stats

select * from customers where country like '%UK'
select * from customers where  country = 'UK'


--im Plan SCAN: alles von A bis Z durchlesen.. weil kein vernünftiger IX vorhanden ist
--SEEK = gezieltes herauspicken

select * from customers where customerid like 'A%'
select * from customers where left(customerid ,1) = 'A'


