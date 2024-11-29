show processlist;

set global event_scheduler = on;

/**/

create database testeeventos;

use testeeventos;

create table dados (
	valor int not null default 0
);

insert into dados (valor) values (0);

/**/

create event soma_valor_uma_vez
on schedule at '2024-11-28 21:25:00'
do
update testeeventos.dados set valor = valor + 1;

create event soma_valor_cada_minuto
on schedule every 1 minute
do
update testeeventos.dados set valor = valor + 1;

drop event soma_valor_cada_minuto;

select * from dados;

select * from information_schema.events;
