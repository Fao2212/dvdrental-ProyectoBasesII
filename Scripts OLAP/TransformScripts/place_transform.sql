INSERT INTO place (country, city, district, store_id)
SELECT CO.country AS country,
       CI.city AS city,
       A.district AS district,
       S.store_id AS store_id
FROM store S, 
     country CO, 
     city CI, 
     address A
WHERE A.address_id = S.address_id and 
      A.city_id = CI.city_id and 
      CO.country_id = CI.country_id;


