






SELECT	country, 
		YEAR(hiredate) AS yearhired, 
		COUNT(*) AS numemployees
	FROM HR.Employees
	WHERE hiredate >= '20030101'
	GROUP BY country, YEAR(hiredate)
	HAVING COUNT(*) > 1
	ORDER BY country , yearhired DESC;

SELECT * FROM hR.Employees order by region desc
