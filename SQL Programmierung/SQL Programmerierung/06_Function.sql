select city from ku where country = 'USA'

select city from ku where left(country,3) = 'USA'

--Birthdate.. alle im Rentenalter : 65
select * from employees where datediff(yy,birthdate, getdate()) > = 65 --scan

select * from employees where birthdate < dateadd(yy, -65, getdate())  --seek

