CREATE TABLE Empleados (

id INT PRIMARY KEY,
Nombre VARCHAR(100),
Salario DECIMAL(10,2),
Departamento_id INT

);

CREATE TABLE Departamentos (

id INT PRIMARY KEY,
Nombre VARCHAR(100)

);

INSERT INTO Departamentos (id, Nombre)
VALUES (1, 'Gerencia'),
	   (2, 'Recursos Humanos'),
	   (3, 'Atencion al Cliente');

INSERT INTO Empleados (id, Nombre, Salario, Departamento_id)
VALUES (1, 'Jorge Elias', 50000,1),
       (2, 'Simon Castro', 10000, 3),
	   (3, 'Ana Barreto', 20000, 2);

INSERT INTO Empleados (id, Nombre, Salario, Departamento_id)
VALUES(4, 'Guillermo Barreto', 300000, 3);

UPDATE Empleados
SET Salario = 50000
WHERE id = 2; /*Tambien se uso para modificar el salario de Jorge Elias*/

SELECT Nombre, Salario
FROM Empleados
WHERE Salario > 500000

SELECT * FROM Empleados
ORDER BY Nombre ASC;

SELECT DISTINCT id, Nombre
FROM Departamentos

SELECT Nombre, Salario
FROM Empleados
WHERE Departamento_id = 3 AND Salario > 60000

SELECT Nombre, Salario 
FROM Empleados 
WHERE Salario BETWEEN 40000 AND 70000

SELECT Nombre
FROM Empleados 
WHERE Nombre LIKE 'A%' 

SELECT AVG (Salario) SalarioPromedio 
FROM Empleados

/*SELECT Nombre, NombreDepartamentos
FROM Empleados; LO INTENTE ASI, PERO NO ME TOMABA NombreDepartamentos*/ 

SELECT e.Nombre AS NombreEmpleado, d.Nombre AS NombreDepartamentos
FROM Empleados e
JOIN Departamentos d ON e.Departamento_id = d.id;

SELECT Nombre, Salario
FROM Empleados
WHERE Salario > (SELECT AVG(Salario)FROM Empleados);