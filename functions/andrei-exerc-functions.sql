/* Exercício - Functions */

USE escola2;

/* A. Criar uma função chamada aula_com_avaliacao, que irá receber dois
      parâmetros (id da disciplina e data da aula) que irá retornar um char “S” caso
      a aula em questão tenha uma avaliação e um char “N” caso não tenha. */
DELIMITER $$

CREATE FUNCTION aula_com_avaliacao(id_disciplina int, data_aula datetime)
RETURNS char DETERMINISTIC
BEGIN
	DECLARE tem_avaliacao int;
	SELECT CAST(a.id AS BINARY) INTO tem_avaliacao FROM avaliacoes a
	WHERE a.id_disciplina = id_disciplina AND a.data = data_aula;

	IF tem_avaliacao THEN
		RETURN "S";
	ELSE
		RETURN "N";
	END IF;
END $$

DELIMITER ;

/* B. Criar uma consulta de seleção que irá listar todas as informações de todas as
      aulas, bem como o nome da disciplina da aula em questão e se as aulas
      listadas possuem avaliação ou não (utilizando a função criada). */
SELECT a.*, d.nome, aula_com_avaliacao(a.id_disciplina, a.`data`)
FROM aulas a
JOIN disciplinas d ON d.id = a.id_disciplina;
