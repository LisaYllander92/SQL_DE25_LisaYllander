/* ===========================
 0. Making a course database
 =========================== */
-- deletes the table
DROP TABLE IF EXISTS course_structure;

-- create a table
CREATE TABLE IF NOT EXISTS course_structure(
    Week INTEGER,
    Content VARCHAR,
    Lectures INTEGER,
    Exercise VARCHAR
);

-- add values to table
INSERT INTO
    course_structure (Week, Content, Lectures, Exercise)
VALUES
    (46, 'intro', 0, '0'),
    (46, 'course_structure', 1, '0'),
    (46, 'setup duckdb', 2, '0'),
    (46, 'sql_introduction', 3, '0'),
    (46, 'querying data', 4, '0'),
    (46, 'filtering', 5, '0'),
    (47, 'crud operations', 6, '1'),
    (47, 'grouping data', 7, '1'),
    (47, 'strings', 8, '1'),
    (48, 'temporal data', 9, '2'),
    (48, 'enforce constraints', 10, '2'),
    (48, 'set operations', 11, '2'),
    (49, 'joins', 12, '3, lab'),
    (49, 'subquery', 13, '3, lab'),
    (49, 'views', 14, '3, lab'),
    (49, 'cte', 15, '3, lab'),
    (50, 'window funktions', 16, 'lab'),
    (50, 'python connect duckdb', 17, 'lab'),
    (50, 'pandas duckdb', 18, 'lab'),
    (50, 'dlt', 19, 'lab'),
    (51, 'macros', 20, 'lab'),
    (51, 'sql injection', 21, 'lab') -- a) Select all the exercises in this course
SELECT
    Exercise
FROM
    course_structure;

-- b) Select all the lectures in this course
SELECT
    Lectures
FROM
    course_structure;

--  c) Select all records for week 48
SELECT
    *
FROM
    course_structure
WHERE
    week = 48;

--  d) Select all records for week 47-49
SELECT
    *
FROM
    course_structure
WHERE
    week BETWEEN 47
    AND 49;

--  e) How many lectures are in the table?
SELECT
    COUNT(lectures)
FROM
    course_structure;

-- f) How many other content are there?
SELECT
    COUNT(content)
FROM
    course_structure;

-- g) Which are the unique content types in this table?
-- h) Delete the row with content 02_setup_duckdb and add it again.
DELETE FROM
    course_structure
WHERE
    content = 'setup duckdb';

SELECT
    *
FROM
    course_structure;

INSERT INTO
    course_structure (Week, Content, Lectures, Exercise)
VALUES
    (46, 'setup duckdb', 2, '0');

SELECT
    *
FROM
    course_structure;

-- i) You see that 02_setup_duckdb comes in the end of your table, even though the week is 46. 
-- Now make a query where you sort the weeks in ascending order.
SELECT
    *
FROM
    course_structure
ORDER BY
    week;