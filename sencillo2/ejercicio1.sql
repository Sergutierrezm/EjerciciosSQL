CREATE TABLE departamentos (
    id     INT PRIMARY KEY,
    nombre NVARCHAR(30),
    ciudad NVARCHAR(30)
);

INSERT INTO departamentos VALUES
(1, N'IT',        N'Madrid'),
(2, N'Ventas',    N'Barcelona'),
(3, N'Marketing', N'Madrid'),
(4, N'RRHH',      N'Valencia'),
(5, N'Legal',     N'Bilbao');

CREATE TABLE empleados (
    id              INT PRIMARY KEY,
    nombre          NVARCHAR(30),
    departamento_id INT,
    salario         DECIMAL(10,2),
    fecha_alta      DATE,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

INSERT INTO empleados VALUES
(1,  N'Ana',    1,    42000, '2022-03-01'),
(2,  N'Carlos', 1,    35000, '2023-06-15'),
(3,  N'Laura',  1,    48000, '2021-01-10'),
(4,  N'Pedro',  2,    28000, '2024-02-01'),
(5,  N'Marta',  2,    31000, '2022-09-12'),
(6,  N'Sergi',  2,    29500, '2023-11-20'),
(7,  N'Julia',  3,    38000, '2021-05-03'),
(8,  N'Raúl',   3,    NULL,  '2025-01-13'),
(9,  N'Elena',  4,    33000, '2020-10-05'),
(10, N'Pablo',  NULL, 30000, '2025-03-17');


--Una fila por empleado con departamento. Columnas: empleado, departamento, salario.

SELECT
e.nombre AS nombre_empleado,
d.nombre AS nombre_departamento,
e.salario
FROM empleados AS e
INNER JOIN departamentos AS d ON e.departamento_id = d.id;



--Muestra todos los empleados con el nombre de su departamento,
-- incluyendo los que no tienen departamento.

SELECT
e.nombre AS empleados,
d.nombre AS departamento
FROM empleados AS e
LEFT JOIN departamentos AS d ON e.departamento_id = d.id;

--Muestra los departamentos que no tienen ningún empleado.

SELECT
d.nombre AS departamentos,
e.nombre AS nombres
FROM departamentos AS d 
LEFT JOIN empleados AS e ON d.id = e.departamento_id
WHERE e.nombre IS NULL;


--4. Muestra el número de empleados de cada departamento, incluidos los que tienen 0.

SELECT
    d.id AS departamento,
    COUNT(e.id) AS num_empleados
FROM departamentos AS d
LEFT JOIN empleados AS e
    ON d.id = e.departamento_id
GROUP BY d.nombre;


--Por cada departamento, dime cuál es el salario medio,
-- pero solo de los que superen 32000 de media, ordenados de mayor a menor.

SELECT
d.nombre AS departamento,
AVG(e.salario) AS salario_medio
FROM departamentos AS d
INNER JOIN empleados AS e ON d.id = e.departamento_id
GROUP BY d.nombre
HAVING AVG(salario) >32000
ORDER BY salario_medio DESC;

--Por cada ciudad de los departamentos,
 --dime la suma de los salarios, de mayor a menor.

 SELECT
 d.ciudad AS ciudades,
 d.nombre AS departamento,
 SUM(e.salario) AS salarios
 FROM departamentos AS d  
 INNER JOIN empleados AS e ON d.id = e.departamento_id
 GROUP BY d.ciudad
 ORDER BY salarios DESC

--los empleados sin departamento y los departamentos sin empleados, en una sola consulta.

SELECT 
e.nombre AS empleados,
d.nombre AS departamento
FROM empleados AS e  
FULL JOIN departamentos AS d ON e.departamento_id = d.id
WHERE e.id IS NULL OR d.id IS NULL


