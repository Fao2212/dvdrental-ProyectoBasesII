INSERT INTO date (d_year,d_month,d_day)
SELECT DISTINCT EXTRACT(YEAR FROM R.rental_date) AS d_year,EXTRACT(MONTH FROM R.rental_date) AS d_month,EXTRACT(DAY FROM R.rental_date)
FROM rental R