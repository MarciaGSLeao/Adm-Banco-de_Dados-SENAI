----------------------------------------AULA 16--------------------------------------------------------------------------

SELECT * FROM [TABELA DE VENDEDORES]

BEGIN TRANSACTION

UPDATE [TABELA DE VENDEDORES] 
SET [PERCENTUAL COMISSAO] = [PERCENTUAL COMISSAO] * 1.15

INSERT INTO [TABELA DE VENDEDORES] (MATRICULA,NOME, [PERCENTUAL COMISSAO], [DATA DE ADMISSAO],FERIAS,BAIRRO)
VALUES ('99999','Jo�o da Silva',0.08,'2014-09-01',0,'Icara�')

ROLLBACK

COMMIT




------------- AUTO INCREMENTO ------------------------------------------

CREATE TABLE TESTE
( 
	ID INT IDENTITY (1,1) NOT NULL,
	NOME VARCHAR(20) NOT NULL
)

INSERT INTO TESTE(NOME) VALUES ('Roberto Silva')
INSERT INTO TESTE(NOME) VALUES ('Andr� Luiz')
INSERT INTO TESTE(NOME) VALUES ('J�ssica Santos')

SELECT * FROM TESTE

DELETE FROM TESTE WHERE ID = 1

DROP TABLE TESTE


CREATE TABLE TESTE
( 
	ID INT IDENTITY (100,5) NOT NULL,
	NOME VARCHAR(20) NOT NULL
)

INSERT INTO TESTE(NOME) VALUES ('Roberto Silva')
INSERT INTO TESTE(NOME) VALUES ('Andr� Luiz')
INSERT INTO TESTE(NOME) VALUES ('J�ssica Santos')

SELECT * FROM TESTE


---------------- CAMPOS PADR�ES ------------------------------------

CREATE TABLE TAB_PADRAO
(
	ID INT IDENTITY (1,1) NOT NULL, --A FUN��O 'IDENTITY' � AUTO-INCREMENTAL NA COLUNA ONDE A FUN��O � ESPECIFICADA
	NOME VARCHAR(20) NULL,
	ENDERECO VARCHAR(200) NULL,
	CIDADE VARCHAR(50) DEFAULT 'Cidade n�o definida',
	DATA_CRIACAO DATE DEFAULT GETDATE()
)

INSERT INTO [TAB_PADRAO](NOME, ENDERECO, CIDADE, DATA_CRIACAO) 
VALUES ('Pedro Silva', 'Rua 145', 'S�o Paulo', '2019-09-25')

SELECT * FROM  [TAB_PADRAO]

INSERT INTO [TAB_PADRAO](NOME, ENDERECO) VALUES ('Pedro Silva', 'Rua 145')

SELECT * FROM  [TAB_PADRAO]



------------------------- TRIGGER ----------------------------------------------------------------

/* --SINTAXE DE UMA TRIGGER

CREATE TRIGGER [NOME DA TRIGGER]
ON [TABELA MONITORADA]
	AS
		BEGIN
			[AFTER/BEFORE/FOR/INSTEAD OF] [INSERT/UPDATE/DELETE]

				<CORPO DA TRIGGER>

		END
*/

CREATE TABLE [VENDAS DIARIAS]
(
	DATA_VENDA DATE,
	TOTAL_VENDA FLOAT
)

SELECT * FROM [VENDAS DIARIAS]

CREATE TRIGGER TG_VENDAS_DIARIAS
ON [TABELA DE ITENS NOTAS FISCAIS] --TABELA A SER 'MONITORADA'
	AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DELETE FROM [VENDAS DIARIAS]

	INSERT INTO [VENDAS DIARIAS] (DATA_VENDA,TOTAL_VENDA)

	SELECT NF.DATA, SUM (INF.QUANTIDADE*INF.PRE�O) AS 'TOTAL VENDA' FROM [TABELA DE NOTAS FISCAIS]NF
	INNER JOIN [TABELA DE ITENS NOTAS FISCAIS]INF
	ON NF.NUMERO = INF.NUMERO
	GROUP BY NF.DATA
	ORDER BY NF.DATA DESC
