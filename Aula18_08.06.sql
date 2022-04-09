--DESAFIO 02
--Crie uma vari�vel chamada NUMNOTAS e atribua a ela o n�mero de notas fiscais do dia 01/01/2017.
--Mostre na sa�da do script o valor da vari�vel.

/*SELECT COUNT(*) FROM [TABELA DE NOTAS FISCAIS]
WHERE [DATA] = '20170101'*/

DECLARE @NUMNOTAS INT
SELECT @NUMNOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE [DATA] = '20170101'

PRINT 'TOTAL DE NOTAS: ' + CONVERT(VARCHAR,@NUMNOTAS)