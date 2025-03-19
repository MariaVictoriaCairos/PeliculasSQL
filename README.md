# **PeliculasSQL - Proyecto SQL**

## 📌 Autora  
**María Victoria Cairós González**  

## 📅 Fechas  
- **Fecha de inicio:** 3 de marzo de 2025  
- **Fecha de finalización:** 10 de marzo de 2025  

## 📖 Descripción  
Este proyecto consiste en el análisis y manipulación de una base de datos de películas utilizando SQL. Se han desarrollado diversas consultas para explorar y extraer información relevante, asegurando la correcta interpretación de los datos almacenados.

---

## 🔧 Herramientas utilizadas  
- **GitHub:** Se creó un repositorio público llamado `peliculassql` para la gestión del proyecto.  
- **DBeaver:** Se utilizó como entorno de desarrollo para la ejecución de las consultas SQL y el análisis de la base de datos.  

---

## 🚀 Pasos seguidos para la resolución del proyecto  

### 1️⃣ **Configuración del entorno**  
- Se creó en **GitHub** el repositorio público `peliculassql`.  
- Se utilizó **DBeaver** para la administración y ejecución de las consultas SQL.  

### 2️⃣ **Carga y verificación de la base de datos**  
- Se importó en **DBeaver** el script `BBDD_proyecto.sql` y se ejecutó.  
- Se refrescó la vista de la base de datos y se verificó la correcta creación de las tablas y del diagrama de entidad-relación (**ERD**).  

### 3️⃣ **Análisis inicial de la base de datos**  
- Se revisaron las estructuras de las tablas, claves primarias, tipos de datos y relaciones entre ellas.  

### 4️⃣ **Desarrollo de consultas SQL**  
- Se creó un **script SQL** en **DBeaver** donde se resolvieron los ejercicios del **2 al 64**.  
- Para cada consulta, se verificó su correcto funcionamiento y se revisaron los datos obtenidos.  

### 5️⃣ **Validación de resultados y optimización de consultas**  
- En algunos casos, se ejecutaron **consultas intermedias** para analizar datos parciales antes de obtener el resultado final.  
- Se añadieron comentarios en el código para explicar la lógica aplicada y facilitar la comprensión de los pasos realizados.  
- Cuando una consulta arrojaba un **resultado vacío**, se verificaron manualmente los datos de la tabla correspondiente.  

### 6️⃣ **Manejo de valores nulos**  
- Se utilizó la función **COALESCE** para gestionar valores nulos en los resultados, asegurando que se informaran correctamente los datos disponibles.  

---

## 📂 Estructura del repositorio  

```bash
. 
├── BBDD_Proyecto.sql #Script de creación de la base de datos
├── Ejercicios_resueltos.sql # Consultas de SQL
└── README.md  #Documentación del Proyecto

3 archivos
```


---

## ✅ Conclusiones  
Este proyecto permitió poner en práctica la construcción de consultas SQL avanzadas, analizar una base de datos relacional y manejar diferentes situaciones como valores nulos y relaciones entre tablas.  
Tenía más de 15 años sin trabajar en SQL. Al finalizar el proyecto me sentí satisfecha por la abilidad con pude alcanzar en la resolución de los últimos ejercicios. 

## ✅ Correcciones

Los comentarios del Feedback se trabajan en el archivo "Ejercicios_resueltos.sql" colocandole un comentario en la última línea de la sentencia SQL.
en el caso del ejercicio 56 donde se buscan los actores que no han actuado en peliculas de 'music', se hace una aclaratoria para demostrar que la sentencia si excluye la categoria 'Music'. Agradezco que si aún no que da claro, me lo vuelvan a comentar.