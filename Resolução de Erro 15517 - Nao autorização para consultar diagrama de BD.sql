-- RESOLUÇÃO DO ERRO 15517:
-- Texto da mensagem:
/* Não é possível executar como banco de dados de entidade, pois a entidade “principal” não existe,
esse tipo de entidade não pode ser representada ou você não tem permissão para isso.

[ESQUINA_VENDAS] - Nome do Banco de Dados
[MARCIA_REAL\Marcia] - Nome de Usuário
*/

ALTER AUTHORIZATION ON DATABASE:: [ESQUINA_VENDAS] TO [MARCIA_REAL\Marcia]
GO
