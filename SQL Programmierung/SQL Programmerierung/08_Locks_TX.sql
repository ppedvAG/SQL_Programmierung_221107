--Locks   Latches

--Locks erzeugen TRansactions und sperren andere Abfragen
--Latch interne Sperre... ein Prozess hindert den anderen


select * into kunden from customers




--TX können rückgängog gemacht werden, dann aber
--wird alles was in der TX stattfand rückgängig gemacht
begin tran
select @@TRANCOUNT
select * from kunden
update kunden set city = 'Paris' where customerid = 'ALFKI'
update customers set city = 'Paris' where customerid = 'ALFKI'


rollback-- rückgängig
commit-- jetzt fix




--Default: READ COMMITTED- nach commit

--READ uncommited .. Lesen trotz TX..den akt Wert aus der TX

--REPEATBALE READ: LESEN verhindert schreiben
--SERIALZABLE verhindert auch ein INsert, was das Repeatable read nicht tun



--Sperrniveaus:
--Datenbank
--Tabelle--> Partition--->Block-->Seiten--> DS

/*
nur per IX kann das Sperrniveau gesenkt werden
ist eine Zeile betroffen oder wenige Zeilensperre  (91bytes)
sind aber viele Zeilen einer Seiten betroffen--> statt 300 Sperrren zu setzne--> 1* Seitensperre (91bytes)
--> jetzt sind aber auch DS gesperrt , die man gar nicht braucht
sind mehr Seiten betroffen, dann Block
ist fast gesamte Tabelle betroffen --> Tabelle

Ausnahme: Partitionsperre geht auch ohne Indizes

halte daher TX  so kurz wie möglich

