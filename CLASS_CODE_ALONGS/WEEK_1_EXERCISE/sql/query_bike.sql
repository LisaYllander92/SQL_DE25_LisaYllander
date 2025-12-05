/*=============
 Query teh data
 ===============*/
-- overview of data
DESC;

DESC staging.joined_tables;

-- select all or some columns
SELECT
    *
FROM
    staging.joined_tables;

SELECT
    order_date,
    customer_first_name,
    customer_last_name,
    product_name
FROM
    staging.joined_tables;

-- filter rows eith WHERE clause
SELECT
    order_date,
    customer_first_name,
    customer_last_name,
    product_name
FROM
    staging.joined_tables
WHERE
    customer_first_name = 'Marvin';

-- create a new table for order status description
-- inside () what we want in the table
CREATE TABLE IF NOT EXISTS staging.status(
    order_status INTEGER,
    order_status_description VARCHAR
);

SELECT
    *
FROM
    staging.status;

INSERT INTO
    staging.status
VALUES
    (1, 'Pending'),
    (2, 'Processing'),
    (3, 'Rejected'),
    (4, 'Completed');

-- sort the rows by order_status
-- ORDER BY ... ASC/DESC
SELECT
    j.order_id,
    j.order_status,
    s.order_status_description
FROM
    staging.joined_tables j --alias 'j'
    -- join status description to this table
    JOIN staging.status s ON j.order_status = s.order_status -- ORDER BY j.order_status DESC; 
ORDER BY
    j.order_status ASC;

/* ============================
 Investigare unique customers
 ============================ */
-- DISTINCT
SELECT
    order_id
FROM
    staging.joined_tables
ORDER BY
    order_id DESC;

-- find unique valus of customer_id
SELECT
    DISTINCT customer_id
FROM
    staging.joined_tables
ORDER BY
    customer_id ASC;

-- -> 1445 rows returned (in local host)
-- find unique values of customers full names
SELECT
    DISTINCT customer_first_name,
    customer_last_name
FROM
    staging.joined_tables
ORDER BY
    customer_first_name,
    customer_last_name;

-- it is 'Justina Jenkins' that is the issue, she has two customer_id,
-- this can be found out by one window function
SELECT
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_city
FROM
    staging.joined_tables
WHERE
    customer_first_name = 'Justina'
    AND customer_last_name = 'Jenkins';