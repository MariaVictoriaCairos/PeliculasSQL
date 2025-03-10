-- Ejercicios resueltos por: María Victoria Cairós González
-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
--
SELECT  i."title" AS pelicula, 
        i."rating" AS clasificacion
FROM FILM AS i 
WHERE i."rating" = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

SELECT  concat(a."first_name", ' ', a."last_name") AS Nombre, 
        a."actor_id"
FROM actor AS a
WHERE a."actor_id" BETWEEN '30' AND '40';

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
-- Resultado: no existen coincidencias del idioma con el idioma original.

SELECT  f."title", 
        f."language_id", 
        f."original_language_id"
FROM film AS f
WHERE f."language_id" = f."original_language_id";

-- 5. Ordena las películas por duración de forma ascendente.

SELECT f."title", f."length"
FROM film AS f
ORDER BY f."length" ASC; 

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

SELECT concat(a."first_name", ' ', a."last_name") AS Nombre
FROM actor AS a
WHERE a."last_name" ILIKE '%allen%';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
--    “film” y muestra la clasificación junto con el recuento.

SELECT  c."name" AS Categoria, 
        COUNT(FC."category_id") as Pelicula_Por_Categoria
FROM film_category AS FC
INNER JOIN category AS c
ON fc."category_id" = c."category_id"
GROUP BY c."name";

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
-- duración mayor a 3 horas en la tabla film.
SELECT  i."title" AS Pelicula, 
        i."rating" AS clasificacion, 
        i."length" AS Tiempo_Min
FROM FILM AS i 
WHERE i."rating" = 'PG-13' AND i."length"> '180';

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT VARIANCE(replacement_cost) AS Varianza
FROM film;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT MAX(length) AS Mayor_duracion_pelicula
FROM film;

SELECT MIN(length) AS Menor_duracion_pelicula
FROM film;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT  "payment_date" AS fecha_antepenultimo,
        "amount" AS alquiler
FROM payment
ORDER BY "payment_date" ASC  
LIMIT 1
OFFSET 2;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’
--     ni ‘G’ en cuanto a su clasificación.

SELECT  i."title" AS Pelicula, 
        i."rating" AS Clasificacion
FROM FILM AS i 
WHERE i."rating" NOT IN ('NC-17', 'G');

-- 13. Encuentra el promedio de duración de las películas para cada
-- clasificación de la tabla film y muestra la clasificación junto con el
-- promedio de duración.
SELECT  i."rating" AS Clasificacion_Pelicula, 
        Round(AVG(i."length"),2) AS Tiempo_promedio_Min
FROM FILM AS i
GROUP BY i."rating";

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT  i."title" AS Pelicula, 
        i."length" AS Tiempo_Min
FROM FILM AS i 
WHERE  i."length"> '180';

-- 15. ¿Cuánto dinero ha generado en total la empresa?

SELECT sum(payment_id) AS Ingresos_Totales
FROM payment; 

-- 16. Muestra los 10 clientes con mayor valor de id.
SELECT concat(c."first_name", ' ', c."last_name") AS Cliente,
        c."customer_id"
FROM customer AS c
ORDER BY c."customer_id" DESC 
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la
-- película con título ‘Egg Igby’

SELECT f."title" AS pelicula,
        concat(a."first_name", ' ', a."last_name") AS actores
FROM film AS f
INNER JOIN film_actor AS FA
ON f."film_id"=fa."film_id"
INNER JOIN actor AS a
ON a."actor_id" = fa."actor_id"
WHERE f."title" ILIKE '%Egg Igby%';

-- 18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT a."title"
FROM film AS a
ORDER BY a."title";

-- 19. Encuentra el título de las películas que son comedias y tienen una
-- duración mayor a 180 minutos en la tabla “film”. 
SELECT f."title" AS pelicula,
       f."length" AS tiempo_min
FROM film AS f
INNER JOIN film_category AS fc
ON f."film_id"= fc."film_id"
WHERE fc."category_id"=5 AND f."length">180; -- Comedia tiene ID=5

-- 20. Encuentra las categorías de películas que tienen un promedio de
-- duración superior a 110 minutos y muestra el nombre de la categoría
-- junto con el promedio de duración.

SELECT c."name" AS categoria,
    round(AVG(f."length"),2) AS Promedio_duracion
