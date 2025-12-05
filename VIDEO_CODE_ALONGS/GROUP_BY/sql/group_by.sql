-- put all searches for the same food into one row
SELECT
    food,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    food
ORDER BY
    total_searches DESC
LIMIT
    10;

-- total searches by year
SELECT
    year,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    year
ORDER BY
    --    total_searches DESC;
    year;

-- filter by total search > 300k
SELECT
    year,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    year
HAVING
    total_searches > 300000
ORDER BY
    total_searches DESC;

-- group by 2 columns
SELECT
    year,
    food,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    food,
    year
HAVING
    food IN ('pizza', 'sushi')
ORDER BY
    food,
    year;

-- total_searches DESC;