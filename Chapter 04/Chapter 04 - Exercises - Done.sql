	USE TSQL2012;  

	INSERT INTO Production.Suppliers   (companyname, contactname, contacttitle, address, city, postalcode, country, phone)   
	VALUES (N'Supplier XYZ', N'Jiru', N'Head of Security', N'42 Sekimai Musashino-shi', N'Tokyo', N'01759', N'Japan', N'(02) 4311-2609');

	select * from dbo.Nums


-- Exercise 1

	select  c.custid,
			c.companyname,
			o.orderid,
			o.orderdate
		from Sales.Customers c
			inner join Sales.Orders o
				on o.custid = c.custid

-- Exercise 2

	select  c.custid,
			c.companyname,
			o.orderid,
			o.orderdate
		from Sales.Customers c
			left outer join Sales.Orders o
				on o.custid = c.custid
		where o.orderid is null;

	select  c.custid,
			c.companyname,
			o.orderid,
			o.orderdate
		from Sales.Customers c
			left outer join Sales.Orders o
				on o.custid = c.custid
					and o.orderdate >= '20080201'
					and o.orderdate < '20080301';

	/*
		Lesson Review

		1. D
		2. C e D
		3. A
	*/


	SELECT  ROW_NUMBER() OVER(PARTITION BY categoryid ORDER BY unitprice, productid) AS rownum,  
			categoryid, 
			productid, 
			productname, 
			unitprice 
		FROM Production.Products;


	WITH EmpsCTE AS (  
		SELECT  empid, 
				mgrid, 
				firstname, 
				lastname, 
				0 AS distance   
			FROM HR.Employees   
			WHERE empid = 9  

		UNION ALL  

		SELECT  M.empid, 
				M.mgrid, 
				M.firstname, 
				M.lastname, 
				S.distance + 1 AS distance   
			FROM EmpsCTE AS S     
				JOIN HR.Employees AS M       
					ON S.mgrid = M.empid 
	) 
	
	SELECT  empid, 
			mgrid, 
			firstname, 
			lastname, 
			distance 
		FROM EmpsCTE;


-- Exercise 1

	SELECT  p.categoryid,
			MIN(p.unitprice) lowestprice
		FROM Production.Products p
		GROUP BY p.categoryid;

	WITH CatMin AS (
		SELECT  p.categoryid,
			MIN(p.unitprice) lowestprice
		FROM Production.Products p
		GROUP BY p.categoryid
	)
	SELECT *
		FROM Production.Products p
			INNER JOIN CatMin cte 
				ON cte.categoryid = p.categoryid
					AND cte.lowestprice = p.unitprice;

-- Exercise 2

	IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL 
		DROP FUNCTION Production.GetTopProducts; 
	GO 
		CREATE FUNCTION Production.GetTopProducts(@supplierid AS INT, @n AS BIGINT) 
		
			RETURNS TABLE AS  
		
			RETURN   
		
			SELECT  productid, 
					productname, 
					unitprice   
				FROM Production.Products   
				WHERE supplierid = @supplierid   
				ORDER BY unitprice, productid   
				OFFSET 0 ROWS FETCH FIRST @n ROWS ONLY; 
		GO

	SELECT * FROM Production.GetTopProducts(1, 2) AS P;

	SELECT  S.supplierid, 
			S.companyname AS supplier, 
			A.* 
		FROM Production.Suppliers AS S   
			CROSS APPLY Production.GetTopProducts(S.supplierid, 2) AS A 
		WHERE S.country = N'Japan';

	SELECT  S.supplierid, 
			S.companyname AS supplier, 
			A.* 
		FROM Production.Suppliers AS S   
			OUTER APPLY Production.GetTopProducts(S.supplierid, 2) AS A 
		WHERE S.country = N'Japan';

	IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL DROP FUNCTION Production.GetTopProducts;


	/*
		Lesson Review

		1. A
		2. B e C
		3. B
	*/


-- Exercise 1

	SELECT empid	
		FROM Sales.Orders
		WHERE custid = 1
	
	EXCEPT

	SELECT empid
		FROM Sales.Orders
		WHERE custid = 2;

-- Exercise 2 

	SELECT empid	
		FROM Sales.Orders
		WHERE custid = 1
	
	INTERSECT

	SELECT empid
		FROM Sales.Orders
		WHERE custid = 2;
	
	/*
		Lesson Review

		1. A, C e D
		2. D
		3. B e D
	*/

	/*
		Case Scenario 1: Code Review

		1 - Podem ser feitas altarações para utilizar CTE, com isso o código fica mais simples, legivel e sem copy and paste.
		2 - Podem ser feitas alteraçoes	para utilizar Apply operator, com isso não existe mais a necessidade de cursores para algumas situações.
		3 - Podemos criar indices nas FKS e outros campos, assim as consultas com JOINs ficam mais rápidas.
	*/

	/*
		Case Scenario 2: Explaining Set Operators

		1 - ?
		2 - ?
	*/

-- Practice 1

	
-- Practice 2

	-- forma 1
		SELECT e.empid
			FROM HR.Employees e

		EXCEPT
	
		SELECT  o.empid
			FROM Sales.Orders o
			WHERE o.orderdate = '2008-02-12';

	-- forma 2
		SELECT e.empid
			FROM HR.Employees e
				LEFT JOIN Sales.Orders o
					ON o.empid = e.empid
						AND o.orderdate = '2008-02-12' 
			WHERE o.orderid IS NULL

	-- forma 3
		SELECT e.empid
			FROM HR.Employees e
			WHERE NOT EXISTS(SELECT  o.empid
								FROM Sales.Orders o
								WHERE o.orderdate = '2008-02-12'
									AND o.empid = e.empid);
		