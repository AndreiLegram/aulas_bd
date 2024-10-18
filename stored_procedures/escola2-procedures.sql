USE escola2;

delimiter $$
CREATE PROCEDURE calcula_media_final(IN matricula int, IN disciplina int)
BEGIN
	DECLARE media_final float;
	SELECT sum((av.peso / 10) * n.nota) INTO media_final
		FROM notas n JOIN avaliacoes av ON av.id = n.id_avaliacao
		WHERE av.id_disciplina = disciplina AND n.id_matricula = matricula;
	UPDATE matriculas set nota_final = media_final WHERE id = matricula;
END $$
delimiter ;

CALL calcula_media_final(1, 1);
CALL calcula_media_final(2, 1);