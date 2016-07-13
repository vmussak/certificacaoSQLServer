


-- Exercise 1

	SELECT  c.custid,
			c.city,
			COUNT(*) AS quantidade
		FROM Sales.Customers c
			INNER JOIN Sales.Orders o
				ON o.custid = c.custid
		WHERE c.country = 'Spain'
		GROUP BY c.custid, c.city;

-- Exercise 2
	
	SELECT  c.custid,
			c.city,
			COUNT(*) AS quantidade
		FROM Sales.Customers c
			INNER JOIN Sales.Orders o
				ON o.custid = c.custid
		WHERE c.country = 'Spain'
		GROUP BY GROUPING SETS((c.custid, c.city), ())
		ORDER BY GROUPING(c.custid);

/*
	Lesson Review

	1. D
	2. B
	3. A
*/


-- Exercise 1
	
	WITH PivotData AS
	(
		SELECT  YEAR(o.orderdate) AS orderyear,
				o.shipperid,
				o.shippeddate
			FROM Sales.Orders o
	)
	SELECT p.orderyear,
			[1],
			[2],
			[3]
		FROM PivotData p
		PIVOT(MAX(p.shippeddate) FOR p.shipperid IN ([1], [2], [3])) AS p;

-- Exercise 2
	
	WITH PivotData AS
	(
		SELECT  o.custid,
				o.orderid,
				o.shipperid
			FROM Sales.Orders o
	)
	SELECT p.custid,
			[1],
			[2],
			[3]
		FROM PivotData p
		PIVOT(COUNT(p.orderid) FOR p.shipperid IN ([1], [2], [3])) AS p;

/*
	Lesson Review

	1. B
	2. A e B
	3. D
*/

	SELECT  custid, 
			orderid,    
			val,   
			SUM(val) OVER(PARTITION BY custid) AS custtotal,   
			SUM(val) OVER() AS grandtotal 
		FROM Sales.OrderValues;

-- Exercise 1

	SELECT  o.custid,
			o.orderid,
			o.val,
			o.orderdate,
			AVG(o.val) OVER (PARTITION BY o.custid 
								ORDER BY o.orderdate
									ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
							) as media
		FROM Sales.OrderValues o;

-- Exercise 2

	-- select * FROM Sales.Orders

	WITH Sales AS (
		SELECT  ROW_NUMBER() OVER(PARTITION BY o.shipperid ORDER BY o.freight DESC, o.orderid) AS numero,
				o.shipperid,
				o.orderid,
				o.freight
			FROM Sales.Orders o
	)
	SELECT  s.shipperid,
			s.numero,
			s.orderid,
			s.freight
		FROM Sales s
		WHERE s.numero < 4;
		
-- Exercise 2.2

	SELECT  o.orderid,
			o.val,
			o.val - (LAG(o.val) OVER (PARTITION BY o.custid ORDER BY o.orderdate, o.orderid)) AS subant,
			o.val - (LEAD(o.val) OVER (PARTITION BY o.custid ORDER BY o.orderdate, o.orderid)) AS subpos
		FROM Sales.OrderValues o;

/*
	Lesson Review

	1. A ou B
	2. B
	3. A
*/

/*
	Case Scenarios 1

	1 - Now we can use new features from T-SQL, like CTE and window funcions. Another thing that we can use is PIVOT, it's very userfull for data analyst.
	2 - We can use PIVOT to translate the data from rows to columns, then insert into some table.
	3 - We can use functions like LAG and LEAD, with that is possible to acess rows next and before the current row.
*/

/*
	Case Scenarios 2

	1 - ROW_NUMBER returns the corresponding line number associated at the row. The Rank returns the number of the correspondent position joing the lines with same value.
	2 - 
	3 - Because it's acessed just from SELECT and ORDER BY clausules. If you need to filter some datas based on window functions result, you can use a CTE ou subquery to do that.
*/