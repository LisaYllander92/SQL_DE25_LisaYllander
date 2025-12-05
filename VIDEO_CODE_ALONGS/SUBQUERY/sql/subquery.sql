FROM
    staging.students;

-- subquery to filter students scores higher than average
SELECT
    *
FROM
    staging.students
WHERE
    grade_math > (
        SELECT
            avg(grade_math)
        FROM
            staging.students
        ORDER BY
            grade_math;

);

-- to see average score (84.2)
SELECT
    avg(grade_math)
FROM
    staging.students;

-- multirow subquery
-- query that return multible rows
-- used with IN opertatoe to check membership
-- filter students in classes taught bu Anna S.
SELECT
    *
FROM
    staging.students
WHERE
    class_name IN (
        -- subquery
        SELECT
            class_name
        FROM
            staging.teachers
        WHERE
            teacher_name = 'Anna S.'
    );

-- correlated subquery
-- subquery depends in column values of outer query
-- filter students with math grade higher than average of there own classes
SELECT
    *
FROM
    staging.students s
WHERE
    s.grade_math > (
        SELECT
            avg(grade_math)
        FROM
            staging.students
        WHERE
            class_name = s.class_name
    )
ORDER BY
    s.class_name;

-- check results of above by looking at avg grade per class
SELECT
    class_name,
    avg(grade_math) AS class_avg_grade
FROM
    staging.students
GROUP BY
    class_name;