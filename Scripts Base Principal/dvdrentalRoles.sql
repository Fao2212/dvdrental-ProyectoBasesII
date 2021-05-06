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

CREATE ROLE ADMIN;
GRANT CONNECT ON DATABASE dvdrental TO ADMIN;
GRANT USAGE ON SCHEMA public TO ADMIN;

CREATE USER video WITH PASSWORD 'vid123';
GRANT CONNECT ON DATABASE dvdrental TO video;
GRANT USAGE ON SCHEMA public TO video;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO video;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO video;

CREATE USER empleado1 WITH PASSWORD 'emp123';
GRANT EMP to empleado1;

CREATE USER administrador1 WITH PASSWORD 'adm123';
GRANT EMP to administrador1;
GRANT ADMIN to administrador1;