FROM film AS f 
INNER JOIN film_category AS fc 
ON f."film_id"= fc."film_id"
INNER JOIN category AS c
ON fc."category_id"= c."category_id"
GROUP BY c."category_id"
HAVING  round(AVG(f."length"),2)>110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT  avg(r."return_date" - r."rental_date") AS Duracion_Promedio_Alquiler
FROM RENTAL AS R; 

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT concat(a."first_name", ' ', a."last_name")
FROM ACTOR AS A; 

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT  r."rental_date",
        count(r."rental_date") AS Alquileres_por_dia
FROM RENTAL AS R 
GROUP BY r."rental_date"
ORDER BY Alquileres_por_dia DESC; 

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT 
    f."title" AS pelicula, 
    f."length" AS duracion
FROM FILM AS f
WHERE f."length" > (SELECT AVG(f2."length") FROM FILM AS f2); -- el promedio es 115,272

-- 25. Averigua el número de alquileres registrados por mes.
SELECT  date_part('MONTH',r."rental_date") AS mes,
        count(r."rental_date") AS N_alquileres_mes
FROM rental AS R
GROUP BY mes 
ORDER BY mes;

-- 26. Encuentra el promedio, la desviación estándar y varianza del tota pagado.
SELECT  ROUND(AVG(p."amount"),2) AS promedio_total_pagado,
        ROUND(STDDEV(p."amount"),2) AS desviacion_estandar,
        ROUND(VARIANCE(p."amount"),2) AS varianza
FROM PAYMENT AS p;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
    

 WITH avg_alquiler AS (
    SELECT AVG("amount") AS promedio FROM payment  -- 4,20 es el promedio de alquiler de peliculas
)
SELECT 
    f."title" AS Pelicula,
    p."amount" AS Alquiler
FROM payment AS p
INNER JOIN rental AS r ON p."rental_id" = r."rental_id"
INNER JOIN inventory AS i ON r."inventory_id" = i."inventory_id"
INNER JOIN film AS f ON i."film_id" = f."film_id"
WHERE p."amount" > (SELECT promedio FROM avg_alquiler);   


-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

WITH actores_peliculas AS (
    SELECT 
        f."actor_id",
        COUNT(f."film_id") AS Numero_peliculas
    FROM film_actor AS f
    GROUP BY f."actor_id"
    HAVING COUNT(f."film_id") > 40
)
SELECT 
    CONCAT(a."first_name", ' ', a."last_name") AS nombre_completo,
    ap.Numero_peliculas
FROM actores_peliculas AS ap
INNER JOIN actor AS a ON ap."actor_id" = a."actor_id";


-- 29. Obtener todas las películas y, si están disponibles en el inventario mostrar la cantidad disponible.
WITH cuenta AS (
    SELECT COUNT(i."inventory_id") AS cantidad_inv,
            i."film_id"
    FROM inventory AS i
    GROUP BY i."film_id"
)
SELECT f."title" AS pelicula,
        i."cantidad_inv" AS Inventario
FROM film AS f
LEFT JOIN cuenta AS i
ON f."film_id" = i."film_id";

-- 30. Obtener los actores y el número de películas en las que ha actuado.
WITH cuenta AS (
    SELECT  COUNT(fa."film_id") AS Cantidad_peliculas,
            fa."actor_id"
    FROM FILM_ACTOR AS fa 
    GROUP BY fa."actor_id"
)
SELECT  concat(a."first_name", ' ', a."last_name"),
        c."cantidad_peliculas"
FROM ACTOR AS A 
LEFT JOIN cuenta AS c
ON a."actor_id" = c."actor_id";

-- 31. Obtener todas las películas y mostrar los actores que han actuado en
-- ellas, incluso si algunas películas no tienen actores asociados.

SELECT  f."title" AS pelicula,
       COALESCE(STRING_AGG(a."first_name" || ' ' || a."last_name", ', '), 'Sin actores') AS actores     -- esto es para que NO se repita peliculas
FROM film AS f                                                                                          -- une todos los actores en una misma fila
LEFT JOIN film_actor AS fa
ON f."film_id" =fa."film_id"
LEFT JOIN ACTOR AS A 
ON fa."actor_id"= a."actor_id"
GROUP BY f."film_id", f."title"
ORDER BY pelicula;

-- 32. Obtener todos los actores y mostrar las películas en las que han
-- actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT  concat(a."first_name", ' ',a."last_name") AS actor,
       COALESCE(STRING_AGG(f."title", ', '), 'Sin peliculas') AS peliculas     -- esto es para que NO se repita los actores
