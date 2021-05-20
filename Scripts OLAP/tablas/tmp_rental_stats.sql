CREATE TABLE tmp_rental_stats
(
    movie_id INT NOT NULL,
    place_id INT NOT NULL,
    date_id INT NOT NULL,
    language_id INT NOT NULL,
    duration_id INT NOT NULL,
    rental_count INT NOT NULL,
    rental_cost NUMERIC(5,2) NOT NULL
);