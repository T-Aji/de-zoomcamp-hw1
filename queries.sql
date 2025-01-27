-- Q3: Trip Segmentation Count
SELECT
    SUM(CASE WHEN trip_distance <= 1 THEN 1 ELSE 0 END) AS trips_up_to_1_mile,
    SUM(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 ELSE 0 END) AS trips_1_to_3_miles,
    SUM(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 ELSE 0 END) AS trips_3_to_7_miles,
    SUM(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 ELSE 0 END) AS trips_7_to_10_miles,
    SUM(CASE WHEN trip_distance > 10 THEN 1 ELSE 0 END) AS trips_over_10_miles
FROM
    green_taxi_data
WHERE
    lpep_pickup_datetime >= '2019-10-01' AND
    lpep_pickup_datetime < '2019-11-01' AND
    lpep_dropoff_datetime < '2019-11-01';

-- Q4: Longest trip for each day
SELECT
    DATE(lpep_pickup_datetime) AS pickup_day,
    MAX(trip_distance) AS longest_trip_distance
FROM
    green_taxi_data
GROUP BY
    DATE(lpep_pickup_datetime)
ORDER BY
    longest_trip_distance DESC
LIMIT 1;

-- Q5: Three biggest pickup zones
SELECT
    tz."Zone" AS pickup_zone,
    SUM(gt.total_amount) AS total_amount
FROM
    green_taxi_data gt
JOIN
    taxi_zones tz ON gt."PULocationID" = tz."LocationID"
WHERE
    DATE(gt.lpep_pickup_datetime) = '2019-10-18'
GROUP BY
    tz."Zone"
HAVING
    SUM(gt.total_amount) > 13000
ORDER BY
    total_amount DESC
LIMIT 3;

-- Q6: Largest tip
SELECT
    tz_dropoff."Zone" AS dropoff_zone,
    MAX(gt.tip_amount) AS largest_tip
FROM
    green_taxi_data gt
JOIN
    taxi_zones tz_pickup ON gt."PULocationID" = tz_pickup."LocationID"
JOIN
    taxi_zones tz_dropoff ON gt."DOLocationID" = tz_dropoff."LocationID"
WHERE
    tz_pickup."Zone" = 'East Harlem North' AND
    DATE_TRUNC('month', gt.lpep_pickup_datetime) = '2019-10-01'
GROUP BY
    tz_dropoff."Zone"
ORDER BY
    largest_tip DESC
LIMIT 1;