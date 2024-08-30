/* DDL */

CREATE DATABASE futebol_olimpiadas_db;
USE futebol_olimpiadas_db;

CREATE TABLE selecoes (
	id INTEGER NOT NULL AUTO_INCREMENT,
	nome VARCHAR(250) NOT NULL,
	confederacao VARCHAR(250) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE estadios (
	id INTEGER NOT NULL AUTO_INCREMENT,
	nome VARCHAR(250) NOT NULL,
	capacidade INTEGER NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE partidas (
	id INTEGER NOT NULL AUTO_INCREMENT,
	id_time_mandante INTEGER NOT NULL,
	id_time_visitante INTEGER NOT NULL,
	id_estadio INTEGER NOT NULL,
	placar_time_mandante INTEGER NOT NULL,
	placar_time_visitante INTEGER NOT NULL,
	data_hora DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY (id_time_mandante) REFERENCES selecoes(id),
	FOREIGN KEY (id_time_visitante) REFERENCES selecoes(id),
	FOREIGN KEY (id_estadio) REFERENCES estadios(id)
);

/* DML */

INSERT INTO selecoes
(nome, confederacao)
VALUES
('BRA', 'CONMEBOL'),
('ARG', 'CONMEBOL'),
('URU', 'CONMEBOL'),
('FRA', 'UEFA'),
('SWE', 'UEFA'),
('EGY', 'CAF');

INSERT INTO estadios
(nome, capacidade)
VALUES
('Stade de Bordeaux', 42115),
('Stade de Lyon', 59186),
('Stade de Marseille', 67394);

INSERT INTO partidas
(id_time_mandante, id_time_visitante, id_estadio, 
placar_time_mandante, placar_time_visitante, data_hora)
VALUES
(1, 2, 1, 1, 2, STR_TO_DATE('27/07/2024 17:00','%d/%m/%Y %H:%i')),
(3, 1, 2, 3, 1, STR_TO_DATE('30/07/2024 21:00','%d/%m/%Y %H:%i')),
(4, 5, 3, 0, 2, STR_TO_DATE('05/08/2024 19:00','%d/%m/%Y %H:%i'));

/* DQL */

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
