-- Intersección de todas las dimensiones mostranto los valores (debe crear la tabla test previamente con las columnas esperadas)
INSERT INTO test (category, name, country, city, district, year, month, day, language, day_count, payment)
SELECT M.category,
       M.name,
       P.country,
       P.city,
       P.district,
       D.year,
       D.month,
       D.day,
       L.name,
       DU.day_count,
      (DU.day_count / F.rental_duration) * F.rental_rate as payment

FROM  Date D, language L, Duration DU, rental R
INNER JOIN inventory I ON I.inventory_id = R.inventory_id
INNER JOIN film F ON F.film_id = I.film_id
INNER JOIN film_category FM ON FM.film_id = F.film_id
INNER JOIN category C ON C.category_id = FM.category_id
INNER JOIN movie M ON M.movie_id = F.film_id

INNER JOIN staff SF ON SF.staff_id = R.staff_id
INNER JOIN store ST ON ST.manager_staff_id = SF.staff_id
INNER JOIN address A ON A.address_id = ST.address_id
INNER JOIN city CI ON CI.city_id = A.city_id
INNER JOIN country CO ON CO.country_id = CI.country_id
INNER JOIN place P ON P.store_id = ST.store_id

WHERE M.category = C.name AND
      EXTRACT(YEAR FROM R.rental_date)::smallint = D.year AND
      EXTRACT(MONTH FROM R.rental_date)::smallint = D.month AND
      EXTRACT(DAY FROM R.rental_date)::smallint = D.day AND
      F.language_id = L.language_id AND
      DATE_PART('day', R.return_date - R.rental_date)::smallint = DU.day_count
GROUP BY M.category, M.name, P.country, P.city, P.district, D.year, D.month, D.day, L.name, DU.day_count, payment
ORDER BY M.category;

-- Llenado de datos de la tabla temporal con los datos de la tabla central del modelo estrella
INSERT INTO tmp_loan (movie_id, place_id, date_id, language_id, duration_id, rental_count, amount_sold)
SELECT M.movie_id,
       P.place_id,
       D.date_id,
       L.language_id,
       DU.duration_id,
       1,
       (DU.day_count / F.rental_duration) * F.rental_rate as amount_sold
FROM  Date D, language L, Duration DU, rental R
INNER JOIN inventory I ON I.inventory_id = R.inventory_id
INNER JOIN film F ON F.film_id = I.film_id
INNER JOIN film_category FM ON FM.film_id = F.film_id
INNER JOIN category C ON C.category_id = FM.category_id
INNER JOIN movie M ON M.movie_id = F.film_id

INNER JOIN staff SF ON SF.staff_id = R.staff_id
INNER JOIN store ST ON ST.manager_staff_id = SF.staff_id
INNER JOIN address A ON A.address_id = ST.address_id
INNER JOIN city CI ON CI.city_id = A.city_id
INNER JOIN country CO ON CO.country_id = CI.country_id
INNER JOIN place P ON P.store_id = ST.store_id

WHERE M.category = C.name AND
      EXTRACT(YEAR FROM R.rental_date)::smallint = D.year AND
      EXTRACT(MONTH FROM R.rental_date)::smallint = D.month AND
      EXTRACT(DAY FROM R.rental_date)::smallint = D.day AND
      F.language_id = L.language_id AND
      DATE_PART('day', R.return_date - R.rental_date)::smallint = DU.day_count;

-- Llenado de datos de la tabla central del modelo estrella
INSERT INTO Loan
SELECT movie_id,
       place_id,
       date_id,
       language_id,
       duration_id,
       SUM(rental_count),
       SUM(amount_sold)
FROM tmp_loan
GROUP BY movie_id, place_id, date_id, language_id, duration_id, amount_sold;
