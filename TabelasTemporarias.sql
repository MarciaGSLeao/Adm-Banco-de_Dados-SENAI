-- Tabelas Tempor�rias: todas s�o criadas e armazenadas em mem�ria, ou seja, quando houver o logoff a tabela deixar� de existir.

/*
Come�a com #  --> vale apenas para a conex�o vigente
Come�a com ## --> vale para v�rias conex�es
Come�a com @  --> vale para o procedimento que est� sendo executado
*/

create table #tb_temp01(
	id varchar(50) not null,
	nome varchar(50) not null
)
go

insert into #tb_temp01 values ('1', 'Pedro')
go

select * from #tb_temp01
go

insert into #tb_temp01 values ('2', 'M�rcia')
go


create table ##tb_temp02(
	id varchar(50) not null,
	nome varchar(50) not null
)
go

insert into ##tb_temp02 values ('1', 'Pedro')
insert into ##tb_temp02 values ('2', 'M�rcia')
go


select * from ##tb_temp02  -- Testar: abrir 'Nova Consulta' e executar essa consulta para validar o conceito de tabela tempor�ria com ## no nome.
go

--==============================================================================================================================================================================
-- Tabela Tempor�ria como vari�vel

begin transaction

declare @tb_nf_status table (	numero_nf int,
							[status_nf] varchar(100)) -- cria��o da tabela tempor�ria

declare @NumNotaInicial int
declare @NumNotaFinal int

SELECT @NumNotaInicial = MIN(NUMERO) FROM [TABELA DE NOTAS FISCAIS]
SELECT @NumNotaFinal = MAX(NUMERO) FROM [TABELA DE NOTAS FISCAIS]

while @NumNotaInicial <= @NumNotaFinal
begin
	if @NumNotaInicial in(select Numero from [TABELA DE NOTAS FISCAIS])
	begin
		--print 'Ok! - ' + cast(@NumNotaInicial as varchar)
		insert into @tb_nf_status values (@NumNotaInicial, '� nota fiscal')
		set @NumNotaInicial = @NumNotaInicial + 1
		continue
	end
	else
		print 'acabou'
		--break
end

select * from @tb_nf_status
go


