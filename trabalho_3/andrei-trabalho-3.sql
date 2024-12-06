/* Trabalho 3 - Triggers, Loops, Cursores e Events no MySQL */

USE campeonatobrasileiro;

SET GLOBAL event_scheduler = ON;

/* A. Criar um gatilho chamado novo_gol_partida, que será executado após a ação
de inserção na tabela de gols. O gatilho em questão irá somar um gol ao
placar do time que fez o gol. Atente para a possibilidade do gol ser contra,
onde o gol deverá ir para o outro time, e não para o time do jogador. */
DROP TRIGGER IF EXISTS novo_gol_partida;

DELIMITER $$

CREATE TRIGGER novo_gol_partida AFTER INSERT ON gols
FOR EACH ROW
BEGIN
    IF NEW.gol_contra = 1 THEN
        IF EXISTS (
            SELECT 1 
            FROM partidas 
            WHERE id = NEW.id_partida 
              AND id_time_mandante = (SELECT id_time FROM jogadores WHERE id = NEW.id_jogador)
        ) THEN
            UPDATE partidas
            SET placar_time_visitante = placar_time_visitante + 1
            WHERE id = NEW.id_partida;
        ELSE
            UPDATE partidas
            SET placar_time_mandante = placar_time_mandante + 1
            WHERE id = NEW.id_partida;
        END IF;
    ELSE
        IF EXISTS (
            SELECT 1 
            FROM partidas 
            WHERE id = NEW.id_partida 
              AND id_time_mandante = (SELECT id_time FROM jogadores WHERE id = NEW.id_jogador)
        ) THEN
            UPDATE partidas
            SET placar_time_mandante = placar_time_mandante + 1
            WHERE id = NEW.id_partida;
        ELSE
            UPDATE partidas
            SET placar_time_visitante = placar_time_visitante + 1
            WHERE id = NEW.id_partida;
        END IF;
    END IF;
END $$

DELIMITER ;

/* B. Crie uma consulta SQL que dispare o gatilho criado acima. */
INSERT INTO gols (id_partida, id_jogador, tempo, gol_contra)
VALUES (8, 61, 90, 1);

/* C. Criar uma trigger chamada gol_anulado_partida, que será executada após
uma ação de delete na tabela de gols. Ela irá subtrair um gol ao placar do
time que fez o gol. Atente para a possibilidade do gol ser contra, onde o gol
deverá ser subtraído do placar do outro time, e não para o time do jogador. */
DROP TRIGGER IF EXISTS gol_anulado_partida;

DELIMITER $$

CREATE TRIGGER gol_anulado_partida AFTER DELETE ON gols
FOR EACH ROW
BEGIN
    IF OLD.gol_contra = 1 THEN
        IF EXISTS (
            SELECT 1 
            FROM partidas 
            WHERE id = OLD.id_partida 
              AND id_time_mandante = (SELECT id_time FROM jogadores WHERE id = OLD.id_jogador)
        ) THEN
            UPDATE partidas
            SET placar_time_visitante = placar_time_visitante - 1
            WHERE id = OLD.id_partida;
        ELSE
            UPDATE partidas
            SET placar_time_mandante = placar_time_mandante - 1
            WHERE id = OLD.id_partida;
        END IF;
    ELSE
        IF EXISTS (
            SELECT 1 
            FROM partidas 
            WHERE id = OLD.id_partida 
              AND id_time_mandante = (SELECT id_time FROM jogadores WHERE id = OLD.id_jogador)
        ) THEN
            UPDATE partidas
            SET placar_time_mandante = placar_time_mandante - 1
            WHERE id = OLD.id_partida;
        ELSE
            UPDATE partidas
            SET placar_time_visitante = placar_time_visitante - 1
            WHERE id = OLD.id_partida;
        END IF;
    END IF;
END $$

DELIMITER ;

/* D. Crie uma consulta SQL que dispare a trigger criado acima. */
DELETE FROM gols WHERE id = 12;

