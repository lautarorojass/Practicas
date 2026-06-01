CREATE DATABASE stock;

use stock;

create table stock2 (
    ID int primary key AUTO_INCREMENT,
    CANT int not null,
    MARCA varchar(255) not null,
    PRECIO decimal(10, 2) not null
);

insert into stock2 (CANT, MARCA, PRECIO) values (15, 'Asus', 1500.00);

insert into stock2 (CANT, MARCA, PRECIO) values (5, 'Lenovo', 25.00);

insert into stock2 (CANT, MARCA, PRECIO) values (10, 'Apple', 800.00);

select * from stock2;
