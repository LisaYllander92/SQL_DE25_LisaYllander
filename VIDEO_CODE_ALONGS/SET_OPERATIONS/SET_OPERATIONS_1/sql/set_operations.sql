-- with set operations duplicates disapare by default
SELECT
    *
FROM
    synthetic.sales_jan;

-- UNION combins a and b but removes duplicates
SELECT
    *
FROM
    synthetic.sales_jan
UNION
-- get both from result set a and b (jan and feb)
SELECT
    *
FROM
    synthetic.sales_feb;

-- note: monitor not same date!
-- here monitor only appares once, since we only asked for product_name
SELECT
    product_name,
FROM
    synthetic.sales_jan
UNION
SELECT
    product_name,
FROM
    synthetic.sales_feb;

-- UNION ALL includes duplicates
SELECT
    product_name,
FROM
    synthetic.sales_jan
UNION
ALL
SELECT
    product_name,
FROM
    synthetic.sales_feb;

-- INTERSECT only returns duplicates
SELECT
    product_name,
FROM
    synthetic.sales_jan
INTERSECT
SELECT
    product_name,
FROM
    synthetic.sales_feb;

-- nothing gets returned (no duplicates)
SELECT
    *
FROM
    synthetic.sales_jan
INTERSECT
SELECT
    *
FROM
    synthetic.sales_feb;

SELECT
    product_name,
    amount
FROM
    synthetic.sales_jan
INTERSECT
SELECT
    product_name,
    amount
FROM
    synthetic.sales_feb;

-- EXCEPT removes all duplicats in rerult b from result a
SELECT
    product_name,
    amount
FROM
    synthetic.sales_jan
EXCEPT
SELECT
    product_name,
    amount
FROM
    synthetic.sales_feb;