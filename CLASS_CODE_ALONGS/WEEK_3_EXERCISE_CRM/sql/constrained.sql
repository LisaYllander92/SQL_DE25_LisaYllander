/*Task 3
 Create a new schema called constrained and 
 create two tables under it. For each table, 
 create column constraints for the rules specified in task 2 
 and insert rows fulfilling these constraints separately from 
 the two tables in the staging schema.*/
CREATE SCHEMA IF NOT EXISTS constrained;

CREATE TABLE IF NOT EXISTS constrained.crm_old (
    customer_id INTEGER UNIQUE,
    -- unique value
    -- PRIMARY KEY is UNIQUE and not NULL
    name VARCHAR NOT NULL,
    -- not empty
    email VARCHAR CHECK(email LIKE '%@%.%'),
    region VARCHAR CHECK (region IN ('EU', 'US')),
    STATUS VARCHAR CHECK (STATUS IN ('active', 'inactive'))
);

CREATE TABLE IF NOT EXISTS constrained.crm_new (
    customer_id INTEGER UNIQUE,
    -- unique value
    -- PRIMARY KEY is UNIQUE and not NULL
    name VARCHAR NOT NULL,
    -- not empty
    email VARCHAR CHECK(
        regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
    ),
    region VARCHAR CHECK (region IN ('EU', 'US')),
    STATUS VARCHAR CHECK (STATUS IN ('active', 'inactive'))
);

-- Insert values from staging schema
INSERT INTO
    constrained.crm_old
SELECT
    *
FROM
    staging.crm_old
WHERE
    regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
    AND region IN ('EU', 'US')
    AND STATUS IN ('active', 'inactive');

INSERT INTO
    constrained.crm_new
SELECT
    *
FROM
    staging.crm_new
WHERE
    regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
    AND region IN ('EU', 'US')
    AND STATUS IN ('active', 'inactive');

/*Task 4
 In tasks 4 and 5, use the data in the staging schema that
 store customer records before column constraints are enforced.
 
 To validate whether the old and new CRM systems keep the
 same customer records, use the column customer_id as the unique identifier of customers and find out:
 
 customers only recorded in the old CRM system
 customers only recorded in the new CRM system
 customers recorded in both CRM system
 */
-- 7 customers are only recorded in the old CRM system
SELECT
    customer_id
FROM
    staging.crm_old
EXCEPT
SELECT
    customer_id
FROM
    staging.crm_new;

-- 6 customers only recorded in the new CRM system
SELECT
    customer_id
FROM
    staging.crm_new
EXCEPT
SELECT
    customer_id
FROM
    staging.crm_old;

-- 7 common customers in both crm system
SELECT
    customer_id
FROM
    staging.crm_new
INTERSECT
SELECT
    customer_id
FROM
    staging.crm_old;

/*Task 5
 With your findings above, you are going to produce
 a discrepancy report showing customer records that have issues and
 need to be further checked with the system migration and customer teams.
 
 Include records that
 
 violate constraints in task 2
 are not common as you found in task 4*/
-- subquery 1: customers only in the old crm system
(
    SELECT
        *
    FROM
        staging.crm_old
    EXCEPT
    SELECT
        *
    FROM
        staging.crm_new
)
UNION
-- subquery 2: customers only in the new crm system
(
    SELECT
        *
    FROM
        staging.crm_new
    EXCEPT
    SELECT
        *
    FROM
        staging.crm_old
)
UNION
-- subquery 3: cutstomers violating constraints in the old crm system
(
    SELECT
        *
    FROM
        staging.crm_old
    WHERE
        NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
        OR NOT region IN ('EU', 'US')
        OR NOT STATUS IN ('active', 'inactive')
)
UNION
-- subquery 4: cutstomers violating constraints in the new crm system
(
    SELECT
        *
    FROM
        staging.crm_new
    WHERE
        NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
        OR NOT region IN ('EU', 'US')
        OR NOT STATUS IN ('active', 'inactive')
);