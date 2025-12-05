/* EXERCISE 1. More extensive EDA on the sakila database */
INSTALL sqlite;

LOAD sqlite;

CALL sqlite_attach('data/sqlite-sakila.db');

-- a) Describe all tables.
DESC;

DESC actor;

DESC address;

DESC category;

DESC film;

DESC ALL;

FROM
    sqlite_master;

-- b) Select all data on all tables.
SELECT
    *
FROM
    actor;

FROM
    address;

FROM
    country;

FROM
    city;

FROM
    film;

FROM
    film_actor;

FROM
    staff;

-- c) Find out how many rows there are in each table.
SELECT
    count(*)
FROM
    rental;

SELECT
    count(*)
FROM
    actor;

SELECT
    count(*)
FROM
    film_actor;

FROM
    film;

-- The questions here might come from a business stakeholder which is not familiar with the table structure. 
-- Hence it's your job to find out which table(s) to look at.
-- d) Calculate descriptive statistics on film length.
SELECT
    count(*) AS num_of_film,
    AVG(length) AS average_length,
    -- Genomsnittlig längd
    MIN(length) AS shortest_film,
    -- Kortaste film
    MAX(length) AS longest_film,
    -- Längsta film
    SUM(length) AS total_runtime -- Total speltid
FROM
    film;

-- Tabellen som innehåller filmlängden
FROM
    rental;

-- e) What are the peak rental times?
SELECT
    STRFTIME('%H', rental_date) AS rental_hour,
    COUNT(*) AS total_rentals
FROM
    rental
GROUP BY
    rental_hour
ORDER BY
    total_rentals DESC;

--  f) What is the distribution of film ratings?
-- what ratings are they?
SELECT
    DISTINCT rating
FROM
    film;

-- number of films per rating
SELECT
    rating,
    count(film_id) AS number_of_films
FROM
    film
GROUP BY
    rating;

-- g) Who are the top 10 customers by number of rentals?
FROM
    rental;

-- start by calculation how many rentals 
-- each customer has done in rental table
SELECT
    customer_id,
    count(rental_id) AS rental_count
FROM
    rental
GROUP BY
    customer_id
ORDER BY
    rental_count DESC
LIMIT
    10 -- shows top 10 in decending order
FROM
    customer;

-- then get the customers name and do a JOIN 
SELECT
    c.first_name,
    c.last_name,
    count(r.rental_id) AS total_rentals
FROM
    customer AS c
    JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id,
    -- group by customer id to calculate rents per customer
    c.first_name,
    c.last_name
ORDER BY
    total_rentals DESC
LIMIT
    10;

-- h) Retrieve a list of all customers and what films they have rented.
/*
 1. We start with the table 'customer' (c) to get the customers name.
 2. We connect to 'rental' (r) to see which transactions the customer has made (by customer_id).
 3. We connet to 'inventory' (i) to see which copy was rented (by inventory_id).
 4. Last we connect to 'film' (f) to get the title of the film that 
 corresponds to the rented copy (by film_id).
 */
SELECT
    c.first_name, -- customer first name
    c.last_name, -- customer last name
    f.title -- film title
FROM
    customer AS c -- 1. Start: customer table 
    JOIN rental AS r ON c.customer_id = r.customer_id -- 2. Connect to rental (by customer_id) 
    JOIN inventory AS i ON r.inventory_id = i.inventory_id -- 3. Connect to storage (by inventory_id)
    JOIN film AS f ON i.film_id = f.film_id -- 4. Connect to film (by film_id)
ORDER BY
    c.last_name,
    c.first_name,
    f.title;