FROM film AS f                                                                            -- une todos las peliculas en una misma fila
RIGHT JOIN film_actor AS fa
ON f."film_id" =fa."film_id"
RIGHT JOIN ACTOR AS A 
ON fa."actor_id"= a."actor_id"
GROUP BY a."actor_id"
ORDER BY actor;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT  f."title" AS pelicula, 
        r."rental_id" AS id_alquiler
FROM film AS f                                                                                          
LEFT JOIN inventory AS i
ON f."film_id" = i."film_id"
LEFT JOIN rental AS r 
ON i."inventory_id"= r."inventory_id"
ORDER BY f."title";

-- Otra forma para que no se repitan las películas

SELECT  f."title" AS pelicula, 
        COALESCE(STRING_AGG(r."rental_id"::text, ', '), 'Sin alquilar') AS ID_alquileres
FROM film AS f                                                                                          
LEFT JOIN inventory AS i
ON f."film_id" = i."film_id"
LEFT JOIN rental AS r 
ON i."inventory_id"= r."inventory_id"
GROUP BY f."film_id", f."title"
ORDER BY f."title";

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
WITH dinero_cliente AS (
    SELECT  sum(p."amount") AS gastado,
            c."customer_id" AS  cliente
    FROM customer AS c 
    INNER JOIN rental r
    ON c."customer_id" = r."customer_id"
    INNER JOIN payment AS p
    ON r."rental_id"=p."rental_id"
    GROUP BY c."customer_id"
)
SELECT  concat(c."first_name", ' ', c."last_name"),
        d."gastado" AS total_gastado
FROM customer AS c 
LEFT JOIN dinero_cliente AS d
ON c."customer_id" = d."cliente"
ORDER BY d."gastado" DESC 
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es ' Johnny'.
SELECT 
FROM ACTOR AS A 
WHERE a."first_name" ILIKE ' Johnny';  -- indica que NO hay

SELECT DISTINCT "first_name" -- esto es para verificar que realmente NO hay ' Johnny'. si hay 1, pero está en mayuscula y sin espacio
FROM actor AS a
WHERE a."first_name" = 'JOHNNY';

SELECT 
FROM ACTOR AS A 
WHERE LOWER(a."first_name")= 'Johnny';

SELECT  -- esta es la consulta FINAL con un mensaje indicando si NO se encuentra
    COALESCE(
        (SELECT STRING_AGG(a."first_name" || ' ' || a."last_name", ', ') 
         FROM actor AS a
         WHERE a."first_name" ILIKE ' Johnny'),
        'No se encontraron actores con el nombre Johnny'
    ) AS resultado;


-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido. 
SELECT  a."first_name" AS Nombre,
        a."last_name" AS Apellido 
FROM actor AS a;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT  MIN(a.actor_id) AS Actor_ID_mas_bajo   -- el min es 1
FROM actor AS a;

SELECT  MAX(a.actor_id) AS Actor_ID_mas_Alto   -- el maximo es 200
FROM actor AS a;

--38. Cuenta cuántos actores hay en la tabla “actor”
SELECT  COUNT(a.actor_id) AS Cantidad_actores   -- la cantidad de actores son 200
FROM actor AS a;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT  a."first_name" AS Nombre,
        a."last_name" AS Apellido 
FROM actor AS a
ORDER BY apellido ASC;

-- 40. Selecciona las primeras 5 películas de la tabla “film”
SELECT f."title" AS pelicula
FROM film AS f
ORDER BY f."film_id" ASC 
LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
-- mismo nombre. ¿Cuál es el nombre más repetido?

SELECT  a."first_name" AS Nombre,
        COUNT(a."first_name") AS Cantidad_Nombre
FROM actor AS a
GROUP BY a."first_name"
ORDER BY Cantidad_Nombre DESC;     -- los nombre que mas se repiten 3 veces son KENNETH, PENELOPE, JULIA


-- SQL para conseguir los nombres mas repetidos  con una vista y despues se presenta la consulta de los más repetidos
WITH mas_repetido AS (
    SELECT  a."first_name",         -- busca la cantidad de repetidos mas alta de la tabla
            COUNT(a."first_name") AS Cantidad_Nombre
    FROM actor AS a
    GROUP BY a."first_name"
    ORDER BY Cantidad_Nombre DESC
    LIMIT 1
)
SELECT  a."first_name" AS Nombre,           -- lista los nombre más repetidos
        COUNT(a."first_name") AS Cantidad
FROM actor AS a
GROUP BY a."first_name"
HAVING  COUNT(a."first_name") = (SELECT Cantidad_Nombre FROM mas_repetido);

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT r."rental_id" AS num_alquiler,
        c."first_name"
