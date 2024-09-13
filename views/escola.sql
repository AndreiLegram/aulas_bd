create database escola;

use escola;

create table professores(
    id int not null,
    nome varchar(255) not null,
    primary key (id)
);

create table cursos(
    id int not null,
    nome varchar(255) not null,
    nivel enum('M', 'G', 'PG') not null default 'M',
    primary key (id)
);

create table disciplinas(
    id int not null,
    nome varchar(255) not null,
    sala varchar(100) default null,
    id_curso int not null,
    id_professor int not null,
    primary key (id),
    foreign key (id_curso) references cursos (id),
    foreign key (id_professor) references professores (id)
);

create table alunos(
    id int not null,
    nome varchar(255) not null,
    primary key (id)
);

create table matriculas(
    id int not null,
    id_disciplina int not null,
    id_aluno int not null,
    primary key (id),
    foreign key (id_disciplina) references disciplinas (id),
    foreign key (id_aluno) references alunos (id)
);

insert into professores (id, nome) values (1, "Eduardo Schenato dos Santos"), (2, "Rafael Jaques"), (3, "Soeni Bellé");

insert into cursos (id, nome, nivel) values (1, "Informática para Internet", "M"), (2, "ADS", "G"), (3, "Viticultura", "PG");

insert into disciplinas (id, nome, sala, id_curso, id_professor) values (1, "Programação de Banco de Dados", "Lab 1", 2, 1), (2, "Algoritmos", "Lab 4", 1, 2), (3, "Vinhos III", "D-201", 3, 3);

insert into alunos (id, nome) values (1, "João"), (2, "Maria"), (3, "José"), (4, "Laura"), (5, "Pedro"), (6, "Natália");

insert into matriculas (id, id_disciplina, id_aluno) values (1, 1, 1), (2, 1, 2), (3, 2, 3), (4, 2, 4), (5, 3, 5), (6, 3, 6);
