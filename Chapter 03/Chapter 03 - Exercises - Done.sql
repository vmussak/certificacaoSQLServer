
SELECT * FROM HR.Employees;

-- Exercise 1

	SELECT  s.orderid,
			s.orderdate,
			s.custid,
			s.empid
		FROM Sales.Orders s
		WHERE s.shippeddate IS NULL;

-- Exercise 2

	SELECT *
		FROM Sales.Orders s
		WHERE s.orderdate >= '2008-02-11' AND s.orderdate < '2008-02-13';


/*
	Lesson Review

	1. B
	2. B e C
	3. B, C, D e E

*/


	SELECT DISTINCT city
	FROM HR.Employees 
	WHERE country = N'USA' AND region = N'WA' 
	ORDER BY city

-- Exercise 1

	SELECT  orderid, 
			empid, 
			shipperid, 
			shippeddate 
		FROM Sales.Orders 
		WHERE custid = 77
		ORDER BY shipperid;

-- Exercise 2

	SELECT  orderid, 
			empid, 
			shipperid, 
			shippeddate 
		FROM Sales.Orders 
		WHERE custid = 77
		ORDER BY shipperid, shippeddate DESC, orderid DESC;

/*
	Lesson Review

	1. A
	2. C
	3. B, C e D
*/


-- Exercise 1

	SELECT TOP (5) WITH TIES *
		FROM Production.Products p
		WHERE p.categoryid = 1
		ORDER BY p.unitprice DESC;

	SELECT TOP (5) *
		FROM Production.Products p
		WHERE p.categoryid = 1
		ORDER BY p.unitprice DESC, P.productid DESC;

-- Exercise 2


	SELECT *
		FROM Production.Products p
		ORDER BY p.unitprice, P.productid
		OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY;

	SELECT *
		FROM Production.Products p
		ORDER BY p.unitprice, P.productid
		OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

	SELECT *
		FROM Production.Products p
		ORDER BY p.unitprice, P.productid
		OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;

/*
	Lesson Review

	1. B
	2. F
	3. A e C
*/


/*
	Case Scenario 1

	1. Sim, vocês podem começar a filtrar os dados na query usando a clausula WHERE, economizando assim um grande consumo de banda. Vocês também podem mudar a forma como montam as expressões, os dados não devem ser manipulados dentro da clausula where, pois assim a engine não consegue utilizar os indices das tabelas.
	2. Sim, você deve especificar o ORDER BY com o valor (SELECT NULL), para deixar claro que sua intenção era não ordenar.
	3. Evite utilizar o TOP, pois ele não pertence ao standart SQL, prefira o OFFSET-FETCH.
*/

/*
	Case Sceranio 2

	1. Isso não é possível pois as clausulas são executadas em sequencia, e os dados recebidos por determinada clausula são exatamente os dados devolvidos pela clausula anterior, e a sequencia é: FROM, WHERE, GROUP BY, HAVING, SELECT E ORDER BY.
	2. Exatamente pela mesma propriedade explicada acima, como o order by é executado após o SELECT, ele pode utilizar os ALIAS aplicados pelo SELECT.
	3. I don't know
*/

/*
	Identify Logical Query processing phases and  Compare Filters 

		Practice 1:
		
			- FROM, WHERE, GROUP BY, HAVING, SELECT E ORDER BY, TOP.
			- FROM, WHERE, GROUP BY, HAVING, SELECT E ORDER BY, OFFSET-FETCH.

		Practice 2:

			- O OFFSET-FETCH oferece a funcionalidade de pular linhas
			- O TOP não necessita de uma clausula ORDER BY obrigatóriamente.

	Understand Determinism

		Practice 1:

			- Abaixo um exemplo de query não deterministic, pois existe mais de uma forma correta dos dados serem mostrados. Itens com o mesmo preço podem mudar de ordem e ainda assim o resultado continua correto
				
				SELECT *  FROM Production.Products p ORDER BY p.unitprice

			- Para transformar a query acima em deteministic uma alteração é necessária:

				SELECT *  FROM Production.Products p ORDER BY p.unitprice, p.productid

			- Agora só existe um resultado correto, então se trata de uma query deterministic.
				
		Practice 2:

			- TOP 
			
				nondeterministic: SELECT TOP (9) *  FROM Production.Products p ORDER BY p.unitprice
				deterministic:	SELECT TOP (9) WITH TIES *  FROM Production.Products p ORDER BY p.unitprice
				deterministic:	SELECT TOP (9) *  FROM Production.Products p ORDER BY p.unitprice, p.productid

			- OFFSET-FETCH
				
				nondeterministic: SELECT *  FROM Production.Products p ORDER BY p.unitprice OFFSET 2 ROWS FETCH NEXT 7 ROWS ONLY
				nondeterministic: SELECT *  FROM Production.Products p ORDER BY p.unitprice, p.productid OFFSET 2 ROWS FETCH NEXT 7 ROWS ONLY
*/

