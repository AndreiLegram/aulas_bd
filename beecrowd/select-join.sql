/* 1 - Basic Select */
SELECT name FROM customers WHERE state = 'RS';

/* 2 - Customer Address */
SELECT name, street FROM customers WHERE city = 'Porto Alegre';

/* 3 - Under 10 or Greater Than 100 */
SELECT id, name FROM products WHERE price < 10 OR price > 100;

/* 4 - Executive Representatives */
SELECT p.name, pr.name FROM products p LEFT JOIN providers pr ON p.id_providers = pr.id
LEFT JOIN categories ct ON p.id_categories = ct.id
WHERE ct.id = 6;

/* 5 - Categories */
select id, name
from products where id_categories = 9 or id_categories = 7;

/* 6 - Providers' City in Alphabetical Order */
SELECT DISTINCT city FROM providers ORDER BY city ASC;

/* 7 - Action Movies */
SELECT m.id, m.name FROM movies m 
LEFT JOIN genres g ON m.id_genres = g.id
WHERE g.description = 'Action';

/* 8 - Cheap Movies */
SELECT m.id, m.name FROM movies m 
LEFT JOIN prices p ON m.id_prices = p.id
WHERE value < 2;

/* 9 - September Rentals */
select c.name, r.rentals_date from customers c join rentals r on c.id = r.id_customers where extract(month from r.rentals_date) = 9;

/* 10 - Expanding the Business */
SELECT DISTINCT city FROM customers;

/* 11 - No Rental */
SELECT c.id, c.name FROM customers c 
LEFT JOIN locations l ON l.id_customers = c.id
WHERE l.id_customers IS NULL
ORDER BY c.id;

/* 12 - Provider Ajax SA */
select p1.name, p2.name from products p1 join providers p2 on p2.id = p1.id_providers and p2.name like 'Ajax SA';

/* 13 - Imported Products */
SELECT p.name, pr.name, c.name FROM products p
LEFT JOIN providers pr ON p.id_providers = pr.id
LEFT JOIN categories c ON p.id_categories = c.id
WHERE pr.name = 'Sansul SA' AND c.name = 'Imported';

/* 14 - Super Luxury */
SELECT p.name, pr.name, p.price FROM products p
LEFT JOIN providers pr ON p.id_providers = pr.id
LEFT JOIN categories c ON p.id_categories = c.id
WHERE p.price > 1000 AND c.name = 'Super Luxury';

/* 15 - Amounts Between 10 and 20 */
SELECT prod.name
FROM providers AS prov
JOIN products AS prod ON prov.id = prod.id_providers
WHERE prod.amount BETWEEN 10 AND 20 AND prov.name LIKE 'P%';

/* 16 - Legal Person */
SELECT c.name FROM customers c
JOIN legal_person lp ON lp.id_customers = c.id;
