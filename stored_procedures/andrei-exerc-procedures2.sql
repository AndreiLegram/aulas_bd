/* Exercício - Stored Procedures 2 */

USE escola2;

/* A. Criar uma procedure chamada reprovar_alunos_por_falta, que irá receber
dois parâmetros (id da matrícula e id da disciplina) que irá verificar se o aluno
possui alguma falta e caso ele tenha, marcar seu status como reprovado. */
DROP PROCEDURE IF EXISTS reprovar_alunos_por_falta;

DELIMITER $$

CREATE PROCEDURE reprovar_alunos_por_falta(IN matricula int, IN disciplina int)
BEGIN
	DECLARE tem_falta int;
	SELECT CAST(c.id AS BINARY) INTO tem_falta
		FROM chamadas c
		JOIN aulas a ON a.id = c.id_aula
		WHERE c.id_matricula = matricula AND a.id_disciplina = disciplina AND c.faltas > 0;

	IF tem_falta THEN
		UPDATE matriculas SET status = 'REPROVADO'
		WHERE id = matricula AND id_disciplina = disciplina;
	END IF;
END $$

DELIMITER ;

/* B. Executar o procedimento criado acima para a matrícula 1 na disciplina 1, bem
como para a matrícula 2 na disciplina 1. */
CALL reprovar_alunos_por_falta(1, 1);
CALL reprovar_alunos_por_falta(2, 1);

/* C. Criar um procedimento chamado quantidade_nota_faltante_disciplina, que irá
receber um parâmetro de entrada contendo o id da disciplina e um parâmetro
de saída que irá receber o processamento do seguinte cálculo: quantos
pontos faltam em avaliações para atingir os 10 pontos da disciplina. */
DROP PROCEDURE IF EXISTS quantidade_nota_faltante_disciplina;

DELIMITER $$

CREATE PROCEDURE quantidade_nota_faltante_disciplina(IN disciplina int, OUT nota_faltante float)
BEGIN
	SELECT 10 - IFNULL(SUM(a.peso), 0) INTO nota_faltante
		FROM avaliacoes a
		WHERE a.id_disciplina = disciplina;
END $$

DELIMITER ;

/* D. Executar a procedure quantidade_nota_faltante_disciplina para a disciplina 1
(pode-se criar uma variável para receber o parâmetro de saída). */
CALL quantidade_nota_faltante_disciplina(1, @nota_faltante);
SELECT @nota_faltante;

/* E. Criar um procedimento chamado quantidade_reprovados que irá calcular a
quantidade de reprovações em todas as disciplinas, e armazená-los um
parâmetro de saída. */
DROP PROCEDURE IF EXISTS quantidade_reprovados;

DELIMITER $$

CREATE PROCEDURE quantidade_reprovados(OUT reprovacoes int)
BEGIN
	SELECT COUNT(m.id) INTO reprovacoes
	FROM matriculas m
	WHERE m.status = 'REPROVADO';
END $$

DELIMITER ;

/* F. Executar a procedure criada acima. */
CALL quantidade_reprovados(@reprovados);
SELECT @reprovados;

/* G. Criar um procedimento chamado maior_nota_aluno, que irá receber um
parâmetro de entrada contendo o id do aluno e um parâmetro de saída que
irá receber o processamento do seguinte cálculo: qual a maior nota final
deste aluno. */
DROP PROCEDURE IF EXISTS maior_nota_aluno;

DELIMITER $$

CREATE PROCEDURE maior_nota_aluno(IN aluno int, OUT maior_nota float)
BEGIN
	SELECT ROUND(MAX(m.nota_final),1) INTO maior_nota
	FROM matriculas m WHERE m.id_aluno = aluno;
END $$

DELIMITER ;

/* H. Executar a procedure maior_nota_aluno para o aluno 1 (pode-se criar uma
variável para receber o parâmetro de saída). */
CALL maior_nota_aluno(1, @maior_nota_1);
SELECT @maior_nota_1;

/* I. Executar a procedure maior_nota_aluno para o aluno 2 (pode-se criar uma
variável para receber o parâmetro de saída). */
CALL maior_nota_aluno(2, @maior_nota_2);
SELECT @maior_nota_2;
