DESC staging.sweden_holidays;

-- YYYY-MM-DD
FROM
    staging.sweden_holidays
LIMIT
    5;

-- addition and subtraction
SELECT
    date,
    date + INTERVAL 5 DAY AS plus_5_days,
    typeof(plus_5_days) AS plus_5_days_type,
    date - INTERVAL 5 DAY AS minus_5_days,
FROM
    staging.sweden_holidays;

-- DATE functions
SELECT
    today();

SELECT
    today() AS TODAY,
    date - today AS time_after_holiday,
    *
FROM
    staging.sweden_holidays;

-- pick out weekday
SELECT
    date,
    dayname(date) AS weekday
FROM
    staging.sweden_holidays;

-- latest from two dates
SELECT
    *,
    today() AS today,
    greatest(date, today) AS later_day
FROM
    staging.sweden_holidays;

-- convert date to string 
SELECT
    date,
    strftime(date, '%d/%m/%Y') AS date_string,
    typeof(date_string)
FROM
    staging.sweden_holidays;

-- convert from string to date
SELECT
    date,
    strftime(date, '%d/%m/%Y') AS date_string,
    strptime(date_string, '%d/%m/%Y') :: DATE AS new_date,
    typeof(new_date)
FROM
    staging.sweden_holidays;