INSERT INTO Duration (day_count)
SELECT DISTINCT 
    (EXTRACT(DAY FROM R.return_date - R.rental_date) + 
    CEILING(EXTRACT(HOURS FROM R.return_date - R.rental_date) / 24))::smallint as day_column
FROM rental R
EXCEPT ALL SELECT NULL
ORDER BY day_column;

-- Para alquileres sin fecha de devolucion
INSERT INTO Duration (day_count) VALUES (-1);