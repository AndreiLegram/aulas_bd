/* Exercicio Juncoes */
USE futebol_olimpiadas_db;

/* A. Listar o nome de todos os estádios; */
SELECT nome FROM estadios; 

/* B. Listar todas as informações da tabela de seleções, em ordem alfabética; */
SELECT * FROM selecoes ORDER BY nome; 

/* C. Listar o nome das seleções mandantes de todas as partidas; */
SELECT s.nome FROM selecoes s INNER JOIN partidas p ON p.id_time_mandante = s.id;

/* D. Listar as informações das partidas da seleção com ID 1 no seguinte formato:
	nome da seleção mandante, placar da seleção mandante, uma informação
	textual contendo um “X”, placar da seleção visitante e nome da seleção
	visitante. O resultado será similar ao exemplo a seguir:
	Brasil 1 X 0 Nigéria
	Brasil 1 X 2 Japão
	Brasil 0 X 2 Espanha */
SELECT CONCAT(s_mndt.nome, ' ', p.placar_time_mandante, ' X ', 
p.placar_time_visitante, ' ', s_vstt.nome) AS placar
FROM partidas p
JOIN selecoes s_mndt ON p.id_time_mandante = s_mndt.id
JOIN selecoes s_vstt ON p.id_time_visitante = s_vstt.id
WHERE s_mndt.id = 1 OR s_vstt.id = 1;

/* E. Listar o nome da seleção mandante, o nome da seleção visitante e o nome
	do estádio de todas as partidas que terminaram empatadas; */
SELECT s_mndt.nome, s_vstt.nome, e.nome
FROM partidas p
JOIN selecoes s_mndt ON p.id_time_mandante = s_mndt.id
JOIN selecoes s_vstt ON p.id_time_visitante = s_vstt.id
JOIN estadios e ON p.id_estadio = e.id
WHERE p.placar_time_mandante = p.placar_time_visitante;

/* F. Listar o nome do estádio e a quantidade de partidas por estádio; */
SELECT e.nome, COUNT(p.id) FROM estadios e
LEFT JOIN partidas p ON p.id_estadio = e.id
GROUP BY e.id;

/* G. Listar o nome das seleções mandantes que não marcaram gols em suas
	partidas (o placar da seleção mandante for igual a zero); */
SELECT s.nome FROM partidas p
JOIN selecoes s ON p.id_time_mandante = s.id AND p.placar_time_mandante = 0;

/* H. Listar o nome da seleção visitante e a média de gols marcada por ela
	enquanto visitante; */
SELECT s.nome, AVG(p.placar_time_visitante) FROM partidas p
JOIN selecoes s ON p.id_time_visitante = s.id
GROUP BY s.id;

/* I. Listar o nome da seleção vencedora das partidas (nome da seleção
	mandante em partidas que o placar da seleção mandante for maior que o da
	seleção visitante, e o nome da seleção visitante quando o placar da seleção
	visitante for maior que o da seleção mandante); */
SELECT
(CASE
    WHEN p.placar_time_mandante > p.placar_time_visitante THEN s_mndt.nome
    WHEN p.placar_time_visitante > p.placar_time_mandante THEN s_vstt.nome
    ELSE "ninguem (empate)"
END) vencedor
FROM partidas p
JOIN selecoes s_mndt ON p.id_time_mandante = s_mndt.id
JOIN selecoes s_vstt ON p.id_time_visitante = s_vstt.id;

/* J. Listar o nome do estádio e a capacidade do estádio das partidas que a
	seleção com ID 1 jogou (seja como mandante ou visitante). */
SELECT e.nome, e.capacidade FROM estadios e
JOIN partidas p ON p.id_estadio = e.id 
AND (p.id_time_mandante = 1 OR p.id_time_visitante = 1)
GROUP BY e.id;
