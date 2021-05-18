CREATE TABLE tmp_loan
(
    movie_id INT NOT NULL,
    place_id INT NOT NULL,
    date_id INT NOT NULL,
    language_id INT NOT NULL,
    duration_id INT NOT NULL,
    rental_count INT NOT NULL,
    amount_sold NUMERIC(5,2) NOT NULL

    -- CONSTRAINT FK_Movie_Loan
    -- FOREIGN KEY (movie_id)
    -- REFERENCES Movie(movie_id),

    -- CONSTRAINT FK_Place_Loan
    -- FOREIGN KEY (place_id)
    -- REFERENCES Place(place_id),
    
    -- CONSTRAINT FK_Date_Loan
    -- FOREIGN KEY (date_id)
    -- REFERENCES Date(date_id),

    -- CONSTRAINT FK_Language_Loan
    -- FOREIGN KEY (language_id)
    -- REFERENCES Language(language_id),

    -- CONSTRAINT FK_Duration_Loan
    -- FOREIGN KEY (duration_id)
    -- REFERENCES Duration(duration_id)
);