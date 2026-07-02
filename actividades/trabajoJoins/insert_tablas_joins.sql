use joins

insert into clientes (nombre, email)
values ('Juan Perez', 'juan@gmail.com'), ('Ana Gomez', 'ana@gmail.com'), ('Pedro Lopez', 'pedro@gmail.com');

insert into pedidos (id_pedido, fecha_pedido, id_cliente)
values (100, '2026-06-01', 1), (101, '2026-06-02', 1), (102, '2026-06-03', 2);

insert into productos (nombre, precio)
values ('Mouse', 25000), ('Teclado', 45000), ('Monitor', 180000);

insert into detalles_pedido (id_pedido, id_producto, cantidad)
values (100, 1, 2), (100, 2, 1), (101, 3, 1), (102, 1, 3);