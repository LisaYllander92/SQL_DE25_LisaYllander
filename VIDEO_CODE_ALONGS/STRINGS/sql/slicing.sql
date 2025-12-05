--slicing
SELECT
    sql_word,
    sql_word [0],
    sql_word [1],
    sql_word [-1]
FROM
    staging.sql_glossery;

SELECT
    sql_word,
    sql_word [:2],
    sql_word [2:5]
FROM
    staging.sql_glossery;

-- slicing operator
SELECT
    trim(sql_word) as trimmed_word,
    substring(trim(sql_word), 1, 5) as first_five_charcters,
    trimmed_word [1:5] as sliced_five_chars,
FROM
    staging.sql_glossery;