create DATABASE joins

use joins

create table clientes(
    id_cliente int primary key auto_increment,
    nombre varchar(50) not null,
    email varchar(100) unique not null
);

create table productos(
    id_producto int primary key auto_increment,
    nombre varchar(50) not null,
    precio decimal(10,2) not null
);

create table pedidos(
    id_pedido int primary key,
    fecha_pedido date not null,
    id_cliente int,
    foreign key (id_cliente) references clientes(id_cliente)
);

create table detalles_pedido(
    id_detalle int primary key auto_increment,
    id_pedido int,
    id_producto int,
    cantidad int not null,
    foreign key (id_pedido) references pedidos(id_pedido),
    foreign key (id_producto) references productos(id_producto)
);



