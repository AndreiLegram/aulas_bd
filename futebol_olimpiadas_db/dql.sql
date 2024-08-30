USE futebol_olimpiadas_db;

/* A. Listar o nome de todas as seleções; */
SELECT nome FROM selecoes;

/* B. Listar todas as informações da tabela de estádios, ordenados por capacidade
    de forma decrescente; */
SELECT * FROM estadios ORDER BY capacidade DESC;

/* C. Listar o placar do time mandante e o placar do time visitante de todas as
    partidas a partir de 30/07/2024; */
SELECT placar_time_mandante, placar_time_visitante FROM partidas WHERE data_hora > '2024-07-30';

/* D. Listar o nome de todas as seleções que começam com a letra “E”; */
SELECT nome FROM selecoes WHERE nome LIKE "E%";

/* E. Listar o nome da confederação e a quantidade de times por confederação; */
SELECT confederacao, COUNT(id) FROM selecoes GROUP BY confederacao;

/* F. Listar a data e a hora de todas as partidas do time com ID 1 (seja como
    mandante ou como visitante); */
SELECT data_hora FROM partidas WHERE id_time_mandante = 1 OR id_time_visitante = 1;

/* G. Listar todas as informações de todas as partidas que o time com ID 1 jogou
    no estádio com ID 1; */
SELECT * FROM partidas WHERE (id_time_mandante = 1 OR id_time_visitante = 1) AND id_estadio = 1;

/* H. Listar a soma de gols feitos por partida nos jogos realizados no estádio com o
    ID 1 (somar o placar do time mandante com o do time visitante). */
SELECT (placar_time_mandante + placar_time_visitante) AS soma FROM partidas WHERE id_estadio = 1;
