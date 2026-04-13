--Tabla Libros

CREATE TABLE Libros(
	id_libro INT PRIMARY KEY,
	titulo VARCHAR(200),
	autor_id INT,
	editorial_id INT,
	anio_publicacion INT 

);

--TABLA AUTORES

CREATE TABLE Autores (
	id_autor INT PRIMARY KEY,
	nombre  VARCHAR(100),
	pais_origen VARCHAR (50)
);

--Tabla de Editoriales
CREATE TABLE Editoriales (
	id_editorial INT PRIMARY KEY,
	nombre VARCHAR (100),
	ciudad VARCHAR (50)
);

--Tabla Prestamos
CREATE TABLE Prestamos (
	id_prestamo INT PRIMARY KEY,
	libro_id INT,
	usuario_id INT,
	fecha_prestamo DATE,
	fecha_devolucion DATE
);

--Tabla de Usuarios
CREATE TABLE Usuarios (
	id_usuario INT PRIMARY KEY,
	nombre VARCHAR (100),
	email VARCHAR (100)

);

--Insertando autores
INSERT INTO Autores (id_autor, nombre, pais_origen) VALUES 
(1, 'Gabriel Garcia Marquez', 'Colombia'),
(2, 'Isabel Allende','Chile'),
(3, 'Miguel de Cervantes','España');

--Insertando las editoriales
INSERT INTO Editoriales (id_editorial, nombre, ciudad) VALUES
(1, 'Editorial Sudamericana', 'Buenos Aires'),
(2, 'Penguin Random House', 'Barcelona'),
(3, 'Planeta', 'Madrid');

-- Insertar Libros (vinculados a autores y editoriales previos)
INSERT INTO Libros (id_libro, titulo, autor_id, editorial_id, anio_publicacion) VALUES 
(1, 'Cien años de soledad', 1, 1, 1967),
(2, 'La casa de los espíritus', 2, 3, 1982),
(3, 'Don Quijote de la Mancha', 3, 2, 1605),
(4, 'El amor en los tiempos del cólera', 1, 1, 1985);

-- Insertar Usuarios
INSERT INTO Usuarios (id_usuario, nombre, email) VALUES 
(1, 'Juan Pérez', 'juan.perez@email.com'),
(2, 'Ana García', 'ana.garcia@email.com'),
(3, 'Luis Martínez', 'luis.mtz@email.com');

-- Insertar Préstamos (incluye uno vencido y uno sin usuario para los ejercicios)
INSERT INTO Prestamos (id_prestamo, libro_id, usuario_id, fecha_prestamo, fecha_devolucion) VALUES 
(1, 1, 1, '2024-03-01', '2024-03-15'), -- Préstamo vencido
(2, 2, 2, '2024-04-10', '2024-05-10'),
(3, 3, NULL, '2024-04-05', '2024-04-20'); -- Préstamo sin usuario asociado

--EJERCICIO 1

SELECT l.titulo, a.nombre AS nombre_autor
FROM Libros AS l
INNER JOIN Autores AS a ON l.autor_id = a.id_autor;

SELECT a.nombre AS nombre_autor, l.titulo
FROM Autores AS a
LEFT JOIN Libros AS l ON a.id_autor = l.autor_id
ORDER BY a.nombre;

SELECT p.id_prestamo, l.titulo, u.nombre AS nombre_usuario
FROM Prestamos AS p
INNER JOIN Libros AS l ON p.libro_id = l.id_libro
LEFT JOIN Usuarios AS u ON p.usuario_id = u.id_usuario;

--EJERCICIO 2

-- Usamos LEFT JOIN para que salgan todos los autores registrados
SELECT a.nombre AS nombre_autor, l.titulo
FROM Autores AS a
LEFT JOIN Libros AS l ON a.id_autor = l.autor_id
ORDER BY a.nombre;

--EJERCICIO 3
-- LEFT JOIN en Usuarios para ver préstamos que no tengan usuario asignado
SELECT p.id_prestamo, l.titulo, u.nombre AS nombre_usuario
FROM Prestamos AS p
INNER JOIN Libros AS l ON p.libro_id = l.id_libro
LEFT JOIN Usuarios AS u ON p.usuario_id = u.id_usuario;

--EJERCICIO 4
-- Usamos COUNT y GROUP BY para la estadística
SELECT e.nombre AS editorial, COUNT(l.id_libro) AS total_libros
FROM Editoriales AS e
LEFT JOIN Libros AS l ON e.id_editorial = l.editorial_id
GROUP BY e.nombre;

--EJERCICIO 5
-- Filtramos por la fecha actual
SELECT u.nombre AS nombre_usuario, l.titulo, p.fecha_devolucion
FROM Usuarios AS u
INNER JOIN Prestamos AS p ON u.id_usuario = p.usuario_id
INNER JOIN Libros AS l ON p.libro_id = l.id_libro
WHERE p.fecha_devolucion < date('now');