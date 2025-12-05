-- LEFT JOIN
-- which actor has played which film_id?
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    fa.film_id
FROM
    actor a
    LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id;

-- LEFT JOIN
-- which actor has played which film?
-- join 3 tables
SELECT
    a.first_name,
    a.last_name,
    f.title
FROM
    actor a
    LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
    LEFT JOIN film f ON f.film_id = fa.film_id;

-- get all films with associated category
SELECT
    f.title,
    c.name AS category
FROM
    film_category fc
    INNER JOIN category c ON fc.category_id = c.category_id
    INNER JOIN film f ON f.film_id = fc.film_id;

-- see how many rows film table has
SELECT
    count(*)
FROM
    film;

-- see how many rows categorys has
SELECT
    count(*)
FROM
    category;

-- combied (16000)
SELECT
    count(*)
FROM
    film f
    INNER JOIN category c ON category_id;

SELECT
    f.title,
    c.name AS category
FROM
    film f
    INNER JOIN category c ON category_id;

-- in which address, city and country does the staff live in
FROM
    staff;

-- addess_id, first_name, last_name
FROM
    adress;

-- address_id, address, city_id
FROM
    city;

-- city_id, city, country_id
FROM
    country;

-- country_id, country
SELECT
    * -- doesn't work in my system
FROM
    staff s
    LEFT JOIN address a ON s.address_id = a.address_id;

SELECT
    s.first_name,
    s.last_name,
    a.address,
    c.city,
    cty.country
FROM
    staff s
    LEFT JOIN address a ON s.address_id = a.address_id
    LEFT JOIN city c ON a.city_id = c.city_id
    LEFT JOIN country cty ON cty.country_id = c.country_id;