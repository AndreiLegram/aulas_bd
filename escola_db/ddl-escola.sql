CREATE DATABASE escola_db;
USE escola_db;

CREATE TABLE areas (
	idArea INTEGER NOT NULL,
	descricao VARCHAR(250) NOT NULL,
	PRIMARY KEY (idArea)
);

CREATE TABLE cidades (
	idCidade INTEGER NOT NULL,
	nome VARCHAR(250) NOT NULL,
	uf CHAR(2) NOT NULL,
	PRIMARY KEY (idCidade)
);

CREATE TABLE professores (
	siape INTEGER NOT NULL,
	nome VARCHAR(250) NOT NULL,
	cpf VARCHAR(15) NOT NULL,
	dataNasc DATE NOT NULL,
	email VARCHAR(250) NOT NULL,
	endereco VARCHAR(200) NOT NULL,
	numero VARCHAR(20) NOT NULL,
	complemento VARCHAR(50),
	telefone VARCHAR(20) NOT NULL,
	idCidade INTEGER NOT NULL,
	idArea INTEGER NOT NULL,
	PRIMARY KEY (siape),
	FOREIGN KEY (idCidade) REFERENCES cidades(idCidade),
	FOREIGN KEY (idArea) REFERENCES areas(idArea)
);

CREATE TABLE alunos (
	matricula INTEGER NOT NULL,
	nome VARCHAR(250) NOT NULL,
	cpf VARCHAR(15) NOT NULL,
	dataNasc DATE NOT NULL,
	email VARCHAR(250) NOT NULL,
	endereco VARCHAR(200) NOT NULL,
	numero VARCHAR(20) NOT NULL,
	complemento VARCHAR(50),
	telefone VARCHAR(20) NOT NULL,
	idCidade INTEGER NOT NULL,
	PRIMARY KEY (matricula),
	FOREIGN KEY (idCidade) REFERENCES cidades(idCidade)
);

CREATE TABLE disciplinas (
	idDisciplina INTEGER NOT NULL,
	descricao VARCHAR(250) NOT NULL,
	PRIMARY KEY (idDisciplina)
);

CREATE TABLE turmas (
	idTurma INTEGER NOT NULL,
	turma VARCHAR(100) NOT NULL,
	ano CHAR(4) NOT NULL,
	PRIMARY KEY (idTurma)
);

CREATE TABLE alunos_turmas (
	idTurma INTEGER NOT NULL,
	matricula INTEGER NOT NULL,
	PRIMARY KEY (idTurma, matricula),
	FOREIGN KEY (idTurma) REFERENCES turmas(idTurma),
	FOREIGN KEY (matricula) REFERENCES alunos(matricula)
);

CREATE TABLE disciplinas_turmas (
	idTurma INTEGER NOT NULL,
	idDisciplina INTEGER NOT NULL,
	PRIMARY KEY (idTurma, idDisciplina),
	FOREIGN KEY (idTurma) REFERENCES turmas(idTurma),
	FOREIGN KEY (idDisciplina) REFERENCES disciplinas(idDisciplina)
);
