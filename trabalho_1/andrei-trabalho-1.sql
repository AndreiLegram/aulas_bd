/* Trabalho 1 - Views e Transações no MySQL */
USE campeonatobrasileiro;

/* A. Criar uma view chamada "jogadores_gremio", que irá listar o nome e a
	  posição dos jogadores do Grêmio (pode-se filtrar pelo ID do time); */
CREATE OR REPLACE VIEW jogadores_gremio AS
SELECT nome, posicao
FROM jogadores WHERE id_time = 1;

/* B. Criar uma consulta de seleção que irá listar todos os registros da view
	  "jogadores_gremio"; */
SELECT * FROM jogadores_gremio;

/* C. Criar uma view chamada "atacantes", que irá listar o nome do jogador e o
	  nome do time dos jogadores que atuam como atacante; */
CREATE OR REPLACE VIEW atacantes AS
SELECT j.nome AS nome_jogador, t.nome AS nome_time
FROM jogadores j
JOIN times t ON t.id = j.id_time
WHERE j.posicao = 'A';

/* D. Criar uma consulta de seleção que irá listar todos os registros da view
	  "atacantes"; */
SELECT * FROM atacantes;

/* E. Criar uma view chamada "artilharia", que irá listar o nome do jogador, o nome
	  do time do jogador e a quantidade de gols feitas pelo jogador, ordenadas do
	  jogador com mais gols para o jogador com menos gols; */
CREATE OR REPLACE VIEW artilharia AS
SELECT j.nome AS nome_jogador, t.nome AS nome_time, COUNT(g.id) AS qtd_gols
FROM jogadores j
JOIN times t ON t.id = j.id_time
JOIN gols g ON g.id_jogador = j.id
GROUP BY j.id
ORDER BY qtd_gols DESC;

/* F. Criar uma consulta de seleção que irá listar todos os registros da view
	  "artilharia"; */
SELECT * FROM artilharia;

/* G. Criar uma consulta de seleção que irá listar todos os registros da view
	  "artilharia", filtrando apenas pelos jogadores do Grêmio; */
SELECT * FROM artilharia WHERE nome_time = 'Grêmio';

/* H. Criar um bloco de transação que irá criar uma partida entre Flamengo e
	  Grêmio, como mandante e visitante respectivamente, com data e hora de sua
	  escolha, onde o Grêmio venceu o Flamengo por 1 a 0, com gol do Cristaldo; */
START TRANSACTION;

INSERT INTO partidas
(id, id_time_mandante, id_time_visitante,
datahora, placar_time_mandante, placar_time_visitante)
VALUES
(3, 3, 1, NOW(), 0, 1);

INSERT INTO gols
(id, id_partida, id_jogador, tempo, gol_contra)
VALUES
(7, 3, 9, 0, 0);

COMMIT;

/* I. Criar um bloco de transação que irá criar uma partida entre Internacional e
	  Flamengo, como mandante e visitante respectivamente, com data e hora de
	  sua escolha, onde o placar foi 0 a 0; */
START TRANSACTION;

INSERT INTO partidas
(id, id_time_mandante, id_time_visitante,
datahora, placar_time_mandante, placar_time_visitante)
VALUES
(4, 2, 3, NOW(), 0, 0);

COMMIT;

/* J. Criar um bloco de transação que irá criar uma partida entre Grêmio e
	  Flamengo, como mandante e visitante respectivamente, com data e hora de
	  sua escolha, onde o placar foi 1 a 0 para o Flamengo, com gol contra do
	  Marchesín. No final da transação, as operações do bloco deverão ser
	  desfeitas manualmente, em vez de serem efetivadas no banco. */
START TRANSACTION;

INSERT INTO partidas
(id, id_time_mandante, id_time_visitante,
datahora, placar_time_mandante, placar_time_visitante)
VALUES
(5, 1, 3, NOW(), 0, 1);

INSERT INTO gols
(id, id_partida, id_jogador, tempo, gol_contra)
VALUES
(8, 5, 1, 0, 1);

ROLLBACK;
