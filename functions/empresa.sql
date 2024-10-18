create database empresa;

use empresa;

create table clientes(
    id int not null AUTO_INCREMENT,
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
    status enum('ABERTO', 'ENTREGUE', 'CANCELADO') not null default 'ABERTO',
    data date not null,
    valor_total decimal (11, 2) not null,
    id_cliente int not null,
    primary key (id),
    foreign key (id_cliente) references clientes (id)
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

insert into clientes (nome) values ("Fulano"), ("Ciclano");

insert into produtos (nome, preco, saldo_estoque) values ("Camiseta Adidas Branca G", 150, 2), ("Regata Nike Preta M", 120, 1);

insert into vendas (status, data, valor_total, id_cliente) values ("ABERTO", "2023-10-04", 270, 1), ("ENTREGUE", "2023-10-04", 300, 2), ("CANCELADO", "2023-10-04", 750, 2);

insert into itens_venda (id_venda, id_produto, quantidade, valor_unitario) values (1, 1, 1, 150), (1, 2, 1, 120), (2, 1, 2, 150), (3, 1, 5, 150);
