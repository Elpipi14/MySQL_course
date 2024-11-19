INSERT INTO membresias (tipo_membresia, precio, clases_por_semana)
VALUES 
('Básica', 100.00, 3),
('Premium', 250.00, 5),
('Ilimitada', 500.00, 7);

-- INSERTAR DATOS EN LA TABLA USUARIOS
INSERT INTO usuarios (nombre, apellido, email, telefono, direccion, fecha_registro, id_membresia)
VALUES 
('Carlos', 'Pérez', 'carlos.perez@gmail.com', '123456789', 'Av. Principal 123', '2024-01-01', 1),
('Ana', 'López', 'ana.lopez@gmail.com', '987654321', 'Calle Secundaria 456', '2024-01-02', 2),
('Juan', 'Gómez', 'juan.gomez@gmail.com', '234567890', 'Av. Central 789', '2024-01-03', 3),
('María', 'Rodríguez', 'maria.rodriguez@gmail.com', '345678901', 'Calle Norte 101', '2024-01-04', 1),
('Pedro', 'Hernández', 'pedro.hernandez@gmail.com', '456789012', 'Av. Sur 102', '2024-01-05', 3),
('Laura', 'Martínez', 'laura.martinez@gmail.com', '', 'Calle Este 103', '2024-01-06', 3),
('Luis', 'García', 'luis.garcia@gmail.com', '678901234', 'Av. Oeste 104', '2024-01-07', 1);



-- INSERTAR DATOS EN LA TABLA ENTRENADORES
INSERT INTO entrenadores (nombre_completo, especialidad)
VALUES 
('María González', 'Yoga'),
('Juan Ramírez', 'Gimnasio'),
('Luis Torres', 'CrossFit'),
('Marcelo Dam', 'PowerLifting'),
('Lucia Villa', 'Spinning');

-- INSERTAR DATOS EN LA TABLA CLASES
INSERT INTO clases (nombre, descripcion, duracion, id_entrenador)
VALUES 
('Yoga', 'Clases de relajación y estiramiento.', '01:00:00', 1),
('Gimnasio', 'Fortalecimiento muscular.', '01:30:00', 2),
('CrossFit', 'Entrenamiento de alta intensidad.', '01:15:00', 3),
('PowerLifting', 'Entrenamiento para levantamiento de pesas.', '01:45:00', 4),
('Spinning', 'Ejercicios de resistencia cardiovascular.', '01:00:00', 5);

-- INSERTAR DATOS EN LA TABLA HORARIOS
INSERT INTO horarios (id_clase, dia_semana, hora_inicio, hora_fin)
VALUES 
-- Yoga
(1, 'Lunes', '08:00:00', '09:00:00'),
(1, 'Miércoles', '10:00:00', '11:00:00'),
(1, 'Viernes', '18:00:00', '19:00:00'),

-- Gimnasio
(2, 'Martes', '10:00:00', '11:30:00'),
(2, 'Jueves', '16:00:00', '17:30:00'),
(2, 'Sábado', '09:00:00', '10:30:00'),

-- CrossFit
(3, 'Miércoles', '18:00:00', '19:15:00'),
(3, 'Viernes', '07:00:00', '08:15:00'),
(3, 'Sábado', '17:00:00', '18:15:00'),

-- PowerLifting
(4, 'Lunes', '17:00:00', '18:45:00'),
(4, 'Jueves', '10:00:00', '11:45:00'),
(4, 'Sábado', '14:00:00', '15:45:00'),

-- Spinning
(5, 'Martes', '07:00:00', '08:00:00'),
(5, 'Jueves', '19:00:00', '20:00:00'),
(5, 'Domingo', '10:00:00', '11:00:00');

--(insertar reservas y pagos despues de aplicar los triggers haci se acutualiza sus historiales)----

-- Inserción de datos en la tabla Reservas
INSERT INTO reservas (id_horario, id_usuario, fecha_reserva, fecha_clase)
VALUES
(4, 4, now(), '2024-12-06 10:00:00'), -- Usuario 4 reserva clase 4
(5, 5, now(), '2024-12-07 07:00:00'), -- Usuario 5 reserva clase 5
(6, 6, now(), '2024-12-08 18:00:00'), -- Usuario 6 reserva clase 6
(7, 7, now(), '2024-12-09 17:00:00'); -- Usuario 7 reserva clase 7



