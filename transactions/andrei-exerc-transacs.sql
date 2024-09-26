/* Exercício - Transações no SQL */
USE empresa;

/* A. Criar um bloco de transação que irá executar as seguintes operações: */
START TRANSACTION;

/* a. Inserir na tabela movimentacoes_estoque um balanço de 10 itens de
	  quantidade para o produto com o ID 2; */
INSERT INTO movimentacoes_estoque
(id, tipo, quantidade, id_produto)
VALUES
(3, 'B', 10, 2);

/* b. Atualizar o campo saldo_estoque na tabela produtos para o valor do
	  balanço para o produto com o ID 2; */
UPDATE produtos
SET saldo_estoque = 10
WHERE id = 2;

COMMIT;

/* B. Criar um bloco de transação que irá executar as seguintes operações: */
START TRANSACTION;

/* a. Inserir uma movimentação de estoque de saída de 5 itens para o
	  produto com ID 1;*/
INSERT INTO movimentacoes_estoque
(id, tipo, quantidade, id_produto)
VALUES
(4, 'S', 5, 1);

/* b. Atualizar o saldo de estoque deste produto, subtraindo do saldo atual
	  os itens que deram saída; */
UPDATE produtos
SET saldo_estoque = (saldo_estoque - 5)
WHERE id = 1;

COMMIT;

/* C. Criar um bloco de transação que irá inserir uma venda para o cliente com o
	  ID 1 na data atual, onde foram compradas duas unidades do produto com o
	  ID 2 e uma unidade do produto com o ID 1. Lembre-se de preencher o valor
	  total da venda, de inserir as saídas destes produtos do estoque e de atualizar
	  o saldo em estoque destes produtos após a movimentação no estoque. */
START TRANSACTION;

INSERT INTO vendas
(id, data, valor_total, id_cliente)
VALUES
(3, NOW(), 390, 1);

INSERT INTO itens_venda
(id, id_venda, id_produto, quantidade, valor_unitario)
VALUES
(4, 3, 2, 2, 120),
(5, 3, 1, 1, 150);

INSERT INTO movimentacoes_estoque
(id, tipo, quantidade, id_produto)
VALUES
(5, 'S', 2, 2),
(6, 'S', 1, 1);

UPDATE produtos
SET saldo_estoque = (saldo_estoque - 2)
WHERE id = 2;

UPDATE produtos
SET saldo_estoque = (saldo_estoque - 1)
WHERE id = 1;

COMMIT;
