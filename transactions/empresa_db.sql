create database empresa;

use empresa;

create table clientes(
    id int not null,
    nome varchar(255) not null,
    valor_unitario decimal (11, 2) not null,
    primary key (id)
);

create table produtos(
    id int not null,
    nome varchar(255) not null,
    preco decimal (11, 2) not null,
    saldo_estoque int not null default 0, 
    primary key (id)
);

create table movimentacoes_estoque(
    id int not null,
    tipo enum('E', 'S', 'B') not null default 'B',
    quantidade int not null,
    id_produto int not null,
    primary key (id),
    foreign key (id_produto) references produtos (id)
);

create table vendas(
    id int not null,
    data datetime not null,
    valor_total decimal (11, 2) not null,
    id_cliente int not null,
    primary key (id),
    foreign key (id_cliente) references clientes (id)
);

create table itens_venda(
    id int not null,
    id_venda int not null,
    id_produto int not null,
    quantidade int not null default 1,
    valor_unitario decimal (11, 2) not null,
    primary key (id),
    foreign key (id_venda) references vendas (id),
    foreign key (id_produto) references produtos (id)
);

insert into clientes (id, nome) values (1, "Fulano"), (2, "Ciclano");

insert into produtos (id, nome, preco, saldo_estoque) values (1, "Camiseta Adidas Branca G", 150, 2), (2, "Regata Nike Preta M", 120, 1);

insert into movimentacoes_estoque (id, quantidade, id_produto) values (1, 2, 1), (2, 1, 2);

insert into vendas (id, data, valor_total, id_cliente) values (1, "2023-09-06 20:35:00", 270, 1), (2, "2023-09-06 20:45:00", 300, 2);

insert into itens_venda (id, id_venda, id_produto, quantidade, valor_unitario) values (1, 1, 1, 1, 150), (2, 1, 2, 1, 120), (3, 2, 1, 2, 150);
