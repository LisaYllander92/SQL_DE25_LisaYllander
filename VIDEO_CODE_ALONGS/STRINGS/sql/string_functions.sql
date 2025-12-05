FROM
    staging.sql_glossery;

-- Remove leading and trailing spaces
SELECT
    trim(sql_word, ' ') as trimmed_word,
    trimmed_word [1] as first_character,
    trimmed_word [-1] as last_character,
FROM
    staging.sql_glossery;

-- transform character to upper case
SELECT
    upper(trim(sql_word, ' ')) as sql_term,
    sql_term [1] as first_character,
    sql_term [-1] as last_character,
FROM
    staging.sql_glossery;

FROM
    staging.sql_glossery;

-- Replace two spaces with one space
SELECT
    description,
    replace(description, ' ', ' ') as cleaned_description
FROM
    staging.sql_glossery;

-- concatnate strings with ||
SELECT
    concat(upper(trim(sql_word, ' ')), 'command') as sql_command,
    -- || means 'concat' in duckdb
    upper(trim(sql_word, ' ')) || 'command' as sql_commands,
FROM
    staging.sql_glossery;

-- extract substrings
SELECT
    trim(sql_word) as trimmed_word,
    substring(trim(sql_word), 1, 5) as first_five_charcters
FROM
    staging.sql_glossery;

-- Reverse string(words)
SELECT
    reverse(trim(sql_word)) as trimmed_word,
FROM
    staging.sql_glossery;

-- find position of first occurence of a substring
-- return 0 if substring is not found
SELECT
    description,
    instr(description, 'select') as select_position,
    select_position != 0 as about_select
FROM
    staging.sql_glossery;

SELECT
    'fun' || ' joke' AS concatenated_string