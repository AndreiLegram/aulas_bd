/* Exercício - Functions 2 */

USE empresa;

/* A. Criar uma função que irá receber o ID do cliente como parâmetro, calcular a
	  quantidade de pedidos de venda gerados pelo cliente nos últimos 30 dias e
	  retornar este valor; */
DROP FUNCTION IF EXISTS vendas_30_dias;

DELIMITER $$

CREATE FUNCTION vendas_30_dias(id_cliente int)
RETURNS int DETERMINISTIC
BEGIN
	DECLARE num_vendas int;
	SELECT COUNT(v.id) INTO num_vendas FROM vendas v
	WHERE v.id_cliente = id_cliente AND v.data >= DATE_SUB(NOW(), INTERVAL 30 DAY);

	IF num_vendas IS NULL THEN
		RETURN 0;
	ELSE
		RETURN num_vendas;
	END IF;
END $$

DELIMITER ;

/* B. Criar uma consulta de seleção que irá listar o nome do cliente e a quantidade
	  de vendas dele dos últimos 30 dias; */

SELECT c.nome, vendas_30_dias(c.id)
FROM clientes c;

/* C. Criar uma função que irá, dado o ID do cliente, calcular seu ticket médio e
	  retornar este valor; */
DROP FUNCTION IF EXISTS ticket_medio;

DELIMITER $$

CREATE FUNCTION ticket_medio(id_cliente int)
RETURNS float DETERMINISTIC
BEGIN
	DECLARE ticket_medio float;
	SELECT AVG(v.valor_total) INTO ticket_medio FROM vendas v
	WHERE v.id_cliente = id_cliente AND status = 'ENTREGUE';

	IF ticket_medio IS NULL THEN
		RETURN 0;
	ELSE
		RETURN ticket_medio;
	END IF;
END $$

DELIMITER ;

/* D. Criar uma consulta de seleção que irá listar o nome do cliente e seu ticket
	  médio; */
SELECT c.nome, ticket_medio(c.id)
FROM clientes c;

/* E. Criar uma função que irá receber como parâmetro o ID do cliente e o status
	  do pedido, calcular a soma do valor total das vendas do cliente para o status
	  fornecido, e retornar este valor; */
DROP FUNCTION IF EXISTS valor_por_status;

DELIMITER $$

CREATE FUNCTION valor_por_status(id_cliente int, status varchar(20))
RETURNS float DETERMINISTIC
BEGIN
	DECLARE valor_por_status float;
	SELECT SUM(v.valor_total) INTO valor_por_status FROM vendas v
	WHERE v.id_cliente = id_cliente AND v.status = status;

	IF valor_por_status IS NULL THEN
		RETURN 0;
	ELSE
		RETURN valor_por_status;
	END IF;
END $$

DELIMITER ;

/* F. Criar uma consulta de seleção que irá listar o nome do cliente e o valor total
	  de seus pedidos em cancelados; */
SELECT c.nome, valor_por_status(c.id, 'CANCELADO')
FROM clientes c;

/* G. Criar uma consulta de seleção que irá listar o nome do cliente, o valor total de
	  seus pedidos em aberto e o valor total de seus pedidos entregues; */
SELECT c.nome, valor_por_status(c.id, 'ABERTO'), valor_por_status(c.id, 'ENTREGUE')
FROM clientes c;

/* H. Criar uma função que irá receber como parâmetro o ID do produto, calcular a
	  quantidade de estoque reservada para ele (a soma das quantidades dos itens
	  dos pedidos deste cliente em aberto), e retornar este valor; */
DROP FUNCTION IF EXISTS estoque_reservado;

DELIMITER $$

CREATE FUNCTION estoque_reservado(id_produto int)
RETURNS float DETERMINISTIC
BEGIN
	DECLARE estoque_reservado float;
	SELECT SUM(iv.quantidade) INTO estoque_reservado FROM itens_venda iv
	JOIN vendas v ON v.id = iv.id_venda
	WHERE iv.id_produto = id_produto AND v.status = 'ABERTO';

	IF estoque_reservado IS NULL THEN
		RETURN 0;
	ELSE
		RETURN estoque_reservado;
	END IF;
END $$

DELIMITER ;

/* I. Criar uma consulta de seleção que irá listar o nome do produto, seu saldo em
	  estoque, e sua quantidade de estoque reservada; */
SELECT p.nome, p.saldo_estoque, estoque_reservado(p.id)
FROM produtos p;

/* J. Criar uma função que irá receber calcular e retornar o valor total dos pedidos
	  cancelados na base de dados, filtrando pelas datas passadas por parâmetro
	  (data de início e data de término); */
DROP FUNCTION IF EXISTS valor_cancelado;

DELIMITER $$

CREATE FUNCTION valor_cancelado(data_inicio date, data_fim date)
RETURNS float DETERMINISTIC
BEGIN
	DECLARE valor_cancelado float;
	SELECT SUM(v.valor_total) INTO valor_cancelado FROM vendas v
	WHERE v.status = 'CANCELADO' AND v.data BETWEEN data_inicio AND data_fim;

	IF valor_cancelado IS NULL THEN
		RETURN 0;
	ELSE
		RETURN valor_cancelado;
	END IF;
END $$

DELIMITER ;

/* K. Criar uma consulta de seleção que irá listar o valor total dos pedidos
	  cancelados entre 01/08/2023 e 01/11/2023. */
SELECT valor_cancelado("2023-08-01", "2023-11-01");
