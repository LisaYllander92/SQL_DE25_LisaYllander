-- result set a
SELECT
    'customer' AS TYPE,
    c.first_name,
    c.last_name,
FROM
    customer c
WHERE
    c.first_name LIKE 'A%'
UNION -- select all custumers and actors starting first name with 'A'
-- resultset b
SELECT
    'Actor',
    a.first_name,
    a.last_name
FROM
    actor a
WHERE
    a.first_name LIKE 'A%'
ORDER BY
    first_name;

-- find overlapping names between actors and customers
SELECT
    a.first_name,
    a.last_name
FROM
    actor a
INTERSECT
SELECT
    c.first_name,
    c.last_name
FROM
    customer c;
    -- returns result where the first and last name are same in a and b

-- to check if its true
SELECT
    a.first_name,
    a.last_name
FROM
    actor a
WHERE
    a.first_name LIKE 'JENN%';

SELECT
    c.first_name,
    c.last_name
FROM
    customer c
WHERE
    c.first_name LIKE 'JENN%';

-- find all with initials JD and record it's type (actor, customer)
SELECT
    'actor' AS "type",
    a.first_name,
    a.last_name
FROM
    actor a
WHERE
    a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%'
UNION
ALL
SELECT
    'customer' AS "type",
    c.first_name,
    c.last_name
FROM
    customer c
WHERE
    c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%';