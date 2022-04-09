/* 3 - Na Aula 11 (Exemplos de Relatórios) criamos um relatório chamado de Relatório de vendas válidas.
Adapte este relatório gerando um script que baseado numa data (MES/ANO) e (CPF) podemos ter a seguinte mensagem abaixo.*/
--NOME
--VOLUME DE COMPRAS
--MES/ANO
--2015-02

select * from [TABELA DE CLIENTES]
select * from [TABELA DE NOTAS FISCAIS]
select * from [TABELA DE ITENS NOTAS FISCAIS]

select C.NOME, QUANTIDADE AS 'VOLUME COMPRADO', CONVERT(CHAR(4),YEAR(DATA)) + '/' + CONVERT(CHAR(4),MONTH(DATA)) AS 'ANO/MÊS'
from [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
where C.NOME = 'Érica Carvalho' AND YEAR(DATA) = 2015 AND MONTH(DATA)  = 2 --398 registros

------------------------------------------------------------------------------------------------------------------------------------------
--Consulta
select C.NOME, SUM(QUANTIDADE) AS 'VOLUME COMPRADO', CONVERT(CHAR(4),YEAR(DATA)) + '/' + CONVERT(CHAR(4),MONTH(DATA)) AS 'ANO/MÊS'
from [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
where C.NOME = 'Érica Carvalho' AND YEAR(DATA) = 2015 AND MONTH(DATA)  = 2 --1 registros
GROUP BY C.NOME, CONVERT(CHAR(4),YEAR(DATA)) + '/' + CONVERT(CHAR(4),MONTH(DATA))

select SUM(QUANTIDADE)
from [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
where C.NOME = 'Érica Carvalho' AND YEAR(DATA) = 2015 AND MONTH(DATA)  = 2 --1 registros
GROUP BY C.NOME

--RESPOSTA FINAL
DECLARE @NOME VARCHAR(50)
DECLARE @VOLUME_COMPRAS INT
DECLARE @QTD_COMPRADA INT
DECLARE @MES_ANO DATE

SET @NOME = 'Érica Carvalho'
SELECT @VOLUME_COMPRAS = [VOLUME DE COMPRA] FROM [TABELA DE CLIENTES] WHERE NOME = @NOME
SELECT @QTD_COMPRADA =  SUM(QUANTIDADE) from [TABELA DE CLIENTES]C
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON C.CPF = NF.CPF
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
ON NF.NUMERO = INF.NUMERO
where C.NOME = 'Érica Carvalho' AND YEAR(DATA) = 2015 AND MONTH(DATA) = 2
GROUP BY C.NOME

IF @QTD_COMPRADA > @VOLUME_COMPRAS
	BEGIN
		PRINT 'O cliente ' + @NOME + ' ultrapassou o seu volume de compras nesse período!'
	END
ELSE
	BEGIN
		PRINT 'O cliente ' + @NOME + ' não ultrapassou o seu volume de compras nesse período!'
END

PRINT ''
PRINT 'Nome: ' + @NOME
PRINT 'Volume de Compras: ' + CONVERT(VARCHAR,@VOLUME_COMPRAS)
PRINT 'Quantidade Comprada: ' + CONVERT(VARCHAR,@QTD_COMPRADA)

PRINT 'MES/ANO: ' + CONVERT(VARCHAR, @MES_ANO)
























declare @cliente varchar(20), @volume_compras int, @mes_ano date
set @cliente = 'Érica Carvalho'