-- INSERTAR DATOS EXTENDIDOS EN LA TABLA PAGOS
INSERT INTO pagos (id_usuario, monto, fecha_pago, metodo_pago, estado_pago)
VALUES 
-- Pagos para el usuario 1 
(1, 100.00, '2024-01-05 10:00:00', 'Efectivo', 'pagado'),
(1, 100.00, '2024-02-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(1, 100.00, '2024-03-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(1, 100.00, '2024-04-05 10:00:00', 'Efectivo', 'pagado'),
(1, 100.00, '2024-05-05 10:00:00', 'Transferencia', 'pagado'),
(1, 100.00, '2024-06-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(1, 100.00, '2024-07-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(1, 100.00, '2024-08-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(1, 100.00, '2024-09-05 10:00:00', 'Efectivo', 'pagado'),
(1, 100.00, '2024-10-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(1, 100.00, '2024-11-05 10:00:00', 'Transferencia', 'pagado'),

-- Pagos para el usuario 2 
(2, 250.00, '2024-01-06 14:00:00', 'Tarjeta de Crédito', 'pagado'),
(2, 250.00, '2024-02-06 14:00:00', 'PayPal', 'pagado'),
(2, 250.00, '2024-03-06 14:00:00', 'Efectivo', 'pagado'),
(2, 250.00, '2024-04-06 14:00:00', 'PayPal', 'pagado'),
(2, 250.00, '2024-05-06 14:00:00', 'PayPal', 'pagado'),
(2, 250.00, '2024-06-06 14:00:00', 'Tarjeta de Crédito', 'pagado'),
(2, 250.00, '2024-07-06 14:00:00', 'Transferencia', 'pagado'),
(2, 250.00, '2024-08-06 14:00:00', 'PayPal', 'pagado'),
(2, 250.00, '2024-09-06 14:00:00', 'Tarjeta de Crédito', 'pagado'),
(2, 250.00, '2024-10-06 14:00:00', 'PayPal', 'pagado'),
(2, 250.00, '2024-11-06 14:00:00', 'Efectivo', 'pagado'),

-- Pagos para el usuario 3 
(3, 500.00, '2024-01-10 11:00:00', 'Efectivo', 'pagado'),
(3, 500.00, '2024-02-10 11:00:00', 'Efectivo', 'pagado'),
(3, 500.00, '2024-03-10 11:00:00', 'PayPal', 'pagado'),
(3, 500.00, '2024-04-10 11:00:00', 'Efectivo', 'pagado'),
(3, 500.00, '2024-05-10 11:00:00', 'Efectivo', 'pagado'),
(3, 500.00, '2024-06-10 11:00:00', 'Efectivo', 'pagado'),
(3, 500.00, '2024-07-10 11:00:00', 'PayPal', 'pagado'),
(3, 500.00, '2024-08-10 11:00:00', 'Transferencia', 'pagado'),
(3, 500.00, '2024-09-10 11:00:00', 'Efectivo', 'pagado'),
(3, 500.00, '2024-10-10 11:00:00', 'Efectivo', 'pagado'),
(3, 500.00, '2024-11-10 11:00:00', 'Transferencia', 'pagado'),

-- Pagos para el usuario 4
(4, 100.00, '2024-01-10 11:00:00', 'Efectivo', 'pagado'),
(4, 100.00, '2024-02-10 11:00:00', 'Efectivo', 'pagado'),
(4, 100.00, '2024-03-10 11:00:00', 'PayPal', 'pagado'),
(4, 100.00, '2024-04-10 11:00:00', 'Efectivo', 'pagado'),
(4, 100.00, '2024-05-10 11:00:00', 'Efectivo', 'pagado'),
(4, 100.00, '2024-06-10 11:00:00', 'Efectivo', 'pagado'),
(4, 100.00, '2024-07-10 11:00:00', 'PayPal', 'pagado'),
(4, 100.00, '2024-08-10 11:00:00', 'Transferencia', 'pagado'),
(4, 100.00, '2024-09-10 11:00:00', 'Efectivo', 'pagado'),
(4, 100.00, '2024-10-10 11:00:00', 'Efectivo', 'pagado'),
(4, 100.00, '2024-11-10 11:00:00', 'Transferencia', 'pagado'),

-- Pagos para el usuario 5
(5, 500.00, '2024-01-10 11:00:00', 'Efectivo', 'pagado'),
(5, 500.00, '2024-02-10 11:00:00', 'Efectivo', 'pagado'),
(5, 500.00, '2024-03-10 11:00:00', 'PayPal', 'pagado'),
(5, 500.00, '2024-04-10 11:00:00', 'Efectivo', 'pagado'),
(5, 500.00, '2024-05-10 11:00:00', 'Efectivo', 'pagado'),
(5, 500.00, '2024-06-10 11:00:00', 'Efectivo', 'pagado'),
(5, 500.00, '2024-07-10 11:00:00', 'PayPal', 'pagado'),
(5, 500.00, '2024-08-10 11:00:00', 'Transferencia', 'pagado'),
(5, 500.00, '2024-09-10 11:00:00', 'Efectivo', 'pagado'),
(5, 500.00, '2024-10-10 11:00:00', 'Efectivo', 'pagado'),
(5, 500.00, '2024-11-10 11:00:00', 'Transferencia', 'pagado'),

-- Pagos para el usuario 6
(6, 500.00, '2024-01-10 11:00:00', 'Efectivo', 'pagado'),
(6, 500.00, '2024-02-10 11:00:00', 'Efectivo', 'pagado'),
(6, 500.00, '2024-03-10 11:00:00', 'PayPal', 'pagado'),
(6, 500.00, '2024-04-10 11:00:00', 'Efectivo', 'pagado'),
(6, 500.00, '2024-05-10 11:00:00', 'Efectivo', 'pagado'),
(6, 500.00, '2024-06-10 11:00:00', 'Efectivo', 'pagado'),
(6, 500.00, '2024-07-10 11:00:00', 'PayPal', 'pagado'),
(6, 500.00, '2024-08-10 11:00:00', 'Transferencia', 'pagado'),
(6, 500.00, '2024-09-10 11:00:00', 'Efectivo', 'pagado'),
(6, 500.00, '2024-10-10 11:00:00', 'Efectivo', 'pagado'),
(6, 500.00, '2024-11-10 11:00:00', 'Transferencia', 'pagado'),

-- Pagos para el usuario 7
(7, 100.00, '2024-01-05 10:00:00', 'Efectivo', 'pagado'),
(7, 100.00, '2024-02-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(7, 100.00, '2024-03-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(7, 100.00, '2024-04-05 10:00:00', 'Efectivo', 'pagado'),
(7, 100.00, '2024-05-05 10:00:00', 'Transferencia', 'pagado'),
(7, 100.00, '2024-06-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(7, 100.00, '2024-07-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(7, 100.00, '2024-08-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(7, 100.00, '2024-09-05 10:00:00', 'Efectivo', 'pagado'),
(7, 100.00, '2024-10-05 10:00:00', 'Tarjeta de Crédito', 'pagado'),
(7, 100.00, '2024-11-05 10:00:00', 'Transferencia', 'pagado');


-- INSERT INTO facturacion (id_pago, fecha_inicio, fecha_fin, fecha_generacion)
-- VALUES
-- (3, '2024-03-01', '2024-03-31', '2024-03-01'),
-- (4, '2024-04-01', '2024-04-30', '2024-04-01'),
-- (5, '2024-05-01', '2024-05-31', '2024-05-01'),
-- (6, '2024-06-01', '2024-06-30', '2024-06-01'),
-- (7, '2024-07-01', '2024-07-31', '2024-07-01'),
-- (8, '2024-08-01', '2024-08-31', '2024-08-01'),
-- (9, '2024-09-01', '2024-09-30', '2024-09-01'),
-- (10, '2024-10-01', '2024-10-31', '2024-10-01'),
-- (11, '2024-11-01', '2024-11-30', '2024-11-01'),
-- (12, '2024-12-01', '2024-12-31', '2024-12-01');

-- INSERT INTO historial_reservas (id_usuario, id_horario, fecha_reserva)
-- VALUES
-- -- Usuario 1
-- (1, 4, '2024-01-10 17:00:00'),
-- (1, 5, '2024-01-12 19:00:00'),
-- (1, 6, '2024-01-14 08:00:00'),

-- -- Usuario 2
-- (2, 7, '2024-01-15 18:00:00'),
-- (2, 8, '2024-01-20 07:30:00'),
-- (2, 9, '2024-01-22 17:00:00'),

-- -- Usuario 3
-- (3, 10, '2024-02-05 10:00:00'),
-- (3, 11, '2024-02-10 14:00:00'),
-- (3, 12, '2024-02-15 10:30:00'),

-- -- Usuario 4
-- (4, 13, '2024-03-05 07:00:00'),
-- (4, 14, '2024-03-07 19:00:00'),
-- (4, 15, '2024-03-10 10:00:00'),

-- -- Usuario 5
-- (5, 16, '2024-04-01 08:00:00'),
-- (5, 17, '2024-04-03 09:30:00'),
-- (5, 18, '2024-04-05 11:00:00'),

-- -- Usuario 6
-- (6, 19, '2024-05-06 18:00:00'),
-- (6, 20, '2024-05-08 07:00:00'),
-- (6, 21, '2024-05-10 17:00:00'),

-- -- Usuario 7
-- (7, 22, '2024-06-01 10:00:00'),
-- (7, 23, '2024-06-03 11:30:00'),
-- (7, 24, '2024-06-05 08:15:00');

