USE sistema_bancario;

DELETE FROM transacciones;
DELETE FROM tarjetas;
DELETE FROM prestamos;
DELETE FROM cuentas;
DELETE FROM empleados;
DELETE FROM clientes;
DELETE FROM tipos_de_tarjeta;
DELETE FROM tipos_de_cuenta;
DELETE FROM sucursales;

INSERT INTO sucursales (
    id_sucursal, codigo, nombre, direccion, ciudad, telefono, correo, fecha_apertura, activa
) VALUES
    (1, 'CABA-CENTRO', 'Sucursal Centro', 'Av. Corrientes 1234', 'Ciudad Autónoma de Buenos Aires', '+54 11 4321-1001', 'centro@bancosistema.com', '2005-03-01', TRUE),
    (2, 'CABA-PALERMO', 'Sucursal Palermo', 'Av. Santa Fe 3456', 'Ciudad Autónoma de Buenos Aires', '+54 11 4321-1002', 'palermo@bancosistema.com', '2010-07-15', TRUE),
    (3, 'COR-CENTRO', 'Sucursal Córdoba', 'Av. Colón 789', 'Córdoba', '+54 351 422-2001', 'cordoba@bancosistema.com', '2013-09-10', TRUE),
    (4, 'ROS-CENTRO', 'Sucursal Rosario', 'Córdoba 1010', 'Rosario', '+54 341 424-3001', 'rosario@bancosistema.com', '2016-11-25', TRUE);

INSERT INTO tipos_de_cuenta (
    id_tipo_cuenta, nombre, descripcion, interes, limite_retiro, permite_saldo_negativo, activo
) VALUES
    (1, 'Caja de Ahorro en Pesos', 'Cuenta para ahorro en moneda local', 0.0100, 50000.00, FALSE, TRUE),
    (2, 'Cuenta Corriente', 'Cuenta para operaciones comerciales y pago de cheques', 0.0000, 100000.00, TRUE, TRUE),
    (3, 'Caja de Ahorro en Dólares', 'Cuenta para ahorro en dólares estadounidenses', 0.0050, 1000.00, FALSE, TRUE),
    (4, 'Cuenta Sueldo', 'Cuenta para acreditación de haberes', 0.0150, 30000.00, FALSE, TRUE);

INSERT INTO tipos_de_tarjeta (
    id_tipo_tarjeta, nombre, descripcion, marca, limite_credito, activo
) VALUES
    (1, 'Visa Clásica', 'Tarjeta de crédito de consumo general', 'VISA', 500000.00, TRUE),
    (2, 'Mastercard Gold', 'Tarjeta de crédito con beneficios adicionales', 'MASTERCARD', 1500000.00, TRUE),
    (3, 'Visa Platinum', 'Tarjeta de crédito premium', 'VISA', 3500000.00, TRUE),
    (4, 'American Express', 'Tarjeta de crédito internacional', 'AMEX', 5000000.00, TRUE);

INSERT INTO clientes (
    id_cliente, nombre, apellido, dni, correo, telefono, fecha_nacimiento,
    direccion, id_sucursal, fecha_alta, activo
) VALUES
    ('123e4567-e89b-12d3-a456-426614174000', 'Juan', 'Pérez', '30111222', 'juan.perez@example.com', '+54 11 5555-1001', '1985-04-12', 'Av. Rivadavia 2500', 1, '2020-03-15', TRUE),
    ('123e4567-e89b-12d3-a456-426614174001', 'María', 'Gómez', '27888999', 'maria.gomez@example.com', '+54 11 5555-1002', '1990-07-23', 'Av. Cabildo 1800', 2, '2019-11-05', TRUE),
    ('123e4567-e89b-12d3-a456-426614174002', 'Carlos', 'Rodríguez', '33444555', 'carlos.rodriguez@example.com', '+54 11 5555-1003', '1979-11-02', 'Av. Belgrano 950', 1, '2018-08-14', TRUE),
    ('123e4567-e89b-12d3-a456-426614174003', 'Lucía', 'Fernández', '35666777', 'lucia.fernandez@example.com', '+54 351 555-2001', '1995-02-18', 'Bv. San Juan 450', 3, '2023-02-01', TRUE),
    ('123e4567-e89b-12d3-a456-426614174004', 'Martín', 'López', '29444888', 'martin.lopez@example.com', '+54 341 555-3001', '1988-09-30', 'Córdoba 1450', 4, '2024-05-10', TRUE),
    ('123e4567-e89b-12d3-a456-426614174005', 'Sofía', 'Martínez', '36777888', 'sofia.martinez@example.com', '+54 11 5555-1004', '1999-12-05', 'Av. Scalabrini Ortiz 1200', 2, '2025-09-12', TRUE);

