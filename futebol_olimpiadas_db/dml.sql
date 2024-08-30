USE futebol_olimpiadas_db;

INSERT INTO selecoes
(nome, confederacao)
VALUES
('BRA', 'CONMEBOL'),
('ARG', 'CONMEBOL'),
('NOR', 'UEFA'),
('FRA', 'UEFA'),
('SWE', 'UEFA'),
('CAN', 'CONCACAF');

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
(1, 2, 1, 1, 2, STR_TO_DATE('24/07/2024 17:00','%d/%m/%Y %H:%i')),
(3, 4, 2, 3, 1, STR_TO_DATE('27/07/2024 21:00','%d/%m/%Y %H:%i')),
(4, 5, 3, 1, 1, STR_TO_DATE('30/07/2024 19:00','%d/%m/%Y %H:%i'));
