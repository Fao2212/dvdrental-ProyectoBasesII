CREATE OR REPLACE PROCEDURE registrar_devolucion(
	_customer_id smallint,
	_staff_id smallint,
	_rental_id int,
	_amount numeric(9,2)
)
AS
$$
BEGIN
	INSERT INTO payment(customer_id,staff_id,rental_id,amount,payment_date)
	VALUES(_customer_id,_staff_id,_rental_id,_amount,CURRENT_TIMESTAMP);

	UPDATE rental
	SET return_date = CURRENT_TIMESTAMP,
		last_update = CURRENT_TIMESTAMP
	WHERE rental_id = _rental_id;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;

GRANT EXECUTE ON PROCEDURE registrar_devolucion TO EMP;

call registrar_devolucion(2::smallint,2::smallint,2,9.99);