INSERT INTO empleados (
    id_empleado, nombre, apellido, dni, correo, telefono, cargo,
    id_sucursal, fecha_ingreso, salario, activo
) VALUES
    (1, 'Laura', 'Díaz', '26555001', 'laura.diaz@bancosistema.com', '+54 11 4321-2001', 'Cajera', 1, '2015-02-02', 950000.00, TRUE),
    (2, 'Pedro', 'Álvarez', '28111002', 'pedro.alvarez@bancosistema.com', '+54 11 4321-2002', 'Cajero', 2, '2017-06-12', 980000.00, TRUE),
    (3, 'Ana', 'Torres', '30222003', 'ana.torres@bancosistema.com', '+54 11 4321-2003', 'Asesora comercial', 1, '2016-09-01', 1250000.00, TRUE),
    (4, 'Diego', 'Ramírez', '25444004', 'diego.ramirez@bancosistema.com', '+54 351 422-2002', 'Gerente de sucursal', 3, '2012-04-20', 2100000.00, TRUE),
    (5, 'Valeria', 'Castro', '31999005', 'valeria.castro@bancosistema.com', '+54 341 424-3002', 'Analista de créditos', 4, '2019-10-07', 1400000.00, TRUE),
    (6, 'Nicolás', 'Vega', '33666006', 'nicolas.vega@bancosistema.com', '+54 11 4321-2004', 'Cajero', 2, '2021-01-18', 900000.00, TRUE);

INSERT INTO cuentas (
    id_cuenta, numero_cuenta, id_cliente, id_tipo_cuenta, id_sucursal,
    saldo, moneda, estado, fecha_apertura
) VALUES
    (1, '0000000001', '123e4567-e89b-12d3-a456-426614174000', 1, 1, 250000.50, 'ARS', 'activa', '2020-03-20'),
    (2, '0000000002', '123e4567-e89b-12d3-a456-426614174000', 2, 1, 1200000.00, 'ARS', 'activa', '2021-06-10'),
    (3, '0000000003', '123e4567-e89b-12d3-a456-426614174001', 1, 2, 85000.75, 'ARS', 'activa', '2019-11-05'),
    (4, '0000000004', '123e4567-e89b-12d3-a456-426614174001', 3, 2, 1500.00, 'USD', 'activa', '2022-01-20'),
    (5, '0000000005', '123e4567-e89b-12d3-a456-426614174002', 2, 1, -25000.00, 'ARS', 'activa', '2018-08-14'),
    (6, '0000000006', '123e4567-e89b-12d3-a456-426614174003', 1, 3, 430000.00, 'ARS', 'activa', '2023-02-01'),
    (7, '0000000007', '123e4567-e89b-12d3-a456-426614174004', 4, 4, 78000.00, 'ARS', 'activa', '2024-05-10'),
    (8, '0000000008', '123e4567-e89b-12d3-a456-426614174005', 3, 2, 3200.00, 'USD', 'activa', '2025-09-12');

INSERT INTO tarjetas (
    id_tarjeta, codigo_tarjeta, ultimos_digitos, id_cuenta, id_tipo_tarjeta,
    titular, fecha_emision, fecha_vencimiento, estado
) VALUES
    (1, 'TARJETA-0001', '4001', 1, 1, 'Juan Pérez', '2023-05-10', '2027-05-31', 'activa'),
    (2, 'TARJETA-0002', '4002', 2, 2, 'Juan Pérez', '2024-02-01', '2028-02-29', 'activa'),
    (3, 'TARJETA-0003', '4003', 3, 1, 'María Gómez', '2022-09-15', '2027-09-30', 'activa'),
    (4, 'TARJETA-0004', '4004', 4, 4, 'María Gómez', '2025-01-10', '2030-01-31', 'activa'),
    (5, 'TARJETA-0005', '4005', 5, 2, 'Carlos Rodríguez', '2024-03-01', '2028-03-31', 'bloqueada'),
    (6, 'TARJETA-0006', '4006', 6, 3, 'Lucía Fernández', '2023-11-20', '2027-11-30', 'activa'),
    (7, 'TARJETA-0007', '4007', 7, 1, 'Martín López', '2026-01-05', '2030-01-31', 'activa'),
    (8, 'TARJETA-0008', '4008', 8, 4, 'Sofía Martínez', '2024-07-01', '2029-07-31', 'activa');

