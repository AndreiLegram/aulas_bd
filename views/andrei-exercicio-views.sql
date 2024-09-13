CREATE OR REPLACE VIEW alunos_ads AS
SELECT a.id AS id_aluno, a.nome AS nome_aluno,
d.id AS id_disciplina, d.nome AS nome_disciplina
FROM alunos a
INNER JOIN matriculas m ON m.id_aluno = a.id 
INNER JOIN disciplinas d ON d.id = m.id_disciplina
INNER JOIN cursos c ON c.id = d.id_curso AND c.nome = 'ADS'

SELECT * FROM alunos_ads;

SELECT * FROM alunos_ads WHERE nome_disciplina = 'Programação de Banco de Dados';

CREATE OR REPLACE VIEW disciplinas_detalhamento AS
SELECT a.id AS id_aluno, a.nome AS nome_aluno,
d.id AS id_disciplina, d.nome AS nome_disciplina
FROM disciplinas d
INNER JOIN cursos c ON c.id = d.id_curso
INNER JOIN professores p ON p.id = d.id_professor
