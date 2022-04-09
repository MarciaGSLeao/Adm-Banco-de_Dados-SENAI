-- Criação de variáveis e atribuição de valores
-- Existem duas formas de exibir as variáveis criadas para o usuário:
-- DESAFIO 01

DECLARE @CLIENTE VARCHAR(10) = 'João'
DECLARE @IDADE INT = 10
DECLARE @DATA_NASCIMENTO DATE = '2007-01-10'
DECLARE @CUSTO FLOAT = 10.23
-- Exibindo o resultando com a fuñção PRINT
PRINT 'Cliente: ' + @CLIENTE
PRINT 'Idade: ' + convert(varchar, @IDADE)
PRINT 'Data de Nascimento: ' + convert(varchar, @DATA_NASCIMENTO)
PRINT 'Custo: ' + convert(varchar, @CUSTO)
GO

DECLARE @CLIENTE VARCHAR(10) = 'João'
DECLARE @IDADE INT = 10
DECLARE @DATA_NASCIMENTO DATE = '2007-01-10'
DECLARE @CUSTO FLOAT = 10.23
-- Também podemos exibir o resultado com a função SELECT, no entanto é exibido em forma tabular.
SELECT @CLIENTE AS 'CLIENTE', @IDADE AS 'IDADE', @DATA_NASCIMENTO AS 'DATA DE NASCIMENTO', @CUSTO AS 'CUSTO'
GO


-- DESAFIO 02
DECLARE @NUMNOTAS INT
-- Obs: Se o valor a ser atribuído a uma variável for proveniente de uma consulta SELECT, o script deve ser organizado da maneira abaixo.
SELECT @NUMNOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = '2017-01-01'
PRINT 'Total de Notas: ' + CONVERT(VARCHAR, @NUMNOTAS)
GO
/*
SELECT COUNT(*) FROM [TABELA DE NOTAS FISCAIS]
WHERE DATA = '2017-01-01'
GO*/

CREATE TABLE TAB_TESTE
(
	NOME VARCHAR (30)
)
GO

--Criando um fluxo para verificar se a tabela foi criada ou não
IF OBJECT_ID ('TAB_TESTE', 'U') IS NULL --Pelo "OBJECT_ID"
	CREATE TABLE TAB_TESTE
		(NOME VARCHAR (30))
ELSE
	DROP TABLE TAB_TESTE
GO

-- DESAFIO 03
/* Crie um script que, baseado em uma data, conte o número de notas fiscais. Se houver
mais de 70 notas, exiba a mensagem "Muita nota". Se não, exiba a mensagem "Pouca
nota". Exiba também o número de notas. */

SELECT * FROM [TABELA DE NOTAS FISCAIS]
WHERE DATA = '2016-07-22'
GO

SELECT COUNT(*) FROM [TABELA DE NOTAS FISCAIS]  -- 62 registros
WHERE DATA = '2016-07-22'
GO

DECLARE @TOTAL_NOTAS INT
SELECT @TOTAL_NOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = '2016-07-22'

IF @TOTAL_NOTAS > 70
	PRINT 'Muita nota'
ELSE
	PRINT 'Pouca nota'
GO

-- DESAFIO 04
/* Baseado no script de resposta do exercício anterior:
Em vez de testar com a variável @NUMNOTAS, use a própria
consulta SQL na condição de teste. */

DECLARE @TOTAL_NOTAS INT
DECLARE @DATA_NOTA DATE

SET @DATA_NOTA = '2016-07-22'
SELECT @TOTAL_NOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = @DATA_NOTA

IF (SELECT COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = '2016-07-22') > 60
	PRINT 'Muita nota'
ELSE
	PRINT 'Pouca nota'
GO

--Desafio 05
/*Sabendo que a função abaixo soma um dia a uma data:*/
SELECT DATEADD(DAY, 1, @DATA)
/*Faça um script que, a partir do dia 01/01/2017, conte o número de notas fiscais
até o dia 10/01/2017. Imprima a data e o número de notas fiscais.
Dicas:
• Declare variáveis do tipo DATE: DATAINICIAL e DATAFINAL;
• Faça um loop testando se a data inicial é menor que a data final;
• Imprima a data e o número de notas na saída do Management Studio. Não
esqueça de converter as variáveis para VARCHAR;
• Acrescente um dia à data.*/

