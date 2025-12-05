-- create schema
CREATE SCHEMA IF NOT EXISTS staging;

-- creating a table with the data from salaries.csv
CREATE TABLE IF NOT EXISTS staging.cleaned_salaries AS (
    SELECT
        *
    FROM
        read_csv_auto('data/salaries.csv')
);

FROM
    staging.cleaned_salaries;

-- a) Transform employment type column based on this table
-- using ALTER TABLE to add column
ALTER TABLE
    staging.cleaned_salaries
ADD
    COLUMN employment_type_description VARCHAR;

-- Updating the table so that when employment_type is.. THEN description is..
UPDATE
    staging.cleaned_salaries
SET
    employment_type_description = CASE
        employment_type
        WHEN 'CT' THEN 'Contract'
        WHEN 'FL' THEN 'Freelance'
        WHEN 'PT' THEN 'Part time'
        WHEN 'FT' THEN 'Full time'
        ELSE 'Unknown' --In case there's any other shortning
    END;

FROM
    staging.cleaned_salaries;

-- checking the diffrent company sizes
SELECT
    DISTINCT company_size
FROM
    staging.cleaned_salaries;

-- b) Do similar for company size, but you have to figure out what the abbreviations could stand for.
-- adds another column for company_size_description
ALTER TABLE
    staging.cleaned_salaries
ADD
    COLUMN complany_size_description VARCHAR;

-- adds value to description column
UPDATE
    staging.cleaned_salaries
SET
    complany_size_description = CASE
        company_size
        WHEN 'S' THEN 'Small size Company'
        WHEN 'M' THEN 'Medium size Company'
        WHEN 'L' THEN 'Large size Company'
    END;

--  c) Make a salary column with Swedish currency for yearly salary.
ALTER TABLE
    staging.cleaned_salaries
ADD
    COLUMN yearly_salary_sek INTEGER;

-- testing first
SELECT
    ROUND(9.44 * salary_in_usd) AS yearly_salary_sek
FROM
    staging.cleaned_salaries;

UPDATE
    staging.cleaned_salaries -- includes all rows
    -- for every row in table sets new value to the column
SET
    yearly_salary_sek = ROUND(9.44 * salary_in_usd);

FROM
    staging.cleaned_salaries;

-- d) Make a salary column with Swedish currency for monthly salary.
ALTER TABLE
    staging.cleaned_salaries
ADD
    COLUMN monthly_salary_sek INTEGER;

-- testing first
SELECT
    ROUND((9.44 * salary_in_usd) / 12) AS monthly_salary_sek
FROM
    staging.cleaned_salaries;

-- then add changes
UPDATE
    staging.cleaned_salaries
SET
    monthly_salary_sek = ROUND((9.44 * salary_in_usd) / 12);

-- e) Make a salary_level column with the following categories: low, medium, high, insanely_high. Decide your thresholds for each category. 
-- Make it base on the monthly salary in SEK.
ALTER TABLE
    staging.cleaned_salaries
ADD
    COLUMN salary_level VARCHAR;

SELECT
    monthly_salary_sek
FROM
    staging.cleaned_salaries
ORDER BY
    monthly_salary_sek DESC;

-- testing it out
-- first I used BETWEEN but SQL knows that when the first line is '<',
-- it moves on to the next one...
SELECT
    monthly_salary_sek,
    CASE
        WHEN monthly_salary_sek < 50000 THEN 'low'
        WHEN monthly_salary_sek <= 100000 THEN 'medium'
        WHEN monthly_salary_sek <= 300000 THEN 'high'
        ELSE 'insanely_high'
    END AS salary_level
FROM
    staging.cleaned_salaries
ORDER BY
    monthly_salary_sek;

UPDATE
    staging.cleaned_salaries
SET
    salary_level = CASE
        WHEN monthly_salary_sek < 50000 THEN 'low'
        WHEN monthly_salary_sek <= 100000 THEN 'medium'
        WHEN monthly_salary_sek <= 300000 THEN 'high'
        ELSE 'insanely_high'
    END;

SELECT
    monthly_salary_sek,
    salary_level
FROM
    staging.cleaned_salaries;

-- f) Choose the following columns to include in your table:
-- experience_level, employment_type, job_title, salary_annual_sek,
-- salary_monthly_sek, remote_ratio, company_size, salary_level
CREATE TABLE temp_salaries AS -- putting them in the order I want
SELECT
    job_title,
    employment_type,
    employment_type_description,
    experience_level,
    remote_ratio,
    yearly_salary_sek,
    monthly_salary_sek,
    salary_level,
    complany_size_description
