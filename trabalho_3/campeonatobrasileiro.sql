CREATE DATABASE campeonatobrasileiro;

USE campeonatobrasileiro;

CREATE TABLE times (
  id int(11) NOT NULL AUTO_INCREMENT,
  nome varchar(255) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO times (id, nome) VALUES (1, 'Grêmio'), (2, 'Internacional'), (3, 'Flamengo'), (4, 'Fluminense'), (5, 'São Paulo'), (6, 'Palmeiras'), (7, 'Bragantino'), (8, 'Athletico');

CREATE TABLE jogadores (
  id int(11) NOT NULL AUTO_INCREMENT,
  nome varchar(255) NOT NULL,
  posicao enum('G','Z','L','M','A') NOT NULL,
  id_time int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_time) REFERENCES times (id)
);

INSERT INTO jogadores (id, nome, posicao, id_time) VALUES (1, 'Marchesín', 'G', 1), (2, 'João Pedro', 'L', 1), (3, 'Jemerson', 'Z', 1), (4, 'Rodrigo Ely', 'Z', 1), (5, 'Reinaldo', 'L', 1), (6, 'Villasanti', 'M', 1), (7, 'Dodi', 'M', 1), (8, 'Monsalve', 'M', 1), (9, 'Cristaldo', 'M', 1), (10, 'Pavón', 'A', 1), (11, 'Soteldo', 'A', 1), (12, 'Braithwaite', 'A', 1), (13, 'Rochet', 'G', 2), (14, 'Nathan', 'L', 2), (15, 'Mercado', 'Z', 2), (16, 'Vitão', 'Z', 2), (17, 'Renê', 'L', 2), (18, 'Fernando', 'M', 2), (19, 'Thiago Maia', 'M', 2), (20, 'Alan Patrick', 'M', 2), (21, 'Bruno Tabata', 'M', 2), (22, 'Wanderson', 'A', 2), (23, 'Borré', 'A', 2), (24, 'Valencia', 'A', 2), (25, 'Rossi', 'G', 3), (26, 'Varela', 'L', 3), (27, 'David Luiz', 'Z', 3), (28, 'Léo Pereira', 'Z', 3), (29, 'Ayrton Lucas', 'L', 3), (30, 'De La Cruz', 'M', 3), (31, 'Gérson', 'M', 3), (32, 'Alcaraz', 'M', 3), (33, 'Arrascaeta', 'M', 3), (34, 'Éverton Cebolinha', 'A', 3), (35, 'Gabigol', 'A', 3), (36, 'Pedro', 'A', 3), (37, 'Fábio', 'G', 4), (38, 'Samuel Xavier', 'L', 4), (39, 'Thiago Silva', 'Z', 4), (40, 'Felipe Melo', 'Z', 4), (41, 'Marcelo', 'L', 4), (42, 'Renato Augusto', 'M', 4), (43, 'Martinelli', 'M', 4), (44, 'Ganso', 'M', 4), (45, 'Arias', 'M', 4), (46, 'Keno', 'A', 4), (47, 'Cano', 'A', 4), (48, 'John Kennedy', 'A', 4), (49, 'Rafael', 'G', 5), (50, 'Rafinha', 'L', 5), (51, 'Arboleda', 'Z', 5), (52, 'Alan Franco', 'Z', 5), (53, 'Patryck', 'L', 5), (54, 'Pablo Maia', 'M', 5), (55, 'Rodrigo Nestor', 'M', 5), (56, 'Alisson', 'M', 5), (57, 'Galoppo', 'M', 5), (58, 'Lucas Moura', 'A', 5), (59, 'Calleri', 'A', 5), (60, 'Luciano', 'A', 5), (61, 'Weverton', 'G', 6), (62, 'Marcos Rocha', 'L', 6), (63, 'Murilo', 'Z', 6), (64, 'Gómez', 'Z', 6), (65, 'Piquierez', 'L', 6), (66, 'Aníbal Moreno', 'M', 6), (67, 'Richard Ríos', 'M', 6), (68, 'Rafael Veiga', 'M', 6), (69, 'Dudu', 'A', 6), (70, 'Felipe Anderson', 'A', 6), (71, 'Rony', 'A', 6), (72, 'Estêvão', 'A', 6), (73, 'Cleiton', 'G', 7), (74, 'Hurtado', 'L', 7), (75, 'Pedro Henrique', 'Z', 7), (76, 'Realpe', 'Z', 7), (77, 'Luan Cândido', 'L', 7), (78, 'Juninho Capixaba', 'L', 7), (79, 'Matheus Fernandes', 'M', 7), (80, 'Lucas Evangelista', 'M', 7), (81, 'Lincoln', 'M', 7), (82, 'Jhon Jhon', 'A', 7), (83, 'Vitinho', 'A', 7), (84, 'Borbas', 'A', 7), (85, 'Léo Linck', 'G', 8), (86, 'Godoy', 'L', 8), (87, 'Thiago Heleno', 'Z', 8), (88, 'Kaíque Rocha', 'Z', 8), (89, 'Esquivel', 'L', 8), (90, 'Fernandinho', 'M', 8), (91, 'Christian', 'M', 8), (92, 'Zapelli', 'M', 8), (93, 'Cuello', 'A', 8), (94, 'Canobbio', 'A', 8), (95, 'Mastriani', 'A', 8), (96, 'Pablo', 'A', 8);

CREATE TABLE partidas (
  id int(11) NOT NULL AUTO_INCREMENT,
  id_time_mandante int(11) NOT NULL,
  id_time_visitante int(11) NOT NULL,
  datahora datetime NOT NULL,
  placar_time_mandante int(11) NOT NULL,
  placar_time_visitante int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_time_mandante) REFERENCES times (id), 
  FOREIGN KEY (id_time_visitante) REFERENCES times (id)
);

INSERT INTO partidas (id, id_time_mandante, id_time_visitante, datahora, placar_time_mandante, placar_time_visitante) VALUES (1, 1, 2, '2024-10-13 16:00:00', 2, 0), (2, 3, 4, '2024-10-13 16:00:00', 1, 1), (3, 5, 6, '2024-10-13 16:00:00', 0, 0), (4, 7, 8, '2024-10-13 16:00:00', 1, 0), (5, 1, 8, '2024-10-20 16:00:00', 2, 0), (6, 7, 2, '2024-10-20 16:00:00', 1, 0), (7, 3, 5, '2024-10-20 16:00:00', 0, 3), (8, 6, 4, '2024-10-20 16:00:00', 0, 0);

CREATE TABLE gols (
  id int(11) NOT NULL AUTO_INCREMENT,
  id_partida int(11) NOT NULL,
  id_jogador int(11) NOT NULL,
  tempo int(11) NOT NULL,
  gol_contra tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id), 
  FOREIGN KEY (id_partida) REFERENCES partidas (id),
  FOREIGN KEY (id_jogador) REFERENCES jogadores (id)
);

INSERT INTO gols (id, id_partida, id_jogador, tempo, gol_contra) VALUES (1, 1, 9, 30, 0), (2, 1, 12, 60, 0), (3, 2, 36, 36, 0), (4, 2, 47, 47, 0), (5, 4, 75, 10, 0), (6, 5, 10, 80, 0), (7, 5, 12, 85, 0), (8, 6, 16, 50, 1), (9, 7, 56, 30, 0), (10, 7, 59, 60, 0), (11, 7, 59, 90, 0);
