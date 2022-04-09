declare @contador int
set @contador = 1

while @contador <= 10
begin
	print 'Number ' + cast(@contador as varchar)

	set @contador = @contador + 1
end
go

/* Desafio 01
Crie 4 variáveis com as características abaixo:
• Nome: Cliente. Tipo: Caracteres com 10 posições. Valor: João
• Nome: Idade. Tipo: Inteiro. Valor: 10
• Nome: DataNascimento. Tipo: Data. Valor: 10/01/2007
• Nome: Custo. Tipo: Número com casas decimais. Valor: 10,23
Construa um script que declare estas variáveis, atribua valores a elas e exiba-as
na saída do SQL Server Management Studio.*/

declare @cliente varchar(10),
        @idade int,
		@dataNascimento date,
		@custo numeric(10,2)

set @cliente = 'João'
set @idade = 10
set	@dataNascimento = '20070110'
set	@custo = 10.23

print 'Nome: ' + @cliente
print 'Idade: ' + cast(@idade as varchar)
print 'Data de Nascimento: ' + cast(@dataNascimento as varchar)
print 'Custo: ' + cast(@custo as varchar)
go

/* Desafio 02
Crie uma variável chamada NUMNOTAS e atribua a ela o número de notas
fiscais do dia 01/01/2017. Mostre na saída do script o valor da variável.*/

select count(*) [NUMERO] from [TABELA DE NOTAS FISCAIS]

select count(*) [NUMERO] from [TABELA DE NOTAS FISCAIS]
where DATA = '20170101'
go

declare @numNotas int
declare @data date

set @numNotas = (select count(*) [NUMERO] from [TABELA DE NOTAS FISCAIS] where DATA = '20170101')
set @data = '20170101'

print 'Total de notas do dia ' + convert(varchar,@data,105) + ': ' + cast(@numNotas as varchar)
go

/*Desafio 03
Crie um script que, baseado em uma data, conte o número de notas fiscais. Se houver
mais de 70 notas, exiba a mensagem "Muita nota". Se não, exiba a mensagem "Pouca
nota". Exiba também o número de notas.*/

select count(*) from [TABELA DE NOTAS FISCAIS] where data = '20160722'
go

declare @qtdNotas int
declare @data date

set @data = '20160723'
select @qtdNotas = count(*) from [TABELA DE NOTAS FISCAIS] where DATA = @data

if @qtdNotas > 70
	print 'Muitas notas em ' + convert(varchar, @data, 105) + '. Total de notas: ' + cast(@qtdNotas as varchar)

else
	print 'Poucas notas em ' + convert(varchar, @data, 105) + '. Total de notas: ' + cast(@qtdNotas as varchar)
go

/*Desafio 04
Baseado no script de resposta do exercício anterior:
Em vez de testar com a variável @NUMNOTAS, use a própria
consulta SQL na condição de teste*/

declare @qtdNotas int
declare @data date

set @data = '20160723'
select @qtdNotas = count(*) from [TABELA DE NOTAS FISCAIS] where DATA = @data

if (select count(*) from [TABELA DE NOTAS FISCAIS] where DATA = @data) > 70
	print 'Muitas notas em ' + convert(varchar, @data, 105) + '. Total de notas: ' + cast(@qtdNotas as varchar)

else
	print 'Poucas notas em ' + convert(varchar, @data, 105) + '. Total de notas: ' + cast(@qtdNotas as varchar)
go


/*Desafio 05
Sabendo que a função abaixo soma um dia a uma data:
SELECT DATEADD(DAY, 1, @DATA)
Faça um script que, a partir do dia 01/01/2017, conte o número de notas fiscais
até o dia 10/01/2017. Imprima a data e o número de notas fiscais.
Dicas:
• Declare variáveis do tipo DATE: DATAINICIAL e DATAFINAL;
• Faça um loop testando se a data inicial é menor que a data final;
• Imprima a data e o número de notas na saída do Management Studio. Não
esqueça de converter as variáveis para VARCHAR;
• Acrescente um dia à data.*/

select dateadd(day, 2, getdate())
go

declare @dataInicial date,
        @dataFinal date,
		@totalNotas int

set @dataInicial = '20170101'
set @dataFinal = '20170110'

print 'Total de notas por dia'
print ''
while @dataInicial <= @dataFinal
begin
	select @totalNotas = count(*) from [TABELA DE NOTAS FISCAIS] where DATA = @dataInicial

	print convert(varchar, @dataInicial, 105) + ' -> ' + cast(@totalNotas as varchar) + ' notas.'
	-- print @totalNotas
	set @dataInicial = (select dateadd(day, 1, @dataInicial))
end
go


/* Desafio 06
Continue evoluindo o script da resposta do exercício anterior. Agora, inclua o dia e
o número de notas em uma tabela.*/

create table DESAFIO_06_TSQL(
	DATA DATE,
	[TOTAL DE NOTAS] INT
)
GO

select min(data) from [dbo].[TABELA DE NOTAS FISCAIS]
select max(data) from [dbo].[TABELA DE NOTAS FISCAIS]

select count(*) from [dbo].[TABELA DE NOTAS FISCAIS] where [DATA] = '20160915'

select count(*) from [TABELA DE NOTAS FISCAIS] group by DATA -- 1185 dias.
select distinct data from [TABELA DE NOTAS FISCAIS]  -- 1185 dias
go


begin transaction
declare @data_inicial date,
        @data_final date,
        @qtd_notas int

select @data_inicial = min(data) from [dbo].[TABELA DE NOTAS FISCAIS]
select @data_final = max(data) from [dbo].[TABELA DE NOTAS FISCAIS]
--select @qtd_notas = count(*) from [dbo].[TABELA DE NOTAS FISCAIS] where [DATA] = @data_inicial

while @data_inicial <= @data_final
begin
	select @qtd_notas = count(*) from [dbo].[TABELA DE NOTAS FISCAIS] where [DATA] = @data_inicial
	insert into [DESAFIO_06_TSQL] values (@data_inicial, @qtd_notas)

	select @data_inicial = dateadd(day, 1, @data_inicial) 
end
go

select * from DESAFIO_06_TSQL
rollback
commit

select data, COUNT(*) from [TABELA DE NOTAS FISCAIS]
where data = '20180329'
group by DATA
go

select count(*) from DESAFIO_06_TSQL
where [TOTAL DE NOTAS] = 0
go

select 1266 + 1185


-- Testes

create table [TABELA NUMEROS]
(
	NUMERO INT,
	[STATUS] VARCHAR(200)
)
GO

SELECT * FROM [TABELA NUMEROS]
GO

select count(*) from [TABELA DE NOTAS FISCAIS] -- 87880 registros
select min(numero) from [TABELA DE NOTAS FISCAIS] -- 100
select max(numero) from [TABELA DE NOTAS FISCAIS] -- 87979
go

begin transaction

declare @NumNotaInicial int
declare @NumNotaFinal int

SELECT @NumNotaInicial = MIN(NUMERO) FROM [TABELA DE NOTAS FISCAIS]
SELECT @NumNotaFinal = MAX(NUMERO) FROM [TABELA DE NOTAS FISCAIS]

while @NumNotaInicial <= @NumNotaFinal
begin
	if @NumNotaInicial in(select Numero from [TABELA DE NOTAS FISCAIS])
	begin
		--print 'Ok! - ' + cast(@NumNotaInicial as varchar)
		insert into [TABELA NUMEROS] values (@NumNotaInicial, 'É nota fiscal')
		set @NumNotaInicial = @NumNotaInicial + 1
		continue
	end
	else
		print 'acabou'
		break
end
go

select * from [TABELA NUMEROS]
commit