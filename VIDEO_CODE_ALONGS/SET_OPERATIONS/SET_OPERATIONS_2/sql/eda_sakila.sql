DESC;

FROM
    actor;

FROM
    film;

FROM
    film_actor;

FROM
    adress;

FROM
    category;

FROM
    city;

FROM
    country;

FROM
    customer;

SELECT
    count(*) AS number_movies,
    count(DISTINCT title) AS unique_number_of_titles
FROM
    film;

SELECT
    DISTINCT rating
FROM
    main.film;

DESC TABLE film_actor;

FROM
    customer;

SELECT
    'customer' AS TYPE,
    c.first_name,
    c.last_name,
FROM
    customer c
WHERE
    c.first_name LIKE 'D%';

-- will match all first_name that starts with 'D'