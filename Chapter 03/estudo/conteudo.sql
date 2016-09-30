

--  FILTERING DATA WITH PREDICATES

	-- ON
	-- WHERE
	-- HAVING

-- PROBLEMA DE MANIPULAR DADOS NO WHERE

	-- usando funcao
	SELECT  orderid, 
			orderdate, 
			empid
		FROM Sales.Orders
		WHERE COALESCE(shippeddate, '19000101') = COALESCE(@dt, '19000101');

	-- alternativa
	SELECT  orderid, 
			orderdate, 
			empid	
		FROM Sales.Orders
		WHERE shippeddate = @dt OR (shippeddate IS NULL AND @dt IS NULL);

-- FILTERING CHARACTER DATA

	-- like-patterns.jpg

	-- exemplo
	SELECT  empid, 
			firstname, 
			lastname
		FROM HR.Employees
		WHERE lastname LIKE N'D%';

	-- Performance of the LIKE Predicate.jpg


-- FILTERING DATE AND TIME DATA

	-- exemplo
	SELECT  orderid, 
			orderdate, 
			empid, 
			custid
		FROM Sales.Orders
		WHERE orderdate = '02/12/07';
		-- WHERE YEAR(orderdate) = 2007 AND MONTH(orderdate) = 2;
		-- WHERE orderdate >= '20070201' AND orderdate < '20070301';
		-- WHERE orderdate BETWEEN '20070201' AND '20070228 23:59:59.999'


	-- problema 
	SELECT  orderid, 
			orderdate, 
			custid, 
			empid
		FROM Sales.Orders
		WHERE orderdate BETWEEN '20080211' AND '20080212 23:59:59.999';

	-- solucao
	SELECT  orderid, 
			orderdate, 
			custid, 
			empid
		FROM Sales.Orders
		WHERE orderdate >= '20080211' AND orderdate < '20080213';

-- SORTING DATA

	-- exemplo
	SELECT  empid, 
			firstname, 
			lastname, 
			city, 
			MONTH(birthdate) AS birthmonth
		FROM HR.Employees
		WHERE country = N'USA' AND region = N'WA'
		ORDER BY city; -- DESC ou ASC


	-- deterministic
	SELECT  empid, 
			firstname, 
			lastname, 
			city, 
			MONTH(birthdate) AS birthmonth
		FROM HR.Employees
		WHERE country = N'USA' AND region = N'WA'
		ORDER BY city, empid;
		
	-- ORDER BY 4, 1;
	
	-- problema
	SELECT DISTINCT city
		FROM HR.Employees
		WHERE country = N'USA' AND region = N'WA'
		ORDER BY birthdate;

-- FILTERING DATA WITH TOP AND OFFSET-FETH

	