create table stock(
    id int primary key AUTO_INCREMENT,
    nombre varchar(255) not null,
    descripcion text,
    precio decimal(10, 2) not null,
    stock int not null,
    id_categoria int not NULL,
    Foreign Key (id_categoria) REFERENCES categorias(id)
);

CREATE table categorias(
    id int primary key,
    nombre varchar(255) not null
);

insert into categorias (id, nombre) values (1, 'Electronica');
insert into categorias (id, nombre) values (2, 'Ropa');
insert into categorias (id, nombre) values (3, 'Hogar');



INSERT INTO stock ( nombre, descripcion, precio, stock, id_categoria)
VALUES


('Producto 1', 'Descripción del producto 1', 10.00, 100, 1),
('Producto 2', 'Descripción del producto 2', 20.00, 200, 2),
('Producto 3', 'Descripción del producto 3', 30.00, 300, 3),
('Producto 4', 'Descripción del producto 4', 40.00, 400, 1),
('Producto 5', 'Descripción del producto 5', 50.00, 500, 2),
('Producto 6', 'Descripción del producto 6', 60.00, 600, 3),
('Producto 7', 'Descripción del producto 7', 70.00, 700, 1),
('Producto 8', 'Descripción del producto 8', 80.00, 800, 2),
('Producto 9', 'Descripción del producto 9', 90.00, 900, 3),
('Producto 10', 'Descripción del producto 10', 100.00, 1000, 1),
('Producto 100', 'Descripción del producto 100', 1000.00, 10000, 3);
--corremos el script hasta llegar a los 1000 registros, siguiendo el mismo patrón.

SELECT * from stock
where nombre = 'Producto 1';

CREATE INDEX idx_nombre_columna ON stock (nombre);

EXPLAIN SELECT * from stock
where nombre = 'Producto 1';

--el tiempo de busqueda en promedio antes del indice era de 10ms a 13ms y despues del indice fue de 5ms a 7ms.