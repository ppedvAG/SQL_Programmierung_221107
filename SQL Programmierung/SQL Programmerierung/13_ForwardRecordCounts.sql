--Spalten zu Tabellen hinzuzuf�gen kann seltsame Ph�nome verursachen

--Befehl f�r die mittlere Seitendichte

dbcc showcontig('KU')

--94810-- 107707
set statistics io, time on
select * from ku where country like '%X%'

--alter table add Spalte

--wie kann man dummes phyiskalische Tabellen design fststellen
-- forward recordcount

select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku'),NULL,NULL,'detailed')


--CLustered IX erstellen auf Tabelle... dann werden die frc aufgel�st..
--der CL IX k�nnte danach gel�scht werden
--Tab mit CL IX haben nie frc


