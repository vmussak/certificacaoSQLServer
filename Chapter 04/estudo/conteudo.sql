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


