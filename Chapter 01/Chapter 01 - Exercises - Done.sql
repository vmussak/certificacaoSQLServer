
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

		1. Um exemplo da teoria de conjuntos que ajuda entender T-SQL s�o as propriedades b�sicas:
			a - Um conjunto {A - B - A} pode ser considerado exatamente igual a um conjunto {A - B}.
			b - Um conjunto {A - B - C} pode ser considerado exatamente igual a um conjunto {C - B - A}.

		2. Entender o modelo relacional � importante para que seja poss�vel representas as rela��es e seus relacionamentos de forma gr�fica.
*/

/*
	Case Scenario 2 : Interviewing for a Code Reviewer Position

		1. Sim, � impotante. Usar SQL em sua forma padr�o agrega mais portabilidade ao c�digo e a o conhecimento, al�m de ser mais r�pido.
		2. Sim, � uma m� pratica. Segundo a teoria de conjunto a ordem dos dados n�o deve ser importante, ent�o caso seja, a consulta perde a sua propriedade relacional.
		3. Caso a clausula ORDER BY n�o seja especificada, a ordem dos dados ser� decidida pelo mecanismo de busca. Sua escolha depender� das condi��es, e nenhuma ordem � garantida.
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