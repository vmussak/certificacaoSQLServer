

-- Exercise 1

USE TSQL2012;

SELECT  s.shipperid,
		s.companyname,
		s.phone
	FROM Sales.Shippers AS s;

-- Exercise 2

SELECT  s.shipperid,
		s.companyname,
		s.phone AS "phone number" -- OR [phone number]
	FROM Sales.Shippers AS s;
	
/*
	Lesson Review

	1 - B e D
	2 - C
	3 - C e D
*/

SELECT NEWID()

SELECT NEWSEQUENTIALID() -- PESQUISAR COMO FUNCIONA

SELECT * FROM Sales.Orders

SELECT a.index_id, name, avg_fragmentation_in_percent  
FROM sys.dm_db_index_physical_stats (DB_ID(N'TSQL2012'), OBJECT_ID(N'Sales.Orders'), NULL, NULL, NULL) AS a  
    JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id;   

SELECT DATENAME(MONTH, CAST(SYSDATETIME() AS DATE))

--SELECT [dbo].[GKSFNC_DataSemHora](GETDATE())
SELECT CAST(SYSDATETIME() AS DATE)

--SELECT [dbo].[GKSFNC_MontaData](2006, 02, 30)
SELECT  DATEFROMPARTS(2012, 02, 12)

-- SELECT [dbo].[GKSFNC_MontaData](2006, 02, 30, 15, 30, 56)
SELECT  DATETIMEFROMPARTS(2012, 02, 12, 23,59,59, 00)

SELECT EOMONTH(SYSDATETIME(), 2)

SELECT  SWITCHOFFSET(SYSDATETIMEOFFSET(), '-00:00')

SELECT  'Rafael' + NULL + ' Pessoni' AS Nome,
		CONCAT('Rafael', NULL, ' Pessoni') AS NomeConcat


-- Exercise 1

	SELECT  e.empid,
			CONCAT(e.firstname, ' ',e.lastname) AS fullname,
			YEAR(e.birthdate) AS birthdateyear
		FROM Hr.Employees e;

-- Exercise 2

	SELECT EOMONTH(SYSDATETIME()) AS FinalDoMes

	SELECT DATEFROMPARTS(YEAR(SYSDATETIME()),12, 31) AS FinalAno

-- Exercise 3

	SELECT RIGHT(REPLICATE('0', 10) + CAST(p.productid AS VARCHAR(10)),10) AS numero1,
			FORMAT(p.productid, '0000000000') as numero2,
			FORMAT(p.productid, 'd10') as numero3
		FROM Production.Products p;

/*
	Lesson Review

	1. B
	2. A e B
	3. B
*/

/*
	Case Scenario 1

	1. Nos cenários onde o Time não é importante o tipo DATE pode ser ultilizado, e dependendo do nível de detalhe outro tipo de datetime pode ser utilizado
	2. Utilizar sequenciais inteiros deixa a velocidade de leitura mais rápida, visto que o tamanho do campo é menor

	Case Scenario 2

	1. Procure usar funções do SQL standart, pois caso precisem transferir alguma rotina para o outro sistema as alterações serão menores
*/

