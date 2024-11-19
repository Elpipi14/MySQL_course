    ------------------------------------------------------------------------------------
------------------------------ Trigger ---------------------------------------------

--Facturacion cuando el cliente ahce el pago.
DELIMITER $$

CREATE TRIGGER generar_factura
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN
    DECLARE fecha_inicio DATE;
    DECLARE fecha_fin DATE;

    -- La membresía dura un mes a partir de la fecha del pago
    SET fecha_inicio = DATE(NEW.fecha_pago); -- Fecha del pago
    SET fecha_fin = DATE_ADD(fecha_inicio, INTERVAL 1 MONTH); -- Suma un mes

    -- Inserta la nueva factura en la tabla facturacion
    INSERT INTO facturacion (id_pago, fecha_inicio, fecha_fin, fecha_generacion)
    VALUES (NEW.id_pago, fecha_inicio, fecha_fin, CURDATE());
END$$

DELIMITER ;


--Registra el historial cuando el cliente hace la reserva
DELIMITER $$

CREATE TRIGGER registrar_historial_reserva
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
    -- Inserta automáticamente en historial_reservas usando los datos de la nueva reserva
    INSERT INTO historial_reservas (id_usuario, id_horario, fecha_reserva)
    VALUES (NEW.id_usuario, NEW.id_horario, NEW.fecha_reserva);
END$$

DELIMITER ;

--------------------------------------------------------------------------------
--------------------------- Listado de Vistas ----------------------------------

--  1. Vista: vista_usuarios_activos
--  Descripción:
--  Esta vista muestra una lista de usuarios activos junto con su tipo de membresía, el número de pagos realizados y la última fecha de pago. Es útil para monitorear a los clientes activos en el gimnasio.

--Objetivo:
--Identificar usuarios que están activos en el sistema.
--Facilitar la gestión de usuarios por parte del personal administrativo.
--Tablas Compuestas:
--usuarios

CREATE VIEW vista_usuarios_activos AS
SELECT 
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido) AS nombre_completo,
    m.tipo_membresia,
    COUNT(p.id_pago) AS pagos_realizados,
    MAX(p.fecha_pago) AS ultima_fecha_pago
FROM usuarios u
LEFT JOIN membresias m ON u.id_membresia = m.id_membresia
LEFT JOIN pagos p ON u.id_usuario = p.id_usuario
GROUP BY u.id_usuario, m.tipo_membresia;

SELECT * FROM vista_usuarios_activos;

-- 2. Vista: vista_clases_horarios
-- Descripción:
-- Muestra las clases programadas junto con sus horarios, los entrenadores responsables y las descripciones de las clases.

-- Objetivo:
-- Ayudar a los clientes a visualizar las opciones de clases disponibles.
-- Facilitar la planificación de horarios para los entrenadores.
-- Tablas Compuestas:
-- clases
-- horarios
-- entrenadores

CREATE VIEW vista_clases_horarios AS
SELECT 
    c.id_clase,
    c.nombre AS nombre_clase,
    c.descripcion,
    CONCAT(e.nombre_completo, ' (', e.especialidad, ')') AS entrenador,
    h.dia_semana,
    h.hora_inicio,
    h.hora_fin
FROM clases c
INNER JOIN entrenadores e ON c.id_entrenador = e.id_entrenador
INNER JOIN horarios h ON c.id_clase = h.id_clase;

SELECT * FROM vista_clases_horarios;

-- 3. Vista: vista_reservas_por_usuario
-- Descripción:
-- Lista las reservas realizadas por cada usuario, incluyendo los detalles de las clases, horarios y el estado actual de las reservas.

-- Objetivo:
-- Brindar un resumen de las reservas por cliente para mejorar la experiencia de usuario.
-- Ayudar al personal administrativo a gestionar las reservas y su estado.
-- Tablas Compuestas:
-- reservas
-- usuarios
-- horarios
-- clases

CREATE VIEW vista_reservas_por_usuario AS
SELECT 
    r.id_reserva,
    CONCAT(u.nombre, ' ', u.apellido) AS usuario,
    c.nombre AS clase,
    h.dia_semana,
    h.hora_inicio,
    h.hora_fin,
    r.fecha_reserva,
    r.fecha_clase,
    r.estado_reserva
FROM reservas r
INNER JOIN usuarios u ON r.id_usuario = u.id_usuario
INNER JOIN horarios h ON r.id_horario = h.id_horario
INNER JOIN clases c ON h.id_clase = c.id_clase;

SELECT * FROM vista_reservas_por_usuario;

-- 4. Vista: vista_facturacion_mensual
-- Descripción:
-- Proporciona un resumen de facturación mensual, mostrando el total recaudado, el número de facturas emitidas y las membresías asociadas.

-- Objetivo:
-- Monitorear los ingresos mensuales del gimnasio.
-- Proporcionar estadísticas financieras a la gerencia.
-- Tablas Compuestas:
-- facturacion
-- pagos
-- membresias

