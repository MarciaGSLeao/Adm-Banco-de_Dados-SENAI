-- Fun��es definidas pelo usu�rio ou Fun��es UDFs (User Defined Functions)

-- Criar uma fun��o que traga o total da nota fiscal quando o n�mero da nota for informada.
select * from [TABELA DE ITENS NOTAS FISCAIS]
where numero = 100
go

select numero, sum(QUANTIDADE*PRECO) as 'total da nota' from [TABELA DE ITENS NOTAS FISCAIS]
where numero = 100
group by numero
go

create function ValorFaturado (@numero int) 
returns float
as
	begin
		declare @faturamento float

		select @faturamento = sum(QUANTIDADE*PRECO) from [TABELA DE ITENS NOTAS FISCAIS] where numero = @numero

		return @faturamento
	end
go

select numero as 'n� nf', dbo.ValorFaturado(numero) as 'Total' from [TABELA DE NOTAS FISCAIS]
go

/* Desafio 01
Em exerc�cios anteriores, constru�mos um script para obter o n�mero de notas fiscais
de uma determinada data. Veja-o abaixo:*/

DECLARE @NUMNOTAS INT

SELECT @NUMNOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = '20150825'

PRINT @NUMNOTAS
go

/*Transforme este script em uma fun��o onde passamos a data como par�metro e
retornamos o n�mero de notas. Chame esta fun��o de NumeroNotas. Ap�s a sua
cria��o, teste seu uso com um SELECT.*/

select count(*) from [TABELA DE NOTAS FISCAIS]
go

create function NumeroNotas (@data date)
returns int
as
	begin
		declare @qtdNotas int

		select @qtdNotas = count(*) from [TABELA DE NOTAS FISCAIS] where [DATA] = @data

		return @qtdNotas

	end
go

select DATA, [dbo].[NumeroNotas]([DATA]) as 'Total de Notas' FROM [TABELA DE NOTAS FISCAIS]
GROUP BY DATA
ORDER BY DATA
GO


/*Desafio 02
Em exerc�cios anteriores constru�mos um script para criar uma tabela com o n�mero de notas fiscais para um per�odo de datas. Veja o script abaixo:*/

CREATE TABLE [TB_NOTAS POR DATA](
	DATA DATE, 
	NUMNOTAS INT
)
GO

DECLARE @DATAINICIAL DATE
DECLARE @DATAFINAL DATE
DECLARE @NUMNOTAS INT

SELECT @DATAINICIAL = MIN(DATA) FROM [TABELA DE NOTAS FISCAIS]
SELECT @DATAFINAL = MAX(DATA) FROM [TABELA DE NOTAS FISCAIS]

WHILE @DATAINICIAL <= @DATAFINAL
	BEGIN
		SELECT @NUMNOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = @DATAINICIAL

		INSERT INTO [TB_NOTAS POR DATA] (DATA, NUMNOTAS) VALUES (@DATAINICIAL, @NUMNOTAS)

		SELECT @DATAINICIAL = DATEADD(DAY, 1, @DATAINICIAL)
	END
GO

SELECT * FROM [TB_NOTAS POR DATA]

SELECT MIN(DATA) FROM [TABELA DE NOTAS FISCAIS]
SELECT MAX(DATA) FROM [TABELA DE NOTAS FISCAIS]
GO

TRUNCATE TABLE [dbo].[TB_NOTAS POR DATA]
GO


/* Reescreva este script usando a fun��o NumeroNotas no momento de inserir dados na tabela. Execute o SELECT para exibir os dados.*/

DECLARE @DATAINICIAL DATE
DECLARE @DATAFINAL DATE
-- DECLARE @NUMNOTAS INT

SELECT @DATAINICIAL = MIN(DATA) FROM [TABELA DE NOTAS FISCAIS]
SELECT @DATAFINAL = MAX(DATA) FROM [TABELA DE NOTAS FISCAIS]

WHILE @DATAINICIAL <= @DATAFINAL
	BEGIN
		--SELECT @NUMNOTAS = COUNT(*) FROM [TABELA DE NOTAS FISCAIS] WHERE DATA = @DATAINICIAL

		INSERT INTO [TB_NOTAS POR DATA] (DATA, NUMNOTAS) VALUES (@DATAINICIAL, [dbo].[NumeroNotas](@DATAINICIAL))

		SELECT @DATAINICIAL = DATEADD(DAY, 1, @DATAINICIAL)
	END
GO

SELECT * FROM [TB_NOTAS POR DATA]

SELECT MIN(DATA) FROM [TABELA DE NOTAS FISCAIS]
SELECT MAX(DATA) FROM [TABELA DE NOTAS FISCAIS]
GO

TRUNCATE TABLE [dbo].[TB_NOTAS POR DATA]
GO


/* Desafio 03
Veja a consulta abaixo:*/

SELECT DISTINCT DATA, [dbo].[NUMERONOTAS](DATA) AS 'NUMERO'
FROM [TABELA DE NOTAS FISCAIS]
WHERE DATA >= '20170101' AND DATA <= '20170131'
--order by 1 => o order by  combinado com a fun��o DISTINCT consome muita performance do banco
go

/* Ela ir� retornar o n�mero de notas fiscais entre duas datas. Transforme isto em
uma fun��o chamada FuncTabelaNotas, onde o resultado � a consulta acima.
Lembrando que a data inicial e final ser�o par�metros desta fun��o. Depois,
teste a fun��o atrav�s de um SELECT. */

create function FuncTabelaNotas (@dataInicial date, @dataFinal date)
returns table
as
	return
	SELECT DISTINCT DATA, [dbo].[NUMERONOTAS](DATA) as 'QTD DE NOTAS'
	FROM [TABELA DE NOTAS FISCAIS]
	WHERE DATA between @dataInicial and @dataFinal	
go

SELECT * FROM [dbo].[FuncTabelaNotas]('20160101', '20160131')
ORDER BY 1
GO

/* OBS: Fun��es com Valor de Tabela se mostraram ineficientes pois consomem muito do processamento do banco e possui
performance.*/

-- ALTERANDO UMA FUN��O
-- Crie uma fun��o que ao informar o cpf do cliente, a fun��o traga o endere�o completo.

select * from [TABELA DE CLIENTES]
go

create function Endereco (@cpf varchar(12))
returns table
as
	return
	select cpf, nome, endereco, bairro, cidade, estado, cep from [TABELA DE CLIENTES]
	where cpf = @cpf
go

select * from Endereco ('492472718')
go


/* Desafio 04
Veja a consulta abaixo:*/

SELECT DATA, COUNT(*) AS NUMERO FROM [TABELA DE NOTAS FISCAIS]
WHERE DATA >= '20170101' AND DATA <= '20170110'
GROUP BY DATA

/*Ela tamb�m retorna o n�mero de notas entre duas datas. Modifique a fun��o
FuncTabelaNotas para que utilize esta consulta acima */

ALTER function [dbo].[FuncTabelaNotas] (@dataInicial date, @dataFinal date)
returns table
as
	return
	SELECT DATA, count(*) as 'QTD DE NOTAS'
	FROM [TABELA DE NOTAS FISCAIS]
	WHERE DATA between @dataInicial and @dataFinal
	GROUP BY DATA
GO

SELECT * FROM [dbo].[FuncTabelaNotas]('20170101','20170110')
ORDER BY 1
GO


-- EXCLUINDO UMA FUN��O

-- Utilizamos a sintaxe
DROP FUNCTION <NOME DA FUN��O>