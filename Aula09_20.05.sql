GROUP BY----HAVING----
SELECT * FROM [TABELA DE CLIENTES]

SELECT BAIRRO, ESTADO, SUM([LIMITE DE CREDITO]) AS 'SOMA DE LIMITES DE CREDITO' FROM [TABELA DE CLIENTES]
WHERE [ESTADO] = 'SP'
GROUP BY BAIRRO, ESTADO

SELECT BAIRRO, ESTADO, SUM([LIMITE DE CREDITO]) AS 'SOMA DE LIMITES DE CREDITO' FROM [TABELA DE CLIENTES]
WHERE [ESTADO] = 'SP' 
GROUP BY BAIRRO, ESTADO
HAVING SUM([LIMITE DE CREDITO])>=140000

--Quais s?o os clientes que fizeram mais de 2000 compras em 2016?
select * from [dbo].[TABELA DE NOTAS FISCAIS]

select cpf, count(*) as 'Volume de Compras' from [dbo].[TABELA DE NOTAS FISCAIS]
where year(data) = 2016
group by cpf
having count(*) > 2000


--CASE

