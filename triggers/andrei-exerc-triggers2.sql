/* Lista de Exercícios - Triggers */

USE escola3;

/* A. Criar um gatilho chamado adicionar_entrada_estoque_produto, que será
      executado após a ação de inclusão na tabela movimentacoes_estoque. O
      gatilho em questão irá somar a quantidade lançada na movimentação ao
      estoque do respectivo produto. Preste atenção no filtro pelo tipo de
      movimentação. */

/* B. Criar e executar um comando SQL que dispare o gatilho criado acima. */

/* C. Criar um gatilho chamado adicionar_saida_estoque_produto, que também
      será executado após a ação de inclusão na tabela movimentacoes_estoque.
      O gatilho em questão irá subtrair a quantidade lançada na movimentação ao
      estoque do respectivo produto. */

/* D. Criar e executar um comando SQL que dispare o gatilho criado acima. */

/* E. Criar uma trigger chamada salvar_historico_alteracao_preco, executada após
      a atualização dos dados na tabela de produtos, onde será armazenada na
      tabela alteracao_precos um histórico da alteração no preço do produto. */

/* F. Criar e executar um comando SQL que execute a trigger criada acima. */

/* G. Criar uma tabela chamada lixeira_clientes, contendo os seguintes dados: id e
      nome. */

/* H. Criar uma trigger chamada salvar_cliente_lixeira, a qual irá inserir os dados
      do cliente excluído na tabela criada no exercício anterior. */

/* I. Criar e executar um comando SQL que execute a trigger criada acima. */

/* J. Criar um gatilho chamado valida_preco_produto_insercao, que será
      executado antes da inserção de registro na tabela de produtos, e irá validar o
      preço do produto inserido: se o preço for negativo, ele receberá 0 como valor. */

/* K. Criar e executar um comando SQL que execute o gatilho acima. */

/* L. Criar um gatilho chamado valida_preco_produto_edicao, com funcionamento
      similar ao da trigger criada anteriormente, porém sendo executada no update
      de produtos. */

/* M. Criar e executar um comando SQL que execute o gatilho acima. */
