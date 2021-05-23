CREATE OR REPLACE PROCEDURE registrar_alquiler(
	_inventory_id integer,
	_customer_id smallint,
	_staff_id smallint
)
AS
$$
BEGIN--Se deja la fecha de retorno nula? Se usa usa un trigger?
	INSERT INTO rental(rental_date,inventory_id,customer_id,staff_id,last_update)
	VALUES (CURRENT_TIMESTAMP,_inventory_id,_customer_id,_staff_id,CURRENT_TIMESTAMP);
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER

GRANT EXECUTE ON PROCEDURE registrar_alquiler TO EMP;

call registrar_alquiler(2,2::smallint,2::smallint);

select * from rental --Hay muchas rentals esta ultima es la 16051
WHERE inventory_id = 2 and customer_id = 2