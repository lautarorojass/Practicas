use joins;

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
select c.nombre as Cliente, coalesce(
        sum(dp.cantidad * pr.precio), 0
    ) as Total_Gastado
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
    coalesce(
        sum(dp.cantidad * pr.precio),
        0
    ) as Total_Gastado
from
    clientes c
    left join pedidos p on c.id_cliente = p.id_cliente
    left join detalles_pedido dp on p.id_pedido = dp.id_pedido
    left join productos pr on dp.id_producto = pr.id_producto
group by
    c.id_cliente,
    c.nombre;