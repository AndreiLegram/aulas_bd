use escola3;

drop trigger valida_nota;

delimiter $$
create trigger valida_nota before insert on notas  
for each row 
begin 
	if new.nota < 0 then 
		signal sqlstate '22006' set message_text = 'Nota deve ser maior que 0';
	end if;
	if new.nota > 10 then 
		signal sqlstate '22006' set message_text = 'Nota deve ser menor que 10';
	end if;
end $$
delimiter ;

select * from notas;

insert into notas (id_avaliacao, id_matricula, nota) values (1, 1, 78);
