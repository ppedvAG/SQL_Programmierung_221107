--Sichten und deren Problem
drop table slf

create table slf (id int, stadt int, land int, fluss int)

insert into slf
select 1,10,100,1000
UNION ALL
select 2,20,200,2000
UNION ALL
select 3,30,300,3000

select * from slf

--Sicht


create or alter view vslf with schemabinding
as
select id, stadt, land, fluss from dbo.slf

select * from vslf

--Sicht ist genauso schnell wie adhoc Abfrage
select * from (select * from slf) vslf

--Warum Sichten: komplexe Abfragen vereinfachen
--wg Security


alter table slf add tier int

update slf set tier = id *10000

select * from slf


select * from vslf --tier fehlt obwohl * .. weil * aufgelöst..neee er merkt sich das Ausgabeschema

alter table slf drop column land

select * from vslf


--with schemabinding---> man muss genau arbeiten .. kein *  und angabe des Schemas notwendig


create view v2
as
SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Employees.LastName, Employees.FirstName, [Order Details].ProductID, [Order Details].OrderID, [Order Details].UnitPrice, [Order Details].Quantity, Orders.OrderDate, Orders.Freight, 
                   Products.ProductName
FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID


select * from v2
--ich brauche--aKunde und deren Bestellungen unter 100 Frachtkosten

set statistics io, time on
select distinct companyname  from v2 where freight < 100

select distinct  companyname from customers c inner join orders o on c.customerid = o.customerid where o.freight < 100


--Sicht nicht zweckentfremden


select * into ku4 from ku --KU4 = HEAP

select * from ku4 where id < 2 --T SCAN

--PROZEDUREN  -- besser oder schlechter oder gleich wie adhoc Abfrage

--besser : weil komplette Logik gekapselt
--sicherer und schneller

exec suchId 2

create proc suchID @id int
as
select * from ku4 where id < @id


select * from ku4 where id < 2 --T SCAN--> NIX_ID .. 0ms    4 seiten




select * from ku4 where id < 20000 --> TAB SCAN --47423   500ms



exec suchID 2


exec suchID 1000000

---1 MIO Seiten , CPU-Zeit = 3219 ms, verstrichene Zeit = 15707 ms.

select * from ku4 where id < 1000000 --> TAB SCAN --47423   500ms

dbcc freeproccache

--Warum sollten PROZ schneller sein?
--die Proz macht den Plan beim ersten Aufruf der Proz anhand der Parameter.. dann ist der Plan fix auch nach neustart


---Was sollte man nun tun?
---zb wenn der Plan auch der best wäre.. zb id unter 12000
--was sollte nicht sein: mal einer mal alle

--Customerid nchar(5)
--customers (customerid)
exec gpSucheKunden 'ALFKI' --1 Treffer --seek

exec gpSucheKunden 'A' --4 Treffer --seek immer noch ok

exec gpSucheKunden  '' --91 Treffer--scan wäre besser 

create or alter proc gpSucheKunden @Custid nvarchar(5) ='%'
as
select * from customers where customerid like @Custid +'%'

--selten schlecht ...


create or alter proc gpSucheKunden @Custid nvarchar(5) ='%'
as
IF
exec gpSuchealle^ --scan

else
exec gpsuchebestKunden --seek




--wie finde ich zu Proz den besten Plan


select * from customers where customerid like @Custid +'%'