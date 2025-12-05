/* ========================
 1. Exploring hemnet data
 ======================== */
-- a) Create a database file called hemnet.duckdb 
-- and ingest the data from the csv file into your database.
CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS hemnet AS(
    SELECT
        *
    FROM
        read_csv_auto('data/hemnet_data_clean.csv')
);

-- b) Make a wildcard selection to checkout the data (use the asterisk symbol)
SELECT
    *
FROM
    hemnet;

-- c) Find out how many rows there are in the table
-- there are 500 rows 
-- d) Describe the table that you have ingested to see the columns and data types.
DESCRIBE hemnet;

-- e) Find out the 5 most expensive homes sold
SELECT
    *
FROM
    hemnet
ORDER BY
    final_price DESC -- soring by price, highest first
LIMIT
    5;

-- Displays only top 5
-- f) Find out the 5 cheapest homes sold.
SELECT
    *
FROM
    hemnet
ORDER BY
    final_price -- soring by price, ascending by defalut
LIMIT
    5;

-- Displays only 5
-- g) Find out statistics on minimum, mean, median and maximum prices of homes sold.
SELECT
    MIN(final_price) AS min_home_sold,
    ROUND(AVG(final_price)) AS mean_home_sold,
    -- use ROUND to round number
    MEDIAN(final_price) AS median_home_sold,
    MAX(final_price) AS max_home_sold
FROM
    hemnet;

-- Find out statistics on minimum, mean, median and maximum prices of price per area.
SELECT
    MIN(price_per_area) AS min_home_sold,
    ROUND(AVG(price_per_area)) AS mean_home_sold,
    -- use ROUND to round number
    MEDIAN(price_per_area) AS median_home_sold,
    MAX(price_per_area) AS max_home_sold
FROM
    hemnet;

--  i) How many unique communes are represented in the dataset.
SELECT
    DISTINCT commune
FROM
    hemnet
ORDER BY
    commune;

-- j) How many percentage of homes cost more than 10 million?
-- first I found out how many houses cost more than 10 million
SELECT
    COUNT(*)
FROM
    hemnet
WHERE
    final_price > 10000000 -- then I found out how many houses there are in total
SELECT
    COUNT(*)
FROM
    hemnet;

-- then I do the calculation 
SELECT
    COUNT(*) AS total_homes,
    -- total amount og homes
    -- calculates number of homes that matches the condision
    COUNT(*) FILTER(
        WHERE
            final_price > 10000000
    ) AS expensive_homes,
    ROUND(expensive_homes / total_homes * 100) AS percentage_expensive
FROM
    hemnet;