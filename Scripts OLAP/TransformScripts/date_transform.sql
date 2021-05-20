INSERT INTO date (year,month,day)
SELECT DISTINCT 
    EXTRACT(YEAR FROM R.rental_date)::smallint AS year,
    EXTRACT(MONTH FROM R.rental_date)::smallint AS month, 
    EXTRACT(DAY FROM R.rental_date)::smallint AS day
FROM rental R
ORDER BY year, month, day;