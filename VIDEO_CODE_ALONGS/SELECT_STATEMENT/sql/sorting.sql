-- sorted in ascending order by default
SELECT
    *
FROM
    data_jobs
ORDER BY
    salary_in_usd;

-- sort by salary_in_usd DESC and employee_residens ascending
SELECT
    *
FROM
    data_jobs
ORDER BY
    salary_in_usd DESC,
    employee_residens ASC;