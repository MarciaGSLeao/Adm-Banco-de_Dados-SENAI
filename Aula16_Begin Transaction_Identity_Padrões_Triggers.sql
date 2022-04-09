/*	- IDENTITY (10,10) : significa que o campo é preenchido automaticamente,
iniciando em 10 e sendo incrementado de 10 em 10.
*/

create table teste1(
	id_faturamento int identity (10, 10),
	empresa varchar (255)
)
go

select * from teste1
go

begin transaction
insert into teste1 (empresa) values
('A'),
('B'),
('C'),
('D'),
('E')
go

select * from teste1
go

commit
go
rollback
go

truncate table teste1
go


/*	- PADRÃO: define valor padrão a ser inserido em uma coluna
*/

create table teste2_padrao
(
	id_medicao int identity (1, 1),
	empresa varchar(255),
	status varchar(255) default 'teste padrão'
)
go

select * from [dbo].[teste2_padrao]
go

insert into teste2_padrao (empresa) values ('XPTO'),
('abcd'),
('efgh'),
('ijkl'),
('mnop')
go

-- DESAFIO
select CPF, NOME, [DATA DE NASCIMENTO] from [TABELA DE CLIENTES]
go


SELECT GETDATE()

SELECT SYSDATETIME()

SELECT NOME, [DATA DE NASCIMENTO] FROM [TABELA DE CLIENTES]
SELECT NOME, IDADE, CONCAT(DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE()),'a') as IDADE_2
FROM [dbo].[TABELA DE CLIENTES]
GO

CREATE TRIGGER TG_CLIENTE_IDADE
ON [TABELA DE CLIENTES]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	UPDATE [TABELA DE CLIENTES]
	SET IDADE = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
END
GO

INSERT INTO [TABELA DE CLIENTES] (CPF, NOME, [DATA DE NASCIMENTO]) VALUES
('08475495427', 'Felipe', '1989-11-28')
go

alter table [tabela de clientes]
add idade2 date
go

alter table [tabela de clientes]
alter column IDADE2 varchar
go

select NOME, IDADE, IDADE2 from [TABELA DE CLIENTES]

CREATE TRIGGER TG_MES_ANIVERSARIO
ON [TABELA DE CLIENTES]
FOR INSERT, UPDATE, DELETE
AS
	BEGIN
		UPDATE [TABELA DE CLIENTES]
		SET [IDADE2] = DATENAME(MONTH, DATEPART(MONTH,[DATA DE NASCIMENTO]))
	END
GO