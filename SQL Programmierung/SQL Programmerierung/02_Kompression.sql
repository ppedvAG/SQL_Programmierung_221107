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
--RAM nach Ausf�hrung  400

--Seitenlkompression: noralerweise ist mit 40 bis 60% zu rechnen




--SQL Neustart
set statistics io, time on

--Taskmanager: k�nnte mehr sein, k�nnte gleich .. hat sich eigtl nicht ver�ndert

select * from northwind.dbo.txy
--Seiten: 20000 --> weniger 29
--CPU: eigtl mehr, da beim �bergeben an Client mehr Aufwand in der Praxis meist mehr CPU Aufwand
--Dauer:  je nach Datenlast..
--RAM nach Ausf�hrung  weniger da Seiten 1:1 in RAM...


--Kompression macht man eigtl  wg Anderen wichtigen Daten, di8e dann besser in RAM passen oder auch l�nger
--Kompression ist f�r den Client transparent.. er bekommt die gleichen Datenmengen wie vorher
