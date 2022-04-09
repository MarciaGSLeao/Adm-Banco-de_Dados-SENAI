-- 1� PASSO:
	-- Instalar o Provedor Microsoft.ACE.OLEDB.12.0
	-- Link => https://www.microsoft.com/en-us/download/details.aspx?id=13255


-- 2� PASSO:
	-- Executar as procedures abaixo para habilitar a Execu��o de Consultas Distribu�das.

exec sp_configure 'show advanced option', '1'
reconfigure

exec sp_configure 'Ad Hoc Distributed Queries', 1
reconfigure
go


-- 3� PASSO:
	-- Rodas a fun��o para teste.

SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
                         'Excel 16.0;DATABASE=C:\Users\M�rcia\Documents\teste_updatescomVBA.xlsx',
                         'SELECT * FROM [Planilha1]')

SELECT * FROM OPENROWSET(
   BULK 'C:\Users\M�rcia\Documents\teste_updatescomVBA.xlsx',
   SINGLE_CLOB) AS DATA;