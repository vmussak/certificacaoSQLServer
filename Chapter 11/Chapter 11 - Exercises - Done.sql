
-- Exercise 1

	CREATE SEQUENCE dbo.Seq1;

	SELECT TYPE_NAME(system_type_id) AS type,   start_value, minimum_value, current_value, increment, is_cycling FROM sys.sequences WHERE object_id = OBJECT_ID('dbo.Seq1');

-- Exercise 2

	DROP SEQUENCE dbo.Seq1

	CREATE SEQUENCE dbo.Seq1 AS INT START WITH 1 CYCLE;

	SELECT TYPE_NAME(system_type_id) AS type,   start_value, minimum_value, current_value, increment, is_cycling FROM sys.sequences WHERE object_id = OBJECT_ID('dbo.Seq1');

	ALTER SEQUENCE dbo.Seq1 RESTART WITH 2147483647;

	SELECT NEXT VALUE FOR dbo.Seq1

	CREATE SEQUENCE dbo.Seq1 AS INT MINVALUE 1 CYCLE;

/*
	Lesson Review

	1. D
	2. C e D
	3. A
*/

	DECLARE @orderid AS INT = 1,
			@custid AS INT = 1,
			@empid AS INT = 2,
			@orderdate AS DATE = '20120620';

	MERGE INTO Sales.MyOrders WITH(HOLDLOCK) AS TGT
	USING (VALUES(@orderid, @custid, @empid, @orderdate))
			AS SRC(orderid, custid, empid, orderdate)
		ON SRC.orderid = TGT.orderid
	WHEN MATCHED THEN UPDATE
		SET TGT.custid = SRC.custid,
			TGT.empid = SRC.empid,
			TGT.orderdate = SRC.orderdate
	WHEN NOT MATCHED THEN INSERT
		VALUES(SRC.orderid, SRC.custid, SRC.empid, SRC.orderdate);


-- Exercise 1

	IF OBJECT_ID('Sales.MyOrders') IS NOT NULL DROP TABLE Sales.MyOrders; IF OBJECT_ID('Sales.SeqOrderIDs') IS NOT NULL DROP SEQUENCE Sales.SeqOrderIDs;  
	CREATE SEQUENCE Sales.SeqOrderIDs AS INT   MINVALUE 1   CYCLE;  
	CREATE TABLE Sales.MyOrders (   orderid INT NOT NULL     CONSTRAINT PK_MyOrders_orderid PRIMARY KEY     CONSTRAINT DFT_MyOrders_orderid       DEFAULT(NEXT VALUE FOR Sales.SeqOrderIDs),   custid  INT NOT NULL     CONSTRAINT CHK_MyOrders_custid CHECK(custid > 0),   empid   INT NOT NULL     CONSTRAINT CHK_MyOrders_empid CHECK(empid > 0),   orderdate DATE NOT NULL );

	MERGE Sales.MyOrders AS mo
		USING Sales.Orders od
			ON od.orderid = mo.orderid
		WHEN MATCHED AND (	od.custid <> mo.custid OR
							od.empid <> mo.empid OR
							od.orderdate <> mo.orderdate) 
			THEN UPDATE
				SET mo.custid = od.custid,
					mo.empid = od.empid,
					mo.orderdate = od.orderdate
		WHEN NOT MATCHED THEN INSERT
			VALUES(od.orderid, od.custid, od.empid, od.orderdate);

-- Exercise 2

	MERGE Sales.MyOrders AS mo
		USING Sales.Orders od
			ON od.orderid = mo.orderid
				AND shipcountry = N'Norway'
		WHEN MATCHED AND (	od.custid <> mo.custid OR
							od.empid <> mo.empid OR
							od.orderdate <> mo.orderdate) 
			THEN UPDATE
				SET mo.custid = od.custid,
					mo.empid = od.empid,
					mo.orderdate = od.orderdate
		WHEN NOT MATCHED THEN INSERT
			VALUES(od.orderid, od.custid, od.empid, od.orderdate);
	
/*
	Lesson Review

	1. B
	2. A, B e D
	3. C
*/

-- Exercise 1

	UPDATE Production.Products
		SET unitprice += 2.5
		OUTPUT
			inserted.productid,
			inserted.productname,
			deleted.unitprice AS oldprice,
			inserted.unitprice AS newprice,
			CAST(100.0 * (inserted.unitprice - deleted.unitprice) / deleted.unitprice AS NUMERIC(5,2)) AS pct
		WHERE categoryid = 1
			AND supplierid = 16

-- Exercise 2

	INSERT INTO Sales.MyOrdersArchive(orderid, custid, empid, orderdate)
		SELECT orderid, custid, empid, orderdate
			FROM (DELETE FROM Sales.MyOrders
					OUTPUT deleted.*
					WHERE orderdate < '20070101') AS D
			WHERE D.custid in (17,19)

	SELECT * FROM Sales.MyOrdersArchive
	
	/*
		Lesson Review

		1. C
		2. C e D
		3. D
	*/

	/*
		Case Scenario 1

		Pode ser utilizado um objeto unico gerador de sequenciais. Com este objeto 
		é possível saber o numero antes do comando insert ser executado. E como este 
		objeto é independente de qualquer tabela, ele pode ser usado por varias, 
		criando chaves que conflitam entre as tabelas.
	*/

	/*
		Case Scenario 2
	
		1 - Nessa situação o uso do comando merge pode ser muito interessante, pois 
		ele executa comandos insert ou update automaticamente quando identifica ou
		não a existencia de uma linha

		3 - Nesse caso o uso do comando OUTPUT será ideal, pois ele fará em uma unica 
		operação (unity of work) o delete e gravará o histórico do registro.
	*/