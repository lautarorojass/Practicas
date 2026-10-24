USE sistema_bancario;

SELECT nombre, apellido, correo
FROM clientes
WHERE id_cliente = '123e4567-e89b-12d3-a456-426614174000';

SELECT
    c.id_cliente,
    c.nombre,
    c.apellido,
    c.correo,
    c.telefono,
    s.nombre AS sucursal,
    c.fecha_alta,
    c.activo
FROM clientes c
JOIN sucursales s ON s.id_sucursal = c.id_sucursal
WHERE c.id_cliente = '123e4567-e89b-12d3-a456-426614174000';

SELECT
    c.nombre,
    c.apellido,
    cu.numero_cuenta,
    tc.nombre AS tipo_cuenta,
    cu.moneda,
    cu.saldo,
    cu.estado,
    s.nombre AS sucursal
FROM clientes c
JOIN cuentas cu ON cu.id_cliente = c.id_cliente
JOIN tipos_de_cuenta tc ON tc.id_tipo_cuenta = cu.id_tipo_cuenta
JOIN sucursales s ON s.id_sucursal = cu.id_sucursal
WHERE c.id_cliente = '123e4567-e89b-12d3-a456-426614174000'
ORDER BY cu.fecha_apertura;

SELECT
    t.numero_operacion,
    t.fecha,
    t.tipo,
    t.monto,
    t.moneda,
    t.estado,
    cu.numero_cuenta AS cuenta_origen,
    cd.numero_cuenta AS cuenta_destino,
    t.descripcion
FROM transacciones t
JOIN cuentas cu ON cu.id_cuenta = t.id_cuenta
LEFT JOIN cuentas cd ON cd.id_cuenta = t.id_cuenta_destino
WHERE cu.id_cliente = '123e4567-e89b-12d3-a456-426614174000'
ORDER BY t.fecha DESC
LIMIT 10;

SELECT
    t.numero_operacion,
    t.fecha,
    t.tipo,
    t.monto,
    t.moneda,
    t.descripcion,
    t.estado
FROM transacciones t
WHERE t.id_cuenta = 1
ORDER BY t.fecha DESC
LIMIT 5;

SELECT
    c.id_cliente,
    c.nombre,
    c.apellido,
    MAX(t.fecha) AS ultima_transaccion
FROM clientes c
JOIN cuentas cu ON cu.id_cliente = c.id_cliente
JOIN transacciones t ON t.id_cuenta = cu.id_cuenta
WHERE c.activo = TRUE
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY ultima_transaccion DESC;

SELECT
    c.nombre,
    c.apellido,
    p.numero_prestamo,
    p.monto,
    p.interes,
    p.plazo,
    p.saldo_pendiente,
    p.estado
FROM prestamos p
JOIN clientes c ON c.id_cliente = p.id_cliente
WHERE p.estado IN ('aprobado', 'en_mora')
ORDER BY p.saldo_pendiente DESC;

SELECT
    t.numero_operacion AS transaccion_id,
    c.id_cliente,
    CONCAT('****', RIGHT(cu.numero_cuenta, 4)) AS cuenta_enmascarada,
    t.tipo,
    t.monto,
    t.moneda,
    t.fecha,
    t.descripcion,
    t.estado
FROM transacciones t
JOIN cuentas cu ON cu.id_cuenta = t.id_cuenta
JOIN clientes c ON c.id_cliente = cu.id_cliente
WHERE t.fecha >= NOW() - INTERVAL 30 DAY
ORDER BY t.fecha DESC;

SELECT
    s.nombre AS sucursal,
    COUNT(DISTINCT c.id_cliente) AS cantidad_clientes,
    COUNT(DISTINCT cu.id_cuenta) AS cantidad_cuentas,
    SUM(cu.saldo) AS saldo_total
FROM sucursales s
JOIN clientes c ON c.id_sucursal = s.id_sucursal
JOIN cuentas cu ON cu.id_cliente = c.id_cliente
GROUP BY s.id_sucursal, s.nombre
ORDER BY s.nombre;
