verwende nie UNION , wenn du weisst dass es keine doppelten DS gibt...

select 100
UNION 
select 200
union 
select 300

select 100
union
select 100




select * from orders
--alle Datesätze auf dem Jahr 1997 (orderdate)

select * from orders where year(orderdate) = 1997  --korrekt aber langsam --immer scan

select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.999'  --schnell aber falsch 

select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.997'  

--das datetime wird intern als INT gespeichert  Spanne von 2 bis 3 ms)


--Logischer FLuss


---> FROM (ALIAS)--Reihe nach die JOIN Tabellen und ALIAS --> 
--> where ---> group by ---> having  --> select --> Ergebnis --> order by  --> top  / Distinct


--Dinge die man nicht tun darf:
--tu nie im having etwas filtern, was ein where kann oder 
--im having sind immer nur AGG zu finden

