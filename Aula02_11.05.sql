/*Criação de banco de dados por meio de especificação de parâmetros de local de armazenamento e tamanho do banco de dados.*/

CREATE DATABASE TESTE2
ON 
(NAME = TESTE2_DAT,
 FILENAME = 'C:\temp\data\teste2.mdf', /*.mdf é a extensão do arquivo do SQLServer*/
 SIZE= 10,
 MAXSIZE = 50,
 FILEGROWTH = 5)
LOG ON
 (NAME = TESTE2_LOG,
  FILENAME = 'C:\temp\data\teste2_log.ldf', /*.ldf é a extensão do arquivo de log*/
  SIZE= 10,
  MAXSIZE = 50,
  FILEGROWTH = 5)