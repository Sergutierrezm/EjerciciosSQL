#Reto 1: Muestra el Nombre, la Categoria y el Precio de todos los productos que pertenezcan a la categoría 'Periféricos' o 'Monitores', cuyos precios sean mayores o iguales a 30, ordenados por precio de mayor a menor.

SELECT Nombre,
Categoria,
Precio
FROM Productos
WHERE Categoria IN ('Perifericos', 'Monitores')
AND Precio >= 30
ORDER BY Precio DESC

#Reto 2: Queremos saber cuántos productos hay y cuál es el precio promedio por cada categoría. Escribe una consulta que devuelva la Categoria, el número total de productos (llámalo TotalProductos) y el precio medio (llámalo PrecioPromedio), mostrando únicamente las categorías que tengan un precio promedio superior a 70.
SELECT Categoria,
COUNT(ProductoID) AS TotalProductos,
AVG(Precio) AS PrecioPromedio
FROM Productos
GROUP BY Categoria
HAVING AVG(Precio) > 70;
