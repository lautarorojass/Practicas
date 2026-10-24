CREATE DATABASE IF NOT EXISTS sistema_bancario;

USE sistema_bancario;

DROP TABLE IF EXISTS transacciones;
DROP TABLE IF EXISTS tarjetas;
DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS cuentas;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS tipos_de_tarjeta;
DROP TABLE IF EXISTS tipos_de_cuenta;
DROP TABLE IF EXISTS sucursales;

CREATE TABLE sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    telefono VARCHAR(25),
    correo VARCHAR(120) UNIQUE,
    fecha_apertura DATE NOT NULL,
    activa BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE tipos_de_cuenta (
    id_tipo_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    interes DECIMAL(5, 4) NOT NULL DEFAULT 0,
    limite_retiro DECIMAL(15, 2) NOT NULL DEFAULT 1000,
    permite_saldo_negativo BOOLEAN NOT NULL DEFAULT FALSE,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE tipos_de_tarjeta (
    id_tipo_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    marca VARCHAR(20) NOT NULL,
    limite_credito DECIMAL(15, 2) NOT NULL DEFAULT 0,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE clientes (
    id_cliente VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    dni VARCHAR(15) NOT NULL UNIQUE,
    correo VARCHAR(120) NOT NULL UNIQUE,
    telefono VARCHAR(25),
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(150),
    id_sucursal INT NOT NULL,
    fecha_alta DATE NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal),
    INDEX (apellido)
);

CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    dni VARCHAR(15) NOT NULL UNIQUE,
    correo VARCHAR(120) NOT NULL UNIQUE,
    telefono VARCHAR(25),
    cargo VARCHAR(60) NOT NULL,
    id_sucursal INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    salario DECIMAL(12, 2) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal)
);

CREATE TABLE cuentas (
    id_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    numero_cuenta VARCHAR(20) NOT NULL UNIQUE,
    id_cliente VARCHAR(36) NOT NULL,
    id_tipo_cuenta INT NOT NULL,
    id_sucursal INT NOT NULL,
    saldo DECIMAL(15, 2) NOT NULL DEFAULT 0,
    moneda VARCHAR(3) NOT NULL DEFAULT 'ARS',
    estado VARCHAR(20) NOT NULL DEFAULT 'activa',
    fecha_apertura DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_tipo_cuenta) REFERENCES tipos_de_cuenta (id_tipo_cuenta),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal)
);

CREATE TABLE tarjetas (
    id_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    codigo_tarjeta VARCHAR(30) NOT NULL UNIQUE,
    ultimos_digitos VARCHAR(4) NOT NULL,
    id_cuenta INT NOT NULL,
    id_tipo_tarjeta INT NOT NULL,
    titular VARCHAR(120) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'activa',
    FOREIGN KEY (id_cuenta) REFERENCES cuentas (id_cuenta),
    FOREIGN KEY (id_tipo_tarjeta) REFERENCES tipos_de_tarjeta (id_tipo_tarjeta)
);

CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    numero_operacion VARCHAR(40) NOT NULL UNIQUE,
    id_cuenta INT NOT NULL,
    id_cuenta_destino INT,
    id_empleado INT,
    tipo VARCHAR(20) NOT NULL,
    monto DECIMAL(15, 2) NOT NULL,
    moneda VARCHAR(3) NOT NULL DEFAULT 'ARS',
    descripcion VARCHAR(200),
    fecha DATETIME NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'completada',
    FOREIGN KEY (id_cuenta) REFERENCES cuentas (id_cuenta),
    FOREIGN KEY (id_cuenta_destino) REFERENCES cuentas (id_cuenta),
    FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado),
    INDEX (fecha)
);

CREATE TABLE prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    numero_prestamo VARCHAR(20) NOT NULL UNIQUE,
    id_cliente VARCHAR(36) NOT NULL,
    id_sucursal INT NOT NULL,
    id_empleado INT,
    monto DECIMAL(15, 2) NOT NULL,
    interes DECIMAL(5, 4) NOT NULL,
    plazo INT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_aprobacion DATE,
    fecha_vencimiento DATE,
    saldo_pendiente DECIMAL(15, 2) NOT NULL DEFAULT 0,
    estado VARCHAR(20) NOT NULL DEFAULT 'solicitado',
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal),
    FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado),
    INDEX (estado)
);