INSERT INTO transacciones (
    id_transaccion, numero_operacion, id_cuenta, id_cuenta_destino, id_empleado,
    tipo, monto, moneda, descripcion, fecha, estado
) VALUES
    (1, '8f14e45f-ea2b-4c3d-9a1b-000000000001', 1, NULL, 1, 'deposito', 50000.00, 'ARS', 'Depósito en efectivo', '2026-10-18 09:15:00', 'completada'),
    (2, '8f14e45f-ea2b-4c3d-9a1b-000000000002', 1, NULL, 1, 'retiro', 20000.00, 'ARS', 'Extracción en cajero', '2026-10-19 11:40:00', 'completada'),
    (3, '8f14e45f-ea2b-4c3d-9a1b-000000000003', 1, 3, NULL, 'transferencia', 15000.00, 'ARS', 'Transferencia a María Gómez', '2026-10-20 14:05:00', 'completada'),
    (4, '8f14e45f-ea2b-4c3d-9a1b-000000000004', 2, NULL, NULL, 'pago', 35000.00, 'ARS', 'Pago de servicio de electricidad', '2026-10-21 08:30:00', 'completada'),
    (5, '8f14e45f-ea2b-4c3d-9a1b-000000000005', 2, 6, NULL, 'transferencia', 100000.00, 'ARS', 'Transferencia a Lucía Fernández', '2026-10-21 10:12:00', 'completada'),
    (6, '8f14e45f-ea2b-4c3d-9a1b-000000000006', 3, NULL, 2, 'deposito', 80000.00, 'ARS', 'Depósito por ventanilla', '2026-10-22 09:05:00', 'completada'),
    (7, '8f14e45f-ea2b-4c3d-9a1b-000000000007', 4, NULL, NULL, 'retiro', 200.00, 'USD', 'Extracción en cajero automático', '2026-10-22 09:45:00', 'completada'),
    (8, '8f14e45f-ea2b-4c3d-9a1b-000000000008', 5, NULL, NULL, 'pago', 12000.00, 'ARS', 'Débito por compra online', '2026-10-22 10:20:00', 'completada'),
    (9, '8f14e45f-ea2b-4c3d-9a1b-000000000009', 6, 1, NULL, 'transferencia', 25000.00, 'ARS', 'Transferencia a Juan Pérez', '2026-10-22 11:00:00', 'completada'),
    (10, '8f14e45f-ea2b-4c3d-9a1b-000000000010', 7, NULL, NULL, 'debito_automatico', 15000.00, 'ARS', 'Débito automático de seguro', '2026-10-22 11:30:00', 'completada'),
    (11, '8f14e45f-ea2b-4c3d-9a1b-000000000011', 8, NULL, NULL, 'deposito', 500.00, 'USD', 'Depósito en dólares', '2026-10-20 16:15:00', 'completada'),
    (12, '8f14e45f-ea2b-4c3d-9a1b-000000000012', 3, NULL, NULL, 'retiro', 10000.00, 'ARS', 'Extracción en cajero pendiente de confirmación', '2026-10-22 12:10:00', 'pendiente'),
    (13, '8f14e45f-ea2b-4c3d-9a1b-000000000013', 5, 2, NULL, 'transferencia', 30000.00, 'ARS', 'Transferencia rechazada por saldo insuficiente', '2026-10-21 17:45:00', 'rechazada'),
    (14, '8f14e45f-ea2b-4c3d-9a1b-000000000014', 4, NULL, NULL, 'pago', 300.00, 'USD', 'Pago con tarjeta de débito', '2026-10-19 20:10:00', 'completada'),
    (15, '8f14e45f-ea2b-4c3d-9a1b-000000000015', 2, NULL, 3, 'deposito', 200000.00, 'ARS', 'Depósito de haberes', '2026-10-15 08:00:00', 'completada'),
    (16, '8f14e45f-ea2b-4c3d-9a1b-000000000016', 6, NULL, 4, 'retiro', 18000.00, 'ARS', 'Extracción por ventanilla', '2026-10-16 13:25:00', 'completada');

INSERT INTO prestamos (
    id_prestamo, numero_prestamo, id_cliente, id_sucursal, id_empleado,
    monto, interes, plazo, fecha_solicitud,
    fecha_aprobacion, fecha_vencimiento, saldo_pendiente, estado
) VALUES
    (1, 'PRE-2026-0001', '123e4567-e89b-12d3-a456-426614174000', 1, 3, 2000000.00, 0.0450, 24, '2026-01-15', '2026-01-20', '2028-01-20', 1450000.00, 'aprobado'),
    (2, 'PRE-2026-0002', '123e4567-e89b-12d3-a456-426614174001', 2, 5, 800000.00, 0.0520, 12, '2026-03-05', '2026-03-08', '2027-03-08', 320000.00, 'aprobado'),
    (3, 'PRE-2025-0003', '123e4567-e89b-12d3-a456-426614174002', 1, 3, 500000.00, 0.0600, 6, '2025-08-10', '2025-08-12', '2026-02-12', 0.00, 'pagado'),
    (4, 'PRE-2026-0004', '123e4567-e89b-12d3-a456-426614174003', 3, 4, 3500000.00, 0.0390, 36, '2026-06-01', '2026-06-05', '2029-06-05', 3100000.00, 'aprobado'),
    (5, 'PRE-2026-0005', '123e4567-e89b-12d3-a456-426614174004', 4, 5, 1200000.00, 0.0480, 18, '2026-10-20', NULL, NULL, 0.00, 'solicitado'),
    (6, 'PRE-2025-0006', '123e4567-e89b-12d3-a456-426614174005', 2, 5, 600000.00, 0.0580, 12, '2025-11-10', '2025-11-15', '2026-11-15', 600000.00, 'en_mora');
