--	Hacer un cubo por año y categoría de película para el número de alquileres y el monto cobrado

CREATE OR REPLACE FUNCTION rent_gain_per_year_category()
RETURNS TABLE (year smallint,category VARCHAR,rental_count BIGINT, amount_sold NUMERIC(5,2))
AS 
$$
BEGIN
    RETURN QUERY
        SELECT D.year, M.category, SUM(RS.rental_count) as rental_count, SUM(RS.amount_sold) as amount_sold
        FROM rental_stats RS
        INNER JOIN Date D ON D.date_id = RS.date_id
        INNER JOIN Movie M ON M.movie_id = RS.movie_id
        GROUP BY CUBE (D.year, M.category)
        ORDER BY D.year, M.category;
END;
$$ LANGUAGE plpgsql

select * from rent_gain_per_year_category();