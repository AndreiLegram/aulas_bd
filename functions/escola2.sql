create database escola2;

use escola2;

create table professores(
    id int not null AUTO_INCREMENT,
    nome varchar(255) not null,
    primary key (id)
);

create table cursos(
    id int not null AUTO_INCREMENT,
    nome varchar(255) not null,
    nivel enum('M', 'G', 'PG') not null default 'M',
    primary key (id)
);

create table disciplinas(
    id int not null AUTO_INCREMENT,
    nome varchar(255) not null,
    sala varchar(100) default null,
    id_curso int not null,
    id_professor int not null,
    primary key (id),
    foreign key (id_curso) references cursos (id),
    foreign key (id_professor) references professores (id)
);

create table alunos(
    id int not null AUTO_INCREMENT,
    nome varchar(255) not null,
    primary key (id)
);

create table matriculas(
    id int not null AUTO_INCREMENT,
    id_disciplina int not null,
    id_aluno int not null,
    primary key (id),
    foreign key (id_disciplina) references disciplinas (id),
    foreign key (id_aluno) references alunos (id)
);

create table aulas(
    id int not null AUTO_INCREMENT,
    id_disciplina int not null,
    data datetime not null,
    descricao text not null,
    primary key (id),
    foreign key (id_disciplina) references disciplinas (id)
);

create table chamadas(
    id int not null AUTO_INCREMENT,
    id_aula int not null,
    id_matricula int not null,
    faltas int not null default 0,
    primary key (id),
    foreign key (id_aula) references aulas (id),
    foreign key (id_matricula) references matriculas (id)
);

create table avaliacoes(
    id int not null AUTO_INCREMENT,
    id_disciplina int not null,
    data datetime not null,
    descricao text not null,
    peso int not null,
    primary key (id),
    foreign key (id_disciplina) references disciplinas (id)
);

create table notas(
    id int not null AUTO_INCREMENT,
    id_avaliacao int not null,
    id_matricula int not null,
    nota int not null,
    primary key (id),
    foreign key (id_avaliacao) references avaliacoes (id),
    foreign key (id_matricula) references matriculas (id)
);

insert into professores (nome) values ("Eduardo Schenato dos Santos"), ("Rafael Jaques"), ("Soeni Bellé");

insert into cursos (nome, nivel) values ("Informática para Internet", "M"), ("ADS", "G"), ("Viticultura", "PG");

insert into disciplinas (nome, sala, id_curso, id_professor) values ("Programação de Banco de Dados", "Lab 1", 2, 1), ("Algoritmos", "Lab 4", 1, 2), ("Vinhos III", "D-201", 3, 3);

insert into alunos (nome) values ("João"), ("Maria"), ("José"), ("Laura"), ("Pedro"), ("Natália");

insert into matriculas (id_disciplina, id_aluno) values (1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6);

insert into aulas (id_disciplina, data, descricao) values (1, "2023-09-13 20:35:00", "Trabalho 1"), (1, "2023-09-27 20:35:00", "Functions"), (1, "2023-10-18 20:35:00", "Trabalho 2");

insert into chamadas (id_aula, id_matricula, faltas) values (1, 1, 0), (1, 2, 0), (2, 1, 2), (2, 2, 0), (3, 1, 0), (3, 2, 0);

insert into avaliacoes (id_disciplina, data, descricao, peso) values (1, "2023-09-13 20:35:00", "Trabalho 1", 3), (1, "2023-10-18 20:35:00", "Trabalho 2", 4);

insert into notas (id_avaliacao, id_matricula, nota) values (1, 1, 10), (1, 2, 5), (2, 1, 8), (2, 2, 7);
