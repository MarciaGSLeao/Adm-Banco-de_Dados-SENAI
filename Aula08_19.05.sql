USE ESQUINA_VENDAS

-- A fun��o DISTINCT: retorna apenas linhas com valores diferentes.
SELECT * FROM [TABELA DE PRODUTOS]
SELECT DISTINCT EMBALAGEM, TAMANHO FROM [TABELA DE PRODUTOS]

-- Pode ser usado para descobrir uma lista distinta entre as combina��es poss�veis entre colunas.
SELECT DISTINCT EMBALAGEM, TAMANHO, SABOR FROM [TABELA DE PRODUTOS]

-- Pode ser usado com a cl�usula WHERE
SELECT DISTINCT EMBALAGEM, TAMANHO, SABOR FROM [TABELA DE PRODUTOS]
WHERE SABOR = 'LARANJA'

-- Quantos bairros diferentes da cidade do Rio de Janeiro e S�o Paulo possuem clientes?
SELECT DISTINCT BAIRRO, CIDADE FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'RIO DE JANEIRO'

SELECT DISTINCT BAIRRO, CIDADE FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'S�O PAULO'

--A fun��o TOP
SELECT TOP(10) * FROM [TABELA DE CLIENTES]

--ORDER BY
/*  
	SELECT * FROM [NOME DA TABELA]
    ORDER BY [COLUNA1],[COLUNA2] 
*/
-- Qual as 10 primeiras vendas do dia 01/01/2017?
SELECT TOP 10 * FROM [TABELA DE NOTAS FISCAIS]
WHERE DATA = '01/01/2017'
order by numero

--Qual foi a maior venda do produto 'Linha Refrescante - 1 Litro - Morango/Lim�o'?
SELECT * FROM [TABELA DE PRODUTOS]

select * from [dbo].[TABELA DE PRODUTOS]
where [NOME DO PRODUTO] like '%Morango/Lim�o%'

select * from [dbo].[TABELA DE ITENS NOTAS FISCAIS]

select * from [dbo].[TABELA DE ITENS NOTAS FISCAIS]
where [CODIGO DO PRODUTO] = '1101035'
order by [QUANTIDADE] desc

--ORDER BY
/*
	SELECT [X], SUM, MAX, MIN, AVG ou COUNT[Y] FROM [NOME DA TABELA]
	GROUP BY [X]
*/

--Quantos itens de venda existem com a maior quantidade de venda para o produto '1101035'?
select count(*) from [dbo].[TABELA DE ITENS NOTAS FISCAIS]
where [CODIGO DO PRODUTO] = '1101035' and [QUANTIDADE] = 99

--HAVING: condi��o que se aplica ao resultado de uma agrega��o
--		  � aplicada para que possamos aplicar um filtro sobre um resultado de um group by.
--Quais s�o os clientes que fizeram mais de 2000 compras em 2016?
select * from [tabela de notas fiscais]

select CPF, count(*) as 'QTDE. DE COMPRAS' FROM [TABELA DE NOTAS FISCAIS]
WHERE YEAR(DATA) = 2016
GROUP BY CPF
HAVING COUNT(*) > 2000

--CASE
/*
CASE
	WHEN [CONDI�AO 1] THEN [VALOR CASO A CONDI��O FOR ATENDIDA]
	...
	...
	ELSE [VALOR SE NENHUMA DAS CONDI��ES ACIMA FOREM ATENDIDAS]
END
*/
--Veja o ano de nascimento dos clientes e classifique-os como: nascidos antes de 1990 s�o adultos, entre 1990 e 1995 s�o jovens e depois 
--s�o crian�as. Liste o nome do cliente e esta classifica��o.
SELECT NOME, YEAR([DATA DE NASCIMENTO]) AS 'ANO DE NASCIMENTO',
	
	CASE
		WHEN YEAR([DATA DE NASCIMENTO]) < 1990 THEN ('ADULTOS')
		WHEN YEAR([DATA DE NASCIMENTO]) >= 1990 AND YEAR([DATA DE NASCIMENTO]) <= 1995 THEN 'JOVENS'
		ELSE 'CRIAN�AS'
	END AS 'CLASSIFICA��O'

FROM [TABELA DE CLIENTES]
ORDER BY YEAR([DATA DE NASCIMENTO]) DESC

