/* Exercício - Stored Procedures */

USE escola2;

/* A. Criar um procedimento chamado fechar_nota, que irá receber dois
      parâmetros (id da matrícula e id da disciplina) que irá calcular a média final
      da matrícula baseada nas notas das avaliações e colocar como média final
      da matrícula. Além disso, irá definir o aluno com o status de aprovado ou de
      reprovado caso a média for maior ou igual a 7 ou menor que 7
      respectivamente. */
DROP PROCEDURE IF EXISTS fechar_nota;

DELIMITER $$

CREATE PROCEDURE fechar_nota(IN id_matricula int, IN id_disciplina int)
BEGIN
	DECLARE media_final float;
	DECLARE novo_status varchar(20);
	SELECT sum((av.peso / 10) * n.nota) INTO media_final
		FROM notas n JOIN avaliacoes av ON av.id = n.id_avaliacao
		WHERE av.id_disciplina = id_disciplina AND n.id_matricula = id_matricula;

	IF media_final IS NULL THEN
		SET media_final = 0;
	END IF;

	IF media_final < 7 THEN
		SET novo_status = 'REPROVADO';
	ELSEIF media_final >= 7 THEN
		SET novo_status = 'APROVADO';
	END IF;

	UPDATE matriculas set nota_final = media_final, status = novo_status
	WHERE id = id_matricula AND id_disciplina = id_disciplina;
END $$

DELIMITER ;

/* B. Executar o procedimento criado acima para a matrícula 2 e para a disciplina
      1. */
CALL fechar_nota(2, 1);
