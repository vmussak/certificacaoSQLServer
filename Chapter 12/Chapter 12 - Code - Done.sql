select * from clientes WITH(NOLOCK)

rollback transaction teste

select * from sys.dm_tran_active_transactions
BEGIN TRAN;

UPDATE Production.Suppliers SET Fax = N'555-1212' WHERE supplierid = 1

UPDATE HR.Employees SET phone = N'555-9999' WHERE empid = 1

begin transaction teste

create table clientes(nome varchar(200))

rollback transaction teste
select * from sys.dm_tran_active_transactions
BEGIN TRAN;

UPDATE HR.Employees SET Region = N'10004' WHERE empid = 1

UPDATE Production.Suppliers SET Fax = N'555-1212' WHERE supplierid = 1

@@TRANCOUNT


/*
	Lesson Review

	1. A e C
	2. B e C
	3. A, B e D
*/

RAISERROR('mensagem de erro', 16, 0)

select * from sys.tables


-- Exercise 1

DECLARE @address AS NVARCHAR(60) = '5678 rue de l''Abbaye'; 
PRINT N'SELECT * FROM [Sales].[Customers] WHERE address = '+ @address;

DECLARE @address AS NVARCHAR(60) = '5678 rue de l''Abbaye'; 
PRINT N'SELECT * FROM [Sales].[Customers] WHERE address = '+ QUOTENAME(@address, '''') + ';';

-- Exercise 2

IF OBJECT_ID('Sales.ListCustomersByAddress') IS NOT NULL     
	DROP PROCEDURE Sales.ListCustomersByAddress; 
GO 

CREATE PROCEDURE Sales.ListCustomersByAddress     
	@address NVARCHAR(60) 
AS     
	DECLARE @SQLString AS NVARCHAR(4000); 
	SET @SQLString = ' SELECT companyname, contactname  FROM Sales.Customers WHERE address = ''' + @address + '''';     
	
	PRINT @SQLString; 
	
	EXEC(@SQLString); 
	RETURN; 
GO


EXEC [Sales].[ListCustomersByAddress] '''; SELECT * FROM sys.Tables;--'

IF OBJECT_ID('Sales.ListCustomersByAddress') IS NOT NULL      
	DROP PROCEDURE Sales.ListCustomersByAddress; 
GO 

CREATE PROCEDURE Sales.ListCustomersByAddress     
	@address AS NVARCHAR(60) 
AS 
	DECLARE @SQLString AS NVARCHAR(4000); 
	
	SET @SQLString = ' 
		SELECT  companyname, 
				contactname  
			FROM Sales.Customers 
			WHERE address = @address;
			
		select @address '; 
	
	EXEC sp_executesql     
		@statment = @SQLString, 
		@params = N'@address NVARCHAR(60)', 
		@address = @address; 
	
	RETURN; 
GO

-- Exercicio 3


/*
	Lesson Review

	1. B
	2. A e C
	3. B e C
*/

