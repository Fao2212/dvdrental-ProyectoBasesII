CREATE OR REPLACE PROCEDURE insertar_nueva_pelicula(
	_title varchar(255),
	_description text,
	_release_year int,
	_language_id smallint,
	_rental_duration smallint,
	_rental_rate numeric(4,2),
	_length smallint,
	_replacement_cost numeric(5,2),
	_rating mpaa_rating,
	_special_features text[],
	_fulltext tsvector,
	_store_id smallint
)
AS
$$
DECLARE
	returned_id int;
BEGIN
	--Insercion en peliculas
	INSERT INTO film (title,description,release_year,language_id,rental_duration,rental_rate,length,replacement_cost,rating,last_update,special_features,fulltext)
	VALUES (_title,_description,_release_year,_language_id,_rental_duration,_rental_rate,_length,_replacement_cost,_rating,CURRENT_TIMESTAMP,_special_features,fulltext) 
	RETURNING film_id INTO returned_id;
	--Insercion en inventario
	INSERT INTO inventory(film_id,store_id,last_update)
	VALUES (returned_id,_store_id,CURRENT_TIMESTAMP);
END;
$$ LANGUAGE plpgsql

--Prueba pendiente investigar los diferentes tipos de datos

select * from film
select * from inventory