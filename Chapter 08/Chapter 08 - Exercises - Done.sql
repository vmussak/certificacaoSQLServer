
CREATE TABLE Production.CategoriesTest
(
	categoryid INT NOT NULL IDENTITY
);

ALTER TABLE Production.CategoriesTest ADD categoryname NVARCHAR(15) NOT NULL;

ALTER TABLE Production.CategoriesTest ADD description NVARCHAR(200) NOT NULL;

SET IDENTITY_INSERT Production.CategoriesTest ON;
INSERT INTO Production.CategoriesTest (categoryid, categoryname, description)
	SELECT categoryid, categoryname, description from Production.Categories;
GO
	SET IDENTITY_INSERT Production.CategoriesTest ON;
GO

ALTER TABLE Production.CategoriesTest ALTER COLUMN description NVARCHAR(500);

SELECT description
	FROM Production.CategoriesTest
	WHERE categoryid = 8;

UPDATE Production.CategoriesTest SET description = NULL WHERE categoryid = 8;

ALTER TABLE Production.CategoriesTest ALTER COLUMN description NVARCHAR(500) NULL;

ALTER TABLE Production.CategoriesTest ALTER COLUMN description NVARCHAR(500) NOT NULL;

UPDATE Production.CategoriesTest SET description = 'Seaweed and fish' WHERE categoryid = 8;

/*
	Lesson Review

	1. A, C e D
	2. C
	3. D
*/

SELECT * FROM sys.key_constraints where type = 'PK'


-- Exercise 1

	SELECT * FROM Production.Products WHERE productid = 1;

	SET IDENTITY_INSERT Production.Products ON;

	GO
		INSERT INTO Production.Products (productid, productname, supplierid, categoryid, unitprice, discontinued)
			VALUES (1, N'Product TEST', 1, 1 , 18, 0);
	GO

	SET IDENTITY_INSERT Production.Products OFF;

	--

	INSERT INTO Production.Products (productname, supplierid, categoryid, unitprice, discontinued)
			VALUES (N'Product TEST', 1, 1 , 18, 0);

	-- 

	DELETE FROM Production.Products WHERE productname = N'Product TEST';

	--

	INSERT INTO Production.Products (productname, supplierid, categoryid, unitprice, discontinued)
			VALUES (N'Product TEST', 1, 99, 18, 0);

	--

	ALTER TABLE Production.Products DROP CONSTRAINT FK_Products_Categories;

	--

	ALTER TABLE Production.Products  WITH CHECK ADD CONSTRAINT FK_Products_Categories FOREIGN KEY(categoryid) REFERENCES Production.Categories (categoryid); 

	--

	UPDATE Production.Products SET categoryid = 1 WHERE productname = N'Product TEST'

-- Exercice 2

	-- DONE


	/*
		Lesson Review

		1. B e D
		2. C
		3. A
	*/

/*
	Case Scenario 1

		1. creating a unique index
		2. determinating the data type and if necessary with check constraint
		3. creating a foreign key
		4. I don't know

	Case Scenario 2

		1. creating a unique index
		2. by using a not null identify
		3. by using a default value
*/