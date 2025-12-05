SELECT
    COUNT(*)
FROM
    data_jobs;

SELECT
    COUNT(*)
FROM
    data_jobs
WHERE
    -- dispays all the rows that fufill this requierment
    salary_in_usd < 50000;

-- find entry level jobs
SELECT
    DISTINCT experience_level
FROM
    data_jobs;

SELECT
    *
FROM
    data_jobs
WHERE
    experience_level = 'EN';

-- find median salary for entry level jobs
SELECT
    MEDIAN(salary_in_usd) AS median_salary_usd,
    AVG(salary_in_usd) AS mean_salary_usd
FROM
    data_jobs
WHERE
    experience_level = 'EN';

SELECT
    MEDIAN(salary_in_usd) AS median_salary_usd,
    AVG(salary_in_usd) AS mean_salary_usd
FROM
    data_jobs
WHERE
    experience_level = 'MI';