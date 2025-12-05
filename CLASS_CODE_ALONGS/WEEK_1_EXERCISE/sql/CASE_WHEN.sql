/* ===========
 CASE...WHEN
 =========== */
-- simulare if .. else in ofter languages
-- we can replace the order_status column to some descriptions
-- ex insted of 4, it will say 'completed'
SELECT
    order_id,
    product_name,
    CASE
        order_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Completed'
    END AS order_status_description -- end and give it a column name
FROM
    staging.joined_tables;