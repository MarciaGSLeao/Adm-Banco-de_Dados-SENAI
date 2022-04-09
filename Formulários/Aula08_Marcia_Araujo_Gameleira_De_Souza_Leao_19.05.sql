--1 - Monte uma consulta que liste o nome, bairro e cidade ordenando por ordem alfab�tica pelo nome do cliente.
SELECT TOP(1) * FROM [TABELA DE CLIENTES]

--QUERY FINAL
SELECT NOME, BAIRRO, CIDADE FROM [TABELA DE CLIENTES]
ORDER BY NOME ASC


--2 - Listar as notas vendidas e seus respectivos vendedores ordenados pelo bairro do vendedor.
SELECT * FROM [dbo].[TABELA DE VENDEDORES]
SELECT count(*) FROM [dbo].[TABELA DE NOTAS FISCAIS]
SELECT * FROM [dbo].[TABELA DE ITENS NOTAS FISCAIS]

SELECT TNF.NUMERO, TNF.MATRICULA, TV.BAIRRO 
FROM [dbo].[TABELA DE NOTAS FISCAIS]TNF

-- QUERY FINAL
SELECT V.NOME, COUNT(NF.NUMERO) AS 'NOTAS POR VENDEDOR', V.BAIRRO FROM [TABELA DE VENDEDORES]V
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON V.MATRICULA = NF.MATRICULA
GROUP BY V.NOME, V.BAIRRO
ORDER BY V.BAIRRO


--3 - Liste a menor venda pela Esquina de Suco para cada produto.
SELECT TOP(1) * FROM [TABELA DE ITENS NOTAS FISCAIS]
SELECT TOP(1) * FROM [TABELA DE PRODUTOS]

--QUERY FINAL
SELECT P.[NOME DO PRODUTO], MIN(INF.QUANTIDADE*INF.PRE�O) AS 'VENDA M�NIMA' FROM [TABELA DE PRODUTOS]P
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON INF.[CODIGO DO PRODUTO] = P.[CODIGO DO PRODUTO]
GROUP BY P.[NOME DO PRODUTO]
ORDER BY MIN(INF.QUANTIDADE*INF.PRE�O)