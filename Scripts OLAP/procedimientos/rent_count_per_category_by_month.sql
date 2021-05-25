-- Para un mes dado, sin importar el año, dar para cada categoría de película el número de alquileres realizados

CREATE OR REPLACE FUNCTION rent_total_per_category_by_month (IN p_month INT) 
RETURNS TABLE (month INT, category VARCHAR(100), rent_count BIGINT)
LANGUAGE plpgsql    
AS $$
BEGIN
    RETURN QUERY 
        SELECT M.category, COUNT(*)
        FROM rental_stats RS
        INNER JOIN movie M ON M.movie_id = RS.movie_id
        INNER JOIN date D ON D.date_id = RS.date_id
        WHERE D.month = p_month
        GROUP BY M.category
        ORDER BY M.category;
END; $$

-- Indices para la optimización de esta consulta
CREATE INDEX idx_movieid_dateid on rental_stats(movie_id, date_id);
CREATE INDEX idx_date_month on date(month);