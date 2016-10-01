

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
		WHERE shippeddate = @dt 
			OR (shippeddate IS NULL AND @dt IS NULL);

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
		--WHERE orderdate = '02/12/07';
		--WHERE YEAR(orderdate) = 2007 AND MONTH(orderdate) = 2;
		--WHERE orderdate >= '20070201' AND orderdate < '20070301';
		--WHERE orderdate BETWEEN '20070201' AND '20070228 23:59:59.999'


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
		-- ORDER BY city, empid;
		ORDER BY 4, 1;
	
	-- problema
	SELECT DISTINCT city
		FROM HR.Employees
		WHERE country = N'USA' AND region = N'WA'
		ORDER BY birthdate;

<<<<<<< HEAD
-- FILTERING DATA WITH TOP AND OFFSET-FETH
=======
-- FILTERING DATA WITH TOP AND OFFSET-FETCH
>>>>>>> 2fec702a0a627ed09f4d3eea6d9341992ca0e805

	SELECT TOP (3) orderid, orderdate, custid, empid
		FROM Sales.Orders
		ORDER BY orderdate DESC;

	DECLARE @x int = 30
	SELECT TOP (@x) orderid, orderdate, custid, empid
		FROM Sales.Orders
		ORDER BY orderdate DESC;

	-- The correct syntax is with parentheses

	-- Option to guarantee determinism 
	SELECT TOP (3) WITH TIES orderid, orderdate, custid, empid
		FROM Sales.Orders
		ORDER BY orderdate DESC, orderid DESC;

	/*
			In order to make the syntax intuitive, you can use 
			the keywords NEXT or FIRST interchangeably.
		When skipping some rows, it might be more intuitive 
		to you to use the keywords FETCH NEXT to indicate 
		how many rows to filter; but when not skipping any 
		rows, it might be more intuitive to you to use the 
		keywords FETCH FIRST.
	*/

	SELECT orderid, orderdate, custid, empid
		FROM Sales.Orders
		ORDER BY orderdate DESC, orderid DESC /*obrigatório*/
		OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;

	SELECT orderid, orderdate, custid, empid
		FROM Sales.Orders
		ORDER BY orderdate DESC, orderid DESC
		OFFSET 0 ROWS FETCH FIRST 25 ROW/*(S)*/ ONLY;

	SELECT orderid, orderdate, custid, empid
		FROM Sales.Orders
		ORDER BY orderdate DESC, orderid DESC
		OFFSET 50 ROWS;

	SELECT orderid, orderdate, custid, empid
		FROM Sales.Orders
		ORDER BY (SELECT NULL) /*Gambi*/
		OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;

	-- exemplo de paginação
	DECLARE @pagesize AS BIGINT = 25, @pagenum AS BIGINT = 3;
	SELECT orderid, orderdate, custid, empid
		FROM Sales.Orders
		ORDER BY orderdate DESC, orderid DESC
		OFFSET (@pagenum - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY;

	-- Answer: OFFSET-FETCH is standard and TOP isn’t; also, OFFSET-FETCH supports a skipping capability that TOP doesn’t.

	-- Exercício: Fazer os Case Scenarios;


	CREATE INDEX IDX_Teste ON Sales.Orders(orderdate)

	ALTER TABLE Sales.Orders
	ALTER COLUMN orderdate datetime null 