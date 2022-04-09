/* 1 - Na aula, construímos um relatório que apresentou os clientes que tiveram vendas inválidas.
       Complemente este relatório, listando somente os que tiveram vendas inválidas e calculando 
	   a diferença entre o limite de venda máximo e o realizado, em percentuais.*/

SELECT C.NOME,
       --CONVERT(VARCHAR, NF.DATA),
       SUBSTRING(CONVERT(VARCHAR,NF.DATA), 1, 7) AS 'ANO/MÊS',
	   SUM(INF.QUANTIDADE) AS 'QTDE. MÊS',
	   C.[VOLUME DE COMPRA] AS 'LIM. VOL. COMPRA',
	   ROUND((((SUM(INF.QUANTIDADE))/(C.[VOLUME DE COMPRA]))*100), 2) AS '(%)',
	   CASE
	       WHEN C.[VOLUME DE COMPRA] > SUM(INF.QUANTIDADE) THEN 'VENDA VÁLIDA'
		   ELSE 'VENDA INVÁLIDA'
	   END AS 'STATUS VENDA'
FROM [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY C.NOME, SUBSTRING(CONVERT(VARCHAR,NF.DATA), 1, 7), C.[VOLUME DE COMPRA]
HAVING ROUND((((SUM(INF.QUANTIDADE))/(C.[VOLUME DE COMPRA]))*100), 2) > 100
ORDER BY 1, 2
GO
