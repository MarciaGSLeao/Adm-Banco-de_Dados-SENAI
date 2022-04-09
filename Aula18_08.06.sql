--DESAFIO 02
--Crie uma variável chamada NUMNOTAS e atribua a ela o número de notas fiscais do dia 01/01/2017.
--Mostre na saída do script o valor da variável.

/*SELECT COUNT(*) FROM [TABELA DE NOTAS FISCAIS]
WHERE [DATA] = '20170101'*/

DECLARE @NUMNOTAS INT
SELECT @NUMNOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE [DATA] = '20170101'

PRINT 'TOTAL DE NOTAS: ' + CONVERT(VARCHAR,@NUMNOTAS)