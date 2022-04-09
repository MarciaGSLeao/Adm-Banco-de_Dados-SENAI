-- STORED PROCEDURE

/* Desafio 01
Na aula criamos a stored procedure abaixo: */ 
CREATE PROCEDURE BuscaPorEntidades @ENTIDADE VARCHAR (10)
AS
BEGIN
	IF @ENTIDADE = 'CLIENTES'
		SELECT [CPF] AS 'IDENTIFICADOR', [NOME] AS 'DESCRITOR', [BAIRRO] AS 'BAIRRO' FROM [TABELA DE CLIENTES]
	ELSE IF @ENTIDADE = 'VENDEDORES'
		SELECT [MATRICULA] AS 'IDENTIFICADOR', [NOME] AS 'DESCRITOR',[BAIRRO] AS'BAIRRO' FROM [TABELA DE VENDEDORES]
END
go

/* Crie uma segunda stored procedure chamada BuscaPorEntidadesCompleta com o
mesmo código da de cima, mas acrescente a entidade PRODUTOS. Das entidades, liste
apenas os seus identificadores e os seus nomes. */

create procedure sp_BuscaPorEntidadesCompleta @entidade varchar(30)
as
begin
	if @entidade = 'cliente'
		select cpf as 'IDENTIFICADOR', NOME FROM [TABELA DE CLIENTES]
	else if @entidade = 'produto'
		select [CODIGO DO PRODUTO] AS 'IDENTIFICADOR', [NOME DO PRODUTO] AS 'NOME' from [TABELA DE PRODUTOS]
	ELSE IF @entidade = 'VENDEDOR'
		SELECT MATRICULA AS 'IDENTIFICADOR', NOME FROM [TABELA DE VENDEDORES]
end
go

exec sp_BuscaPorEntidadesCompleta CLIENTE
EXEC sp_BuscaPorEntidadesCompleta PRODUTO
EXEC sp_BuscaPorEntidadesCompleta VENDEDOR
go


/* Objetivo: atualizar a idade baseada na data de nascimento e na data atual do
computador. Então é como se fosse uma atualização do campo idade.*/

SELECT * FROM [TABELA DE CLIENTES]
GO

-- COMANDO PARA DESABILITAR UMA TRIGGER
DISABLE TRIGGER TG_CLIENTES_IDADE ON [dbo].[TABELA DE CLIENTES]
GO

SELECT DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
FROM [TABELA DE CLIENTES]
GO

SELECT NOME, IDADE FROM [TABELA DE CLIENTES]
GO

CREATE PROCEDURE sp_CalcIdade
AS
	BEGIN
		UPDATE [TABELA DE CLIENTES]
		SET IDADE = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
	END
GO

INSERT INTO [TABELA DE CLIENTES] 
(CPF, NOME, ENDERECO, BAIRRO, CIDADE, ESTADO, CEP, [DATA DE NASCIMENTO], SEXO, [LIMITE DE CREDITO], [VOLUME DE COMPRA], [PRIMEIRA COMPRA])
VALUES
('02608703313', 'MARCIA GAMELEIRA', 'AV PEDRO MANOEL', 'CONTINENTAL', 'OSASCO', 'SP', '06020194', '19800722', 'F', 20000, 1000, 1)
GO

SELECT * FROM [TABELA DE CLIENTES]
GO

EXEC sp_CalcIdade
go

-- Desafio 02
-- Na empresa Esquina dos Sucos temos 3 categorias de produtos: Garrafas, Lata ou PET.
	SELECT DISTINCT EMBALAGEM FROM [TABELA DE PRODUTOS]
	GO

/* Imagine que, pela legislação, o imposto pago depende do tipo de embalagem do produto
e, a cada momento, ele muda. Temos o campo IMPOSTO na tabela de notas fiscais, que
determina o imposto a ser pago (alíquota sobre o faturamento). Faça uma stored
procedure que terá como entrada de dados:

• Mês
• Ano
• Alíquota
• Tipo de Produto (Garrafas, Lata ou PET)

Ela irá modificar a alíquota para a alíquota informada na entrada da stored procedure, para
as vendas de todas as notas fiscais no mês/ano informados, para todos os produtos do tipo
informado. Nome da stored procedure: AtualizaImposto.*/

-- ANÁLISE
SELECT P.[CODIGO DO PRODUTO],
       P.[NOME DO PRODUTO],
	   P.EMBALAGEM,
	   INF.NUMERO,
	   INF.QUANTIDADE,
	   INF.PRECO,
	   NF.IMPOSTO,
	   CASE
	       WHEN PRECO > 0 THEN PRECO*QUANTIDADE*(1+IMPOSTO)
	   END AS 'FATURAMENTO',
	   NF.[DATA]
FROM [TABELA DE PRODUTOS] P
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS] INF
ON P.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON INF.NUMERO = NF.NUMERO
WHERE NF.NUMERO = 100
GO

SELECT * FROM [TABELA DE NOTAS FISCAIS]
WHERE NUMERO = 100
GO

