  
CREATE OR REPLACE FUNCTION rent_gain_per_month_year()
RETURNS TABLE (year smallint,month smallint,amount_sold NUMERIC(5,2))
--Es necesario verificar los tipos ademas de poner los datos correctos para los join
AS 
$$
BEGIN
    RETURN QUERY
        SELECT D.year,D.month,SUM(L.amount_sold)
        FROM rental_stats L
        INNER JOIN Date D ON D.date_id = L.date_id
        GROUP BY ROLLUP(D.year,D.month);
END;
$$ LANGUAGE plpgsql

select * from rent_gain_per_month_year();