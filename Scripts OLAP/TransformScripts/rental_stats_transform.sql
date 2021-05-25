
-- Llenado de datos de la tabla temporal con los datos de la tabla central del modelo estrella
WITH payments_added_up AS
(
    SELECT rental_id,
       SUM(amount) AS total_amount
    FROM payment p
    GROUP BY rental_id
)
INSERT INTO tmp_rental_stats (movie_id, place_id, date_id, language_id, duration_id, rental_count, rental_cost)
SELECT M.movie_id,
       P.place_id,
       D.date_id,
       L.language_id,
       DU.duration_id,
       1 as rental_count,
       CASE WHEN PAU.total_amount IS NOT NULL 
            THEN PAU.total_amount
            ELSE 0
       END
FROM Date D, language L, Duration DU, rental R
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

LEFT JOIN payments_added_up PAU ON PAU.rental_id = R.rental_id

WHERE M.category = C.name AND
      EXTRACT(YEAR FROM R.rental_date)::smallint = D.year AND
      EXTRACT(MONTH FROM R.rental_date)::smallint = D.month AND
      EXTRACT(DAY FROM R.rental_date)::smallint = D.day AND
      F.language_id = L.language_id AND
      CASE WHEN R.return_date IS NOT NULL THEN
                  (EXTRACT(DAY FROM R.return_date - R.rental_date) + 
                  CEILING(EXTRACT(HOURS FROM R.return_date - R.rental_date) / 24))::smallint = DU.day_count
            ELSE 
                  -1 = DU.day_count
      END;


-- Llenado de datos de la tabla central del modelo estrella
INSERT INTO rental_stats
SELECT movie_id,
       place_id,
       date_id,
       language_id,
       duration_id,
       SUM(rental_count) as renatal_count,
       SUM(rental_cost) as amount_sold
FROM tmp_rental_stats
GROUP BY movie_id, place_id, date_id, language_id, duration_id;
