--USE ESQUINA_VENDAS

INSERT INTO [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO],[NOME DO PRODUTO], [EMBALAGEM], [TAMANHO], [SABOR], [PREÇO DE LISTA])
VALUES ('788975', 'Pedaçõs de Frutas - 1,5 Litros - Maça', 'PET', '1,5 Litros', 'Maça', 18.01)


DROP TABLE [TABELA DE PRODUTOS]

--Criando tabela especificando a chave primária

CREATE TABLE [TABELA DE PRODUTOS]
(
	[CODIGO DO PRODUTO][VARCHAR](10),
	[NOME DO PRODUTO][VARCHAR](50),
	[EMBALAGEM][VARCHAR](20),
	[TAMANHO][VARCHAR](10),
	[SABOR][VARCHAR](20),
	[PREÇO DE LISTA][smallmoney],
    PRIMARY KEY ([CODIGO DO PRODUTO])
)

INSERT INTO [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO],[NOME DO PRODUTO],[EMBALAGEM],[TAMANHO],[SABOR],[PREÇO DE LISTA])
  VALUES 
  ('1040107','Light - 350 ml - Melancia','Lata','350 ml','Melancia',4.56),
   ('1037797','Clean - 2 Litros - Laranja','PET','2 Litros','Laranja',16.01),
    ('1000889','Sabor da Montanha - 700 ml - Uva','Garrafa','700 ml','Uva',6.31),
     ('1004327','Videira do Campo - 1,5 Litros - Melancia','PET','1,5 Litros','Melancia',19.51),
      ('1088126','Linha Citros - 1 Litro - Limão','PET','1 Litro','Limão',7.00),
       ('544931','Frescor do Verão - 350 ml - Limão','Lata','350 ml','Limão',2.46),
        ('1078680','Frescor do Verão - 470 ml - Manga','Garrafa','470 ml','Manga',5.18),
		 ('788975', 'Pedaços de Frutas - 1,5 Litros - Maça', 'PET', '1,5 Litros', 'Maça', 18.01)


DROP TABLE [TABELA DE CLIENTES]

CREATE TABLE [TABELA DE CLIENTES]
(
	[CPF] [VARCHAR] (11) ,
	[NOME] [VARCHAR] (100) ,
	[ENDERECO 1] [VARCHAR] (150) ,
	[ENDERECO 2] [VARCHAR] (150) ,
	[BAIRRO] [VARCHAR] (50) ,
	[CIDADE] [VARCHAR] (50) ,
	[ESTADO] [VARCHAR] (2) ,
	[CEP] [VARCHAR] (8) ,
	[DATA DE NASCIMENTO] [DATE],
	[IDADE] [SMALLINT],
	[SEXO] [VARCHAR] (1) ,
	[LIMITE DE CREDITO] [MONEY] ,
	[VOLUME DE COMPRA] [FLOAT] ,
	[PRIMEIRA COMPRA] [BIT],
	PRIMARY KEY ([CPF])
)

-- DESAFIO MASTER

DROP TABLE [Tab_Vendedores]

create table [Tab_Vendedores]
(
	[Matricula][varchar](5),
	[Nome][varchar](100),
	[Comissao %][float],
	[DataAdmissao][date],
	[Ferias?][bit],
	Primary Key ([Matricula])
)

insert into [Tab_Vendedores] values ('00133','Marly dos Santos Gama',0.08,'20140815',0),
									('00144','Bruno César Brandão',0.05,'20160815',1),
									('00155','Roberta Serra',0.11,'20180815',0),
									('00166','Pericles Alves',0.11,'20190815',1)

select * from Tab_Vendedores