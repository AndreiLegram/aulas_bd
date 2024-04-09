select name from customers where state = 'RS';

select name, street from customers where city = 'Porto Alegre';

SELECT id, name FROM products WHERE price < 10 OR price > 100;

select p.name, pr.name from products p left join providers pr on p.id_providers = pr.id
left join categories ct on p.id_categories = ct.id
where ct.id = 6;

select p.id, p.name from products p 
left join categories ct on p.id_categories = ct.id
where ct.name LIKE "super%";

SELECT DISTINCT city FROM providers ORDER BY city ASC;

select m.id, m.name from movies m 
left join genres g on m.id_genres = g.id
where g.description = 'Action';

select m.id, m.name from movies m 
left join prices p on m.id_prices = p.id
where value < 2;

select r.rentals_date, c.name from rentals r
left join customers c on r.id_customers = c.id
where r.rentals_date between '2016-09-01' and '2016-09-30';

select DISTINCT city from customers;

select c.id, c.name from customers c 
left join locations l on l.id_customers = c.id
WHERE l.id_customers IS NULL
ORDER BY c.id;

select p.name, pr.name from products p 
left join providers pr on p.id_providers = pr.id
where pr.name = 'Ajax SA';

select p.name, pr.name, c.name from products p
left join providers pr on p.id_providers = pr.id
left join categories c on p.id_categories = c.id
where pr.name = 'Sansul SA' AND c.name = 'Imported';

select p.name, pr.name, p.price from products p
left join providers pr on p.id_providers = pr.id
left join categories c on p.id_categories = c.id
where p.price > 1000 and c.name = 'Super Luxury';

select p.name from products p
left join providers pr on p.id_providers = pr.id
where pr.name LIKE 'p%' AND p.amount between 10 and 20;

SELECT c.name FROM customers c
JOIN legal_person lp ON lp.id_customers = c.id;
