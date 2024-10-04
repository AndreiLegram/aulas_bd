USE escola2;

SELECT * FROM aulas;
SELECT * FROM chamadas;
SELECT * FROM matriculas;

DELIMITER $$

CREATE FUNCTION quantidade_faltas(id_matricula int, id_disciplina int)
RETURNS int DETERMINISTIC
BEGIN
	DECLARE faltas int;
	SELECT SUM(c.faltas) INTO faltas FROM chamadas c
	WHERE c.id_matricula = id_matricula AND c.id_aula IN (
		SELECT a.id FROM aulas a
		WHERE a.id_disciplina = id_disciplina
	);

	IF faltas IS NULL THEN
		RETURN 0;
	ELSE
		RETURN faltas;
	END IF;
END $$

DELIMITER ;

SELECT quantidade_faltas(1, 1);

SELECT a.nome AS aluno, d.nome AS disciplina,
quantidade_faltas(m.id, d.id) AS faltas
FROM matriculas m
JOIN alunos a ON a.id = m.id_aluno
JOIN disciplinas d ON d.id = m.id_disciplina;
