CREATE DATABASE campeonatobrasileiro;

USE campeonatobrasileiro;

CREATE TABLE times (
  id int(11) NOT NULL,
  nome varchar(255) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO times (id, nome) VALUES (1, 'Grêmio'), (2, 'Internacional'), (3, 'Flamengo');

CREATE TABLE jogadores (
  id int(11) NOT NULL,
  nome varchar(255) NOT NULL,
  posicao enum('G','Z','L','M','A') NOT NULL,
  id_time int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_time) REFERENCES times (id)
);

INSERT INTO jogadores (id, nome, posicao, id_time) VALUES (1, 'Marchesín', 'G', 1), (2, 'João Pedro', 'L', 1), (3, 'Jemerson', 'Z', 1), (4, 'Rodrigo Ely', 'Z', 1), (5, 'Reinaldo', 'L', 1), (6, 'Villasanti', 'M', 1), (7, 'Dodi', 'M', 1), (8, 'Monsalve', 'M', 1), (9, 'Cristaldo', 'M', 1), (10, 'Pavón', 'A', 1), (11, 'Soteldo', 'A', 1), (12, 'Braithwaite', 'A', 1), (13, 'Rochet', 'G', 2), (14, 'Nathan', 'L', 2), (15, 'Mercado', 'Z', 2), (16, 'Vitão', 'Z', 2), (17, 'Renê', 'L', 2), (18, 'Fernando', 'M', 2), (19, 'Thiago Maia', 'M', 2), (20, 'Alan Patrick', 'M', 2), (21, 'Bruno Tabata', 'M', 2), (22, 'Wanderson', 'A', 2), (23, 'Borré', 'A', 2), (24, 'Valencia', 'A', 2), (25, 'Rossi', 'G', 3), (26, 'Varela', 'L', 3), (27, 'David Luiz', 'Z', 3), (28, 'Léo Pereira', 'Z', 3), (29, 'Ayrton Lucas', 'L', 3), (30, 'De La Cruz', 'M', 3), (31, 'Gérson', 'M', 3), (32, 'Alcaraz', 'M', 3), (33, 'Arrascaeta', 'M', 3), (34, 'Éverton Cebolinha', 'A', 3), (35, 'Gabigol', 'A', 3), (36, 'Pedro', 'A', 3);

CREATE TABLE partidas (
  id int(11) NOT NULL,
  id_time_mandante int(11) NOT NULL,
  id_time_visitante int(11) NOT NULL,
  datahora datetime NOT NULL,
  placar_time_mandante int(11) NOT NULL,
  placar_time_visitante int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_time_mandante) REFERENCES times (id), 
  FOREIGN KEY (id_time_visitante) REFERENCES times (id)
);

INSERT INTO partidas (id, id_time_mandante, id_time_visitante, datahora, placar_time_mandante, placar_time_visitante) VALUES (1, 1, 2, '2024-09-13 20:30:00', 3, 1), (2, 2, 1, '2024-09-20 20:30:00', 1, 1);

CREATE TABLE gols (
  id int(11) NOT NULL,
  id_partida int(11) NOT NULL,
  id_jogador int(11) NOT NULL,
  tempo int(11) NOT NULL,
  gol_contra tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id), 
  FOREIGN KEY (id_partida) REFERENCES partidas (id),
  FOREIGN KEY (id_jogador) REFERENCES jogadores (id)
);

INSERT INTO gols (id, id_partida, id_jogador, tempo, gol_contra) VALUES (1, 1, 20, 12, 0), (2, 1, 17, 24, 1), (3, 1, 12, 45, 0), (4, 1, 9, 88, 0), (5, 2, 22, 30, 0), (6, 2, 12, 90, 0);