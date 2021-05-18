INSERT INTO date (year,month,day)
SELECT DISTINCT 
    EXTRACT(YEAR FROM R.rental_date)::smallint AS d_year,
    EXTRACT(MONTH FROM R.rental_date)::smallint AS d_month, 
    EXTRACT(DAY FROM R.rental_date)::smallint
FROM rental R;