CREATE VIEW vista_facturacion_mensual AS
SELECT 
    DATE_FORMAT(f.fecha_generacion, '%Y-%m') AS mes,
    COUNT(f.id_factura) AS total_facturas,
    SUM(p.monto) AS ingresos_totales,
    GROUP_CONCAT(DISTINCT m.tipo_membresia) AS membresias_asociadas
FROM facturacion f
INNER JOIN pagos p ON f.id_pago = p.id_pago
INNER JOIN usuarios u ON p.id_usuario = u.id_usuario
INNER JOIN membresias m ON u.id_membresia = m.id_membresia
GROUP BY DATE_FORMAT(f.fecha_generacion, '%Y-%m');

SELECT * FROM vista_facturacion_mensual;

-- 5. Vista: vista_uso_membresias
-- Descripción:
-- Muestra cuántos usuarios están inscritos en cada tipo de membresía, junto con el número total de clases reservadas por tipo de membresía.

-- Objetivo:
-- Analizar el uso de cada tipo de membresía.
-- Tomar decisiones estratégicas sobre precios y promociones basadas en el uso.
-- Tablas Compuestas:
-- membresias
-- usuarios
-- reservas

CREATE VIEW vista_uso_membresias AS
SELECT 
    m.tipo_membresia,
    COUNT(u.id_usuario) AS usuarios_inscritos,
    COUNT(r.id_reserva) AS clases_reservadas
FROM membresias m
LEFT JOIN usuarios u ON m.id_membresia = u.id_membresia
LEFT JOIN reservas r ON u.id_usuario = r.id_usuario
GROUP BY m.tipo_membresia;

--------------------------------------------------------------------------------
------------------------  Listado de Funciones ---------------------------------

-- 1. Función: cantidad_tipo_membresia_por_usuario
-- Descripción:
-- Calcula la cantidad de usuarios para cada tipo de membresía.

-- Objetivo:
-- Obtener una visión general del número de usuarios inscritos en cada tipo de membresía.
-- Ayudar a identificar las membresías más populares.

DELIMITER $$

CREATE PROCEDURE cantidad_tipo_membresia_por_usuario()
BEGIN
    SELECT 
        m.tipo_membresia,
        COUNT(u.id_usuario) AS cantidad_usuarios
    FROM membresias m
    LEFT JOIN usuarios u ON m.id_membresia = u.id_membresia
    GROUP BY m.tipo_membresia;
END$$

DELIMITER ;

CALL cantidad_tipo_membresia_por_usuario();

--------------------------------------------------------------------------------
((REVISAR DE ACA PARA ABJO PARA TERMINAR LA ENTREGA))
-- 2. Función: cantidad_pagos_por_cliente
-- Descripción:
-- Calcula la cantidad de pagos realizados por cada cliente.

-- Objetivo:
-- Proporcionar un desglose del número de pagos realizados por cada cliente.
-- Facilitar el monitoreo de la frecuencia de pago de los usuarios.

DELIMITER $$
CREATE FUNCTION cantidad_pagos_por_cliente()
RETURNS TABLE(nombre_cliente VARCHAR(200), cantidad_pagos INT)
DETERMINISTIC
BEGIN
    RETURN (
        SELECT 
            CONCAT(u.nombre, ' ', u.apellido) AS nombre_cliente,
            COUNT(p.id_pago) AS cantidad_pagos
        FROM usuarios u
        LEFT JOIN pagos p ON u.id_usuario = p.id_usuario
        GROUP BY u.id_usuario
    );
END$$

DELIMITER ;

-- Uso de la Función:
SELECT * FROM cantidad_pagos_por_cliente();

--------------------------------------------------------------------------------

-- 3. Función: facturacion_total_por_mes
-- Descripción:
-- Calcula el monto total facturado en cada mes.

-- Objetivo:
-- Proporcionar un resumen financiero mensual.
-- Ayudar a la gerencia a monitorear los ingresos mensuales.

DELIMITER $$
CREATE FUNCTION facturacion_total_por_mes()
RETURNS TABLE(mes VARCHAR(7), total_facturado DECIMAL(10, 2))
DETERMINISTIC
BEGIN
    RETURN (
        SELECT 
            DATE_FORMAT(f.fecha_generacion, '%Y-%m') AS mes,
            SUM(p.monto) AS total_facturado
        FROM facturacion f
        INNER JOIN pagos p ON f.id_pago = p.id_pago
        GROUP BY DATE_FORMAT(f.fecha_generacion, '%Y-%m')
        ORDER BY mes;
    );
END$$
DELIMITER ;

-- Uso de la Función:
SELECT * FROM facturacion_total_por_mes();

--------------------------------------------------------------------------------
---------------------------- Stored Procedure ----------------------------------

