DESC staging.train_schedules;

FROM
    staging.train_schedules;

SELECT
    scheduled_arrival,
    actual_arrival,
    delay_minutes,
    age(actual_arrival, scheduled_arrival) AS delay_interval,
    typeof(delay_interval)
FROM
    staging.train_schedules;

-- trunc current local time to minutes (shows exact minute now)
SELECT
    current_localtimestamp() AS current_time,
    date_trunc('minute', current_time) AS min;

-- same but with seconds
SELECT
    current_localtimestamp() AS current_time,
    date_trunc('second', current_time) AS SECOND;

-- truncate a timestamp to specific precision
-- rounds to nearest hour
SELECT
    scheduled_arrival,
    date_trunc('hour', scheduled_arrival) AS scheduled_arrival_trunc
FROM
    staging.train_schedules;

-- extract subfield of timestamp
-- show arrival hour in text
SELECT
    scheduled_arrival,
    'kl:' || extract (
        'hour'
        FROM
            scheduled_arrival
    ) AS scheduled_arrival_hour
FROM
    staging.train_schedules;