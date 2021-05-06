CREATE OR REPLACE PROCEDURE insertar_nuevo_empleado(
	_first_name varchar(45),
	_last_name varchar(45),
	_address_id smallint,
	_email varchar(50),
	_store_id smallint,
	_username varchar(16),
	_password varchar(40)
	--_picture
)
AS
$$
BEGIN
	INSERT INTO staff(first_name,last_name,address_id,email,store_id,active,username,password,last_update)
	VALUES(_first_name,_last_name,_address_id,_email,_store_id,TRUE,_username,_password,CURRENT_TIMESTAMP);
END;
$$ LANGUAGE plpgsql
GRANT EXECUTE ON PROCEDURE insertar_nuevo_empleado TO ADMIN;
CALL insertar_nuevo_empleado('Fernando','Alvarez',1::smallint,'correosdecostarrica@correosdecostarrica.com',1::smallint,'nando','123QWE');

SELECT * FROM staff
