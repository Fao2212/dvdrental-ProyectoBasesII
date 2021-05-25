INSERT INTO Movie (movie_id, name, category)
SELECT F.film_id, 
       F.title, 
       C.name
FROM film F
INNER JOIN film_category FC ON F.film_id = FC.film_id
INNER JOIN category C ON C.category_id = FC.category_id
ORDER BY C.name;
