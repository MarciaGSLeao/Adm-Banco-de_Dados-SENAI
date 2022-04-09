/* Crie uma consulta que mostre o nome do vendedor, o n�mero da nota fiscal, o valor faturado da nota
e quanto o vendedor  ganhou de comiss�o para cada nota fiscal.
*/
USE ESQUINA_VENDAS
GO

SELECT TOP 1 * FROM [TABELA DE VENDEDORES]
GO

SELECT TOP 1 * FROM [TABELA DE NOTAS FISCAIS]
GO

SELECT COUNT(*) FROM [TABELA DE NOTAS FISCAIS]  -- 87877 registros.
GO

SELECT TOP 1 * FROM [TABELA DE ITENS NOTAS FISCAIS]
GO

SELECT COUNT(*) FROM [TABELA DE ITENS NOTAS FISCAIS]
GO


SELECT V.NOME AS 'VENDEDOR',
	   NF.NUMERO AS 'N� DA NF', 
	   INF.QUANTIDADE*INF.PRECO AS 'TOTAL', 
	   V.[PERCENTUAL COMISSAO]*INF.QUANTIDADE*INF.PRECO AS 'COMISS�O'
FROM [TABELA DE VENDEDORES]V
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON V.MATRICULA = NF.MATRICULA
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GO

SELECT V.NOME AS 'VENDEDOR',
	   NF.NUMERO AS 'N� DA NF', 
	   SUM(INF.QUANTIDADE*INF.PRECO) AS 'TOTAL', 
	   SUM(V.[PERCENTUAL COMISSAO]*INF.QUANTIDADE*INF.PRECO) AS 'COMISS�O'
FROM [TABELA DE VENDEDORES]V
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON V.MATRICULA = NF.MATRICULA
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY V.NOME, NF.NUMERO
ORDER BY NF.NUMERO
GO

/*Crie uma consulta que traga como resultado a quantidade de vendas no m�s de Dezembro de 2015
somente para os clientes do bairro da Tijuca. */



select * from [dbo].[TABELA DE CLIENTES]
go

SELECT NOME, IDADE, [DATA DE NASCIMENTO],
CASE
	WHEN YEAR([DATA DE NASCIMENTO]) < 1990 THEN 'ADULTOS'
	WHEN YEAR([DATA DE NASCIMENTO]) BETWEEN 1990 AND 1995 THEN 'JOVENS'
	WHEN YEAR([DATA DE NASCIMENTO]) > 1995 THEN 'CRIAN�AS'
END AS 'FAIXA ET�RIA'
FROM [TABELA DE CLIENTES]
ORDER BY 'FAIXA ET�RIA'
GO

-- OU
SELECT NOME, IDADE, [DATA DE NASCIMENTO],
CASE
	WHEN YEAR([DATA DE NASCIMENTO]) < 1990 THEN 'ADULTOS'
	WHEN YEAR([DATA DE NASCIMENTO]) BETWEEN 1990 AND 1995 THEN 'JOVENS'
	WHEN YEAR([DATA DE NASCIMENTO]) > 1995 THEN 'CRIAN�AS'
END AS 'FAIXA ET�RIA'
FROM [TABELA DE CLIENTES]
ORDER BY
CASE
	WHEN YEAR([DATA DE NASCIMENTO]) < 1990 THEN 'ADULTOS'
	WHEN YEAR([DATA DE NASCIMENTO]) BETWEEN 1990 AND 1995 THEN 'JOVENS'
	WHEN YEAR([DATA DE NASCIMENTO]) > 1995 THEN 'CRIAN�AS'
END
GO

-- OU
SELECT NOME, IDADE, [DATA DE NASCIMENTO],
CASE
	WHEN YEAR([DATA DE NASCIMENTO]) < 1990 THEN 'ADULTOS'
	WHEN YEAR([DATA DE NASCIMENTO]) BETWEEN 1990 AND 1995 THEN 'JOVENS'
	WHEN YEAR([DATA DE NASCIMENTO]) > 1995 THEN 'CRIAN�AS'
END AS 'FAIXA ET�RIA'
FROM [TABELA DE CLIENTES]
ORDER BY NOME DESC, 'FAIXA ET�RIA' ASC
GO

-- JOINS

SELECT * FROM [TABELA DE VENDEDORES]
GO

