
-- CONVERS�O
	SELECT CAST('2' AS INT)
	SELECT CONVERT(DATE, '1/2/2012', 101) 
	SELECT PARSE('1/2/2012' AS DATE USING 'en-US')
	SELECT TRY_CONVERT(float, 'test')
	SELECT TRY_PARSE('Jabberwokkie' AS datetime2 USING 'en-US')

-- GUID
	SELECT NEWID()


-- DATE AND TIME

	-- CURRENT DATE AND TIME

		SELECT GETDATE()
		SELECT CURRENT_TIMESTAMP
		SELECT GETUTCDATE()
		SELECT SYSDATETIME()
		SELECT SYSUTCDATETIME()
		SELECT SYSDATETIMEOFFSET()

	-- DATE AND TIME PARTS

		SELECT DATEPART(month, '20120212')
		SELECT DATENAME(month, '20120212')
		SELECT DATEFROMPARTS(1,2,3)
		SELECT DATETIME2FROMPARTS(1,2,3,4,5,6,7,1)
		SELECT DATETIMEFROMPARTS ( 2010, 12, 31, 23, 59, 59, 0 )
		SELECT DATETIMEOFFSETFROMPARTS(2,3,4,5,4,2,3,8,8,1)
		SELECT SMALLDATETIMEFROMPARTS(2010,12,31,23,59)
		SELECT TIMEFROMPARTS(12,22,59,2,2)
		SELECT EOMONTH('20120212')

	-- ADD AND DIFF
	
		SELECT DATEADD(year, 1, '20120212') 
		SELECT DATEDIFF(day, '20110212', '20120212') 

	-- OFFSET

		SELECT SWITCHOFFSET('20130212 14:00:00.0000000 -08:00', '-05:00')
		SELECT TODATETIMEOFFSET('20130212 14:00:00.0000000', '-08:00')

-- CHARACTER FUNCTIONS

	-- CONCATENATION

		SELECT CONCAT('Rafael', ' ', 'Pessoni')  -- The + operator by default yields a NULL result on NULL input, whereas the CONCAT function treats NULLs as empty strings.
		SELECT SUBSTRING('abcde', 1, 3)
		SELECT CHARINDEX(' ','Itzik Ben-Gan')
		SELECT LEFT('ABCDEFGH', 5)
		SELECT RIGHT('ABCDEFGH', 5)
		SELECT LEN(N'xyz ')  
		SELECT DATALENGTH(N'xyz')
		SELECT REPLACE('.1.2.3.', '.', '/')
		SELECT REPLICATE('0', 10)
		SELECT STUFF(',x,y,z', 1, 1, '')
		SELECT UPPER('aBCdefGh')
		SELECT LOWER('aBCdefGh')
		SELECT LTRIM('   aBCdefGh   ')
		SELECT RTRIM('   aBCdefGh   ')
		SELECT FORMAT(1759, '000000000')

-- CASE EXPRESSION AND RELATED FUNCTIONS

	-- CASE IS A EXPRESSION AND NOT A STATEMENT

	SELECT	CASE 1 
				WHEN 0 THEN 'No' 
				WHEN 1 THEN 'Yes' 
				ELSE 'Unknown' 
			END AS Result

	SELECT CASE 
				WHEN 1 = 2 THEN 'Low' 
				WHEN 1 <> 1 THEN 'Medium' 
				WHEN 2 = 2 THEN 'High'
 				ELSE 'Unknown'	
 			END AS pricerange
	
	-- FUNCTION

		SELECT COALESCE(NULL, 'x', 'y') 
		SELECT  NULLIF('ABC', 'ABC'), NULLIF('BC', 'ABC')
		SELECT ISNULL(NULL, 1)
		SELECT IIF(2015 = 2012, 'TRUE', 'FALSE')
		SELECT CHOOSE(2, 'x', 'y', 'z')