-- 1. Stored Procedure: sp_agregar_reserva
-- Descripción:
-- Este procedimiento almacena una nueva reserva para un usuario en una clase específica. También actualiza el historial de reservas automáticamente.

-- Objetivo:
-- Automatizar el proceso de agregar una reserva para un usuario.
-- Garantizar la consistencia al registrar simultáneamente la reserva y el historial.
-- Beneficio:
-- Simplifica la inserción de reservas desde la aplicación o interfaz de usuario.
-- Reduce errores al manejar automáticamente las dependencias entre reservas y historial_reservas.
-- Tablas Utilizadas:
-- reservas
-- historial_reservas

DELIMITER $$
CREATE PROCEDURE sp_agregar_reserva(
    IN p_id_usuario INT,
    IN p_id_horario INT,
    IN p_fecha_reserva DATETIME,
    IN p_fecha_clase DATETIME
)
BEGIN
    -- Insertar nueva reserva
    INSERT INTO reservas (id_usuario, id_horario, fecha_reserva, fecha_clase, estado_reserva)
    VALUES (p_id_usuario, p_id_horario, p_fecha_reserva, p_fecha_clase, 'activa');

    -- Insertar en historial de reservas
    INSERT INTO historial_reservas (id_usuario, id_horario, fecha_reserva)
    VALUES (p_id_usuario, p_id_horario, p_fecha_reserva);
END$$

DELIMITER ;

-- Uso del Procedimiento:
CALL sp_agregar_reserva(1, 4, NOW(), '2024-12-10 08:00:00');

------------------------------------------------------------------------------------

-- 2. Stored Procedure: sp_generar_factura
-- Descripción:
-- Genera una factura para un pago específico, calculando las fechas de inicio y fin de la membresía asociada.

-- Objetivo:
-- Automatizar la creación de facturas relacionadas con pagos de usuarios.
-- Calcular automáticamente las fechas de vigencia de la membresía.
-- Beneficio:
-- Asegura que las facturas se generen de manera uniforme y consistente.
-- Reduce la complejidad de manejar las facturas manualmente.
-- Tablas Utilizadas:
-- facturacion
-- pagos

DELIMITER $$
CREATE PROCEDURE sp_generar_factura(
    IN p_id_pago INT
)
BEGIN
    DECLARE fecha_inicio DATE;
    DECLARE fecha_fin DATE;

    -- Obtener la fecha del pago
    SELECT DATE(fecha_pago)
    INTO fecha_inicio
    FROM pagos
    WHERE id_pago = p_id_pago;

    -- Calcular la fecha fin sumando 1 mes
    SET fecha_fin = DATE_ADD(fecha_inicio, INTERVAL 1 MONTH);

    -- Insertar la factura
    INSERT INTO facturacion (id_pago, fecha_inicio, fecha_fin, fecha_generacion)
    VALUES (p_id_pago, fecha_inicio, fecha_fin, CURDATE());
END$$

DELIMITER ;

-- Uso del Procedimiento:
-- CALL sp_generar_factura(3);

------------------------------------------------------------------------------------

-- 3. Stored Procedure: sp_reporte_facturacion_mensual
-- Descripción:
-- Genera un reporte de la facturación total por mes, mostrando el mes, el número de facturas emitidas y el monto total.

-- Objetivo:
-- Proveer un resumen financiero mensual del gimnasio.
-- Facilitar la generación de reportes para el análisis de ingresos.
-- Beneficio:
-- Permite generar reportes rápidos y reutilizables.
-- Proporciona información clave para la toma de decisiones financieras.
-- Tablas Utilizadas:
-- facturacion
-- pagos

DELIMITER $$
CREATE PROCEDURE sp_reporte_facturacion_mensual()
BEGIN
    SELECT 
        DATE_FORMAT(f.fecha_generacion, '%Y-%m') AS mes,
        COUNT(f.id_factura) AS total_facturas,
        SUM(p.monto) AS total_facturado
    FROM facturacion f
    INNER JOIN pagos p ON f.id_pago = p.id_pago
    GROUP BY DATE_FORMAT(f.fecha_generacion, '%Y-%m')
    ORDER BY mes;
END$$

DELIMITER ;

-- Uso del Procedimiento:
CALL sp_reporte_facturacion_mensual();
Resumen de Stored Procedures
sp_agregar_reserva:

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Objetivo: Insertar una nueva reserva y actualizar el historial de reservas.
-- Beneficio: Automatiza el proceso de reservas, reduciendo errores.
-- Tablas: reservas, historial_reservas.
-- sp_generar_factura:

-- Objetivo: Generar una factura para un pago específico.
-- Beneficio: Asegura la consistencia en la generación de facturas.
-- Tablas: facturacion, pagos.
-- sp_reporte_facturacion_mensual:

-- Objetivo: Proveer un resumen mensual de facturación.
-- Beneficio: Simplifica la generación de reportes financieros.
-- Tablas: facturacion, pagos.

