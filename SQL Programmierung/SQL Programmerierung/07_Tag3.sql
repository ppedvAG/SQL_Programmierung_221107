--Tag 3

--IM Tabellen

/*
Indizes

ab wann macht SQL Serer keine Vorschläge mehr.. zB ab or in where

sobald ein Join in einer Adhoc Abfrage aufrtitt ird der Plan nicht mehr parametrisiert!
--Plan neuüberlegung

mit welchem Instrument bekommt man immer eine Plan vorgefertigt
Stored Procedure generiert beim ersten Aufruf mit dem ersten Parameter einen Plan
Vorteil der Proc ist auch ihr Nachteil...
toDO : intern auf andere Proc verweigen oder best Anweisunge nicht zulassen  "alles " zb


Sicht
 with schemabinding    :  kein * 
										: muss!  Angabe des Schemas

nicht tun: nicht zweckentfremden.. zb Abfrage die 2 Tabellen braucht, Sicht aber 10 Tabellen abfragen muss
 


 --Funktion


*/


select * from orders o 
inner join customers  c on c.CustomerID=o.CustomerID
where orderid = 10250

select * from [order details]

--Rechnungsumme

select * from orders--Rechnungsumme


1 MIO KD ---> 2 MIO Best ---> 4 MIO 


--? wie kann an die Rechnungssumme in Orders reinbringen

--Sicht zunächst keine Lösung, da immer noch Abfrage auf Order details
--Trigger: --ja machbar--- aber evtl langsam
--F()

--Skalarwertfunction
create function fname (@par1 int) returns int
as
BEGIN
		return (select ...)
END


select dbo.fRngSumme(10248) --440



create function fRngSum(@Bestnr int) returns money
as
begin 
	return (select sum(unitprice*quantity) from [Order Details] where  orderid =@Bestnr)
end

select dbo.fRngSum(10248)

set statistics io, time on
select * from orders where dbo.fRngSum(orderid) < 1000

select dbo.fRngSum(orderid), * from orders


alter table orders add RngSumme as dbo.frngsum(orderid)

select * from orders