FROM
    staging.cleaned_salaries;

FROM
    temp_salaries;

-- I drop the old table so I can rename the new one
DROP TABLE staging.cleaned_salaries;

ALTER TABLE
    temp_salaries RENAME TO cleaned_salaries;

FROM
    cleaned_salaries;

/* =================================
 1. Explore your transformed table 
 ================================= */
--  a) Count number of Data engineers jobs.
-- For simplicity just go for job_title Data Engineer.
SELECT
    -- count (all) as ...
    COUNT(*) AS number_of_data_engineers
FROM
    cleaned_salaries
WHERE
    job_title = 'Data Engineer';

-- b) Count number of unique job titles in total.
SELECT
    COUNT(DISTINCT job_title)
FROM
    cleaned_salaries;

-- c) Find out how many jobs that goes into each salary level.
SELECT
    salary_level,
    -- selects the column to group by, so the result shows category name.
    COUNT(*) AS num_jobs_salary_level -- aggregates and counts all rows within each group
FROM
    cleaned_salaries
GROUP BY
    salary_level -- instuctures the database to collect all rows that have
    --the same value in 'salary_level' and performs the count operation
ORDER BY
    num_jobs_salary_level DESC;

-- d) Find out the median and mean salaries for each seniority levels
SELECT
    experience_level,
    ROUND(AVG(monthly_salary_sek)) AS mean_senior_salary,
    ROUND(MEDIAN(monthly_salary_sek)) AS median_senior_salary
FROM
    cleaned_salaries
WHERE
    experience_level = 'SE'
GROUP BY
    experience_level;

-- e) Find out the top earning job titles based on their median salaries and how much they earn.
SELECT
    job_title,
    -- calculates the median salary for each job title
    ROUND(MEDIAN(monthly_salary_sek)) AS median_salary_sek
FROM
    cleaned_salaries
GROUP BY
    job_title
ORDER BY
    median_salary_sek DESC --sorts by median salary
LIMIT
    10;

-- f) How many percentage of the jobs are fully remote, 50 percent remote and fully not remote.
SELECT
    COUNT(*) AS Total_Remote_jobs,
    -- calculates the total of remote_ratio
    -- calculates all the rows where remote_ratti = 100, save in 'alias'
    COUNT(*) FILTER(
        WHERE
            remote_ratio = 100
    ) AS Fully_Remote,
    COUNT(*) FILTER(
        WHERE
            remote_ratio = 50
    ) AS Fifth_Percent_Remote,
    COUNT(*) FILTER(
        WHERE
            remote_ratio = 0
    ) AS Zero_Percent_Remote,
    -- clculate the percentage
    -- first COUNT(*) calculates all the rows that fufill the requierment remote_ratio = 100
    -- the second COUNT(*) calculates ALL the rows in the table without any requierment
    ROUND(
        COUNT(*) FILTER(
            WHERE
                remote_ratio = 100
        ) / COUNT(*) * 100
    ) AS Persentage_Fully_Remote,
    ROUND(
        COUNT(*) FILTER(
            WHERE
                remote_ratio = 50
        ) / COUNT(*) * 100
    ) AS Percentage_Fifty_Remote,
    ROUND(
        COUNT(*) FILTER(
            WHERE
                remote_ratio = 0
        ) / COUNT(*) * 100
    ) AS Percentage_Zero_Remote
FROM
    cleaned_salaries;

/* To CAST (change datatype), safer! 
 ROUND(
 CAST(COUNT(*) FILTER(WHERE remote_ratio = 100) AS DOUBLE) 
 / COUNT(*) * 100
 ) AS Persentage_Fully_Remote,
 */
-- g) Pick out a job title of interest and figure out if company size affects the salary. 
-- Make a simple analysis as a comprehensive one requires causality investigations which are much harder to find.
SELECT
    job_title,
    complany_size_description,
    -- column I want to GROUP BY
    -- calculate average salary for each company size
    ROUND(AVG(monthly_salary_sek)) AS Average_Salary_Sek
FROM
    cleaned_salaries
WHERE
    job_title = 'Data Engineer' -- filtering which job title
GROUP BY
    job_title,
    complany_size_description -- aggregate salary for each company size
ORDER BY
    Average_Salary_sek DESC;