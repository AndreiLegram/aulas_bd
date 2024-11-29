use empresa5;

delimiter $$
create procedure contar1a10()
begin
    declare contagem int;
    set contagem = 0;
    loop1a10: loop
        set contagem = contagem + 1;
        select contagem;
        if contagem > 9 then
            LEAVE loop1a10;
        end if;
    end loop;
end $$
delimiter ;

call contar1a10();

delimiter $$
create procedure calcular_comissoes(out total float)
begin
    declare concluido bool default false;
    declare tipo_vendedor enum('A', 'B', 'C');
    declare valor_venda float;
    declare cur cursor for select vendedores.tipo, vendas.valor_total from vendas left join vendedores on vendedores.id = vendas.id_vendedor;
    declare continue handler for not found set concluido = true;
    set total = 0;
    open cur;
    loop_calcular_comissao: loop
        fetch cur into tipo_vendedor, valor_venda;
        if concluido then
            leave loop_calcular_comissao;
        end if;
        if tipo_vendedor = 'A' then
            set total = total + (valor_venda * 0.2);
        else 
            if tipo_vendedor = 'B' then
                set total = total + (valor_venda * 0.1);
            else 
                set total = total + (valor_venda * 0.05);
            end if;
        end if;
    end loop;
    close cur;
end $$
delimiter ;

call calcular_comissoes(@total_comissao);

select @total_comissao;
