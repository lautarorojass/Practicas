create DATABASE biblioteca;

use  biblioteca;

create table libros(
    id int not null primary key AUTO_INCREMENT,
    titulo varchar(255) not null,
    autor varchar(255) not null,
    anio_publicacion int not null,
    genero varchar(100) not null,
    disponible boolean not null
)

create table usuarios(
    id int not null primary key AUTO_INCREMENT,
    nombre varchar(255) not null,
    email varchar(255) not null unique,
    telefono varchar(20) not null
)

create table prestamos(
    id int not null primary key AUTO_INCREMENT,
    id_libro int not null,
    id_usuario int not null,
    fecha_prestamo date not null,
    fecha_devolucion date,
    FOREIGN KEY (id_libro) REFERENCES libros(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
)

create table categorias(
    id int not null primary key AUTO_INCREMENT,
    nombre varchar(100) not null unique
)

create table autores(
    id int not null primary key AUTO_INCREMENT,
    nombre varchar(255) not null unique,
    biografia text
)

create table libro_categoria(
    primary KEY (id_libro, id_categoria),
    id_libro int not null,
    id_categoria int not null,
    FOREIGN KEY (id_libro) REFERENCES libros(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
)

create table libro_autor(
    primary KEY (id_libro, id_autor),
    id_libro int not null,
    id_autor int not null,
    FOREIGN KEY (id_libro) REFERENCES libros(id),
    FOREIGN KEY (id_autor) REFERENCES autores(id)
)

create table usuarios_prestamos(
    PRIMARY KEY (id_usuario, id_prestamo),
    id_usuario int not null,
    id_prestamo int not null,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_prestamo) REFERENCES prestamos(id)
)


insert into categorias (nombre) values ('Ficción'), ('Comics'), ('Ciencia'), ('Historia'), ('Biografía'), ('Fantasía'), ('Misterio'), ('Romance'), ('Terror'), ('Aventura');

insert into autores (nombre, biografia) values 
('Gabriel García Márquez', 'Gabriel García Márquez fue un escritor colombiano, conocido por su obra maestra "Cien años de soledad".'),
('J.K. Rowling', 'J.K. Rowling es una autora británica, famosa por la serie de libros "Harry Potter".'),
('Stephen King', 'Stephen King es un autor estadounidense, reconocido por sus novelas de terror y suspenso.'),
('Jane Austen', 'Jane Austen fue una novelista inglesa, conocida por sus obras como "Orgullo y prejuicio".'),
('George R.R. Martin', 'George R.R. Martin es un escritor estadounidense, famoso por su serie de fantasía "Canción de hielo y fuego".');

insert into usuarios (nombre, email, telefono) values 
('Juan Pérez', 'juan.perez@example.com', '1234567890'),
('María Gómez', 'maria.gomez@example.com', '0987654321'),
('Carlos Sánchez', 'carlos.sanchez@example.com', '1122334455'),
('Ana Martínez', 'ana.martinez@example.com', '5566778899');

insert into libros (titulo, autor, anio_publicacion, genero, disponible) values 
('Cien años de soledad', 'Gabriel García Márquez', 1967, 'Ficción', true),
('Harry Potter y la piedra filosofal', 'J.K. Rowling', 1997, 'Fantasía', true),
('El resplandor', 'Stephen King', 1977, 'Terror', true),
('Orgullo y prejuicio', 'Jane Austen', 1813, 'Romance', true),
('Juego de tronos', 'George R.R. Martin', 1996, 'Fantasía', true),
('El código Da Vinci', 'Dan Brown', 2003, 'Misterio', true),
('La sombra del viento', 'Carlos Ruiz Zafón', 2001, 'Ficción', true),
('El alquimista', 'Paulo Coelho', 1988, 'Aventura', true),
('Los pilares de la tierra', 'Ken Follett', 1989, 'Historia', true),
("Batman: Año Uno", 'Frank Miller', 1987, 'Comics', true);

insert into prestamos (id_libro, id_usuario, fecha_prestamo, fecha_devolucion) values 
(1, 1, '2025-01-15', '2025-02-15'),
(2, 2, '2025-02-10', '2025-03-10'),
(3, 3, '2025-03-05', '2025-04-05'),
(4, 4, '2025-04-20', '2025-05-20'),
(5, 1, '2025-05-10', '2025-06-10'),
(6, 2, '2025-06-15', '2025-07-15'),
(7, 3, '2025-07-20', '2025-08-20'),
(8, 4, '2025-08-25', '2025-09-25'),
(9, 1, '2025-09-30', '2025-10-30'),
(10, 2, '2025-10-05', '2025-11-05');

insert into libro_categoria (id_libro, id_categoria) values 
(1, 1), (2, 6), (3, 9), (4, 8), (5, 6), (6, 7), (7, 1), (8, 10), (9, 4), (10, 2);

insert into libro_autor (id_libro, id_autor) values
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

insert into usuarios_prestamos (id_usuario, id_prestamo) values 
(1, 1), (2, 2), (3, 3), (4, 4), (1, 5), (2, 6), (3, 7), (4, 8), (1, 9), (2, 10);

select * from libros;
select * from usuarios;
select * from prestamos;
select * from categorias;   
select * from autores;
select * from libro_categoria;
select * from libro_autor;
select * from usuarios_prestamos;

UPDATE autores SET nombre = 'Stephen King', biografia = 'Stephen King es un autor estadounidense, reconocido por sus novelas de terror y suspenso.' WHERE id = 3;

delete from libros where id >= 11;