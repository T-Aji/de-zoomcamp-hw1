## Q1:
>SOLUTION
```bash
docker run -it --entrypoint bash python:3.12.8
```
>ANSWER ✅
```
24.3.1
```

## Q2:

>ANSWER ✅
```
postgres:5432
```

## Q3:
>SOLUTION
```sql
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

```
>ANSWER ✅
```
104802, 198924, 109603, 27678, 35189
```

## Q4:
>SOLUTION
```sql
SELECT
    DATE(lpep_pickup_datetime) AS pickup_day,
    MAX(trip_distance) AS longest_trip_distance
FROM
    green_taxi_data
GROUP BY
    DATE(lpep_pickup_datetime)
ORDER BY
    longest_trip_distance DESC
LIMIT 1
```
>ANSWER ✅
```
pickup_day  longest_trip_distance
2019-10-31                 515.89
```

## Q5:
>SOLUTION
```sql
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
LIMIT 3
```
>ANSWER ✅
```
        pickup_zone  total_amount
  East Harlem North      18686.68
  East Harlem South      16797.26
Morningside Heights      13029.79
```

## Q6:
>SOLUTION
```sql
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
```
>ANSWER ✅
```
dropoff_zone  largest_tip
 JFK Airport         87.3
```

## Q7:

>ANSWER ✅
```
terraform init, terraform apply -auto-approve, terraform destroy
```

