-- •	dar el número de alquileres y el monto cobrado, por duración del préstamo

CREATE OR REPLACE FUNCTION rent_stats_by_duration (IN p_days INT) 
RETURNS TABLE (days smallint, rent_count INT, amount_charged NUMERIC(5,2))
LANGUAGE plpgsql    
AS $$
BEGIN
    RETURN QUERY
        SELECT D.day_count, SUM(RS.rental_count)::INT, SUM(RS.amount_sold)
        FROM rental_stats RS
        INNER JOIN duration D ON D.duration_id = RS.duration_id
        WHERE D.day_count = p_days::smallint
        GROUP BY D.day_count;
END;$$

CREATE INDEX idx_rentalstats_duration ON rental_stats(duration_id);
CREATE INDEX idx_day_count ON duration(day_count);