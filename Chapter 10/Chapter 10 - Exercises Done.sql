
select * from Sales.MyOrders


EXEC sp_describe_first_result_set N'SELECT * FROM Sales.Customers;';

-- Exercise 1

	IF OBJECT_ID('Sales.MyCustomers') IS NOT NULL DROP TABLE Sales.MyCustomers;  
	CREATE TABLE Sales.MyCustomers (   custid       INT NOT NULL     CONSTRAINT PK_MyCustomers PRIMARY KEY,   companyname  NVARCHAR(40) NOT NULL,   contactname  NVARCHAR(30) NOT NULL,   contacttitle NVARCHAR(30) NOT NULL,   address      NVARCHAR(60) NOT NULL,   city         NVARCHAR(15) NOT NULL,   region       NVARCHAR(15) NULL,   postalcode   NVARCHAR(10) NULL,   country      NVARCHAR(15) NOT NULL,   phone        NVARCHAR(24) NOT NULL,   fax          NVARCHAR(24) NULL );

	INSERT INTO Sales.MyCustomers (custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
		SELECT custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax
			FROM Sales.Customers as c
			WHERE NOT EXISTS(SELECT * FROM Sales.Orders AS o where o.custid = c.custid);

	DROP TABLE Sales.MyCustomers;
	
-- Exercise 2

	SELECT custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax
		INTO Sales.MyCustomers 
		FROM Sales.Customers as c
		WHERE NOT EXISTS(SELECT * FROM Sales.Orders AS o where o.custid = c.custid);

	SELECT * FROM Sales.MyCustomers;


/*
	Lesson Review

	1. D
	2. A, B, C e D
	3. C
*/


/*
	Lesson Review

	1. C
	2. A, C e D
	3. B
*/

-- deletar um funcionarios e todos os seus superiores
-- deletar uma opção do menu e todas as suas filhas

/*
	Lesson Review

	1. B
	2. A e D
	3. B e C
*/