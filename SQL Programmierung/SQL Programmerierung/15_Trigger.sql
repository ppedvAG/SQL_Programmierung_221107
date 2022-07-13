/*

Trigger:  DDL (INS UP DEL) 
			  DML (CR; AL DR)

DDL: INS wird Tabelle erstellt inserted
         DEL                                   deleted
		 UP                 inserted und deleted

TX --löst durch INS UP DEL einen Trigger aus... dann Rollback.. werden auch rückgängig gemacht

*/

create trigger trgdemo ON Tabelle
for INSERT, UPDATE, DELETE
as
Code


create trigger trgDemoKunden on Kunden
for INSERT, UPDATE, DELETE
as
select * from inserted
select * from deleted


--Orders zus Spalte rgs
alter table orders add rgs money


create trigger trgdemo ON Tabelle
for INSERT, UPDATE, DELETE
as
Code


create or alter  trigger trgrgs on [order details]
for insert, update, delete
as

declare @rgsumme as money
select @rgsumme =sum (unitprice*quantity) from [Order Details] where orderid = (select distinct orderid from inserted)

update orders set rgs = (select sum (unitprice*quantity) from [Order Details] where orderid = (select distinct orderid from inserted))
 (select distinct orderid from inserted)

update [Order Details] set Quantity = 10 where orderid = 10248 and productid = 11


select * from orders

select @rgsumme =sum (unitprice*quantity) from [Order Details] where orderid = (select distinct orderid from inserted)

update orders set rgs = 

















--Trigger der die rgsumme aktualsiert




update kunden set city = left(city,5)