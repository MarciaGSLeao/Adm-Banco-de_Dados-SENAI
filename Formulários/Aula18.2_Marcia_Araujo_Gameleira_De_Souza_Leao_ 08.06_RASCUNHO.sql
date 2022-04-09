/* 1 - Altere o script abaixo para incluir o dia e o n�mero de notas em uma tabela([TABELA NOTAS]). Use o que foi aprendido na �ltima aula.*/

--C�DIGO INICIAL
DECLARE @DATAINICIAL DATE
DECLARE @DATAFINAL DATE
DECLARE @NUMNOTAS INT
SET @DATAINICIAL = '20170101'
SET @DATAFINAL = '20170110'

WHILE @DATAINICIAL < @DATAFINAL
BEGIN
	SELECT @NUMNOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS]
	WHERE DATA = @DATAINICIAL

	PRINT CONVERT(VARCHAR(10), @DATAINICIAL + ' --> ' + CONVERT(VARCHAR(10), @NUMNOTAS)
	SELECT @DATAINICIAL = DATEADD(DAY, 1, @DATAINICIAL)
END
-------------------------------------------------------------------------------------------------------------------------------------------------
--RASCUNHO: incluir o dia e o n�mero de notas em uma tabela
SELECT * FROM [TABELA DE NOTAS FISCAIS] --87877 registros

SELECT COUNT(*) as 'Notas de 01 a 10/01' FROM [TABELA DE NOTAS FISCAIS]
WHERE DATA BETWEEN  '20170101' AND '20170110' --762 registros


--C�DIGO FINAL
DECLARE @DATAINICIAL DATE
DECLARE @DATAFINAL DATE
DECLARE @NUMNOTAS INT

SET @DATAINICIAL = '20170101'
SET @DATAFINAL = '20170110'


WHILE @DATAINICIAL <= @DATAFINAL
BEGIN
	SELECT @NUMNOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS]
	WHERE DATA = @DATAINICIAL

	PRINT CONVERT(VARCHAR(10), @DATAINICIAL) + ' --> ' + CONVERT(VARCHAR(10), @NUMNOTAS)
	SELECT @DATAINICIAL = DATEADD(DAY, 1, @DATAINICIAL)
END
