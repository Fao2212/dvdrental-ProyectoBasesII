CREATE TABLE Place
(
    place_id SERIAL PRIMARY KEY,
    country VARCHAR(100),
    city VARCHAR(100),
    district VARCHAR(100),
    store_id INT NOT NULL
);
