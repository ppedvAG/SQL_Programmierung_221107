--CTE

---spez Aufbau

;WITH CTENAME (Spalte1, Spalte2..)
as
(select spa, spb from ....)
select * from ctename

with CTE
as
(select customerid, country, city from customers)
select * from cte

select customerid, freight from orders

--wie hoch sind die durchschnit max Frachtkosten der Kunden

select customerid, avg(max(freight)) from orders  group by customerid --geht nicht

select avg(MaxFr) from 
(
select customerid, max(freight) as maxFr from orders  group by customerid --geht nicht
) t

with cte(Kunde, Maxfr)
as
(select customerid, max(freight) as maxFr from orders  group by customerid)
select avg(MaxFr) from cte



select employeeid, reportsto from employees



WITH CTE (SPALTE)
as
(select ... --Basis/Anker--wer ist der Chef
UNION ALL
select * from tab inner join CTE
)
select cte

with cteang
as
(
select employeeid, lastname,0 as Ebene from employees where reportsto is null
UNION ALL
select e.employeeid, e.lastname,Ebene+1 from employees e inner join cteang on e.reportsto=cteang.EmployeeID)
select * from cteang where Ebene = 2


19      2/4/8  XML
