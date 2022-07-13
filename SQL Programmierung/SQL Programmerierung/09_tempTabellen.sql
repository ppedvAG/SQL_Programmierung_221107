--temp Tabellen

/*
Zwaischenergebnisse aus langen Rechenwegen ... auf man später immer wieder zugreifen muss
diese landen  in tempdb


#tabelle
lokale temp Tabelle

temp:	solange ErstellerSession offen und Tabelle nicht gelöscht
lokal:   es kann nur der Ersteller zugreifen

##tabelle
globale temp Tabelle
temp:  existiert solange bis Ersteller weg ist oder sie gelöscht hat, aber 
global: auch andere können darauf zugreifen, aberbest Abfragen würde nicht unterbrichen werden


*/

select * into #t from sysfiles
select * into ##t from sysfiles


select * from #t





--cube rollup


--anzahl der Kunden pro Land und Stadt

select country, city, count(*) from customers
group by country, city order by 1,2

--es werden alle Zwischenergebnisse der Hierarchie(Reihe) nach errechnet
select country, city, count(*) from customers
group by country, city 
with rollup
order by 1,2

--jedes mögliche Aggregat
select country, city, count(*) as Anzahl into #result from customers
group by country, city 
with cube
order by 1,2

select * from #result

--ix sind auch möglich
create nonclustered index nix on #result(city)

--temporäre Proc weil kein Recht normale anzulegen
create proc #proc1 @par1 int
as
select getdate()


