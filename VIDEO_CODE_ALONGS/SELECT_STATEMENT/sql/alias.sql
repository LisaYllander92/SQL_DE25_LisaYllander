-- creating a alsias with 'AS'
SELECT
    DISTINCT salary_currency AS unique_currency
FROM
    data_jobs;

-- space insted of 'AS' for alias
SELECT
    DISTINCT salary_currency unique_currency
FROM
    data_jobs;

SELECT
    COUNT(DISTINCT salary_currency) AS number_currencies
FROM
    data_jobs;

-- 
SELECT
    ROW_NUMBER() OVER () AS id,
    *
FROM
    data_jobs