FROM rental AS r
INNER JOIN customer AS c
ON r."customer_id" = c."customer_id";

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT concat(c."first_name", ' ', c.last_name) AS Nombre,
        COALESCE(STRING_AGG(r."rental_id"::text, ', '), 'Sin alquiler') AS alquileres  -- para NO repetir filas con el mismo cliente
FROM CUSTOMER AS C 
LEFT JOIN RENTAL AS R 
ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id";

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT f."title" AS pelicula,
        c."name" AS categoria
FROM FILM AS F 
CROSS JOIN CATEGORY AS C; 

-- no aporta valor porque lista todas las peliculas combinadas con todas la categorias sin relación alguna.

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
WITH Comedy AS (
    SELECT  F."film_id" AS Pelicula_id,         -- Busca las peliculas con categoria Comedy
            f."title" AS pelicula
    FROM FILM AS F 
    INNER JOIN FILM_CATEGORY AS FC 
    ON fc."film_id" = f."film_id"
    INNER JOIN CATEGORY AS c 
    ON fc."category_id"=c."category_id"
    WHERE c."name"='Comedy'
)
SELECT concat(a."first_name", ' ', a."last_name") AS actor,
        c."pelicula"
FROM actor AS a
INNER JOIN FILM_ACTOR AS FA 
ON a."actor_id"= fa."actor_id"
INNER JOIN Comedy AS C
ON fa."film_id"= c."pelicula_id";

-- 46. Encuentra todos los actores que no han participado en películas.

SELECT  a."actor_id", 
        concat(a."first_name", ' ', a."last_name") AS actor
FROM actor AS a
LEFT JOIN film_actor AS fa 
ON a."actor_id" = fa."actor_id"
WHERE fa."film_id" IS NULL;                 -- todos los actores han particcipado en al menos una pelicula


-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT  a."actor_id",
        CONCAT(a."first_name", ' ', a."last_name") AS actor,
        COUNT(fa."film_id") AS cantidad_peliculas
FROM actor AS a
LEFT JOIN film_actor AS fa ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id"
ORDER BY cantidad_peliculas DESC, actor;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
-- de los actores y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS
SELECT  a."actor_id",
        CONCAT(a."first_name", ' ', a."last_name") AS actor,
        COUNT(fa."film_id") AS cantidad_peliculas
FROM actor AS a
LEFT JOIN film_actor AS fa ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id";

--49. Calcula el número total de alquileres realizados por cada cliente.

SELECT  c."customer_id" AS ID_cliente,
        concat(c."first_name", ' ', c."last_name") AS Cliente,
        COUNT(r."rental_id") AS Num_alquileres
FROM CUSTOMER AS c 
INNER JOIN RENTAL AS R 
ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name";

-- 50. Calcula la duración total de las películas en la categoría 'Action'

SELECT COUNT(f."length") AS Duracion_Total_minutos
FROM film AS f
INNER JOIN FILM_CATEGORY AS FC 
ON f."film_id" = fc."film_id"
INNER JOIN CATEGORY AS c 
ON fc."category_id"= c."category_id"
WHERE c."name" = 'Action';                         -- total 64 min

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

CREATE TEMP TABLE cliente_rentas_temporal (                                     -- se crea la tabla
    customer_id INT PRIMARY KEY,
    name TEXT,
    total_rental INT
);

INSERT INTO cliente_rentas_temporal (customer_id,name, total_rental)            --se insertan los valores
SELECT  c."customer_id",
        concat(c."first_name", ' ', c.last_name) AS name,
        COUNT(r."rental_id") AS total_rental  
FROM CUSTOMER AS C 
LEFT JOIN RENTAL AS R 
ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id";

SELECT *                                                                        -- se consultan los valores, es correcto el resultado
FROM cliente_rentas_temporal;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
-- películas que han sido alquiladas al menos 10 veces.

CREATE TEMP TABLE peliculas_alquiladas_temporal (                                     -- se crea la tabla
    film_id INT PRIMARY KEY,
    Title TEXT,
    total_rental INT
);

INSERT INTO peliculas_alquiladas_temporal (film_id, Title, total_rental)              -- se insertan los valores
SELECT 
    f."film_id",
    f."title" AS title,
    COUNT(r."rental_id") AS total_rental
