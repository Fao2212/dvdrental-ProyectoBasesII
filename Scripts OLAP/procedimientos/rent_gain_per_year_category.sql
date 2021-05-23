CREATE OR REPLACE FUNCTION rent_gain_per_year_category()
RETURNS TABLE (year smallint,category VARCHAR,rental_count BIGINT,amount_sold NUMERIC(5,2))
--Es necesario verificar los tipos ademas de poner los datos correctos para los join
AS 
$$
BEGIN
    RETURN QUERY
        SELECT D.year,M.category,COUNT(L.rental_count),SUM(L.amount_sold)
        FROM rental_stats L
        INNER JOIN Date D ON D.date_id = L.date_id
        INNER JOIN Movie M ON M.movie_id = L.movie_id
        GROUP BY ROLLUP(D.year,M.category);
END;
$$ LANGUAGE plpgsql

select * from rent_gain_per_year_category();