END


INSERT INTO [TABELA DE NOTAS FISCAIS] (NUMERO, DATA, CPF, MATRICULA, IMPOSTO)
VALUES ('011111', '2021-06-02', '1471156710', '00235', 0.25)

INSERT INTO [TABELA DE ITENS NOTAS FISCAIS] (NUMERO,[CODIGO DO PRODUTO],[QUANTIDADE],PRE�O)
VALUES ('011111', '1000889', 100, 1)

SELECT * FROM [VENDAS DIARIAS]
WHERE DATA_VENDA = '2021-06-02'

INSERT INTO [TABELA DE ITENS NOTAS FISCAIS] (NUMERO,[CODIGO DO PRODUTO],[QUANTIDADE],PRE�O)
VALUES ('011111', '1002334', 100, 1)

SELECT * FROM [VENDAS DIARIAS]
WHERE DATA_VENDA = '2021-06-02'

DELETE FROM [TABELA DE ITENS NOTAS FISCAIS]
WHERE NUMERO = '011111' AND [CODIGO DO PRODUTO] = '1002334'

SELECT * FROM [VENDAS DIARIAS]
WHERE DATA_VENDA = '2021-06-02'


UPDATE [TABELA DE ITENS NOTAS FISCAIS]
SET QUANTIDADE = 300
WHERE NUMERO =  '011111' AND [CODIGO DO PRODUTO]= '1000889'

SELECT * FROM [VENDAS DIARIAS]
WHERE DATA_VENDA = '2021-06-02'


UPDATE [TABELA DE ITENS NOTAS FISCAIS]
SET PRE�O = 5
WHERE NUMERO =  '011111' AND [CODIGO DO PRODUTO]= '1000889'

SELECT * FROM [VENDAS DIARIAS]
WHERE DATA_VENDA = '2021-06-02'


---------------- DESAFIO DA AULA 16 ---------------------------------------
--Minha Query
--O SQL abaixo calcula a idade em anos baseado na data atual.
--Construa uma TRIGGER, de nome TG_CLIENTES_IDADE, que atualize as idades
--dos clientes, na tabela de clientes, toda vez que a tabela sofrer uma inclus�o,
--altera��o ou exclus�o.

select * from [TABELA DE CLIENTES]

SELECT [NOME],
	   [CPF],
	   [IDADE],
	   [DATA DE NASCIMENTO],
	   DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
AS 'IDADE ATUAL'
FROM [TABELA DE CLIENTES]

CREATE TRIGGER TG_CLIENTES_IDADE
ON [TABELA DE CLIENTES]
	AFTER INSERT, UPDATE, DELETE
AS
BEGIN --Abaixo � o comando que a Trigger deve disparar. 
	UPDATE [TABELA DE CLIENTES]
	SET IDADE = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())	
END

--Query do Professor
SELECT [CPF], [IDADE], [DATA DE NASCIMENTO],
DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE()) AS 'IDADE' 
FROM [TABELA DE CLIENTES]


CREATE TRIGGER TG_CLIENTES_IDADE
ON [TABELA DE CLIENTES]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	UPDATE [TABELA DE CLIENTES] 
	SET [IDADE] = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE());
END



--TESTANDO O DESAFIO
  INSERT INTO [TABELA DE CLIENTES] (CPF,NOME,ENDERECO,COMPLEMENTO,CIDADE,ESTADO,CEP,[DATA DE NASCIMENTO],IDADE,SEXO,[LIMITE DE CREDITO],[VOLUME DE COMPRA],[PRIMEIRA COMPRA])
  VALUES ('51073366200','Kl�cio Lira','Rua Conde de Bonfim','','Rio de Janeiro', 'RJ','22020001','2001-01-01',1,'M', 120000,22000,1)

  SELECT * FROM [TABELA DE CLIENTES]
  WHERE NOME LIKE '%Kl�cio%'

  UPDATE [TABELA DE CLIENTES]
  SET IDADE = 300
  WHERE NOME LIKE '%Kl�cio%'

  SELECT * FROM [TABELA DE CLIENTES]
  WHERE NOME LIKE '%Kl�cio%'

 DELETE FROM [TABELA DE CLIENTES]
 WHERE NOME LIKE '%Kl�cio%'

  SELECT * FROM [TABELA DE CLIENTES]
  WHERE NOME LIKE '%Kl�cio%'