FROM film AS f
INNER JOIN inventory AS i 
ON f."film_id" = i."film_id"
INNER JOIN rental AS r 
ON i."inventory_id" = r."inventory_id"
GROUP BY f."film_id", f."title"
HAVING COUNT(r."rental_id") >= 10;


SELECT *                                                                        -- se consultan los valores, es correcto el resultado
FROM peliculas_alquiladas_temporal;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente
-- con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
-- los resultados alfabéticamente por título de película.

WITH No_devuelto AS (
        SELECT  r."rental_id", 
                r."inventory_id",
                concat(c."first_name", ' ', last_name) AS Nombre
        FROM rental AS r
        INNER JOIN CUSTOMER AS C
        ON r."customer_id"=c."customer_id"
        WHERE r."return_date" IS NULL 
        AND concat(c."first_name", ' ', last_name) ILIKE 'tammy sanders'
)
SELECT f."title" AS Pelicula
FROM No_devuelto AS nd
INNER JOIN inventory i 
ON nd."inventory_id" = i."inventory_id"
INNER JOIN film f 
ON i."film_id" = f."film_id"
ORDER BY f."title";

-- 54. Encuentra los nombres de los actores que han actuado en al menos una
-- película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
-- alfabéticamente por apellido.

WITH PeliculasSci AS(
     SELECT     
            f."film_id",
            f."title" AS Pelicula,
            c."name" AS categoria
     FROM film AS f
     INNER JOIN FILM_CATEGORY AS FC 
     ON f."film_id"= FC."film_id"
     INNER JOIN CATEGORY AS C 
     ON FC."category_id"= C."category_id"
     WHERE c."name" = 'Sci-Fi'
)
SELECT  
        a."last_name" AS Apellido,
        a."first_name" AS Nombre,
        p."pelicula"     
FROM actor AS a
INNER JOIN FILM_ACTOR AS FA 
ON a."actor_id"=FA."actor_id"
INNER JOIN PeliculasSci AS p
ON FA."film_id" = p."film_id"
ORDER BY a."last_name";

-- 55. Encuentra el nombre y apellido de los actores que han actuado en
-- películas que se alquilaron después de que la película ‘Spartacus
-- Cheaper’ se alquilara por primera vez. Ordena los resultados
-- alfabéticamente por apellido.

WITH Fecha_Primera_Pelicula AS (                    -- Fecha del primer alquiler
    SELECT MIN(r."rental_date") AS PrimeraFecha
    FROM film AS f 
    INNER JOIN inventory AS i
    ON f."film_id"= i."film_id"
    INNER JOIN rental AS r
    ON r."inventory_id" = i."inventory_id" 
    WHERE f."title"=  'SUIT WALLS'                      -- No existen la pelucula 'SPARTACUS CHEAPER'
),                                                      -- se comprueba que funciona con la pelicula 'SUIT WALLS'
    Peliculas_mayores AS (            -- peliculas alquiladas despues del primer alquiler
    SELECT f."film_id",
           f."title" AS pelicula, 
           r."rental_date" AS PrimeraFecha
    FROM film AS f
    INNER JOIN inventory AS i
    ON f."film_id"= i."film_id"
    INNER JOIN rental AS r
    ON r."inventory_id" = i."inventory_id"
    WHERE r."rental_date" > (SELECT PrimeraFecha FROM Fecha_Primera_Pelicula)
)
SELECT  
        a."last_name" AS Apellido,
        a."first_name" AS Nombre,
        p."pelicula"     
FROM actor AS a
INNER JOIN film_actor AS fa 
ON a."actor_id"=fa."actor_id"
INNER JOIN Peliculas_mayores AS p
ON FA."film_id" = p."film_id"
ORDER BY a."last_name";

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en
-- ninguna película de la categoría ‘Music’.

WITH PeliculasMusic AS(
     SELECT     
            f."film_id",
            f."title" AS Pelicula,
            c."name" AS categoria
     FROM film AS f
     INNER JOIN FILM_CATEGORY AS FC 
     ON f."film_id"= FC."film_id"
     INNER JOIN CATEGORY AS C 
     ON FC."category_id"= C."category_id"
     WHERE c."name" = 'Music'
)
SELECT  DISTINCT                                            -- el distinc se coloca para que salga una sola vez el autor
        a."last_name" AS Apellido,
        a."first_name" AS Nombre   