SELECT COUNT(*) FROM [TABELA DE NOTAS FISCAIS]
WHERE DATA = '2017-01-10'
GO

DECLARE @DATA_INICIAL DATE
DECLARE @DATA_FINAL DATE
DECLARE @TOTAL_NOTAS INT

SET @DATA_INICIAL = '2017-01-01'
SET @DATA_FINAL = '2017-01-10'
--SELECT @DATA_INICIAL = MIN(DATA) FROM [TABELA DE NOTAS FISCAIS]
--SELECT @DATA_FINAL = MAX(DATA) FROM [TABELA DE NOTAS FISCAIS]

WHILE @DATA_INICIAL <= @DATA_FINAL
	BEGIN
		SELECT @TOTAL_NOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = @DATA_INICIAL
		
		PRINT CONVERT(VARCHAR,@DATA_INICIAL) + ' --> ' + CONVERT(VARCHAR, @TOTAL_NOTAS) + ' notas.'

		SELECT @DATA_INICIAL = DATEADD(DAY, 1, @DATA_INICIAL)
	END
GO

--Desafio 06
/*Continue evoluindo o script da resposta do exercício anterior. Agora, inclua o dia e
o número de notas em uma tabela.*/

--ANÁLISE
SELECT * FROM [TABELA DE NOTAS FISCAIS]

SELECT DATA, COUNT(*) AS 'TOTAL DE NOTAS'FROM [TABELA DE NOTAS FISCAIS]
GROUP BY DATA
ORDER BY DATA ASC
GO

SELECT MIN(DATA) FROM [TABELA DE NOTAS FISCAIS]
GO

SELECT MAX(DATA) FROM [TABELA DE NOTAS FISCAIS]
GO

--Criando a tabela
IF OBJECT_ID('TOTAL DE NOTAS POR DATA', 'U') IS NULL
	BEGIN
		CREATE TABLE [TOTAL DE NOTAS POR DATA]
		(
			DATA DATE,
			[TOTAL DE NOTAS] INT
		)

	END
GO

/*ELSE
	BEGIN
		TRUNCATE TABLE NOTAS_POR_DATA
	END
GO*/

--Programação
BEGIN TRANSACTION

DECLARE @DATA_INICIAL DATE
DECLARE @DATA_FINAL DATE
DECLARE @TOTAL_NOTAS INT

SELECT @DATA_INICIAL = MIN(DATA) FROM [TABELA DE NOTAS FISCAIS]
SELECT @DATA_FINAL = MAX(DATA) FROM [TABELA DE NOTAS FISCAIS]

WHILE @DATA_INICIAL <= @DATA_FINAL
	BEGIN
		SELECT @TOTAL_NOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = @DATA_INICIAL
	
		INSERT INTO [dbo].[TOTAL DE NOTAS POR DATA] (DATA, [TOTAL DE NOTAS]) VALUES (@DATA_INICIAL, @TOTAL_NOTAS)

		--PRINT CONVERT(VARCHAR,@DATA_INICIAL) + ' --> ' + CONVERT(VARCHAR, @TOTAL_NOTAS) + ' notas.'
		SELECT @DATA_INICIAL = DATEADD(DAY, 1, @DATA_INICIAL)
	END
GO

--Verificando
SELECT count(*) FROM [dbo].[TOTAL DE NOTAS POR DATA]

SELECT * FROM [dbo].[TOTAL DE NOTAS POR DATA]
WHERE [TOTAL DE NOTAS] > 0
GO

ROLLBACK
COMMIT
GO

--=======================================================================================

CREATE TABLE [TABELA NUMEROS]
(
	NUMERO INT,
	[STATUS] VARCHAR (200)
)
GO

SELECT COUNT(*) FROM [TABELA DE NOTAS FISCAIS]
SP_HELP [TABELA DE NOTAS FISCAIS]

SELECT MIN(NUMERO) FROM [TABELA DE NOTAS FISCAIS]
SELECT MAX(NUMERO) FROM [TABELA DE NOTAS FISCAIS]




