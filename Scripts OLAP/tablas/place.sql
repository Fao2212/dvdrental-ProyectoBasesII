CREATE TABLE Place
(
    place_id SERIAL PRIMARY KEY,
    store_id INT NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100),
    district VARCHAR(100),

    CONSTRAINT FK_Store_Place
    FOREIGN KEY (store_id)
    REFERENCES Store(store_id)
);