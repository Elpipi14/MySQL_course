-- Elimina la base de datos db_gimnasio si existe
DROP DATABASE IF EXISTS db_gimnasio;

-- Creación de la base de datos db_gimnasio
CREATE DATABASE IF NOT EXISTS db_gimnasio;

-- Usar la base de datos
USE db_gimnasio;

-- Tabla Membresías
CREATE TABLE membresias (
    id_membresia INT PRIMARY KEY AUTO_INCREMENT,   -- Identificador único de la membresía
    tipo_membresia VARCHAR(30) NOT NULL UNIQUE,    -- Nombre de la membresía 
    precio DECIMAL(10, 2) NOT NULL,                -- Precio de la membresía
    clases_por_semana INT NOT NULL                 -- Número de clases permitidas por semana
);

-- Tabla Usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,      -- Identificador único del usuario
    nombre VARCHAR(100) NOT NULL,                   -- Nombre del usuario
    apellido VARCHAR(100) NOT NULL,                 -- Apellido del usuario
    email VARCHAR(50) NOT NULL UNIQUE,              -- Correo electrónico del usuario
    telefono VARCHAR(15),                           -- Teléfono del usuario
    direccion VARCHAR(100),                         -- Dirección del usuario
    fecha_registro DATE NOT NULL,                   -- Fecha en la que el usuario se registró
    id_membresia INT,                               -- Relación con la tabla membresías
    FOREIGN KEY (id_membresia) REFERENCES membresias(id_membresia)
);

-- Tabla Pagos
CREATE TABLE pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,         -- Identificador único del pago
    id_usuario INT NOT NULL,                        -- Identificador del usuario que realiza el pago
    monto DECIMAL(10, 2) NOT NULL,                  -- Monto del pago
    fecha_pago DATETIME NOT NULL,                   -- Fecha y hora en que se realizó el pago
    metodo_pago VARCHAR(50) NOT NULL,               -- Método de pago
    estado_pago ENUM('pendiente', 'pagado', 'rechazado') NOT NULL,  -- Estado del pago
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla Facturación
CREATE TABLE facturacion (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,      -- Identificador único de la factura
    id_pago INT NOT NULL,                           -- Identificador del pago relacionado
    fecha_inicio DATE NOT NULL,                     -- Fecha en la que se activa la membresía
    fecha_fin DATE NOT NULL,                        -- Fecha en la que finaliza la membresía
    fecha_generacion DATE NOT NULL,                 -- Fecha de generación de la factura
    FOREIGN KEY (id_pago) REFERENCES pagos(id_pago)
);

-- Tabla Entrenadores
CREATE TABLE entrenadores (
    id_entrenador INT PRIMARY KEY AUTO_INCREMENT,   -- Identificador único del entrenador
    nombre_completo VARCHAR(100) NOT NULL,          -- Nombre completo del entrenador
    especialidad VARCHAR(50) NOT NULL               -- Especialidad del entrenador
);

-- Tabla Clases
CREATE TABLE clases (
    id_clase INT PRIMARY KEY AUTO_INCREMENT,        -- Identificador único de la clase
    nombre VARCHAR(100) NOT NULL,                   -- Nombre de la clase
    descripcion VARCHAR(255),                       -- Descripción de la clase (más largo)
    duracion TIME,                                  -- Duración de la clase
    id_entrenador INT,                              -- Identificador del entrenador
    FOREIGN KEY (id_entrenador) REFERENCES entrenadores(id_entrenador)
);

-- Tabla Horarios
CREATE TABLE horarios (
    id_horario INT PRIMARY KEY AUTO_INCREMENT,      -- Identificador único del horario
    id_clase INT NOT NULL,                          -- Identificador de la clase
    dia_semana ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo') NOT NULL, -- Día de la semana
    hora_inicio TIME NOT NULL,                      -- Hora de inicio
    hora_fin TIME NOT NULL,                         -- Hora de fin
    FOREIGN KEY (id_clase) REFERENCES clases(id_clase)
);

-- Tabla Reservas
CREATE TABLE reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,      -- Identificador único de la reserva
    id_horario INT NOT NULL,                        -- Identificador del horario
    id_usuario INT NOT NULL,                        -- Identificador del usuario
    fecha_reserva DATETIME NOT NULL,                -- Fecha y hora de la reserva
    fecha_clase DATETIME NOT NULL,                  -- Fecha y hora de la clase reservada
    estado_reserva ENUM('activa', 'cancelada', 'completada') DEFAULT 'activa', -- Estado de la reserva
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_horario) REFERENCES horarios(id_horario)
);

-- Tabla Historial de Reservas
CREATE TABLE historial_reservas (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,       -- Identificador único del historial
    id_usuario INT NOT NULL,                           -- Identificador del usuario que hizo la reserva
    id_horario INT NOT NULL,                           -- Identificador del horario de la clase
    fecha_reserva DATETIME NOT NULL,                   -- Fecha y hora en que se hizo la reserva
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario), -- Relación con la tabla usuarios
    FOREIGN KEY (id_horario) REFERENCES horarios(id_horario)  -- Relación con la tabla horarios
);