SELECT * FROM [TABELA DE NOTAS FISCAIS]
GO

-- JUNTANDO AS TABELAS COM TODAS AS COLUNAS
SELECT * FROM [TABELA DE VENDEDORES]V
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON V.MATRICULA = NF.MATRICULA
GO

-- FILTRANDO PELO WHERE
SELECT * FROM [TABELA DE VENDEDORES]V
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON V.MATRICULA = NF.MATRICULA
WHERE V.MATRICULA = '00235'
GO

-- CONTANDO A QUANTIDADE DE REGISTROS
SELECT COUNT(*) FROM [TABELA DE VENDEDORES]V
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON V.MATRICULA = NF.MATRICULA
WHERE V.MATRICULA = '00235'
GO

-- ESCOLHENDO COLUNAS
SELECT V.NOME, NF.DATA, NF.NUMERO FROM [TABELA DE VENDEDORES]V
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON V.MATRICULA = NF.MATRICULA
WHERE YEAR(NF.DATA) = 2016
GO


-- DESAFIO
-- Crie uma tabela que especifique o nome e a idade dos clientes. */

SELECT * FROM [TABELA DE CLIENTES]
GO

SELECT NOME,
       DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE()) AS 'IDADE'
FROM [dbo].[TABELA DE CLIENTES]
GO

-- DESAFIO
-- Na tabela de notas fiscais, temos o valor do imposto.
-- J� na tabela de itens, temos a quantidade e o fauramento.
-- Calcule o valor do imposto pago no ano de 2016, arredondando para o menor inteiro.

SELECT * FROM [TABELA DE NOTAS FISCAIS]
SELECT * FROM [TABELA DE ITENS NOTAS FISCAIS]
GO

SELECT YEAR(NF.DATA) AS 'ANO',
       --NF.NUMERO,
	   --FORMAT((ROUND(SUM(NF.IMPOSTO*INF.QUANTIDADE*INF.PRECO), 2)), 'R$ ###,###,###,###.00') AS 'IMPOSTO PAGO EM 2016'  -- 1� MANEIRA
	   FORMAT(ROUND(SUM(NF.IMPOSTO*INF.QUANTIDADE*INF.PRECO), 2), 'C', 'PT-BR') AS 'IMPOSTO PAGO EM 2016'  -- 2� MANEIRA
FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY YEAR(NF.DATA)
GO

/*  Construa uma consulta cujo resultado seja, para cada cliente:
	"O cliente Jo�o da Silva comprou R$ 120.00,00 no ano de 2016." 
	Somente para o ano de 2016.  */

SELECT TOP 1 * FROM [dbo].[TABELA DE CLIENTES]
GO

SELECT TOP 1 * FROM [dbo].[TABELA DE NOTAS FISCAIS]
GO

SELECT TOP 1 * FROM [dbo].[TABELA DE ITENS NOTAS FISCAIS]
GO

SELECT CONCAT('O cliente ', C.NOME , 
              -- ' comprou ', FORMAT(SUM(INF.QUANTIDADE*INF.PRECO), 'R$ ###,###,###,###.00'), 
			  'comprou', FORMAT(SUM(INF.QUANTIDADE*INF.PRECO), 'C', 'PT-BR'),
			  ' em ', YEAR(NF.DATA))