/* E. Criar uma tabela chamada transferencias, contendo os seguintes campos: id,
id_time_antigo, id_time_novo e id_jogador. Atente para a criação das chaves
estrangeiras. */
DROP TABLE IF EXISTS transferencias;

CREATE TABLE transferencias (
	id int(11) NOT NULL AUTO_INCREMENT,
	id_time_antigo int(11) NOT NULL,
	id_time_novo int(11) NOT NULL,
	id_jogador int(11) NOT NULL,
	PRIMARY KEY (id),
 	FOREIGN KEY (id_time_antigo) REFERENCES times (id), 
 	FOREIGN KEY (id_time_novo) REFERENCES times (id)
);

/* F. Criar um gatilho chamado transferir_jogador, que será executado após a ação
de update na tabela de jogadores. O gatilho em questão irá verificar se o id
do time do jogador após a atualização é diferente do id do time do jogador
antes da atualização e, neste caso, inserir um registro na tabela
transferencias criada acima. */
DROP TRIGGER IF EXISTS transferir_jogador;

DELIMITER $$

CREATE TRIGGER transferir_jogador AFTER UPDATE ON jogadores
FOR EACH ROW
BEGIN
    IF OLD.id_time != NEW.id_time THEN
        INSERT INTO transferencias (id_time_antigo, id_time_novo, id_jogador)
        VALUES (OLD.id_time, NEW.id_time, NEW.id);
    END IF;
END $$

DELIMITER ;

/* G. Crie uma consulta SQL que dispare o gatilho criado acima. */
UPDATE jogadores SET id_time = 3 WHERE id = 10;

/* H. Criar uma trigger chamada validar_gol, que verifica se o tempo do gol estiver
entre 0 e 90. Caso não esteja, um erro de SQL deverá ser lançado. A trigger
deverá ser disparada antes da inserção de gols. */
DROP TRIGGER IF EXISTS validar_gol;

DELIMITER $$

CREATE TRIGGER validar_gol BEFORE INSERT ON gols
FOR EACH ROW
BEGIN
	IF NEW.tempo < 0 THEN
		SIGNAL SQLSTATE '22006' SET message_text = 'O tempo do gol deve ser maior que 0';
	END IF;
   	IF NEW.tempo > 90 THEN
		SIGNAL SQLSTATE '22006' SET message_text = 'O tempo do gol deve ser menor que 90';
	END IF;
END $$

DELIMITER ;

/* I. Crie uma consulta SQL que dispare a trigger acima. */
INSERT INTO gols (id_partida, id_jogador, tempo, gol_contra)
VALUES (8, 61, 91, 1);

/* J. Criar uma coluna SQL na tabela jogadores chamada quantidade_gols, que
deverá ser do tipo inteiro. */
ALTER TABLE jogadores ADD COLUMN quantidade_gols int(11);

/* K. Criar um evento SQL que irá executar a cada minuto, calcular a quantidade
de gols feitas por cada jogador, e atualizar o valor da coluna quantidade_gols. */
DROP EVENT IF EXISTS atualizar_quantidade_gols;

DELIMITER $$

CREATE EVENT atualizar_quantidade_gols
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    UPDATE jogadores
    SET quantidade_gols = (
        SELECT COUNT(*)
        FROM gols
        WHERE gols.id_jogador = jogadores.id AND gols.gol_contra = 0
    );
END $$

DELIMITER ;

/* L. Criar um event SQL chamado limpar_transferencias, que será executado no
dia 06/12/2024, às 22h. O evento deverá excluir todos os registros da tabela
de transferências. */
DROP EVENT IF EXISTS limpar_transferencias;

DELIMITER $$

CREATE EVENT limpar_transferencias
ON SCHEDULE AT '2024-12-06 22:00:00'
DO
BEGIN
    DELETE FROM transferencias;
END $$

DELIMITER ;
