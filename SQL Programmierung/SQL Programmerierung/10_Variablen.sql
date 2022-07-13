/*  Variablen sind keine Parameter



@var1
lokal
Lebenszeit: der Batch .. achtung GO

@@var2
global
wie bei lokal
Lebenszeit wie bei lokal

Sinn einer globalen Variablen: 

*/


declare @i as int = 0
GO
select @i


--Variablen können nicht gut geschätzt werden
declare @DAtum as datetime
select @Datum = dateadd(yy,-65, getdate())

select * from employees where birthdate < @datum

--besser
select * from employees where birthdate < dateadd(yy,-65, getdate())

--vor allem dann ein Problem , wenn der Var ein Wert durch eine Abfrage auf Tabellen zugewiesen werden soll



