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

--Unidades vendidas por producto, de mayor a menor.
SELECT
producto,
SUM(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY producto
ORDER BY unidades_vendidas DESC 

--Importe total por cliente (cantidad * precio), de mayor a menor.
SELECT
cliente,
SUM(cantidad * precio) AS importe_total
FROM ventas
GROUP BY cliente
ORDER BY importe_total DESC 

--Categorías con un precio medio superior a 50.
SELECT
categoria,
AVG(precio) AS precio_medio
FROM ventas
GROUP BY categoria
HAVING AVG(precio) > 50

--Clientes con más de una compra.

SELECT
cliente,
COUNT(*) AS num_compras
FROM ventas
GROUP BY cliente
HAVING COUNT(*) > 1 


--Por categoría, el número de ventas y las unidades vendidas,
-- solo con ventas posteriores al 1 de febrero de 2026
--y solo categorías con más de 2 ventas.

SELECT
categoria
COUNT(*) AS num_ventas
SUM(cantidad) AS unidades_vendidas
FROM ventas
WHERE fecha > '2026-02-01'
GROUP BY categoria
HAVING COUNT(*) > 2

--Por ciudad, el importe total, sin contar las ventas sin ciudad 
--y solo ciudades con más de 500 de importe total, ordenadas de mayor a menor.

SELECT
ciudad,
SUM(cantidad * precio) AS importe_total,
FROM ventas
WHERE ciudad IS NOT NULL
GROUP BY ciudad
HAVING SUM(cantidad * precio) > 500
ORDER BY importe_total DESC



