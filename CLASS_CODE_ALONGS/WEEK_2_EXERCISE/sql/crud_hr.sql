/* ============
 DDL - CREATE
 ============ */
-- TASK 1
-- create schema
CREATE SCHEMA IF NOT EXISTS staging;

-- got some problems with the employee_id 
DROP TABLE IF EXISTS staging.employees;

-- 1. Radera SEKVENSOBJEKTET
DROP SEQUENCE IF EXISTS id_sequence;

-- create sequence to generate values for employement_id column later
CREATE SEQUENCE IF NOT EXISTS id_sequence START 1;

-- create table with schema staging
-- add values and its datatype
CREATE TABLE IF NOT EXISTS staging.employees (
    employee_id INTEGER DEFAULT nextval('id_sequence'),
    department VARCHAR,
    employment_year INTEGER
);

/* CRUD (DML) - CREATE/INSERT (create new values) */
-- TASK 2
-- insert 3 rows manually
INSERT INTO
    -- which table
    staging.employees (department, employment_year) -- what
VALUES
    -- values
    ('Sales', 2001),
    ('Locistics', 2002),
    ('IT', 2002);

FROM
    staging.employees;

-- when you do a missspell, drop table and create again
-- same as ' duckdb_file < sql_file ' (imput ingestion)
-- insert records from csv-file using the read_csv function
-- ref: https://duckdb.org/docs/stable/guides/file_formats/csv_import
INSERT INTO
    staging.employees (department, employment_year)
SELECT
    *
FROM
    read_csv('data/employees.csv');

/*CRUD - READ (SELECT)*/
SELECT
    *
FROM
    staging.employees;

-- LIMIT 10 - show the first 10
SELECT
    *
FROM
    staging.employees
LIMIT
    10;

-- OFFSET 10 - exclude the first 10
-- TASK 3
/* CRUD - UPDATE */
-- modify existing data
UPDATE
    staging.employees
SET
    employment_year = 2023
WHERE
    employee_id IN (98, 99);

-- same as: where employee_id = 98 OR employee_id = 99;
/* DDL - ALTER */
ALTER TABLE
    staging.employees
ADD
    COLUMN pension_plan VARCHAR DEFAULT 'plan 1'
FROM
    staging.employees
    /* CRUD - UPDATE */
UPDATE
    staging.employees
SET
    pension_plan = 'plan 2' -- what to update
WHERE
    -- where we want the update
    employment_year > 2015;

-- TASK 5
/* CRUD - DELETE */
-- always check the rows before you delete
SELECT
    *
FROM
    staging.employees
WHERE
    emplyoee_id = 1;

-- delete
DELETE FROM
    staging.employees
WHERE
    emplyoee_id = 1;