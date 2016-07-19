
	SELECT  [Customer].custid AS [custid],   
			[Customer].companyname AS [companyname],   
			[Order].orderid AS [orderid],   
			[Order].orderdate AS [orderdate] 
		FROM Sales.Customers AS [Customer]  
			INNER JOIN Sales.Orders AS [Order]   
				ON [Customer].custid = [Order].custid 
		WHERE 1 = 2 
		FOR XML AUTO, 
			ELEMENTS,      
			XMLSCHEMA('TK461-CustomersOrders');

	-- Exercise 1


	SELECT  c.custid,
			c.companyname,
			o.orderid,
			o.orderdate
		FROM Sales.Customers c
			INNER JOIN Sales.Orders o
				ON o.custid = c.custid
		FOR XML RAW;

	WITH XMLNAMESPACES('TK461-CostumersOrders' AS co)
	SELECT TOP 1
			[co:Customer].custid,
			[co:Customer].companyname,
			[co:Order].orderid,
			[co:Order].orderdate
		FROM Sales.Customers AS [co:Customer]
			INNER JOIN Sales.Orders AS [co:Order]
				ON [co:Order].custid = [co:Customer].custid
		ORDER BY [co:Customer].custid, [co:Order].orderid
		FOR XML AUTO, ELEMENTS, ROOT('CustomersOrders');


	-- Exercise 2

	SELECT  Customer.custid AS [@custid],  
			Customer.companyname AS [@companyname],  
			(
				SELECT  [Order].orderid AS [@orderid],    
						[Order].orderdate AS [@orderdate]   
					FROM Sales.Orders AS [Order]   
					WHERE Customer.custid = [Order].custid     
						AND [Order].orderid % 2 = 0   
					ORDER BY [Order].orderid   
					FOR XML PATH('Order'), TYPE
			) 
		FROM Sales.Customers AS Customer .;;
		WHERE Customer.custid <= 2 
		ORDER BY Customer.custid 
		FOR XML PATH('Customer');

	/*
	<Customer custid="1" companyname="Customer NRZBB">
		<Order orderid="10692" orderdate="2007-10-03T00:00:00"/>
		<Order orderid="10702" orderdate="2007-10-13T00:00:00"/>
		<Order orderid="10952" orderdate="2008-03-16T00:00:00"/>
	</Customer>
	*/


	/*
		Lesson Review

		1. A e D
		2. C
		3. C
	*/
