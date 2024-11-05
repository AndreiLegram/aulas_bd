/* Trabalho 2 - Funções e Procedimentos no MySQL */

USE campeonatobrasileiro;

SELECT * FROM times t;
SELECT * FROM jogadores j;
SELECT * FROM partidas p;
SELECT * FROM gols g;

/* A. Criar uma função chamada “pontos”, que irá receber como parâmetro o ID do
	  time, calcular e retornar sua pontuação baseada na seguinte regra: jogos que
	  o time venceu valem 3 pontos, jogos que o time empatou vale 1 ponto e jogos
	  que o time perdeu valem 0 pontos; */
DROP FUNCTION IF EXISTS pontos;

DELIMITER $$

CREATE FUNCTION pontos(id_time int)
RETURNS int DETERMINISTIC
BEGIN
	DECLARE pontos_vitorias int;
	DECLARE pontos_empates int;

	SELECT COUNT(p.id) * 3 INTO pontos_vitorias FROM partidas p
	WHERE (p.id_time_mandante = id_time AND p.placar_time_mandante > p.placar_time_visitante)
	OR (p.id_time_visitante = id_time AND p.placar_time_visitante > p.placar_time_mandante);

	SELECT COUNT(p.id) INTO pontos_empates FROM partidas p
	WHERE (p.id_time_mandante = id_time OR p.id_time_visitante = id_time)
	AND p.placar_time_mandante = p.placar_time_visitante;

	IF pontos_vitorias IS NULL THEN
		SET pontos_vitorias = 0;
	END IF;

	IF pontos_empates IS NULL THEN
		SET pontos_empates = 0;
	END IF;

	RETURN pontos_vitorias + pontos_empates;
END $$

DELIMITER ;

/* B. Criar uma função chamada “quantidade_vitorias”, que irá receber como
	  parâmetro o ID do time e calcular a quantidade de vitórias que ele teve e
	  retornar este valor; */
DROP FUNCTION IF EXISTS quantidade_vitorias;

DELIMITER $$

CREATE FUNCTION quantidade_vitorias(id_time int)
RETURNS int DETERMINISTIC
BEGIN
	DECLARE vitorias int;

	SELECT COUNT(p.id) INTO vitorias FROM partidas p
	WHERE (p.id_time_mandante = id_time AND p.placar_time_mandante > p.placar_time_visitante)
	OR (p.id_time_visitante = id_time AND p.placar_time_visitante > p.placar_time_mandante);

	IF vitorias IS NULL THEN
		SET vitorias = 0;
	END IF;

	RETURN vitorias;
END $$

DELIMITER ;

/* C. Criar uma função chamada "saldo_gols", que irá, dado o time passado por
	  parâmetro, calcular seu saldo de gols (diferença entre os gols feitos e
	  sofridos) e retornar este valor; */
DROP FUNCTION IF EXISTS saldo_gols;

DELIMITER $$

CREATE FUNCTION saldo_gols(id_time int)
RETURNS int DETERMINISTIC
BEGIN
	DECLARE saldo_mandante int;
	DECLARE saldo_visitante int;

	SELECT SUM(p.placar_time_mandante - p.placar_time_visitante)
	INTO saldo_mandante FROM partidas p
	WHERE p.id_time_mandante = id_time;

	SELECT SUM(p.placar_time_visitante - p.placar_time_mandante)
	INTO saldo_visitante FROM partidas p
	WHERE p.id_time_visitante = id_time;

	IF saldo_mandante IS NULL THEN
		SET saldo_mandante = 0;
	END IF;

	IF saldo_visitante IS NULL THEN
		SET saldo_visitante = 0;
	END IF;

	RETURN saldo_mandante + saldo_visitante;
END $$

DELIMITER ;

/* D. Criar uma consulta de seleção que irá listar a tabela de classificação do
	  campeonato, mostrando o nome do time, a quantidade de pontos, a
	  quantidade de vitórias e o saldo de gols, ordenados pela colocação do time
	  no campeonato. A regra de classificação é a seguinte: maior quantidade de
	  pontos, maior quantidade de vitórias, maior saldo de gols e ID do time; */
SELECT t.nome, pontos(t.id) AS pontos, 
quantidade_vitorias(t.id) AS vitorias,
saldo_gols(t.id) AS saldo_gols
FROM times t
ORDER BY pontos desc, vitorias desc, saldo_gols desc, t.id desc;

/* E. Criar um procedimento chamado “inserir_gol”, que irá receber quatro
	  parâmetros de entrada (ID da partida, ID do jogador, minuto em que o gol
	  aconteceu e se o gol foi contra ou não), inserir o gol na tabela
	  correspondente e atualizar o placar do jogo que teve o gol feito; */
DROP PROCEDURE IF EXISTS inserir_gol;

DELIMITER $$

CREATE PROCEDURE inserir_gol(IN partida int, IN jogador int, IN minuto int, IN contra bool)
BEGIN
	DECLARE is_gol_mandante int;

	INSERT INTO gols (id_partida, id_jogador, tempo, gol_contra)
	VALUES (partida, jogador, minuto, contra);

	SELECT CAST(p.id AS BINARY) INTO is_gol_mandante
	FROM partidas p
	JOIN jogadores jm ON jm.id_time = p.id_time_mandante AND jm.id = jogador
	JOIN jogadores jv ON jv.id_time = p.id_time_visitante AND jv.id = jogador
	WHERE p.id = partida AND
	((jm.id = jogador AND NOT contra) OR (jv.id = jogador AND contra));
	
	IF is_gol_mandante THEN 
		UPDATE partidas SET placar_time_mandante = placar_time_mandante + 1
		WHERE id = partida;
	ELSE
		UPDATE partidas SET placar_time_visitante = placar_time_visitante + 1
		WHERE id = partida;
	END IF;
END $$

DELIMITER ;

/* F. Chamar o procedimento criado acima para os seguintes casos:
	  a. Na partida 5, o jogador 10 fez um gol a favor no minuto 88;
	  b. Na partida 5, o jogador 12 fez um gol a favor no minuto 89;
	  c. Na partida 5, o jogador 90 fez um gol a favor no minuto 90. */
CALL inserir_gol(5, 10, 88, false);
CALL inserir_gol(5, 12, 89, false);
CALL inserir_gol(5, 90, 90, false);

/* G. Criar uma procedure chamada “artilheiro” que irá obter o nome do artilheiro
	  do campeonato e retornar este valor; */

/* H. Executar a procedure acima, passando por parâmetro uma variável que irá
	  receber o nome do artilheiro. Após isso, criar uma consulta de seleção que irá
	  exibir o conteúdo da variável. */
