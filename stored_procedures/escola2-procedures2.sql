USE escola2;

delimiter $$
create procedure media_notas_disciplina(in disciplina int, out media float)
begin
	select avg(nota_final) into media from matriculas where id_disciplina = disciplina;
end $$
delimiter ;

call media_notas_disciplina(1, @media_notas_disciplina_1);

select @media_notas_disciplina_1;

set @valor = 2;

select @valor;

delimiter $$
create procedure dobrar_valor(inout valor int)
begin
	select valor * 2 into valor;
end $$
delimiter ;

call dobrar_valor(@valor);

select @valor;