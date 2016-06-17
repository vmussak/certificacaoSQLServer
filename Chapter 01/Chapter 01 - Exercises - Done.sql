
/*
	Lesson Review 1

	1 - B, D e talvez C
	2 - D
	3 - B
*/

-- exercicio 1
SELECT custid, MAX(orderid) AS maxOrderId 
	FROM Sales.Orders 
	GROUP BY custid;

-- exercicio 2
SELECT shipperid, SUM(freight) AS totalfreight 
	FROM Sales.Orders 
	GROUP BY shipperid
	HAVING SUM(freight) > 20000.00;

/*
	Lesson Review 2

	1 - B
	2 - A, C e D
	3 - A
*/


/*
	Case Scenario 1 : Importance of Theory

		1. Um exemplo da teoria de conjuntos que ajuda entender T-SQL são as propriedades básicas:
			a - Um conjunto {A - B - A} pode ser considerado exatamente igual a um conjunto {A - B}.
			b - Um conjunto {A - B - C} pode ser considerado exatamente igual a um conjunto {C - B - A}.

		2. Entender o modelo relacional é importante para que seja possível representas as relações e seus relacionamentos de forma gráfica.
*/

/*
	Case Scenario 2 : Interviewing for a Code Reviewer Position

		1. Sim, é impotante. Usar SQL em sua forma padrão agrega mais portabilidade ao código e a o conhecimento, além de ser mais rápido.
		2. Sim, é uma má pratica. Segundo a teoria de conjunto a ordem dos dados não deve ser importante, então caso seja, a consulta perde a sua propriedade relacional.
		3. Caso a clausula ORDER BY não seja especificada, a ordem dos dados será decidida pelo mecanismo de busca. Sua escolha dependerá das condições, e nenhuma ordem é garantida.
		4. Deve-se utilizar a clausula DISTINCT sempre que os dados possam se repetir.
*/

/*
	Practice 1
		
		a - FROM
		b - WHERE
		c - GROUP BY
		d - HAVING
		e - SELECT
		f - ORDER BY

	Practice 2
		
		Sem resposta.
*/