FROM [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY C.NOME, YEAR(NF.DATA)
GO

/*RELAT�RIO DE VENDAS V�LIDAS - RESOLU��O DO PROFESSOR.
NOME, ANO/MES, QUANTIDADE M�S, VOLUME COMPRA, STATUS VENDA

--PASSO 01: SELECIONAR AS TABELAS 
SELECT * FROM [TABELA DE CLIENTES]

SELECT * FROM [TABELA DE ITENS NOTAS FISCAIS]

SELECT * FROM [TABELA DE NOTAS FISCAIS]

--PASSO 02: FAZER A UNIAO DAS TABELAS QUE TEM OS CAMPOS QUE QUEREMOS
SELECT * FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO

--PASSO 03: PEGAR SOMENTE OS CAMPOS QUE QUEREMOS
SELECT NF.CPF,NF.DATA,INF.QUANTIDADE FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO

--PASSO 04: CONVERTENDO A DATA PARA STRING
SELECT NF.CPF,CONVERT (VARCHAR,NF.DATA) AS 'DATA',INF.QUANTIDADE FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO

--PASSO 5: USAR A FUNCAO SUBSTRING PARA PEGAR SOMENTE ANO/MES
SELECT NF.CPF,
       SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES',INF.QUANTIDADE FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO

--PASSO 6: AGRUPAR A QUANTIDADE POR CPF E ANO/MES
SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7)

--PASSO 7: PEGAR O NOME E O VOLUME DE COMPRA DA TABELA DE CLIENTES
SELECT TC.NOME,TC.[VOLUME DE COMPRA]  FROM [TABELA DE CLIENTES]TC

--PASSO 8: FAZER UMA SUBQUERY DA CONSULTA DO PASSO 6
SELECT * FROM 
(SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7))CQ --> CONSULTA QUANTIDADE (SUBCONSULTA)[SUBQUERY]

--TESTE DO PASSO 8
SELECT CQ.CPF,CQ.[ANO/MES] FROM 
(SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7))CQ --> CONSULTA QUANTIDADE (SUBCONSULTA)[SUBQUERY]

--PASSO 9: APLICAR O INNER JOIN COM A TABELA DE CLIENTES
SELECT * FROM 
(SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7))CQ --> CONSULTA QUANTIDADE (SUBCONSULTA)[SUBQUERY]
INNER JOIN [TABELA DE CLIENTES]TC
ON CQ.CPF = TC.CPF

--PASSO 10:SELECIONARSOMENTE AS COLUNAS NECESSARIAS
SELECT TC.NOME,CQ.[ANO/MES],CQ.[QUANTIDADE MES],TC.[VOLUME DE COMPRA] FROM 
(SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7))CQ --> CONSULTA QUANTIDADE (SUBCONSULTA)[SUBQUERY]
INNER JOIN [TABELA DE CLIENTES]TC
ON CQ.CPF = TC.CPF

--PASSO 11:TRANFORMAR A CONSULTA DO PASSO 10 EM SUBCONSULTA (SUBQUERY)
SELECT * FROM
(SELECT TC.NOME,CQ.[ANO/MES],CQ.[QUANTIDADE MES],TC.[VOLUME DE COMPRA] FROM 
(SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7))CQ --> CONSULTA QUANTIDADE (SUBCONSULTA)[SUBQUERY]
INNER JOIN [TABELA DE CLIENTES]TC
ON CQ.CPF = TC.CPF)AUX

--TESTE DO PASSO 11
SELECT AUX.NOME,AUX.[VOLUME DE COMPRA] FROM
(SELECT TC.NOME,CQ.[ANO/MES],CQ.[QUANTIDADE MES],TC.[VOLUME DE COMPRA] FROM 
(SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7))CQ --> CONSULTA QUANTIDADE (SUBCONSULTA)[SUBQUERY]
INNER JOIN [TABELA DE CLIENTES]TC
ON CQ.CPF = TC.CPF)AUX

--PASSO 12: PEGAR SOMENTE OS CAMPOS QUE QUEREMOS E ACRESCENTAR O CASE NO SELECT 
SELECT AUX.NOME,AUX.[ANO/MES],AUX.[QUANTIDADE MES],AUX.[VOLUME DE COMPRA],
CASE
	WHEN AUX.[QUANTIDADE MES] <= AUX.[VOLUME DE COMPRA] THEN 'VENDA V�LIDA'
	ELSE 'VENDA INVALIDA'
END AS 'STATUS VENDA'

FROM
(SELECT TC.NOME,CQ.[ANO/MES],CQ.[QUANTIDADE MES],TC.[VOLUME DE COMPRA] FROM 
(SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7))CQ --> CONSULTA QUANTIDADE (SUBCONSULTA)[SUBQUERY]
INNER JOIN [TABELA DE CLIENTES]TC
ON CQ.CPF = TC.CPF)AUX

--PASSO 13: ORDENAR OS REGISTROS 
SELECT AUX.NOME,AUX.[ANO/MES],AUX.[QUANTIDADE MES],AUX.[VOLUME DE COMPRA],
CASE
	WHEN AUX.[QUANTIDADE MES] <= AUX.[VOLUME DE COMPRA] THEN 'VENDA V�LIDA'
	ELSE 'VENDA INVALIDA'
END AS 'STATUS VENDA'

FROM
(SELECT TC.NOME,CQ.[ANO/MES],CQ.[QUANTIDADE MES],TC.[VOLUME DE COMPRA] FROM 
(SELECT NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7) AS 'ANO/MES', SUM (INF.QUANTIDADE) AS 'QUANTIDADE MES' FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF,SUBSTRING (CONVERT (VARCHAR,NF.DATA),1,7))CQ --> CONSULTA QUANTIDADE (SUBCONSULTA)[SUBQUERY]
INNER JOIN [TABELA DE CLIENTES]TC
ON CQ.CPF = TC.CPF)AUX
ORDER BY AUX.NOME,AUX.[ANO/MES]
*/

SELECT C.NOME,
       --CONVERT(VARCHAR, NF.DATA),
       SUBSTRING(CONVERT(VARCHAR,NF.DATA), 1, 7) AS 'ANO/M�S',
	   SUM(INF.QUANTIDADE) AS 'QTDE. M�S',
	   C.[VOLUME DE COMPRA],
	   CASE
	       WHEN C.[VOLUME DE COMPRA] > SUM(INF.QUANTIDADE) THEN 'VENDA V�LIDA'
		   ELSE 'VENDA INV�LIDA'
	   END AS 'STATUS VENDA'
FROM [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
GROUP BY C.NOME, SUBSTRING(CONVERT(VARCHAR,NF.DATA), 1, 7), C.[VOLUME DE COMPRA]
ORDER BY 1, 2
GO

/* O dono da Esquina do Suco pediu para que criasse um relat�rio mostrando qual foi o faturamento em
dinheiro por sabor de produto e tamb�m que comparasse a participa��o daquela venda em rela��o ao
total (%). Somente no ano de 2016. */

SELECT YEAR(NF.DATA) AS 'ANO',
       P.SABOR,
       --FORMAT(ROUND(SUM(INF.QUANTIDADE*INF.PRECO), 2), 'C', 'PT-BR') AS 'FATURAMENTO'
       ROUND(SUM(INF.QUANTIDADE*INF.PRECO), 2) AS 'FATURAMENTO'
FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
INNER JOIN [TABELA DE PRODUTOS]P
ON P.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
WHERE YEAR(NF.DATA) = 2016
GROUP BY YEAR(NF.DATA), P.SABOR
-- ORDER BY FORMAT(ROUND(SUM(INF.QUANTIDADE*INF.PRECO), 2), 'C', 'PT-BR')
ORDER BY 3 DESC
GO

SELECT YEAR(NF.DATA) AS 'ANO',
       P.SABOR,
       --FORMAT(ROUND(SUM(INF.QUANTIDADE*INF.PRECO), 2), 'C', 'PT-BR') AS 'FATURAMENTO'
       FORMAT(ROUND(SUM(INF.QUANTIDADE*INF.PRECO), 2), 'R$ ###,###,###,###.00') AS 'FATURAMENTO',
	   ROUND((SUM(INF.QUANTIDADE*INF.PRECO)/(SELECT SUM(INF.QUANTIDADE*INF.PRECO)
												  FROM [dbo].[TABELA DE ITENS NOTAS FISCAIS]INF
												  INNER JOIN [TABELA DE NOTAS FISCAIS]NF
												  ON INF.NUMERO = NF.NUMERO
												  WHERE NF.DATA BETWEEN '20160101' AND '20161231')*100), 2) AS 'PARTICIPA��O (%)'
FROM [TABELA DE NOTAS FISCAIS]NF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
INNER JOIN [TABELA DE PRODUTOS]P
ON P.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
WHERE YEAR(NF.DATA) = 2016
GROUP BY YEAR(NF.DATA), P.SABOR
-- ORDER BY FORMAT(ROUND(SUM(INF.QUANTIDADE*INF.PRECO), 2), 'C', 'PT-BR')
ORDER BY 4 DESC
GO

SELECT * FROM [TABELA DE NOTAS FISCAIS]
WHERE YEAR([DATA]) = 2016
GO

SELECT ROUND(SUM(INF.QUANTIDADE*INF.PRECO), 2)
FROM [dbo].[TABELA DE ITENS NOTAS FISCAIS]INF
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON INF.NUMERO = NF.NUMERO
WHERE NF.DATA BETWEEN '20160101' AND '20161231'
GO
