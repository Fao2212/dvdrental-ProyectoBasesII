CREATE TABLE tmp_payments
(
    payment_id integer,
    customer_id smallint,
    staff_id smallint,
    rental_id integer,
    amount NUMERIC(5,2),
    payment_date timestamp
);

WITH payments_added_up AS
(
    SELECT payment_id, 
       SUM(amount) AS paid_amount
    FROM payment
    GROUP BY rental_id, payment_id
)
select * from payments_added_up;
INSERT INTO tmp_payments
SELECT p.payment_id,
       p.customer_id,
       p.staff_id,
       PAU.rental_id,
       PAU.paid_amount,
       p.payment_date
FROM payments_added_up PAU
INNER JOIN payment P ON P.rental_id = PAU.rental_id
WHERE EXISTS (SELECT 1 
              FROM payments_added_up pu
              WHERE pu.rental_id = PUA.rental_id

