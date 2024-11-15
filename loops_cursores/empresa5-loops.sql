use empresa5;

delimiter $$

create procedure contarDe1a10()
begin
	declare contagem int;
	set contagem = 0;

	loop1a10 : loop
		set contagem = contagem + 1;
		select contagem;
		if contagem >= 10 then
			leave loop1a10;
		end if;
	end loop;
end $$

delimiter ;

call contarDe1a10();