--CHECK: Limita um intervalo de valores que pode ser colocado em uma coluna.

CREATE TABLE CLIENTE_TESTE
(
	ID INT IDENTITY NOT NULL,
	NOME VARCHAR(20),
	IDADE INT,
	CIDADE VARCHAR(20),

	CHECK (IDADE >= 18) --A restri��o CHECK s� permitir� inser��o de valor maior que 18.
)


INSERT INTO CLIENTE_TESTE ( NOME, IDADE, CIDADE) VALUES ('JO�O', 19, 'RIO DE JANEIRO')

SELECT * FROM CLIENTE_TESTE


INSERT INTO CLIENTE_TESTE( NOME, IDADE, CIDADE) VALUES ('PEDRO', 20, 'S�O PAULO')

INSERT INTO CLIENTE_TESTE( NOME, IDADE, CIDADE) VALUES ('MARIA', 17, 'S�O PAULO')

DROP TABLE CLIENTE_TESTE


CREATE TABLE CLIENTE_TESTE
(
	ID INT IDENTITY NOT NULL,
	NOME VARCHAR(20),
	IDADE INT,
	CIDADE VARCHAR(20),

	CHECK (IDADE >= 18 AND CIDADE = 'S�o Paulo') --A restri��o s� permitir� inser��o de valores com coluna IDADE maior ou igual a 18 e coluna CIDADE igual a 'S�o Paulo'.
	
)

INSERT INTO CLIENTE_TESTE ( NOME, IDADE, CIDADE) VALUES ('JO�O', 19, 'RIO DE JANEIRO')

INSERT INTO CLIENTE_TESTE( NOME, IDADE, CIDADE) VALUES ('PEDRO', 20, 'S�O PAULO')

INSERT INTO CLIENTE_TESTE( NOME, IDADE, CIDADE) VALUES ('MARIA', 17, 'S�O PAULO')

SELECT * FROM CLIENTE_TESTE

UPDATE CLIENTE_TESTE
SET CIDADE = 'Campinas'
WHERE ID = 2

drop table cliente_teste

------------------------------ RESTRI��ES -----------------------------------

-- SEM RESTRI��ES
CREATE TABLE CLIENTE_TESTE
(
	ID_CLIENTE INT IDENTITY NOT NULL,
	NOME VARCHAR(20),
	IDADE INT,
	CIDADE VARCHAR(20),
	SEXO CHAR (1),
	EMAIL VARCHAR (30),
)


INSERT INTO CLIENTE_TESTE (NOME,IDADE,CIDADE,SEXO,EMAIL)
VALUES ('Jos� Laborda',42,'Campinas','M','jose@teste.com.br')

select * from CLIENTE_TESTE

DROP TABLE CLIENTE_TESTE


-- SEM AS CONTRAINTS
CREATE TABLE CLIENTE_TESTE
(
	ID_CLIENTE INT IDENTITY NOT NULL,
	NOME VARCHAR(20) NOT NULL,
	IDADE INT NOT NULL,
	CIDADE VARCHAR(20) NOT NULL,
	SEXO CHAR (1) NOT NULL,
	EMAIL VARCHAR (30) NOT NULL,
		
	CHECK (IDADE >= 18),
	CHECK (SEXO IN('M','F')),
	PRIMARY KEY (ID_CLIENTE),
	UNIQUE (EMAIL)
)

INSERT INTO CLIENTE_TESTE (NOME,IDADE,CIDADE,SEXO,EMAIL)
VALUES ('Jos� Laborda',42,'Campinas','M','jose@teste.com.br')

select * from CLIENTE_TESTE

drop table CLIENTE_TESTE

-- COM AS RESTRI��ES E DEFINIDAS PELA CONSTRAINTS (Usando a palavra reservada CONSTRAINT seguida pelo nome que se deseja dar � Constraint)
CREATE TABLE CLIENTE_TESTE

