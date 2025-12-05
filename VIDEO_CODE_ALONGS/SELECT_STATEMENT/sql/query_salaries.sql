SELECT
    *
FROM
    data_jobs;

SELECT
    *
FROM
    main.data_jobs;

/*
 fully qualified name:
 data_jobs - the data base name
 main - schema name
 data_jobs - table name
 */
SELECT
    *
FROM
    data_jobs.main.data_jobs;

/*
 Limit clause choosed how many rows to return
 */
SELECT
    *
FROM
    data_jobs
LIMIT
    5;

/*
 Limit clause choosed how many rows to return
 */
SELECT
    *
FROM
    data_jobs OFFSET 2;

desc data_jobs;

-- select specified columns
SELECT
    work_year,
    job_title,
    salary_in_usd,
    company_location
FROM
    data_jobs;

-- select all columns expecpt those specified in exclude
SELECT
    * EXCLUDE(salary, work_year)
FROM
    data_jobs;

SELECT
    DISTINCT emplyment_type
FROM
    data_jobs;

SELECT
    DISTINCT experience_level
FROM
    data_jobs;