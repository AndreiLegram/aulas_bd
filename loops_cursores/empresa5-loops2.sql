use empresa5;

delimiter $$

CREATE PROCEDURE calcular_comissoes(OUT total float)
BEGIN
	DECLARE concluido bool DEFAULT FALSE;
	DECLARE tipo_vendedor enum('A', 'B', 'C');
	DECLARE valor_venda float;
	
	DECLARE cur CURSOR FOR
		SELECT ve.tipo, va.valor_total FROM vendas va
		LEFT JOIN vendedores ve ON ve.id = va.id_vendedor;
	
	DECLARE CONTINUE handler FOR NOT FOUND SET concluido = TRUE;
	
	SET total = 0;

	OPEN cur;

	loop_calcular_comissao: LOOP
		FETCH cur INTO tipo_vendedor, valor_venda;

		IF concluido THEN
			LEAVE loop_calcular_comissao;
		END IF;
	
		IF tipo_vendedor = 'A' THEN
			SET total = total + valor_venda * 0.2;
		ELSE
			IF tipo_vendedor = 'B' THEN
				SET total = total + valor_venda * 0.1;
			ELSE
				SET total = total + valor_venda * 0.05;
			END IF;
		END IF;
	END LOOP;

	CLOSE cur;

END $$

delimiter ;

call calcular_comissoes(@total_comissao);
SELECT @total_comissao;
