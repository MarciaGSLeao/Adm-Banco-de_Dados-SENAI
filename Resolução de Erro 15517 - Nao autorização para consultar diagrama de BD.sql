-- RESOLU��O DO ERRO 15517:
-- Texto da mensagem:
/* N�o � poss�vel executar como banco de dados de entidade, pois a entidade �principal� n�o existe,
esse tipo de entidade n�o pode ser representada ou voc� n�o tem permiss�o para isso.

[ESQUINA_VENDAS] - Nome do Banco de Dados
[MARCIA_REAL\Marcia] - Nome de Usu�rio
*/

ALTER AUTHORIZATION ON DATABASE:: [ESQUINA_VENDAS] TO [MARCIA_REAL\Marcia]
GO
