CREATE SCHEMA IF NOT EXISTS refined;

-- test first
SELECT
    upper(trim(sql_word)) AS sql_word,
    regexp_replace(trim(description), ' +', ' ', 'g') as description_example
FROM
    staging.sql_glossery
);

CREATE TABLE IF NOT EXISTS refined.sql_glossery AS (
    SELECT
        upper(trim(sql_word)) AS sql_word,
        regexp_replace(trim(description), ' +', ' ', 'g') as description_example
    FROM
        staging.sql_glossery
);

FROM
    refined.sql_glossery;