use empresa5;

delimiter $$
create procedure calcular_comissoes_com_continue(out total float)
begin
	declare concluido bool default false;
    declare tipo_vendedor enum('A', 'B', 'C');
    declare valor_venda float;
    declare cur cursor for 
		select ve.tipo, v.valor_total from vendas v 
        left join vendedores ve on ve.id = v.id_vendedor;
	declare continue handler for not found set concluido = true;
    
    set total = 0;
    open cur;
    loop_vendas_comissao: loop
		fetch cur into tipo_vendedor, valor_venda;
        if concluido then 
			leave loop_vendas_comissao;
		end if;
        if tipo_vendedor = 'A' then 
			set total = total + (valor_venda * 0.2);
            iterate loop_vendas_comissao;
		end if;
        if tipo_vendedor = 'B' then 
			set total = total + (valor_venda * 0.1);
            iterate loop_vendas_comissao;
		end if;
		set total = total + (valor_venda * 0.05);
    end loop;
    close cur;
end $$
delimiter ;

call calcular_comissoes_com_continue(@total_comissao_com_continue);
select @total_comissao_com_continue;
