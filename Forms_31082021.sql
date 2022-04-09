/*Crie a seguinte View que atende a necessidade conforme a figura abaixo. 
- Caso o tempo em anos da venda for maior ou igual 4 será realizado uma visita do vendedor que atendeu o cliente.
- Caso contrário apenas uma ligação pelo vendedor que atendeu o determinado cliente.*/

CREATE VIEW VW_RELATORIO_CONTACTAR_CLIENTE
AS
SELECT CONCAT(C.NOME, ' - CPF: ', C.CPF) AS 'CLIENTE',
	   CONCAT(V.NOME, ' - MATRICULA ', V.MATRICULA) 'VENDEDOR',
	   NF.NUMERO AS 'NOTA FISCAL',
	   DATEDIFF(YEAR, NF.[DATA], GETDATE()) AS 'TEMPO (ANOS)',
	   CASE
	       WHEN DATEDIFF(YEAR, NF.[DATA], GETDATE()) >= 4 THEN CONCAT('Realizar visita do vendedor: ', V.NOME)
		   WHEN DATEDIFF(YEAR, NF.[DATA], GETDATE()) < 4 THEN CONCAT('Realizar um contato pelo vendedor: ', V.NOME)
	   END AS 'TAREFA A REALIZAR'
FROM [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE VENDEDORES]V
ON V.MATRICULA = NF.MATRICULA
GO

SELECT * FROM [dbo].[VW_RELATORIO_CONTACTAR_CLIENTE]
GO

/* Com a view do exercício anterior, realize uma consulta que traga além das informações da view o faturamento de cada nota e o produto */

SELECT RE.CLIENTE,
       RE.VENDEDOR,
	   RE.[NOTA FISCAL],
	   RE.[TEMPO (ANOS)],
	   RE.[TAREFA A REALIZAR],
       ROUND([QUANTIDADE]*[PRECO], 2) AS 'FATURAMENTO',
	   CONCAT(P.[CODIGO DO PRODUTO], ' - ', P.[NOME DO PRODUTO]) AS 'PRODUTO'
FROM [dbo].[VW_RELATORIO_CONTACTAR_CLIENTE]RE
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON RE.[NOTA FISCAL] = INF.NUMERO
INNER JOIN [dbo].[TABELA DE PRODUTOS]P
ON P.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
GO

