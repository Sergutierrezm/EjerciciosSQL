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



--Por cada categoría, muestra el número de ventas, las unidades vendidas, el importe total, el importe medio por venta (redondeado a 2 decimales)
--y el precio unitario máximo. Excluye las ventas sin ciudad, deja solo las categorías con más de 3 ventas 
--y ordénalas por importe total descendente.



SELECT
categoria,
COUNT(*) AS num_ventas,
SUM(cantidad) AS unidades,
SUM(cantidad * precio) AS importe_total,
ROUND(AVG(cantidad * precio), 2) AS importe_medio,
MAX(precio) AS precio_max
FROM ventas
WHERE ciudad IS NOT NULL
GROUP BY categoria
HAVING COUNT(*) > 3
ORDER BY importe_total DESC 

--Por cliente, muestra su nombre en mayúsculas, el número de compras,
-- el importe total y la fecha de su primera y última compra. Solo clientes con importe total superior a 250
-- y con al menos 2 compras. Ordena por importe total descendente y, en caso de empate, por nombre.




SELECT
UPPER(cliente) AS cliente
COUNT(*) AS num_compras
SUM(cantidad * precio) AS importe_total
MIN(fecha) AS primera_compra
MAX(fecha) AS ultima_compra
FROM ventas
GROUP BY cliente
HAVING SUM(cantidad * precio) > 250
   AND COUNT(*) >= 2
ORDER BY importe_total DESC, cliente;   


