CREATE DATABASE dvdrental;

--Carga en un cmd desde la carpeta donde se instalo el postgres
--pg_restore -U postgres -d dvdrental D:\Desktop\dvdrental.tar
--(Se creara un nuevo schema para las tablas?)
--Para heroku el cargar la base es diferente

REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON DATABASE dvdrental FROM PUBLIC;

CREATE ROLE EMP;
GRANT CONNECT ON DATABASE dvdrental TO EMP; 
GRANT USAGE ON SCHEMA public TO EMP;
--No se va a usar
GRANT INSERT ON TABLE customer TO EMP;
GRANT SELECT ON TABLE film TO EMP;
GRANT Insert ON TABLE rental TO EMP;
GRANT USAGE, SELECT ON SEQUENCE customer_customer_id_seq TO EMP;
GRANT USAGE, SELECT ON SEQUENCE rental_rental_id_seq TO EMP;
GRANT USAGE, SELECT ON SEQUENCE payment_payment_id_seq TO EMP;
------------------------------------------------------------

CREATE ROLE ADMIN;
GRANT CONNECT ON DATABASE dvdrental TO ADMIN;
GRANT USAGE ON SCHEMA public TO ADMIN;
--No se va a usar
GRANT INSERT ON TABLE film TO ADMIN;
GRANT INSERT ON TABLE inventory TO ADMIN;
GRANT USAGE, SELECT ON SEQUENCE film_film_id_seq TO ADMIN;
GRANT USAGE, SELECT ON SEQUENCE inventory_inventory_id_seq TO ADMIN;
------------------------------------------------------------

CREATE USER video;
GRANT USAGE ON SCHEMA public TO video;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO video;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO video;

set session role video;
select * from current_user;

CREATE USER empleado1 WITH PASSWORD 'emp123';
GRANT EMP to empleado1;

CREATE USER administrador1 WITH PASSWORD 'adm123';
GRANT EMP to administrador1;
GRANT ADMIN to administrador1;
