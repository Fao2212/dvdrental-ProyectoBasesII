-- Hacer un rollup por año y mes para el monto cobrado por alquileres

CREATE OR REPLACE FUNCTION rent_gain_per_month_year()
RETURNS TABLE (year smallint,month smallint,amount_sold NUMERIC(5,2))
AS 
$$
BEGIN
    RETURN QUERY
        SELECT D.year,D.month, SUM(RS.amount_sold)
        FROM rental_stats RS
        INNER JOIN Date D ON D.date_id = RS.date_id
        GROUP BY ROLLUP(D.year,D.month)
        ORDER BY D.year, D.month;
END;
$$ LANGUAGE plpgsql

select * from rent_gain_per_month_year();