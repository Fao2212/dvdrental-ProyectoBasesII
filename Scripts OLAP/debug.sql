-- Debugging procedures

-- Para reiniciar id serial
ALTER SEQUENCE <tablename>_<id>_seq RESTART WITH 1;

select R.rental_id, 
       R.rental_date, 
       R.return_date, 
       DATE_PART('day', R.return_date - R.rental_date)::smallint as days,
       DATE_PART('hour', R.return_date - R.rental_date)::smallint as hours,
       DATE_PART('minute', R.return_date - R.rental_date)::smallint as minutes,
       F.title
from rental R
join inventory I on I.inventory_id = R.inventory_id
join film F on F.film_id = I.film_id
fetch first 20 rows only;

-- Traer primeras 10 peliculas
select * 
from film
fetch first 10 rows only;

-- Casos específicos con la primera película en film
select *
from inventory
where film_id = 133;

select * 
from rental
where inventory_id = 612;

-- Contar la cantidad de alquileres que no han sido devueltos

select count(*)
from rental 
where return_date IS NULL; -- 183 son nulos

-- Cantidad de alquileres realizados
select count(*)
from rental; -- 16044

-- Hay 15861 alquileres cuya película tiene fecha de devolución 
-- En la tabla de estadísticas de los alquileres se guarda esa cantidad cuando
-- se toma en cuenta esto en la cláusula del WHERE
-- DATE_PART('day', R.return_date - R.rental_date)::smallint = DU.day_count;

-- Seleccionar los registros donde se alquiló dos o más veces la misma película en un día
with date_title as
(
    select R.rental_date, F.title
    from rental R
    join inventory I on I.inventory_id = R.inventory_id
    join film F on F.film_id = I.film_id
)
select rental_date, count(rental_date) as rental_date_count, title, count(title) as title_count
from date_title
GROUP by rental_date, title
HAVING count(rental_date) > 1 OR count(title) > 1;


with tmp as (select * from rental where return_date is not null order by rental_id) select t.rental_id, t.rental_date, t.return_date, p.amount, p.payment_date, f.rental_duration, f.rental_rate from tmp t join payment p on p.rental_id = t.rental_id join inventory i on i.inventory_id = t.inventory_id join film f on f.film_id = i.film_id fetch first 50 rows only;
