/*Cria��o de banco de dados por meio de especifica��o de par�metros de local de armazenamento e tamanho do banco de dados.*/

CREATE DATABASE TESTE2
ON 
(NAME = TESTE2_DAT,
 FILENAME = 'C:\temp\data\teste2.mdf', /*.mdf � a extens�o do arquivo do SQLServer*/
 SIZE= 10,
 MAXSIZE = 50,
 FILEGROWTH = 5)
LOG ON
 (NAME = TESTE2_LOG,
  FILENAME = 'C:\temp\data\teste2_log.ldf', /*.ldf � a extens�o do arquivo de log*/
  SIZE= 10,
  MAXSIZE = 50,
  FILEGROWTH = 5)