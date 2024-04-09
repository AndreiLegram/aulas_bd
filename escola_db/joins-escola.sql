/* 1 - Mostrar a matrícula e nome de todos os alunos que cursaram a disciplina de banco de dados em 2022 */
SELECT a.matricula, a.nome FROM alunos a
JOIN alunos_turmas atu ON atu.matricula = a.matricula
JOIN turmas t ON t.idTurma = atu.idTurma AND t.ano = '2022'
JOIN disciplinas_turmas dtu ON dtu.idTurma = atu.idTurma 
JOIN disciplinas d ON d.idDisciplina = dtu.idDisciplina AND d.descricao = 'Banco de Dados';

/* 2 - Mostrar a matrícula e o nome de todos os alunos que cursaram o 3 ano info nos anos de 2021, 2020 e 2019. */
SELECT a.matricula, a.nome FROM alunos a
JOIN alunos_turmas atu ON atu.matricula = a.matricula
JOIN turmas t ON t.idTurma = atu.idTurma 
AND t.turma = '3º ano Info' AND t.ano IN ('2021', '2020', '2019');

/* 3 - Mostrar todos os alunos que não estão matriculados em nenhuma turma. */
SELECT * FROM alunos a
LEFT JOIN alunos_turmas atu ON atu.matricula = a.matricula
WHERE atu.idTurma IS NULL;

/* 4 - Mostrar todas as disciplinas não cursadas pelo aluno 'XXX' */
SELECT * FROM disciplinas d WHERE idDisciplina NOT IN 
(SELECT d.idDisciplina FROM disciplinas d 
LEFT JOIN disciplinas_turmas dt ON dt.idDisciplina = d.idDisciplina
LEFT JOIN alunos_turmas atu ON atu.idTurma = dt.idTurma
LEFT JOIN alunos a ON a.matricula = atu.matricula 
WHERE a.nome = 'XXX');
