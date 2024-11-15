create database empresa5;

use empresa5;

create table clientes(
    id int not null AUTO_INCREMENT,
    nome varchar(255) not null,
    primary key (id)
);

create table vendedores(
    id int not null AUTO_INCREMENT,
    tipo enum('A', 'B', 'C') default 'C', 
    nome varchar(255) not null,
    primary key (id)
);

create table produtos(
    id int not null AUTO_INCREMENT,
    nome varchar(255) not null,
    preco decimal (11, 2) not null,
    saldo_estoque int not null default 0, 
    primary key (id)
);

create table vendas(
    id int not null AUTO_INCREMENT,
    data datetime not null,
    valor_total decimal (11, 2) not null,
    id_cliente int not null,
    id_vendedor int not null,
    primary key (id),
    foreign key (id_cliente) references clientes (id),
    foreign key (id_vendedor) references vendedores (id)
);

create table itens_venda(
    id int not null AUTO_INCREMENT,
    id_venda int not null,
    id_produto int not null,
    quantidade int not null default 1,
    valor_unitario decimal (11, 2) not null,
    primary key (id),
    foreign key (id_venda) references vendas (id),
    foreign key (id_produto) references produtos (id)
);

insert into clientes (nome) values ("Fulano"), ("Ciclano"), ("Beltrano");

insert into vendedores (tipo, nome) values ("A", "João"), ("B", "Maria"), ("C", "José");

insert into produtos (nome, preco, saldo_estoque) values ("Camiseta Adidas Branca G", 150, 2), ("Camiseta Adidas Branca M", 150, 2), ("Camiseta Adidas Branca P", 150, 2), ("Regata Nike Preta G", 120, 1), ("Regata Nike Preta M", 120, 1), ("Regata Nike Preta P", 120, 1);

insert into vendas (data, valor_total, id_cliente, id_vendedor) values ("2023-11-22", 270, 1, 1), ("2023-11-22", 300, 2, 2), ("2023-11-22", 120, 1, 3), ("2023-11-22", 540, 1, 1);

insert into itens_venda (id_venda, id_produto, quantidade, valor_unitario) values (1, 1, 1, 150), (1, 4, 1, 120), (2, 2, 2, 150), (3, 5, 1, 120), (4, 3, 2, 150), (4, 6, 2, 120);
