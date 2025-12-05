-- Like operator in WHERE clause -> filter rows
-- LIKE operator with wildcards to search for a pattern
SELECT
    example,
    lower(trim(example)) as cleand_example
FROM
    staging.sql_glossery;

-- search for select
SELECT
    example,
    lower(trim(example)) as cleand_example
FROM
    staging.sql_glossery
WHERE
    cleand_example LIKE 'select%';

-- wildcard % matches 0 or more
-- wildcard _ represents one character
SELECT
    example,
    trim(example) as cleand_example
FROM
    staging.sql_glossery
WHERE
    cleand_example LIKE 'S_LECT%';

/*Regular expression*/
SELECT
    lower(trim(description)) as cleaned_description
FROM
    staging.sql_glossery
WHERE
    regexp_matches(cleaned_description, '^c');

-- will filter rows starting with 'c'
-- Starting with 'C' or 'S'
SELECT
    trim(description) as cleaned_description
FROM
    staging.sql_glossery
WHERE
    regexp_matches(cleaned_description, '^[CS]');

-- \b makes it match exactly select word (e.g doesn't match selectS)
SELECT
    lower(description) as cleaned_description
FROM
    staging.sql_glossery
WHERE
    regexp_matches(cleaned_description, 'select\b');

-- [a-f] matches range of characters
-- ^[a-f] matchesstarting with characters 'a' to 'f'
SELECT
    lower(trim(description)) as cleaned_description
FROM
    staging.sql_glossery
WHERE
    regexp_matches(cleaned_description, '^[a-f]');

-- [^a-f] matches any character not ub range a-f
-- ^[^a-f] starting with characters not in range a-f
SELECT
    lower(trim(description)) as cleaned_description
FROM
    staging.sql_glossery
WHERE
    regexp_matches(cleaned_description, '^[^a-f]');

SELECT
    description,
    regexp_replace(trim(description), ' +', ' ', 'g') AS cleaned_description
FROM
    staging.sql_glossery;