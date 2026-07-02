create DATABASE joins

use joins

create table clientes (
    id_cliente int primary key auto_increment,
    nombre varchar(50) not null,
    email varchar(100) unique not null
);

create table productos (
    id_producto int primary key auto_increment,
    nombre varchar(50) not null,
    precio decimal(10, 2) not null
);

create table pedidos (
    id_pedido int primary key,
    fecha_pedido date not null,
    id_cliente int,
    foreign key (id_cliente) references clientes (id_cliente)
);

create table detalles_pedido (
    id_detalle int primary key auto_increment,
    id_pedido int,
    id_producto int,
    cantidad int not null,
    foreign key (id_pedido) references pedidos (id_pedido),
    foreign key (id_producto) references productos (id_producto)
);

insert into clientes (nombre, email)
values ('Juan Perez', 'juan@gmail.com'), ('Ana Gomez', 'ana@gmail.com'), ('Pedro Lopez', 'pedro@gmail.com');

insert into pedidos (id_pedido, fecha_pedido, id_cliente)
values (100, '2026-06-01', 1), (101, '2026-06-02', 1), (102, '2026-06-03', 2);

insert into productos (nombre, precio)
values ('Mouse', 25000), ('Teclado', 45000), ('Monitor', 180000);

insert into detalles_pedido (id_pedido, id_producto, cantidad)
values (100, 1, 2), (100, 2, 1), (101, 3, 1), (102, 1, 3);

-- Ejercicio 1
-- Mostrar: Pedido, Fecha, Cliente
select p.id_pedido as Pedido, p.fecha_pedido as Fecha, c.nombre as Cliente
from pedidos p
    join clientes c on p.id_cliente = c.id_cliente;

-- Ejercicio 2
-- Mostrar: Cliente, Pedido, Producto, Cantidad
select
    c.nombre as Cliente,
    p.id_pedido as Pedido,
    pr.nombre as Producto,
    dp.cantidad as Cantidad
from
    clientes c
    inner join pedidos p on c.id_cliente = p.id_cliente
    inner join detalles_pedido dp on p.id_pedido = dp.id_pedido
    inner join productos pr on dp.id_producto = pr.id_producto;

-- Ejercicio 3
-- Mostrar: Cliente, Producto, Cantidad, Precio, Subtotal
select
    c.nombre as Cliente,
    pr.nombre as Producto,
    dp.cantidad as Cantidad,
    pr.precio as Precio,
    dp.cantidad * pr.precio as Subtotal
from
    clientes c
    inner join pedidos p on c.id_cliente = p.id_cliente
    inner join detalles_pedido dp on p.id_pedido = dp.id_pedido
    inner join productos pr on dp.id_producto = pr.id_producto;

-- Ejercicio 4
-- Mostrar todos los clientes aunque no tengan pedidos
select c.nombre as Cliente
from clientes c
    left join pedidos p on c.id_cliente = p.id_cliente
group by
    c.id_cliente,
    c.nombre;

-- Ejercicio 5
-- Mostrar el total gastado por cada cliente
select c.nombre as Cliente, coalesce(sum(dp.cantidad * pr.precio), 0) as Total_Gastado
from
    clientes c
    left join pedidos p on c.id_cliente = p.id_cliente
    left join detalles_pedido dp on p.id_pedido = dp.id_pedido
    left join productos pr on dp.id_producto = pr.id_producto
group by
    c.id_cliente,
    c.nombre;

-- Desafio Final
-- Mostrar: Cliente, Cantidad de Pedidos, Cantidad de Productos Comprados, Total Gastado
select
    c.nombre as Cliente,
    count(distinct p.id_pedido) as Cantidad_de_Pedidos,
    coalesce(sum(dp.cantidad), 0) as Cantidad_de_Productos_Comprados,
    coalesce(sum(dp.cantidad * pr.precio),0) as Total_Gastado
from
    clientes c
    left join pedidos p on c.id_cliente = p.id_cliente
    left join detalles_pedido dp on p.id_pedido = dp.id_pedido
    left join productos pr on dp.id_producto = pr.id_producto
group by
    c.id_cliente,
    c.nombre;

--Pregunta 1
--En estos ejercicios participan principalmente las tablas "clientes", "pedidos", "detalles_pedido" y "productos".

--Pregunta 2
--Las claves foráneas que se usan para unirlas son:
--pedidos.id_cliente y clientes.id_cliente
--detalles_pedido.id_pedido y pedidos.id_pedido
--detalles_pedido.id_producto y productos.id_producto

--Pregunta 3
--Para mostrar cliente, pedido, producto y cantidad hicieron falta **3 INNER JOIN**, porque hay que conectar cuatro tablas entre sí: primero clientes con pedidos, después pedidos con detalles, y por último detalles con productos.

--Pregunta 4
--En el ejercicio 4 se usa `LEFT JOIN` porque la consigna pide mostrar **todos los clientes aunque no tengan pedidos**. Eso es importante porque `Pedro Lopez` no tiene ningún pedido cargado, pero igual debe aparecer en el resultado.

--Pregunta 5
--Si se usara `INNER JOIN` en lugar de `LEFT JOIN`, solo aparecerían los clientes que sí tienen pedidos. Entonces `Pedro Lopez` quedaría afuera, porque no hay ningún registro en la tabla `pedidos` relacionado con él.