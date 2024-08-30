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