(
	ID_CLIENTE INT IDENTITY NOT NULL,
	NOME VARCHAR(20) NOT NULL,
	IDADE INT NOT NULL,
	CIDADE VARCHAR(20) NOT NULL,
	SEXO CHAR (1) NOT NULL,
	EMAIL VARCHAR (30) NOT NULL,

	
	CONSTRAINT CK_IDADE CHECK (IDADE >= 18),
	CONSTRAINT CK_SEXO CHECK (SEXO IN('M','F')),
	CONSTRAINT PK_ID PRIMARY KEY (ID_CLIENTE),
	CONSTRAINT UQ_EMAIL UNIQUE (EMAIL)
	
)

INSERT INTO CLIENTE_TESTE (NOME,IDADE,CIDADE,SEXO,EMAIL)
VALUES ('Jos� Laborda',42,'Campinas','M','jose@teste.com.br')

DROP TABLE CLIENTE_TESTE




CREATE TABLE CLIENTE_TESTE
(
	ID_CLIENTE INT IDENTITY NOT NULL,
	NOME VARCHAR(20) NOT NULL,
	IDADE INT NOT NULL,
	CIDADE VARCHAR(20) NOT NULL,
	SEXO CHAR (1) NOT NULL,
	EMAIL VARCHAR (30) NOT NULL,
	NUMERO VARCHAR (6) NOT NULL,

	CONSTRAINT CK_IDADE CHECK (IDADE >= 18),
	CONSTRAINT CK_SEXO CHECK (SEXO IN('M','F')),
	CONSTRAINT PK_ID PRIMARY KEY (ID_CLIENTE),
	CONSTRAINT UQ_EMAIL UNIQUE (EMAIL),
	CONSTRAINT FK_CLIENTE_TESTE_TABELA_DE_NOTAS_FISCAIS FOREIGN KEY  (NUMERO) REFERENCES [TABELA DE NOTAS FISCAIS] (NUMERO)
)

INSERT INTO CLIENTE_TESTE (NOME,IDADE,CIDADE,SEXO,EMAIL,NUMERO)
VALUES ('Jos� Ladislau',43,'Campinas','M','ladislau@teste.com.br','01111')

select * from [TABELA DE NOTAS FISCAIS]
where NUMERO = '01111'


--ALTERANDO A TABELA PARA ADICIONAR CONSTRAINT


DROP TABLE CLIENTE_TESTE

CREATE TABLE CLIENTE_TESTE
(
	ID_CLIENTE INT IDENTITY NOT NULL,
	NOME VARCHAR(20) NOT NULL,
	IDADE INT NOT NULL,
	CIDADE VARCHAR(20) NOT NULL,
	SEXO CHAR (1) NOT NULL,
	EMAIL VARCHAR (30) NOT NULL,
	NUMERO VARCHAR (6) NOT NULL,

	
	CONSTRAINT CK_IDADE CHECK (IDADE >= 18),
	CONSTRAINT CK_SEXO CHECK (SEXO IN('M','F')),
	--CONSTRAINT PK_ID PRIMARY KEY (ID_CLIENTE),
	CONSTRAINT UQ_EMAIL UNIQUE (EMAIL),
	--CONSTRAINT FK_CLIENTE_TESTE_TABELA_DE_NOTAS_FISCAIS FOREIGN KEY  (NUMERO) REFERENCES [TABELA DE NOTAS FISCAIS] (NUMERO)
	
)


ALTER TABLE [CLIENTE_TESTE]
	ADD CONSTRAINT PK_ID PRIMARY KEY (ID_CLIENTE)

ALTER TABLE [CLIENTE_TESTE]
	ADD CONSTRAINT FK_CLIENTE_TESTE_TABELA_DE_NOTAS_FISCAIS FOREIGN KEY  (NUMERO) REFERENCES [TABELA DE NOTAS FISCAIS] (NUMERO)


ALTER TABLE CLIENTE_TESTE
	DROP CONSTRAINT PK_ID

ALTER TABLE CLIENTE_TESTE
	DROP CONSTRAINT FK_CLIENTE_TESTE_TABELA_DE_NOTAS_FISCAIS


