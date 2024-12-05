/* Exercício - Loops e Cursores */

USE empresa5;

/* A. Criar uma procedure denominada calcular_comissoes_periodo, que irá
	  calcular e retornar o somatório do valor a ser pago em comissões dadas as
	  vendas de um determinado período passado por parâmetro (data inicial e
	  data final). A regra para calcular a comissão é a seguinte: se o tipo do
	  vendedor for A, ele recebe 20% do total de seus pedidos; se o tipo for B, ele
	  recebe 10%; e se o tipo for C, recebe 5%. O procedimento deverá receber
	  um parâmetro de saída que irá receber o total a ser pago. */
DROP PROCEDURE IF EXISTS calcular_comissoes_periodo;

DELIMITER $$

CREATE PROCEDURE calcular_comissoes_periodo(IN data_inicio datetime, IN data_fim datetime, OUT total float)
BEGIN
	DECLARE concluido bool DEFAULT FALSE;
	DECLARE tipo_vendedor enum('A', 'B', 'C');
	DECLARE valor_venda float;
	DECLARE cur CURSOR FOR
		SELECT ve.tipo, v.valor_total FROM vendas v
		LEFT JOIN vendedores ve ON ve.id = v.id_vendedor
		WHERE v.data BETWEEN data_inicio AND data_fim;
	DECLARE CONTINUE handler FOR NOT FOUND SET concluido = TRUE;

	SET total = 0;
	OPEN cur;
	loop_vendas_comissao: LOOP
		FETCH cur INTO tipo_vendedor, valor_venda;
		IF concluido THEN
			LEAVE loop_vendas_comissao;
		END IF;
		IF tipo_vendedor = 'A' THEN
			SET total = total + (valor_venda * 0.2);
			ITERATE loop_vendas_comissao;
		END IF;
		IF tipo_vendedor = 'B' THEN
			SET total = total + (valor_venda * 0.1);
			ITERATE loop_vendas_comissao;
		END IF;
		IF tipo_vendedor = 'C' THEN
			SET total = total + (valor_venda * 0.05);
			ITERATE loop_vendas_comissao;
		END IF;
	END LOOP;
	CLOSE cur;
END $$

DELIMITER ;

/* B. Executar a procedure criada acima. */
CALL calcular_comissoes_periodo('2023-11-22', '2023-11-22', @total);
SELECT @total;

/* C. Criar uma nova coluna na tabela clientes chamada
	  valor_cupom_black_friday, que será do tipo float. */
ALTER TABLE clientes ADD COLUMN valor_cupom_black_friday float;

/* D. Criar um procedimento chamado calcular_cupom_black_friday, que irá
	  calcular o valor total do cupom de desconto disponibilizado aos clientes na
	  Black Friday, e salvar este valor na nova coluna da tabela de clientes criada
	  acima. A regra para calcular o valor do cupom é a seguinte: se o cliente tiver
	  uma venda, o valor do cupom será de 10% do valor de sua venda; se o
	  cliente tiver mais que uma venda, o valor do cupom será de 20% do
	  somatório dos totais de suas vendas. */
DROP PROCEDURE IF EXISTS calcular_cupom_black_friday;

DELIMITER $$

CREATE PROCEDURE calcular_cupom_black_friday()
BEGIN
	DECLARE concluido bool DEFAULT FALSE;
	DECLARE id_cliente int;
	DECLARE num_vendas int;
	DECLARE total_vendas float;
	DECLARE cur CURSOR FOR
		SELECT c.id, count(v.id) AS num_vendas, ifnull(sum(v.valor_total), 0) AS total
		FROM clientes c LEFT JOIN vendas v ON v.id_cliente = c.id GROUP BY c.id;
	DECLARE CONTINUE handler FOR NOT FOUND SET concluido = TRUE;

	OPEN cur;
	loop_clientes: LOOP
		FETCH cur INTO id_cliente, num_vendas, total_vendas;
		IF concluido THEN
			LEAVE loop_clientes;
		END IF;
		IF num_vendas = 1 THEN
			UPDATE clientes SET valor_cupom_black_friday = (total_vendas * 0.1)
			WHERE id = id_cliente;
			ITERATE loop_clientes;
		END IF;
		IF num_vendas > 1 THEN
			UPDATE clientes SET valor_cupom_black_friday = (total_vendas * 0.2)
			WHERE id = id_cliente;
			ITERATE loop_clientes;
		END IF;
		UPDATE clientes SET valor_cupom_black_friday = 0
		WHERE id = id_cliente;
	END LOOP;
	CLOSE cur;
END $$

DELIMITER ;

/* E. Executar a procedure criada acima. */
CALL calcular_cupom_black_friday();
