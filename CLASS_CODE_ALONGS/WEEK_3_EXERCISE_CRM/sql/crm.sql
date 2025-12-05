-- Task 2 - Both CRM datasets may contain invalid records. 
-- Identify all rows in both datasets that fail to meet the following rules:
FROM
    staging.crm_old;

FROM
    staging.crm_new;

-- The email address must include an @ symbol followed later by a .
-- with regex
SELECT
    email
FROM
    staging.crm_old
WHERE
    NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]');

-- whitin the (). first argument (email, = where we want to look)
-- , the pattern we want)
-- '+' means that you can have multible characters 
-- '\' escape character for the patterns to understand that the '.' is a dot,
-- and not any character 
SELECT
    email
FROM
    staging.crm_new
WHERE
    NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]');

-- use LIKE with wildcard for the old data 
-- for the new data we need to use regex to find the pattern
SELECT
    *
FROM
    staging.crm_old
WHERE
    email NOT LIKE '%@%.%';

-- % certain/'any' character
-- combine all three conditions
SELECT
    *
FROM
    staging.crm_new
WHERE
    NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
    OR NOT region IN ('EU', 'US')
    OR NOT STATUS IN ('active', 'inactive');

SELECT
    *
FROM
    staging.crm_old
WHERE
    NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z0-9]+\.[A-Za-z]')
    OR NOT region IN ('EU', 'US')
    OR NOT STATUS IN ('active', 'inactive');

-- The region value must be either EU or US
-- The status must be either active or inactive