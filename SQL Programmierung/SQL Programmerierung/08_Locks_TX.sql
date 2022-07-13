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
rollback-- rückgängig
commit-- jetzt fix



--Default: READ COMMITTED- nach commit

--READ uncommited .. Lesen trotz TX..den akt Wert aus der TX

--REPEATBALE READ: LESEN verhindert schreiben
--SERIALZABLE verhindert auch ein INsert, was das Repeatable read nicht tun



--Sperrniveaus:
--Datenbank
--Tabelle--> Partition--->Block-->Seiten--> DS

