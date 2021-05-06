--Buscado dinamico? No porque solo se trabaja en base? Busqueda solo por titulo
--Quedan pendientes los joins?
--Busqueda contra inventario pendiente
--No se si sera necesario cargar la cantidad de peliculas porque dependeria de en que tienda se este pidiendo
--Y siento que es mas una funcionalidad para el cliente lo cual no nos piden. Porque la progra se centra en 
--El manejo de la base OLAP pero, hay que tomar consideraciones para los datos a analizar en el OLAP por lo que
--Puede llegar a ser necesario. Consultar.
CREATE OR REPLACE FUNCTION buscar_una_pelicula(
	_title VARCHAR(255)
)
RETURNS TABLE (film_id int,title varchar(255),rental_duration smallint)--Verificar la fecha de retorno no es necesario trigger
AS
$$
BEGIN
	RETURN QUERY
		SELECT F.film_id,F.title,F.rental_duration,I. FROM film F
		INNER JOIN inventory I ON F.film_id = I.film_id
		WHERE F.title LIKE '%'||_title||'%';
END;
$$ LANGUAGE plpgsql
GRANT EXECUTE ON FUNCTION buscar_una_pelicula TO EMP;

select * from buscar_una_pelicula('Airport')

select* from film
select * from inventory