CREATE TABLE Movie
(
    movie_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(100),


    CONSTRAINT FK_Movie_Film
    FOREIGN KEY (movie_id)
    REFERENCES Film(film_id)
);