CREATE PROCEDURE sp_AtualizaImposto
@mes int, @ano int, @imposto float, @embalagem varchar(10)
as
	begin
		UPDATE NF
		SET NF.IMPOSTO = @imposto
		FROM [TABELA DE NOTAS FISCAIS]NF
		INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
		ON NF.NUMERO = INF.NUMERO
		INNER JOIN [TABELA DE PRODUTOS]TP
		ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
		WHERE MONTH (NF.DATA) = @mes AND YEAR (NF.DATA) = @ano AND TP.[EMBALAGEM] = @embalagem
	end
go

-- Teste
SELECT P.[CODIGO DO PRODUTO],
       P.[NOME DO PRODUTO],
	   P.EMBALAGEM,
	   INF.NUMERO,
	   INF.QUANTIDADE,
	   INF.PRECO,
	   NF.IMPOSTO,
	   CASE
	       WHEN PRECO > 0 THEN PRECO*QUANTIDADE*(1+IMPOSTO)
	   END AS 'FATURAMENTO', -- Faturamento do item 1013793 = 1663,893
	   NF.[DATA]
FROM [TABELA DE PRODUTOS] P
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS] INF
ON P.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON INF.NUMERO = NF.NUMERO
WHERE NF.NUMERO = 100
GO

-- Executando a Procedure
BEGIN TRANSACTION
exec sp_AtualizaImposto @mes = 1, @ano = 2015, @imposto = 0.05, @embalagem = 'PET'
GO
SELECT DISTINCT --P.[CODIGO DO PRODUTO],
       --P.[NOME DO PRODUTO],
	   P.EMBALAGEM,
	   INF.NUMERO,
	   --INF.QUANTIDADE,
	   --INF.PRECO,
	   NF.IMPOSTO,
	   /*CASE
	       WHEN PRECO > 0 THEN PRECO*QUANTIDADE*(1+IMPOSTO)
	   END AS 'FATURAMENTO', -- Faturamento do item 1013793 = 1663,893*/
	   NF.[DATA]
FROM [TABELA DE PRODUTOS] P
INNER JOIN [TABELA DE ITENS NOTAS FISCAIS] INF
ON P.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [TABELA DE NOTAS FISCAIS]NF
ON INF.NUMERO = NF.NUMERO
WHERE P.[EMBALAGEM] = 'PET' AND MONTH([DATA]) = 1 AND YEAR([DATA]) = 2015
GO

ROLLBACK
COMMIT
GO

-- Exercício
/* Crie uma Storage Procedure que traga todas as notas de um cliente de um determinado período. */

-- Analíse

select top 5 * from [TABELA DE CLIENTES]
select top 5 * from [TABELA DE NOTAS FISCAIS]
select top 5 * from [TABELA DE ITENS NOTAS FISCAIS]
select top 5 * from [TABELA DE PRODUTOS]
go


create procedure sp_BuscaNotas
@cpf varchar(12), @dataInicial date, @dataFinal date
as
	begin
		select nf.cpf, nf.data, nf.numero,
		       p.[NOME DO PRODUTO],
			   inf.QUANTIDADE*inf.PRECO as 'TOTAL'
		from [TABELA DE NOTAS FISCAIS]nf
		inner join [TABELA DE ITENS NOTAS FISCAIS]inf
		on nf.NUMERO = inf.NUMERO
		inner join [TABELA DE PRODUTOS]p
		on inf.[CODIGO DO PRODUTO] = p.[CODIGO DO PRODUTO]
        where cpf = @cpf and [DATA] between @dataInicial and @dataFinal
	end
go

EXEC sp_BuscaNotas @cpf = '3623344710', @dataInicial = '20150101', @dataFinal = '20151231'
go

select nf.cpf, nf.data, nf.numero,
		       p.[NOME DO PRODUTO],
			   inf.QUANTIDADE,
			   inf.PRECO,
			   inf.QUANTIDADE*inf.PRECO as 'TOTAL'
		from [TABELA DE NOTAS FISCAIS]nf
		inner join [TABELA DE ITENS NOTAS FISCAIS]inf
		on nf.NUMERO = inf.NUMERO
		inner join [TABELA DE PRODUTOS]p
		on inf.[CODIGO DO PRODUTO] = p.[CODIGO DO PRODUTO]
        where cpf = '3623344710' and [DATA] between '20150101' and '20151231'
go

/* Desafio 03
Temos a seguinte consulta que nos retorna o número de notas fiscais por dia, onde
@ListaDatas é uma variável do tipo tabela, com a lista de datas a serem exibidas:*/

SELECT [DATA], COUNT(*) AS NUMERO FROM [NOTAS FISCAIS]
WHERE DATA IN (SELECT DATANOTA FROM @ListaDatas)
GROUP BY DATA
go


-- • Crie um estrutura do tipo TYPE, onde iremos inserir as datas;
-- • Passe este tipo para a SP como parâmetro, representando a lista de datas. O nome da SP deve ser ListaNumeroNotas;
-- • Utilize o SELECT mencionado acima, usando a variável @ListaDatas como sendo a lista de datas passada como parâmetro;
-- • Crie a SP;
-- • Inicialize algumas datas em uma variável do tipo definido no passo inicial;
-- • Execute a SP.
-- Construa uma SP que retorne o número de notas fiscais por dia, baseada na lista de dias passada como parâmetro. */
