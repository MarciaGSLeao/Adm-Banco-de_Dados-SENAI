--================================================================ EXEMPLO 1 ================================================================
declare @nome varchar(30)

declare cursor1 cursor for
select nome from [tabela de clientes]

open cursor1
fetch next from cursor1 into @nome
while @@FETCH_STATUS = 0
	begin
		print @nome
		fetch next from cursor1 into @nome
	end
close cursor1
deallocate cursor1
go

--================================================================ EXEMPLO 2 ================================================================
-- Acessando mais de um campo

select * from [TABELA DE CLIENTES]
go

declare @nome varchar(30)
declare @endereco varchar(max)

declare cursor2 cursor for
select NOME, ENDERECO + ' - ' + BAIRRO + ' - ' + CIDADE + ' - ' + ESTADO + ' - ' + CEP from [TABELA DE CLIENTES]

open cursor2
fetch next from cursor2 into @nome, @endereco

while @@FETCH_STATUS = 0
	begin
		print @nome + ' - Endereço: ' + @endereco
		fetch next from cursor2 into @nome, @endereco
	end
close cursor2
deallocate cursor2
go

--================================================================ EXEMPLO 3 ================================================================
-- Gerando valores aleatórios
-- Passo 1: Criar uma função aleatório
select round(rand(), 2)

-- Criando uma função
create function NumeroAleatorio


