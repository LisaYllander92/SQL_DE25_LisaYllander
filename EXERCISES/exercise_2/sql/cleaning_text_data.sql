/*0. Cleaning malformed text data*/

/* a) Create a schema called refined. 
 This is the schema where you'll put the transformed data.*/
CREATE SCHEMA IF NOT EXISTS refined;

CREATE TABLE IF NOT EXISTS refined.cleaned_glossery AS (
    SELECT
        *
    FROM
        read_csv_auto('data/sql_terms.csv')
);

FROM
    refined.cleaned_glossery;

/* b) Now transform and clean the data
 and place the cleaned table inside the refined schema.*/
-- test first
SELECT
    upper(trim(sql_word)) AS sql_word,
    regexp_replace(trim(description), ' +', ' ', 'g') AS description_example
FROM
    refined.cleaned_glossery;

CREATE TABLE IF NOT EXISTS refined.glossery AS(
    SELECT
        upper(trim(sql_word)) AS sql_word,
        regexp_replace(trim(description), ' +', ' ', 'g') AS description_example
    FROM
        refined.cleaned_glossery
);

FROM
    refined.glossery;

/* c) Practice filtering and searching for different keywords in different columns. 
 Discuss with a friend why this could be useful in this case.*/
SELECT
    *
FROM
    refined.glossery
WHERE
    sql_word LIKE 'A%';

SELECT
    *
FROM
    refined.glossery
ORDER BY
    sql_word;