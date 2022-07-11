--wie mach ich die Anzahl der Seiten geringer

--Kompression: 
--Seiten,, Zeilenkompression

--SQL Neustart
set statistics io, time on

--Taskmanager: RAM Verbrauch des SQL Servers  240 MB --> steigt auf ca 400, da 2000 Seiten in RAM kommen

select * from northwind.dbo.txy
--Seiten: 20000
--CPU: 93
--Dauer: 1858
--RAM nach Ausführung  400

--Seitenlkompression: noralerweise ist mit 40 bis 60% zu rechnen




--SQL Neustart
set statistics io, time on

--Taskmanager: könnte mehr sein, könnte gleich .. hat sich eigtl nicht verändert

select * from northwind.dbo.txy
--Seiten: 20000 --> weniger 29
--CPU: eigtl mehr, da beim Übergeben an Client mehr Aufwand in der Praxis meist mehr CPU Aufwand
--Dauer:  je nach Datenlast..
--RAM nach Ausführung  weniger da Seiten 1:1 in RAM...


--Kompression macht man eigtl  wg Anderen wichtigen Daten, di8e dann besser in RAM passen oder auch länger
--Kompression ist für den Client transparent.. er bekommt die gleichen Datenmengen wie vorher
