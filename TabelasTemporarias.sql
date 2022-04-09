-- Tabelas Temporárias: todas são criadas e armazenadas em memória, ou seja, quando houver o logoff a tabela deixará de existir.

/*
Começa com #  --> vale apenas para a conexão vigente
Começa com ## --> vale para várias conexões
Começa com @  --> vale para o procedimento que está sendo executado
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

insert into #tb_temp01 values ('2', 'Márcia')
go


create table ##tb_temp02(
	id varchar(50) not null,
	nome varchar(50) not null
)
go

insert into ##tb_temp02 values ('1', 'Pedro')
insert into ##tb_temp02 values ('2', 'Márcia')
go


select * from ##tb_temp02  -- Testar: abrir 'Nova Consulta' e executar essa consulta para validar o conceito de tabela temporária com ## no nome.
go

--==============================================================================================================================================================================
-- Tabela Temporária como variável

begin transaction

declare @tb_nf_status table (	numero_nf int,
							[status_nf] varchar(100)) -- criação da tabela temporária

declare @NumNotaInicial int
declare @NumNotaFinal int

SELECT @NumNotaInicial = MIN(NUMERO) FROM [TABELA DE NOTAS FISCAIS]
SELECT @NumNotaFinal = MAX(NUMERO) FROM [TABELA DE NOTAS FISCAIS]

while @NumNotaInicial <= @NumNotaFinal
begin
	if @NumNotaInicial in(select Numero from [TABELA DE NOTAS FISCAIS])
	begin
		--print 'Ok! - ' + cast(@NumNotaInicial as varchar)
		insert into @tb_nf_status values (@NumNotaInicial, 'É nota fiscal')
		set @NumNotaInicial = @NumNotaInicial + 1
		continue
	end
	else
		print 'acabou'
		--break
end

select * from @tb_nf_status
go


