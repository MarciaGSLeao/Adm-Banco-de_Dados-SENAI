-- Cria��o de vari�veis e atribui��o de valores
-- Existem duas formas de exibir as vari�veis criadas para o usu�rio:
-- DESAFIO 01

DECLARE @CLIENTE VARCHAR(10) = 'Jo�o'
DECLARE @IDADE INT = 10
DECLARE @DATA_NASCIMENTO DATE = '2007-01-10'
DECLARE @CUSTO FLOAT = 10.23
-- Exibindo o resultando com a fu���o PRINT
PRINT 'Cliente: ' + @CLIENTE
PRINT 'Idade: ' + convert(varchar, @IDADE)
PRINT 'Data de Nascimento: ' + convert(varchar, @DATA_NASCIMENTO)
PRINT 'Custo: ' + convert(varchar, @CUSTO)
GO

DECLARE @CLIENTE VARCHAR(10) = 'Jo�o'
DECLARE @IDADE INT = 10
DECLARE @DATA_NASCIMENTO DATE = '2007-01-10'
DECLARE @CUSTO FLOAT = 10.23
-- Tamb�m podemos exibir o resultado com a fun��o SELECT, no entanto � exibido em forma tabular.
SELECT @CLIENTE AS 'CLIENTE', @IDADE AS 'IDADE', @DATA_NASCIMENTO AS 'DATA DE NASCIMENTO', @CUSTO AS 'CUSTO'
GO


-- DESAFIO 02
DECLARE @NUMNOTAS INT
-- Obs: Se o valor a ser atribu�do a uma vari�vel for proveniente de uma consulta SELECT, o script deve ser organizado da maneira abaixo.
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

--Criando um fluxo para verificar se a tabela foi criada ou n�o
IF OBJECT_ID ('TAB_TESTE', 'U') IS NULL --Pelo "OBJECT_ID"
	CREATE TABLE TAB_TESTE
		(NOME VARCHAR (30))
ELSE
	DROP TABLE TAB_TESTE
GO

-- DESAFIO 03
/* Crie um script que, baseado em uma data, conte o n�mero de notas fiscais. Se houver
mais de 70 notas, exiba a mensagem "Muita nota". Se n�o, exiba a mensagem "Pouca
nota". Exiba tamb�m o n�mero de notas. */

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
/* Baseado no script de resposta do exerc�cio anterior:
Em vez de testar com a vari�vel @NUMNOTAS, use a pr�pria
consulta SQL na condi��o de teste. */

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
/*Sabendo que a fun��o abaixo soma um dia a uma data:*/
SELECT DATEADD(DAY, 1, @DATA)
/*Fa�a um script que, a partir do dia 01/01/2017, conte o n�mero de notas fiscais
at� o dia 10/01/2017. Imprima a data e o n�mero de notas fiscais.
Dicas:
� Declare vari�veis do tipo DATE: DATAINICIAL e DATAFINAL;
� Fa�a um loop testando se a data inicial � menor que a data final;
� Imprima a data e o n�mero de notas na sa�da do Management Studio. N�o
esque�a de converter as vari�veis para VARCHAR;
� Acrescente um dia � data.*/

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
/*Continue evoluindo o script da resposta do exerc�cio anterior. Agora, inclua o dia e
o n�mero de notas em uma tabela.*/

--AN�LISE
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

--Programa��o
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




