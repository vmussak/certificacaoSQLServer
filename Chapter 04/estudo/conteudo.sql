-- Tem exemplos que usam esse cara mas ele nao existe
--USE TSQL2012;
--INSERT INTO Production.Suppliers (companyname, contactname, contacttitle, address, city, postalcode, country, phone)
--VALUES(N'Supplier XYZ', N'Jiru', N'Head of Security', N'42 Sekimai Musashino-shi', N'Tokyo', N'01759', N'Japan', N'(02) 4311-2609');

-- Cross Join
SELECT	D.n AS theday,
		S.n AS shiftno
	FROM dbo.Nums AS D
		CROSS JOIN dbo.Nums AS S
	WHERE D.n <= 7
		AND S.N <= 3
	ORDER BY theday, shiftno;

-- Inner Join
	 -- Usa o predicado "ON" indicando quais campos da tabela s�o equivalentes
	 -- Linhas que existem na tabela "Production.Suppliers" mas n�o existem na tabela "Production.Products" s�o descartadas
	 -- Como a columa "supplierid" � igual nas duas tabelas, � neces�rio colocar o alias + nome. "S.supplierid" por exemplo
	 -- Colunas como "country" n�o tem ambiguidade, mas � recomendado usar o alias tamb�m
	 -- Falar sobre usar WHERE no JOIN e ON pra filtrar
SELECT	S.companyname AS supplier,
		S.country,
		P.productid,
		P.productname,
		P.unitprice
	FROM Production.Suppliers AS S
		INNER JOIN Production.Products AS P
			ON S.supplierid = P.supplierid
	WHERE S.country = N'Japan';

-- Usar WHERE pra Juntar e JOIN pra Filtrar
SELECT	S.companyname AS supplier,
		S.country,
		P.productid,
		P.productname,
		P.unitprice
	FROM Production.Suppliers AS S
		INNER JOIN Production.Products AS P
			ON S.supplierid = P.supplierid
			AND S.country = N'Japan';


-- Exemplo do alias
-- Join com a mesma tabela (auto-relacionamento)
SELECT	E.empid,
		E.firstname + N' ' + E.lastname AS employee,
		M.firstname + N' ' + M.lastname AS manager
	FROM HR.Employees AS E
		INNER JOIN HR.Employees AS M
			ON E.mgrid = M.empid;


-- LEFT OUTER JOIN
-- Aqui, usar WHERE ou ON faz diferen�a
SELECT	S.companyname AS supplier,
		S.country,
		P.productid, 
		P.productname, 
		P.unitprice
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN Production.Products AS P
			ON S.supplierid = P.supplierid
	WHERE S.country = N'Japan';


-- Falar sobre RIGHT JOIN e FULL OUTER JOIN


--Combinando v�rios JOINS
SELECT	S.companyname AS supplier,
		S.country,
		P.productid,
		P.productname,
		P.unitprice,
		C.categoryname
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN Production.Products AS P
			ON S.supplierid = P.supplierid
		INNER JOIN Production.Categories AS C
			ON C.categoryid = P.categoryid
	WHERE S.country = N'Japan';



-- Resolvendo o problema acima:
SELECT	S.companyname AS supplier,
		S.country,
		P.productid,
		P.productname,
		P.unitprice,
		C.categoryname
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN
			(Production.Products AS P
				INNER JOIN Production.Categories AS C
					ON C.categoryid = P.categoryid
			)
			ON S.supplierid = P.supplierid
	WHERE S.country = N'Japan';


-- Subqueries

SELECT	productid,
		productname,
		unitprice
	FROM Production.Products
	WHERE unitprice = (SELECT MIN(unitprice) FROM Production.Products);


SELECT	productid,
		productname,
		unitprice
	FROM Production.Products
	WHERE supplierid IN (SELECT supplierid FROM Production.Suppliers WHERE country = N'Japan');


-- Subqueries correlacionadas

SELECT	categoryid,
		productid,
		productname,
		unitprice
	FROM Production.Products AS P1
	WHERE unitprice = (
		SELECT MIN(unitprice) 
			FROM Production.Products AS P2 
			WHERE P2.categoryid = P1.categoryid
	);


--Table expressions (CTEs)




