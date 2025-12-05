FROM
    staging.squad;

-- clean string
SELECT
    regexp_replace(lower(trim(title)), '_', ' ', 'g') AS trimed_title
FROM
    staging.squad;

UPDATE
    staging.squad
SET
    title = regexp_replace(lower(trim(title)), '_', ' ', 'g'),
    context = regexp_replace(lower(trim(context)), '_', ' ', 'g')
WHERE
    title IN title
    AND context IN context;

/* TASK 2 */
SELECT
    title,
    context
FROM
    staging.squad
WHERE
    NOT regexp_matches(context, title);

--two arguments are string and substring
/* TASK 2 alternative */
SELECT
    title,
    context,
    INSTR(context, title) -- no match if there is no match, new column hows matches
FROM
    staging.squad
WHERE
    NOT regexp_matches(context, title);

/* TASK 3 */
-- show rows if context matches title
-- use LIKE operator with wildcard %
SELECT
    title,
    context
FROM
    staging.squad
WHERE
    context LIKE title || '%';

/* TASK 3 alternative */
SELECT
    *
FROM
    staging.squad
WHERE
    context LIKE CONCAT(title, '%');

-- check the result for Southern_California
-- the result are not ok due to the wildcard _
-- with regexp_matches
-- if you use regular expression, underscore will be a litteral character
SELECT
    *
FROM
    staging.squad
WHERE
    regexp_matches(context, CONCAT('^', title));

/* TASK 4 */
-- show a new column with is rhe forst answer from the AI model 
-- without pattern matching, using slicing
SELECT
    answers [18:],
    -- slicing
    answers [18],
    -- indexing
    CASE
        WHEN answers [18] = ',' THEN NULL
        ELSE answers [18:]
    END AS striped_answer,
    instr(striped_answer, '''') AS first_quotation_index,
    -- escape in end of answer where -> '
    -- a single quatation needs to be typed as ''
    striped_answer [:first_quotation_index-1] AS first_answers,
    answers
FROM
    staging.squad;

/* TASK 5 */
-- with pattern matching
SELECT
    -- don't allows single quotation inside ' and ',
    regexp_extract(answers, '''([^'']+)'',') AS first_answer,
    -- = starts with '([', ends with ',
    -- allows upper and lower case letter, digits, space, comma
    regexp_extract(answers, '''([^A-Za-z0-9 ,]+)'',') AS first_answer,
    -- use the grouping optional argument in regexp_extract function
    regexp_extract(answers, '''([^A-Za-z0-9 ,]+)'',', 1) AS first_answer,
    answers
FROM
    staging.squad;

