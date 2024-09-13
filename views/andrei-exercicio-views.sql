/* Exercício - Views */

USE escola;

/* A. Criar uma view chamada alunos_ads que irá listar o ID e nome dos alunos
      matriculados em qualquer disciplina do curso de ADS e o ID e nome da
      respectiva disciplina que ele está matriculado (caso o aluno esteja
      matriculado em mais de uma disciplina, ele deverá ser listado novamente); */
CREATE OR REPLACE VIEW alunos_ads AS
SELECT a.id AS id_aluno, a.nome AS nome_aluno,
d.id AS id_disciplina, d.nome AS nome_disciplina
FROM alunos a
INNER JOIN matriculas m ON m.id_aluno = a.id 
INNER JOIN disciplinas d ON d.id = m.id_disciplina
INNER JOIN cursos c ON c.id = d.id_curso AND c.nome = 'ADS';

/* B. Criar uma consulta que irá listar todos os registros da view alunos_ads; */
SELECT * FROM alunos_ads;

/* C. Criar uma consulta que irá listar todos os registros da view alunos_ads que
      representem alunos da disciplina “Programação de Banco de Dados”; */
SELECT * FROM alunos_ads WHERE nome_disciplina = 'Programação de Banco de Dados';

/* D. Criar uma view chamada disciplinas_detalhamento, a qual irá conter o nome
      e a sala da disciplina, o nome do curso dela e o nome do professor que
      ministra ela; */
CREATE OR REPLACE VIEW disciplinas_detalhamento AS
SELECT d.nome AS nome_disciplina, d.sala AS sala_disciplina,
c.nome AS nome_curso, p.nome AS nome_professor
FROM disciplinas d
INNER JOIN cursos c ON c.id = d.id_curso
INNER JOIN professores p ON p.id = d.id_professor;

/* E. Criar uma consulta que irá listar todos os registros da view
      disciplinas_detalhamento; */
SELECT * FROM disciplinas_detalhamento;

/* F. Criar uma view chamada quantidade_matriculas_por_disciplina que irá listar
      o nome da disciplina e a quantidade de alunos matriculados nela, ordenados
      da disciplina com mais alunos para a com menos alunos; */
CREATE OR REPLACE VIEW quantidade_matriculas_por_disciplina AS
SELECT d.nome AS nome_disciplina, COUNT(a.id) AS alunos_matriculados
FROM disciplinas d
LEFT JOIN matriculas m ON m.id_disciplina = d.id
LEFT JOIN alunos a ON a.id = m.id_aluno
GROUP BY d.id
ORDER BY alunos_matriculados DESC;

/* G. Criar uma consulta que irá listar todos os registros da view
      quantidade_matriculas_por_disciplina. */
SELECT * FROM quantidade_matriculas_por_disciplina;
