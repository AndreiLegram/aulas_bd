use escola;

insert into disciplinas
(id, nome, sala, id_curso, id_professor)
VALUES
(4, "Principios da IHC", "Lab 5", 2, 1);

create view professores_disciplinas_view as
select p.nome as nome_professor from professores p;

create or replace view professores_disciplinas_view as
select p.nome as nome_professor, d.nome as nome_disciplina
from professores p
join disciplinas d on d.id_professor = p.id;

select * from professores_disciplinas_view;

select * from professores_disciplinas_view
order by nome_disciplina;

drop view professores_disciplinas_view;

SELECT * FROM cursos c;
SELECT * FROM disciplinas d;
SELECT * FROM matriculas m;
SELECT * FROM alunos a;
