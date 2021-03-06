/* 3 - Na Aula 11 (Exemplos de Relat?rios) criamos um relat?rio chamado de Relat?rio de vendas v?lidas.
Adapte este relat?rio gerando um script que baseado numa data (MES/ANO) e (CPF) podemos ter a seguinte mensagem abaixo.*/
--NOME
--VOLUME DE COMPRAS
--MES/ANO
--2015-02


DECLARE @NOME VARCHAR(50)
DECLARE @VOLUME_COMPRAS INT
DECLARE @QTD_COMPRADA INT
DECLARE @MES_ANO DATE

SET @NOME = '?rica Carvalho'
SELECT @VOLUME_COMPRAS = [VOLUME DE COMPRA] FROM [TABELA DE CLIENTES] WHERE NOME = @NOME
SELECT @QTD_COMPRADA =  SUM(QUANTIDADE) from [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
where C.NOME = '?rica Carvalho' AND YEAR(DATA) = 2015 AND MONTH(DATA) = 2
GROUP BY C.NOME

IF @QTD_COMPRADA > @VOLUME_COMPRAS
	BEGIN
		PRINT 'O cliente ' + @NOME + ' ultrapassou o seu volume de compras nesse per?odo!'
	END
ELSE
	BEGIN
		PRINT 'O cliente ' + @NOME + ' n?o ultrapassou o seu volume de compras nesse per?odo!'
END

PRINT ''
PRINT 'Nome: ' + @NOME
PRINT 'Volume de Compras: ' + CONVERT(VARCHAR,@VOLUME_COMPRAS)
PRINT 'Quantidade Comprada: ' + CONVERT(VARCHAR,@QTD_COMPRADA)
