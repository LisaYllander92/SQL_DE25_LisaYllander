/* Aggregation */
-- TASK 6
-- create the new table
CREATE TABLE IF NOT EXISTS staging.more_employees AS (
    SELECT
        *
    FROM
        read_csv_auto('data/more_employees.csv')
);

FROM
    staging.more_employees;

-- count discinct departments
SELECT
    DISTINCT department
FROM
    staging.more_employees;

-- number of departments
SELECT
    COUNT(DISTINCT department)
FROM
    staging.more_employees;

-- analyze salary
SELECT
    department,
    -- select where
    ROUND(AVG(monthly_salary_sek)) -- what you want to analyze
FROM
    staging.more_employees
GROUP BY
    -- grouped by departement
    department;

-- analyze salary average vs median
SELECT
    department,
    -- select where
    ROUND(AVG(monthly_salary_sek)) AS average_salary_sek,
    -- what you want to analyze
    ROUND(MEDIAN(monthly_salary_sek)) AS median_salary_sek,
    ROUND(MIN(monthly_salary_sek)) AS minimum_salary_sek,
    ROUND(MAX(monthly_salary_sek)) AS maxumum_salary_sek
FROM
    staging.more_employees
GROUP BY
    department;