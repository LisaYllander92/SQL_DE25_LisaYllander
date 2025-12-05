FROM
    food;

SELECT
    DISTINCT id
FROM
    food;

-- to count items
SELECT
    COUNT(DISTINCT id)
FROM
    food;

-- 201 distinct items
-- number of rows
SELECT
    COUNT(*) AS number_rows
FROM
    food;

DESC food;

SELECT
    *
FROM
    food
WHERE
    week_id BETWEEN '2004-04'
    AND '2004-06';