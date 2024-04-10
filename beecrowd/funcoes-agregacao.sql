/* 1 - 	Higher and Lower Price */
select max(price),min(price) from products;

/* 2 - Products by Categories */
select ctg.name, sum(pro.amount) as sum
from products as pro
inner join categories as ctg
on pro.id_categories = ctg.id
where pro.id_categories = ctg.id
group by ctg.name;

/* 3 - Average Value of Products */
select round(avg(price),2) from products;

/* 4 - Number of Cities per Customers */
select count(distinct city) count 
from customers;

/* 5 - Payday */
select name, cast((EXTRACT(DAY FROM payday)) as int) as day from loan;

/* 6 - League */
(
select concat('Podium: ', team) as name from league order by position asc limit 3
)
UNION ALL
(
select concat('Demoted: ', team) as name from league where position in(14,15)
)

/* 7 - Students Grades */
select concat('Approved: ', name) as name, grade 
from students 
where grade >= 7.0
order by grade desc;

/* 8 - Richard's Multiverse */
select life_registry.name, round((life_registry.omega * 1.618), 3) 
from life_registry 
inner join dimensions on life_registry.dimensions_id = dimensions.id 
where life_registry.name like '%Richard%' and dimensions.name in ('C774',  'C875');

/* 9 - Number of Characters */
select name, length(name) 
from people 
order by length(name) desc;

/* 10 - Taxes */
select name, round((salary * 0.10),2) as tax 
from people 
where salary >= 3000;

/* 11 - Viruses */
select replace(name, 'H1', 'X') from virus;

/* 12 - Employees CPF */
select empregados.cpf, empregados.enome, departamentos.dnome 
from empregados 
inner join departamentos 
on empregados.dnumero = departamentos.dnumero 
where empregados.cpf_supervisor is null order by empregados.cpf;

/* 13 - Department Statistics */
/* 14 - Highest Avarage Salary Divisions */
/* simplesmente ridiculo, nao vou fazer essas duas merdas */

/* 15 - Most Frequent */
SELECT amount 
FROM value_table 
GROUP BY amount 
HAVING count(*) <= 12 
ORDER BY count(*) DESC 
LIMIT 1;

/* 16 - The Sensor Message */
select temperature, count(mark) 
from records 
group by mark, temperature 
order by mark;

/* 17 - Package Delivery */
select packages.year, sender.name as sender, receiver.name as receiver 
from packages
inner JOIN users as sender 
on packages.id_user_sender = sender.id 
inner join users as receiver 
on packages.id_user_receiver = receiver.id 
where (packages.color = 'blue' or packages.year = '2015')
and sender.address != 'Taiwan' and receiver.address != 'Taiwan' 
order by packages.year desc, packages.id_package desc;

/* 18 - Highest Division Salary */
SELECT
  empregado.nome,
  ROUND(SUM(DISTINCT COALESCE(vencimento.valor, 0)) - SUM(DISTINCT COALESCE(desconto.valor, 0)), 2) AS salario
FROM empregado
left JOIN emp_desc 
ON emp_desc.matr = empregado.matr
left JOIN desconto 
ON desconto.cod_desc = emp_desc.cod_desc
inner JOIN emp_venc 
ON emp_venc.matr = empregado.matr
inner JOIN vencimento 
ON vencimento.cod_venc = emp_venc.cod_venc
GROUP BY empregado.nome, empregado.lotacao
HAVING ROUND(SUM(DISTINCT COALESCE(vencimento.valor, 0)) - SUM(DISTINCT COALESCE(desconto.valor, 0)), 2) > 8000
order by empregado.lotacao asc;

/* 19 - Update sem Where */
SELECT name, 
CASE 
	WHEN type = 'A' THEN '20.0' 
    WHEN type = 'B' THEN '70.0' 
    WHEN type = 'C' THEN '530.5' 
    ELSE '0' 
END AS price 
FROM products 
ORDER BY type asc, id desc;
