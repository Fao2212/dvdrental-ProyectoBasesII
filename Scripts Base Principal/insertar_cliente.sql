CREATE OR REPLACE PROCEDURE insertar_nuevo_cliente(
	_store_id smallint,
	_first_name varchar(45),
	_last_name varchar(45),
	_email varchar(50),
	_address_id smallint	
) AS
$$
BEGIN 
	INSERT INTO customer(store_id,first_name,last_name,email,address_id,activebool,create_date,last_update,active) 
	VALUES(_store_id,_first_name,_last_name,_email,_address_id,TRUE,current_date,LOCALTIMESTAMP,1);
END;
$$ LANGUAGE plpgsql
GRANT EXECUTE ON PROCEDURE insertar_nuevo_cliente TO EMP;

call insertar_nuevo_cliente(1::smallint,'Fernando','Alvarez','testmail@testmail.com',1::smallint)

select * from customer
select * from address
--Crear adress para cada customer?