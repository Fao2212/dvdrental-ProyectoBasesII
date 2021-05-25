CREATE OR REPLACE FUNCTION buscar_una_pelicula(
	_title VARCHAR(255)
)
RETURNS TABLE (id int, titulo varchar(255), categoria VARCHAR(255), descripcion TEXT, duracion_alquiler smallint, tarifa_alquiler NUMERIC(5,2), id_tienda smallint, copias_disponibles bigint)
AS
$$
BEGIN
	RETURN QUERY
		SELECT F.film_id, 
			F.title, 
			C.name,
			F.description, 
			F.rental_duration, 
			F.rental_rate, 
			I.store_id,
			COUNT(*)
		FROM film F
		INNER JOIN inventory I ON F.film_id = I.film_id
		INNER JOIN film_category FC ON FC.film_id = F.film_id
		INNER JOIN category C ON C.category_id = FC.category_id
		WHERE F.title LIKE '%'||_title||'%' AND inventory_in_stock(I.inventory_id) = TRUE
		GROUP BY I.store_id, F.film_id, F.title, C.name, F.description, F.rental_duration, F.rental_rate
		ORDER BY F.title;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER

GRANT EXECUTE ON FUNCTION buscar_una_pelicula TO EMP;

-- Ejemplo
select * from buscar_una_pelicula('Airport')