FROM actor AS a
INNER JOIN film_actor AS fa 
ON a."actor_id"=FA."actor_id"
WHERE fa."film_id" NOT IN (SELECT film_id FROM PeliculasMusic )
ORDER BY a."last_name"; 

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
WITH AlquileresPeliculas AS (                    -- se calcula el numero de veces que se alquila una película
    SELECT 
            f."film_id",
            f."title",
            count(r."rental_date") AS alquileres
    FROM film AS f 
    INNER JOIN inventory AS i
    ON f."film_id"= i."film_id"
    INNER JOIN rental AS r
    ON r."inventory_id" = i."inventory_id" 
    GROUP BY f.film_id                      
)                                               -- peliculas alquiladas m AS de 8 veces
SELECT DISTINCT 
    a."film_id",
    a."title" AS pelicula
FROM AlquileresPeliculas AS a
WHERE a."alquileres" > 8
ORDER BY a."title";

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’
SELECT     
        f."film_id",
        f."title" AS Pelicula,
        c."name" AS categoria
 FROM film AS f
 INNER JOIN FILM_CATEGORY AS FC 
 ON f."film_id"= FC."film_id"
 INNER JOIN CATEGORY AS C 
 ON FC."category_id"= C."category_id"
 WHERE c."name" = 'Animation';
 
-- Encuentra los nombres de las películas que tienen la misma duración
-- que la película con el título ‘Dancing Fever’. Ordena los resultados
-- alfabéticamente por título de película.
 
 WITH duracion AS (
     SELECT f."length" AS tiempo
     FROM film AS f 
     WHERE f."title" = 'DANCING FEVER'
 )
 SELECT f."title"
 FROM film AS f
 WHERE f."length" = (SELECT tiempo FROM duracion)
 ORDER BY f."title";
 
-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7
-- películas distintas. Ordena los resultados alfabéticamente por apellido.

 WITH AlquileresClientes AS (
    SELECT 
        c."customer_id",
        c."first_name",
        c."last_name",
        COUNT(DISTINCT f."film_id") AS peliculas_alquiladas
    FROM customer AS c
    INNER JOIN rental AS r 
    ON c."customer_id" = r."customer_id"
    INNER JOIN inventory AS i 
    ON r."inventory_id" = i."inventory_id"
    INNER JOIN film AS f 
    ON i."film_id" = f."film_id"
    GROUP BY c."customer_id", c."first_name", c."last_name"
)
SELECT 
    a."first_name" AS Nombre,
    a."last_name" AS Apellido,
    a."peliculas_alquiladas"
FROM AlquileresClientes AS a
WHERE a."peliculas_alquiladas" >= 7
ORDER BY a."last_name";

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y
-- muestra el nombre de la categoría junto con el recuento de alquileres.

WITH alquileres_peliculas AS (                  -- se calcula los alquileres por peliculas
    SELECT  f."film_id",
            COUNT(r."inventory_id") AS alquileres
    from film AS f 
    INNER JOIN inventory AS i 
    ON i."film_id" = f."film_id"
    INNER JOIN rental AS r 
    ON r."inventory_id" = i."inventory_id"
    GROUP BY f."film_id"
)
SELECT c."name" AS categoria,                   -- se calcula el alquiler de las categorias
       COUNT(a."alquileres") AS alquileres
FROM category AS c
INNER  JOIN film_category AS fc
ON c."category_id" = fc."category_id"
INNER JOIN alquileres_peliculas AS a 
ON a."film_id" = fc."film_id"
GROUP BY c."category_id";

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

WITH Estreno_2006 AS (                  -- se buscan las peliculas  estrenadas en el 2006
    SELECT  f."film_id"
    FROM  film AS f 
    WHERE f."release_year" = 2006
)
SELECT c."name" AS categoria,                   -- se calcula el alquiler de las categorias
       COUNT(e."film_id") AS Cantidad_Peliculas
FROM category AS c
INNER  JOIN film_category AS fc
ON c."category_id" = fc."category_id"
INNER JOIN Estreno_2006 AS e
ON e."film_id" = fc."film_id"
GROUP BY c."category_id";

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT s."store_id" AS numero_de_tienda,
        concat(st."first_name", ' ', st."last_name") AS empleado       
FROM store AS s
CROSS JOIN staff AS st
ORDER BY empleado;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
-- muestra el ID del cliente, su nombre y apellido junto con la cantidad de
-- películas alquiladas.

SELECT  c."customer_id" AS id_Cliente,
        concat(c."first_name", ' ', c."last_name"),
        COUNT(r."inventory_id")
FROM customer AS c
INNER JOIN rental AS r
ON c."customer_id"=r."customer_id"
GROUP BY c."customer_id";