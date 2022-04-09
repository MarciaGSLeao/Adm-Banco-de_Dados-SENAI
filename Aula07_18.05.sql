CREATE TABLE TESTE
(
	MATRICULA_TESTE VARCHAR (10),
	NOME_TESTE VARCHAR (200),
	MARCA_TESTE VARCHAR (100),
	PRIMARY KEY (MATRICULA_TESTE),
	MATRICULA VARCHAR (5) NOT NULL,
	FOREIGN KEY (MATRICULA) REFERENCES [TABELA DE VENDEDORES] (MATRICULA)
)

DROP TABLE [TABELA DE NOTAS FISCAIS]

CREATE TABLE [TABELA DE NOTAS FISCAIS]
(
	[CPF] VARCHAR (11) NOT NULL,
	[MATRICULA] VARCHAR (5) NOT NULL,
	[DATA] DATE,
	[NUMERO] CHAR (6),
	[IMPOSTO] FLOAT,

	PRIMARY KEY ([NUMERO]),

	FOREIGN KEY ([CPF]) REFERENCES [TABELA DE CLIENTES]([CPF]),
	FOREIGN KEY ([MATRICULA]) REFERENCES [TABELA DE VENDEDORES]([MATRICULA])
)

DROP TABLE [TABELA ITENS NOTAS FISCAIS]

CREATE TABLE [TABELA ITENS NOTAS FISCAIS]
(
	[NUMERO] CHAR (6) NOT NULL,
	[CODIGO DO PRODUTO] VARCHAR (10) NOT NULL,
	[QUANTIDADE] INT,
	[PRECO] FLOAT,

	PRIMARY KEY ([NUMERO],[CODIGO DO PRODUTO]),

	FOREIGN KEY ([NUMERO]) REFERENCES [TABELA DE NOTAS FISCAIS] ([NUMERO]),
	FOREIGN KEY ([CODIGO DO PRODUTO]) REFERENCES [TABELA DE PRODUTOS]([CODIGO DO PRODUTO])
)
