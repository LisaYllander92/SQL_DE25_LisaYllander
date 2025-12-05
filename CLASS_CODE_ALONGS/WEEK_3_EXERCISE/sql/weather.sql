FROM
    staging.weather;

/* TASK 2 */
DESC
SELECT
    sunriseTime,
    sunsetTime,
    temperatureHighTime,
    temperatureLowTime,
    windGustTime,
    precipIntensityMaxTime
FROM
    staging.weather;

-- OR...
SELECT
    typeof(sunriseTime),
    typeof(sunsetTime),
    typeof(temperatureHighTime),
    typeof(temperatureLowTime),
    typeof(windGustTime),
    typeof(precipIntensityMaxTime)
FROM
    staging.weather;

-- Show the UNIX values of these columns:
-- The values are the number of seconds counted 
-- from a reference time point (1970-01-01 00:00:00)
SELECT
    sunriseTime,
    sunsetTime,
    temperatureHighTime,
    temperatureLowTime,
    windGustTime,
    precipIntensityMaxTime
FROM
    staging.weather;

/* TASK 3 */
-- each row in the dataset contains waether data for each combination 
-- of Country/Region, Province/State and date (time column)
-- It's importent to understand which columns can be used to uniquely identify each row
-- use aggregation function together with group by
SELECT
    "Country/Region",
    -- use dubblequotation "" for column names with '/'
    "Province/State",
    -- count (*) as nr_records
    count("Country/Region") AS counted_countrys,
    count("Province/State") AS counted_states
FROM
    staging.weather
GROUP BY
    "Country/Region",
    "Province/State"
ORDER BY
    "Country/Region";

/* TASK 4 */
SELECT
    -- age(to_timestamp(sunriseTime)) as sunrise_age, -- shows time differens from then to now
    to_timestamp(sunriseTime) AS sunrise_utc,
    -- utc as defaul
    to_timestamp(sunriseTime) at time zone 'Europe/Stockholm' AS sunrise_sweTime,
    to_timestamp(sunsetTime) AS sunset_utc,
    to_timestamp(sunsetTime) at time zone 'Europe/Stockholm' AS sunset_sweTime,
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden' -- note the use of single- and double quotation
    /* TASK 4 */
SELECT
    "Country/Region",
    to_timestamp(sunriseTime),
    to_timestamp(sunsetTime),
    typeof(to_timestamp(sunriseTime)),
    typeof(to_timestamp(sunsetTime))
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden';

/* TASK 5 */
-- the new year and month columns involves subtracting a part of timestamp
-- to pick up the date with the largest gap within a month involves
-- the use of aggregation function
-- the gap can be calculated diractly with UNIX time
SELECT
    "Country/Region",
    date_part('year', to_timestamp(sunriseTime)) AS year,
    date_part('month', to_timestamp(sunriseTime)) AS MONTH,
    round(max(sunsetTime - sunriseTime) / 3600, 2) AS gap_in_hours -- divide by 3600 to show gap in hours
    -- ,2 for 2 decimals
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden'
GROUP BY
    "Country/Region",
    year,
    MONTH
ORDER BY
    year,
    MONTH DESC;

/* TASK 5 - alternative for date_part */
SELECT
    "Country/Region",
    extract (
        'year'
        FROM
            to_timestamp(sunriseTime)
    ) AS year_sunrise,
    extract (
        'month'
        FROM
            to_timestamp(sunsetTime)
    ) AS month_sunrise
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden';

/* TASK 6 */
-- concatenate integer and string 
SELECT
    to_timestamp(windGustTime) at time zone 'Europe/Stockholm' AS most_windy_timestamp,
    date_part('hour', most_windy_timestamp) AS most_windy_hour,
    concat(
        'It`s dangerous to use the crane as kl: ',
        most_windy_hour
    ) AS message
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden' 
    
-- concatenate string and string
SELECT
    to_timestamp(windGustTime) at time zone 'Europe/Stockholm' AS most_windy_timestamp,
    -- strftime(), strinf format time, transforms timestamp to string
    -- use the format, like '%H' to show the presentation
    -- strptime() string parse time, transform string to timestamp
    strftime(most_windy_timestamp, '%H') AS most_windy_hour,
    concat(
        'It`s dangerous to use the crane as kl: ',
        most_windy_hour
    ) AS message
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden'