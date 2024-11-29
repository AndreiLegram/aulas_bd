create database empresa6;

use empresa6;

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
    data_ultima_atualizacao_estoque datetime not null, 
    primary key (id)
);

create table movimentacoes_estoque(
    id int not null AUTO_INCREMENT,
    tipo enum('E', 'S', 'B') not null default 'B',
    quantidade int not null,
    id_produto int not null,
    primary key (id),
    foreign key (id_produto) references produtos (id)
);

create table vendas(
    id int not null AUTO_INCREMENT,
    status enum('ABERTO', 'ENTREGUE', 'CANCELADO') not null default 'ABERTO',
    data datetime not null,
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

insert into clientes (nome) values ("Fulano"), ("Ciclano"), ("Beltrano");

insert into produtos (nome, preco, saldo_estoque, data_ultima_atualizacao_estoque) values ("Camiseta Adidas Branca G", 150, 2, "2023-11-04 12:00:00"), ("Regata Nike Preta M", 120, 1, "2023-11-04 12:00:00");

insert into movimentacoes_estoque (quantidade, id_produto) values (2, 1, "2023-11-04 12:00:00"), (1, 2, "2023-11-04 12:00:00");

insert into vendas (status, data, valor_total, id_cliente) values ("ABERTO", "2023-10-04", 270, 1), ("ENTREGUE", "2023-11-04", 300, 2), ("CANCELADO", "2023-11-04", 750, 2);

insert into itens_venda (id_venda, id_produto, quantidade, valor_unitario) values (1, 1, 1, 150), (1, 2, 1, 120), (2, 1, 2, 150), (3, 1, 5, 150);
