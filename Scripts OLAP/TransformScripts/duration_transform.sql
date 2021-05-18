INSERT INTO Duration (day_count)
SELECT DISTINCT 
    DATE_PART('day', R.return_date - R.rental_date)::smallint as day_column
FROM rental R
EXCEPT ALL SELECT NULL;