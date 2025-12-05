/* ===========
 Introduce
 aggregation
 =========== */
-- aggregate over rows
-- there are diffrent ways of aggregation (max, min...)
-- what is the total revenue from all orders
SELECT
    order_id,
    product_name,
    ROUND(SUM(quantity * list_price)) AS revenue -- sum will return one line only
FROM
    staging.joined_tables;

-- tru out other aggregation functions
SELECT
    ROUND(MIN(quantity * list_price)) AS min_revenue,
    ROUND(MAX(quantity * list_price)) AS max_revenue
FROM
    staging.joined_tables;