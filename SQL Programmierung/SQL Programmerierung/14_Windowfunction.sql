--Ranking

--RANK() denserank  Ntile

select row_number() over (order by shipcountry),shipcountry, freight from orders

select shipcountry, freight , row_number() over (partition by shipcountry order by freight)    from orders
order by 1,2

--dense rank ntile
select freight, ntile(10) over (order by freight) from orders


select lag(freight,2)over (order by convert(date, orderdate)),
		lead (freight,2) over (order by convert(date, orderdate)),
		convert (date, orderdate), freight
		from orders order by orderdate


	--der letzte Tag des Monats

	select EOMONTH(getdate())

	andreasr@ppedv.de



