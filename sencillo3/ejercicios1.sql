CREATE TABLE autores (
    id     INT PRIMARY KEY,
    nombre NVARCHAR(30),
    pais   NVARCHAR(20)
);

INSERT INTO autores VALUES
(1, N'Marta Vega',   N'España'),
(2, N'Luis Ortega',  N'México'),
(3, N'Elena Ríos',   N'España'),
(4, N'Pablo Núñez',  N'Chile'),
(5, N'Clara Soler',  N'España');

CREATE TABLE libros (
    id       INT PRIMARY KEY,
    titulo   NVARCHAR(40),
    autor_id INT,
    genero   NVARCHAR(20),
    precio   DECIMAL(6,2),
    anio     INT,
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

INSERT INTO libros VALUES
(1,  N'La casa azul',     1,    N'Novela',   18.50, 2015),
(2,  N'Ecos del mar',     1,    N'Poesía',   12.00, 2018),
(3,  N'Noches de papel',  2,    N'Novela',   21.90, 2012),
(4,  N'El mapa roto',     2,    N'Aventura', 16.75, 2020),
(5,  N'Tierra baja',      3,    N'Novela',   19.90, 2019),
(6,  N'Sombras',          3,    N'Misterio', 14.50, 2021),
(7,  N'Código rojo',      3,    N'Misterio', NULL,  2022),
(8,  N'Mar de dudas',     4,    N'Ensayo',   24.00, 2017),
(9,  N'Sin dueño',        NULL, N'Novela',   9.90,  2010),
(10, N'Cartas lejanas',   1,    N'Novela',   15.00, 2023);


--Por cada autor, dime cuántos libros tiene, incluidos los que no tienen ninguno.

SELECT
a.nombre AS autor,
COUNT(l.autor_id) AS num_libros
FROM autores AS a
LEFT JOIN libros AS l ON a.id = l.autor_id
GROUP BY a.nombre



--Muestra título y precio de los libros publicados a partir de 2018, ordenados del más caro al más barato.

SELECT
titulo,
precio,
anio
FROM libros
WHERE anio >= 2018  --para años siempre comparar >,<
ORDER BY precio DESC 







--Lista los autores de España ordenados alfabéticamente.
SELECT
nombre,
pais
FROM autores
WHERE pais = 'España'
ORDER BY nombre ASC --para orden alfabetico ASC 



--Muestra los libros cuyo género sea Novela o Misterio.
SELECT
titulo,
genero
FROM libros
WHERE genero in ('Novela' , 'Misterio')



--Muestra los libros que no tienen precio informado.

SELECT
titulo,
precio 
FROM libros
WHERE precio is NULL