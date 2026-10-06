CREATE TABLE ventas (
    id         INT PRIMARY KEY,
    cliente    NVARCHAR(50),
    ciudad     NVARCHAR(30),
    producto   NVARCHAR(30),
    categoria  NVARCHAR(30),
    cantidad   INT,
    precio     DECIMAL(8,2),
    fecha      DATE
);

CREATE TABLE clientes (
    nombre     NVARCHAR(50) PRIMARY KEY,
    segmento   NVARCHAR(20),
    fecha_alta DATE
);


--Con INNER JOIN, muestra cliente, producto, importe (cantidad * precio) y segmento de cada venta.

SELECT
v.cliente,
v.producto,
v.cantidad* v.precio  AS importe
c.segmento
FROM ventas AS v
INNER JOIN clientes AS c ON v.cliente = c.nombre;

--Lo mismo con LEFT JOIN. Compara cuántas filas salen y qué pasa con Julia Ramos.

SELECT
v.cliente,
v.producto,
v.cantidad* v.precio  AS importe,
c.segmento
FROM ventas AS v
LEFT JOIN clientes AS c ON v.cliente = c .nombre;

--Con LEFT JOIN y un WHERE, saca las ventas cuyo cliente no existe en clientes.
 --Pista: busca las filas donde una columna de clientes es NULL (IS NULL).

SELECT
v.cliente,
v.producto,
v.cantidad* v.precio  AS importe,
c.segmento
FROM ventas AS v
LEFT JOIN clientes AS c ON v.cliente = c .nombre
WHERE c.nombre IS NULL;

--Saca los clientes que nunca han comprado. Pista: parte de clientes,
-- haz LEFT JOIN con ventas y filtra por una columna de ventas que sea NULL.

SELECT
c.nombre,
v.cliente
FROM clientes AS c
LEFT JOIN ventas AS v ON c.nombre = v.cliente
WHERE v.cliente IS NULL;

--Haz el 4 otra vez, pero con RIGHT JOIN y empezando por ventas.
-- Verás que es el mismo resultado con las tablas en otro orden.

SELECT
v.cliente,
c.nombre
FROM ventas AS V 
RIGHT JOIN clientes AS c ON v.cliente = c.nombre
WHERE v.cliente IS NULL;

--Importe total por segmento, con INNER JOIN y GROUP BY.

SELECT
c.segmento,
SUM(cantidad*precio) AS importe_total
FROM clientes AS c
INNER JOIN ventas AS v ON c.nombre = v.cliente
GROUP BY c.segmento;


--Número de compras por cliente, incluyendo los que tienen 0.
-- Pista: LEFT JOIN desde clientes y COUNT(v.id) en vez de COUNT(*).
-- Piensa por qué importa la diferencia,
-- que es la del ejercicio de COUNT(columna) frente a COUNT(*) con NULL.

SELECT
c.nombre,
COUNT(v.id) AS num_compras
FROM clientes AS c
LEFT JOIN ventas AS v ON  c.nombre = v.cliente
GROUP BY c.nombre;

--Ventas de clientes del segmento Premium: cliente, producto e importe (cantidad * precio).

SELECT
cliente,
producto,
v.cantidad * v.precio AS importe,
segmento
FROM ventas AS v
INNER JOIN clientes AS c ON v.cliente = c.nombre
WHERE c.segmento = 'premium';

--Número de ventas por segmento
SELECT
COUNT(v.cliente) AS num_ventas,
c.segmento
FROM ventas AS v 
INNER JOIN clientes as c ON v.cliente = c.nombre
GROUP BY c.segmento
