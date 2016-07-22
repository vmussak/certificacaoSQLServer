USE TSQL2012;

GO

-- Exercise 1

	IF OBJECT_ID (N'Sales.OrderTotalsByYearCustShip', N'V') IS NOT NULL     
		DROP VIEW Sales.OrderTotalsByYearCustShip; 
	GO 
	CREATE VIEW Sales.OrderTotalsByYearCustShip WITH SCHEMABINDING 	AS

		SELECT  O.custid,
				O.shipperid,
				c.companyname AS customercompany,
				s.companyname AS shippercompany,
				YEAR(O.orderdate) AS orderyear,   
				SUM(OD.qty) AS qty,
				CAST(SUM(OD.qty * OD.unitprice * (1 - OD.discount)) AS NUMERIC(12, 2)) AS val 
			FROM Sales.Orders AS O   
				JOIN Sales.OrderDetails AS OD     
					ON OD.orderid = O.orderid 
				JOIN Sales.Customers AS C     
					ON O.custid = C.custid   
				JOIN Sales.Shippers AS S     
					ON O.shipperid = S.shipperid 
			GROUP BY YEAR(orderdate),
				O.custid,
				O.shipperid,
				c.companyname,
				s.companyname;
	GO

	SELECT  customercompany, 
			shippercompany, 
			orderyear, 
			qty, 
			val  
		FROM Sales.OrderTotalsByYearCustShip 
		ORDER BY customercompany, 
				shippercompany, 
				orderyear;

-- Exercise 2

	IF OBJECT_ID (N'Sales.fn_OrderTotalsByYearCustShip', N'IF') IS NOT NULL     
		DROP FUNCTION Sales.fn_OrderTotalsByYearCustShip; 
	GO 
	CREATE FUNCTION Sales.fn_OrderTotalsByYearCustShip (
		@lowqty int, 
		@highqty int
	) 
	RETURNS TABLE AS 
		
		RETURN ( 
			SELECT  C.companyname AS customercompany,       
					S.companyname AS shippercompany,       
					YEAR(O.orderdate) AS orderyear,       
					SUM(OD.qty) AS qty,       
					CAST(SUM(OD.qty * OD.unitprice * (1 - OD.discount)) AS NUMERIC(12, 2)) AS val     
				FROM Sales.Orders AS O       
					JOIN Sales.OrderDetails AS OD          
						ON OD.orderid = O.orderid       
					JOIN Sales.Customers AS C         
						ON O.custid = C.custid       
					JOIN Sales.Shippers AS S         
						ON O.shipperid = S.shipperid     
				GROUP BY YEAR(O.orderdate), 
						C.companyname, 
						S.companyname     
				HAVING SUM(OD.qty) >= @lowqty 
					AND SUM(OD.qty) <= @highqty   
		); 
	GO


	SELECT  customercompany, 
			shippercompany, 
			orderyear, 
			qty, 
			val  
		FROM Sales.fn_OrderTotalsByYearCustShip (100, 200) 
		ORDER BY customercompany, 
				shippercompany, 
				orderyear;

/*
	Lesson Review

	1. A, C e D
	2. B
	3. 
*/

-- Exercise 1

	CREATE SCHEMA Reports AUTHORIZATION dbo;
	GO

	-- exemplo 1

		SELECT custid, ordermonth, qty FROM Sales.CustOrders;

		CREATE SYNONYM Reports.TotalCustQtyByMonth FOR Sales.CustOrders;

		SELECT custid, ordermonth, qty FROM Reports.TotalCustQtyByMonth;

	-- exemplo 2

		SELECT empid, ordermonth, qty, val, numorders FROM Sales.EmpOrders;

		CREATE SYNONYM Reports.TotalEmpQtyOrdersByMonth FOR Sales.EmpOrders;

		SELECT empid, ordermonth, qty, val, numorders FROM Reports.TotalEmpQtyOrdersByMonth

	-- exemplo 3

		SELECT orderyear, qty FROM Sales.OrderTotalsByYear;

		CREATE SYNONYM Reports.TotalQtyByYear FOR Sales.OrderTotalsByYear; 

		SELECT orderyear, qty FROM Reports.TotalQtyByYear;

	-- exemplo 4

		SELECT orderid, custid, empid, shipperid, orderdate, requireddate, shippeddate, qty, val FROM Sales.OrderValues;

		CREATE SYNONYM Reports.TotalQtyValOrders FOR Sales.OrderValues; 
		
		SELECT orderid, custid, empid, shipperid, orderdate, requireddate, shippeddate, qty, val FROM Reports.TotalQtyValOrders;


	SELECT name, object_id, principal_id, schema_id, parent_object_id FROM sys.synonyms; 
	
	SELECT SCHEMA_NAME(schema_id) AS schemaname,  name, object_id, principal_id, schema_id, parent_object_id  FROM sys.synonyms;


-- exercise 2


/*
	Lesson Review

	1. A, C
	2. A, B e D
	3. C
*/


