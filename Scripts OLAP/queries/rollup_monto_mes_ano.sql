CREATE OR REPLACE FUNCTION rollup_monto_mes_ano()
RETURNS TABLE (year smallint,month smallint,amount_sold NUMERIC(5,2))
--Es necesario verificar los tipos ademas de poner los datos correctos para los join
AS 
$$
BEGIN
    RETURN QUERY
        SELECT D.year,D.month,SUM(L.amount_sold)
        FROM Loan L
        INNER JOIN Date D ON D.date_id = L.date_id
        GROUP BY ROLLUP(D.year,D.month);
END;
$$ LANGUAGE plpgsql

select * from rollup_monto_mes_ano();
